import os
import joblib
import pandas as pd
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LinearRegression

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(BASE_DIR, "modelo_desperdicio_carpintech.pkl")

def entrenar_o_cargar(records_df):
    """Entrena o carga el pipeline de Regresión Lineal para inferencia de desperdicio."""
    if os.path.exists(MODEL_PATH):
        try:
            modelo = joblib.load(MODEL_PATH)
            # Verificar que sea un Pipeline válido listo para inferencia directa
            if hasattr(modelo, 'predict'):
                return modelo
        except Exception:
            pass

    features = [
        'tipo_mueble', 'material_principal', 'largo_cm', 'ancho_cm',
        'alto_cm', 'cantidad_piezas', 'requiere_canto', 'requiere_laca_sellador'
    ]
    X = records_df[features]
    y = records_df['desperdicio_total_pct']

    cat_cols = ['tipo_mueble', 'material_principal']
    num_cols = ['largo_cm', 'ancho_cm', 'alto_cm', 'cantidad_piezas', 'requiere_canto', 'requiere_laca_sellador']

    preprocessor = ColumnTransformer(
        transformers=[
            ('cat', OneHotEncoder(handle_unknown='ignore'), cat_cols),
            ('num', StandardScaler(), num_cols)
        ]
    )

    modelo_final = Pipeline(steps=[
        ('prep', preprocessor),
        ('reg', LinearRegression())
    ])
    modelo_final.fit(X, y)

    joblib.dump(modelo_final, MODEL_PATH)
    return modelo_final


def predecir_desperdicio_pedido(
    modelo_final, tipo_mueble, material_principal,
    largo_cm, ancho_cm, alto_cm, cantidad_piezas,
    requiere_canto=True, requiere_laca_sellador=False
):
    """Predice porcentaje de desperdicio, área total, retal aprovechable (m²) y viruta (kg)."""
    entrada = pd.DataFrame([{
        'tipo_mueble': tipo_mueble,
        'material_principal': material_principal,
        'largo_cm': float(largo_cm),
        'ancho_cm': float(ancho_cm),
        'alto_cm': float(alto_cm),
        'cantidad_piezas': int(cantidad_piezas),
        'requiere_canto': bool(requiere_canto),
        'requiere_laca_sellador': bool(requiere_laca_sellador)
    }])

    desperdicio_pct = round(float(modelo_final.predict(entrada)[0]), 2)
    area_total_m2 = round((float(largo_cm) * float(ancho_cm) * int(cantidad_piezas)) / 10000.0, 2)
    factor_reutilizable = 0.45

    area_desperdicio_m2 = area_total_m2 * (desperdicio_pct / 100.0)
    retal_reutilizable_m2 = round(area_desperdicio_m2 * factor_reutilizable, 2)
    area_viruta_m2 = round(area_desperdicio_m2 * (1 - factor_reutilizable), 2)
    viruta_inservible_kg = round(area_viruta_m2 * 2.5, 2)
    area_util_m2 = round(max(0.0, area_total_m2 - area_desperdicio_m2), 2)

    return {
        'area_total_m2': area_total_m2,
        'area_util_m2': area_util_m2,
        'desperdicio_total_pct': desperdicio_pct,
        'desperdicio_reutilizable_m2': retal_reutilizable_m2,
        'desperdicio_inservible_viruta_kg': viruta_inservible_kg
    }


def generar_dashboard_ml(records_list, filtro_mueble='', filtro_material=''):
    """Genera las proyecciones empresariales de pérdida de material para el Dashboard ML."""
    df = pd.DataFrame(records_list)
    modelo_final = entrenar_o_cargar(df)

    # 1. Proyección acumulada por Material sobre las órdenes reales del taller (filtradas)
    materiales_agg = {}
    for r in records_list:
        if filtro_mueble and r['tipo_mueble'] != filtro_mueble:
            continue
        if filtro_material and r['material_principal'] != filtro_material:
            continue

        pred = predecir_desperdicio_pedido(
            modelo_final, r['tipo_mueble'], r['material_principal'],
            r['largo_cm'], r['ancho_cm'], r['alto_cm'], r['cantidad_piezas'],
            r['requiere_canto'], r['requiere_laca_sellador']
        )
        mat = r['material_principal']
        if mat not in materiales_agg:
            materiales_agg[mat] = {'retal': 0.0, 'viruta': 0.0}
        materiales_agg[mat]['retal'] += pred['desperdicio_reutilizable_m2']
        materiales_agg[mat]['viruta'] += pred['desperdicio_inservible_viruta_kg']

    mat_labels = list(materiales_agg.keys())
    chart_materiales_ml = {
        'labels': mat_labels,
        'retal': [round(materiales_agg[m]['retal'], 2) for m in mat_labels],
        'viruta': [round(materiales_agg[m]['viruta'], 2) for m in mat_labels]
    }

    # 2. Tabla y Gráfica de Predicciones para los Productos Estándar del Taller
    casos_catalogo = [
        ("Cocina Integral", "Madera Cedro", 240, 60, 90, 28, True, True),
        ("Closet Modular", "Madecor 15mm (Melamina)", 180, 55, 210, 22, True, False),
        ("Puerta Tamborada", "Triplex Okume", 90, 4, 210, 6, False, True),
        ("Mueble de Baño", "Lámina Alto Brillo/Mate (Cocinas)", 85, 45, 75, 10, True, True),
        ("Escalera en Madera", "Madera Flor Morado", 260, 100, 230, 32, False, True),
        ("Piso en Madera", "Madera Pino", 200, 120, 30, 18, False, True),
    ]

    predicciones_catalogo = []
    for caso in casos_catalogo:
        if filtro_mueble and caso[0] != filtro_mueble:
            continue
        if filtro_material and caso[1] != filtro_material:
            continue
        res = predecir_desperdicio_pedido(modelo_final, *caso)
        predicciones_catalogo.append({
            'producto': caso[0],
            'material': caso[1],
            'dimensiones': f"{caso[2]}x{caso[3]}x{caso[4]} cm",
            'piezas': caso[5],
            'desperdicio_pct': res['desperdicio_total_pct'],
            'retal_m2': res['desperdicio_reutilizable_m2'],
            'viruta_kg': res['desperdicio_inservible_viruta_kg']
        })

    return {
        'chart_materiales_ml': chart_materiales_ml,
        'predicciones_catalogo': predicciones_catalogo
    }
