import os
import json
import base64
from datetime import datetime, timedelta
from functools import wraps
from urllib.parse import quote_plus
from concurrent.futures import ProcessPoolExecutor
import pandas as pd
from ml_engine.modelo_ml import generar_dashboard_ml, predecir_desperdicio_pedido, entrenar_o_cargar

import bcrypt
import jwt
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
from flask import Flask, jsonify, render_template, request
from flask_socketio import SocketIO, emit
from flask_sqlalchemy import SQLAlchemy

# ===================================================================
# INICIALIZACIÓN Y CONFIGURACIÓN DE LA APLICACIÓN FLASK
# ===================================================================
app = Flask(__name__, template_folder='templates', static_folder='static')
app.config['SECRET_KEY'] = 'mueble_arte_master_key_2026'

db_pwd = quote_plus('Admin_Remoto_2026!')
app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://admin_remoto:{db_pwd}@127.0.0.1/mueble_arte_db"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
socketio = SocketIO(app, cors_allowed_origins="*", async_mode='eventlet')

# Constantes de Cifrado AES-256 en Transporte
AES_KEY = b'MuebleArteClasicoContempor2026!!'
AES_IV = b'1234567890123456'

# ===================================================================
# MODELOS ORM (MAPEO DE TABLAS MYSQL)
# ===================================================================
class Usuario(db.Model):
    __tablename__ = 'usuarios'
    id_usuario = db.Column(db.Integer, primary_key=True, autoincrement=True)
    usuario = db.Column(db.String(50), unique=True, nullable=False)
    contrasenia = db.Column(db.String(255), nullable=False)
    nombre_completo = db.Column(db.String(100), nullable=False)
    rol = db.Column(db.String(30), nullable=False)

class Cliente(db.Model):
    __tablename__ = 'clientes'
    id_cliente = db.Column(db.String(50), primary_key=True)
    nombre_completo = db.Column(db.String(255), nullable=False)
    telefono = db.Column(db.String(255))
    direccion = db.Column(db.String(255), nullable=True)
    tipo_cliente = db.Column(db.String(50), default='Particular')
    numero_pedidos = db.Column(db.Integer, default=0)
    contrasenia = db.Column(db.String(255), nullable=False)

class Producto(db.Model):
    __tablename__ = 'productos'
    id_producto = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nombre_producto = db.Column(db.String(100), unique=True, nullable=False)
    categoria = db.Column(db.String(50), nullable=False)
    precio_venta_base = db.Column(db.Numeric(12, 2), nullable=False)
    costo_estimado = db.Column(db.Numeric(12, 2), nullable=False)

class Material(db.Model):
    __tablename__ = 'materiales'
    id_material = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nombre_material = db.Column(db.String(100), unique=True, nullable=False)
    unidad_medida = db.Column(db.String(20), nullable=False)
    stock_disponible = db.Column(db.Numeric(10, 2), default=0.0)
    costo_unitario = db.Column(db.Numeric(12, 2), nullable=False)

class Pedido(db.Model):
    __tablename__ = 'pedidos'
    id_pedido = db.Column(db.String(30), primary_key=True)
    id_cliente = db.Column(db.String(50), db.ForeignKey('clientes.id_cliente'), nullable=False)
    id_vendedor = db.Column(db.Integer, db.ForeignKey('usuarios.id_usuario'), nullable=False)
    id_artesano = db.Column(db.Integer, nullable=True)
    artesano_nombre = db.Column(db.String(100), default='Taller Maestro')
    tipo_mueble = db.Column(db.String(100), nullable=False)
    material_principal = db.Column(db.String(100), nullable=False)
    largo_cm = db.Column(db.Numeric(8, 2), nullable=False)
    ancho_cm = db.Column(db.Numeric(8, 2), nullable=False)
    alto_cm = db.Column(db.Numeric(8, 2), nullable=False)
    cantidad_piezas = db.Column(db.Integer, nullable=False)
    requiere_canto = db.Column(db.Boolean, default=False)
    requiere_laca_sellador = db.Column(db.Boolean, default=False)
    desperdicio_total_pct = db.Column(db.Numeric(5, 2), nullable=False)
    desperdicio_reutilizable_m2 = db.Column(db.Numeric(8, 2), nullable=False)
    desperdicio_inservible_viruta_kg = db.Column(db.Numeric(8, 2), nullable=False)
    monto_total = db.Column(db.Numeric(12, 2), nullable=False)
    dias_fabricacion = db.Column(db.Integer, default=15)
    estado_pedido = db.Column(db.String(30), default='Pendiente')
    fecha_pedido = db.Column(db.Date, nullable=False)
    fecha_entrega_estimada = db.Column(db.Date, nullable=False)

class Venta(db.Model):
    __tablename__ = 'ventas'
    id_venta = db.Column(db.String(30), primary_key=True)
    id_pedido = db.Column(db.String(30), db.ForeignKey('pedidos.id_pedido'), unique=True, nullable=False)
    id_cliente = db.Column(db.String(50), db.ForeignKey('clientes.id_cliente'), nullable=False)
    id_vendedor = db.Column(db.Integer, db.ForeignKey('usuarios.id_usuario'), nullable=False)
    fecha_venta = db.Column(db.Date, nullable=False)
    metodo_pago = db.Column(db.String(50), nullable=False)
    subtotal = db.Column(db.Numeric(12, 2), nullable=False)
    impuestos = db.Column(db.Numeric(12, 2), nullable=False)
    total_pagado = db.Column(db.Numeric(12, 2), nullable=False)

# ===================================================================
# FUNCIONES AUXILIARES: CRIPTOGRAFÍA AES-256
# ===================================================================
def pkcs7_pad(data_bytes):
    pad_len = 16 - (len(data_bytes) % 16)
    return data_bytes + bytes([pad_len] * pad_len)

def encrypt_payload(data):
    raw_str = json.dumps(data, default=str)
    raw_bytes = pkcs7_pad(raw_str.encode('utf-8'))
    cipher = Cipher(algorithms.AES(AES_KEY), modes.CBC(AES_IV), backend=default_backend())
    enc = cipher.encryptor()
    encrypted = enc.update(raw_bytes) + enc.finalize()
    return base64.b64encode(encrypted).decode('utf-8')

# ===================================================================
# MIDDLEWARE DE CONTROL DE ACCESO (DECORADOR JWT)
# ===================================================================
def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth_header = request.headers.get('Authorization', "")
        token = auth_header.replace("Bearer ", "")
        if not token:
            return jsonify({'error': 'Token ausente'}), 401
        try:
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
            user_id = data.get('id_usuario')
            is_client = data.get('is_client', False)
            cur_user = Cliente.query.get(user_id) if is_client else Usuario.query.get(user_id)
            if not cur_user:
                return jsonify({'error': 'Identidad no válida'}), 401
        except Exception:
            return jsonify({'error': 'Sesión caducada'}), 401
        return f(cur_user, is_client, *args, **kwargs)
    return decorated

# ===================================================================
# ENRUTAMIENTO DE PÁGINAS PRINCIPALES (VISTAS)
# ===================================================================
@app.route('/')
@app.route('/login')
def login_view():
    return render_template('login.html')

@app.route('/dashboard')
def dashboard_view():
    return render_template('dashboard.html')

# ===================================================================
# ENDPOINT: AUTENTICACIÓN Y VALIDACIÓN DE ROLES
# ===================================================================
@app.route('/api/login', methods=['POST'])
def api_login():
    data = request.json or {}
    username = data.get('username', '').strip()
    password = data.get('password', '')

    emp = Usuario.query.filter_by(usuario=username).first()
    if emp:
        valid = False
        if emp.contrasenia.startswith('$2b$'):
            valid = bcrypt.checkpw(password.encode('utf-8'), emp.contrasenia.encode('utf-8'))
        else:
            valid = (emp.contrasenia == password)

        if not valid:
            return jsonify({'error': 'No existe la cuenta'}), 404

        token = jwt.encode({
            'id_usuario': emp.id_usuario,
            'rol': emp.rol,
            'nombre': emp.nombre_completo,
            'is_client': False,
            'exp': datetime.utcnow() + timedelta(hours=10)
        }, app.config['SECRET_KEY'], algorithm='HS256')

        return jsonify({'payload': encrypt_payload({
            'token': token, 'rol': emp.rol, 'nombre': emp.nombre_completo, 'is_client': False
        })})

    cli = Cliente.query.filter_by(id_cliente=username).first()
    if not cli:
        cli = Cliente.query.filter_by(nombre_completo=username).first()

    if cli:
        valid = False
        if cli.contrasenia.startswith('$2b$'):
            valid = bcrypt.checkpw(password.encode('utf-8'), cli.contrasenia.encode('utf-8'))
        else:
            valid = (cli.contrasenia == password)

        if not valid:
            return jsonify({'error': 'No existe la cuenta'}), 404

        token = jwt.encode({
            'id_cliente': cli.id_cliente,
            'id_usuario': cli.id_cliente,
            'rol': 'Cliente',
            'nombre': cli.nombre_completo,
            'is_client': True,
            'exp': datetime.utcnow() + timedelta(hours=10)
        }, app.config['SECRET_KEY'], algorithm='HS256')

        return jsonify({'payload': encrypt_payload({
            'token': token, 'rol': 'Cliente', 'nombre': cli.nombre_completo,
            'id_cliente': cli.id_cliente, 'telefono': cli.telefono or '', 'is_client': True
        })})

    return jsonify({'error': 'No existe la cuenta'}), 404

# ===================================================================
# ENDPOINT: REGISTRO DE CLIENTES
# ===================================================================
@app.route('/api/registro-cliente', methods=['POST'])
def api_registro_cliente():
    data = request.json or {}
    nom = data.get('nombre_completo', '').strip()
    tel = data.get('telefono', '').strip()
    pwd = data.get('password', '')

    import random
    nuevo_id = f"CLI-{random.randint(200, 999)}"
    h = bcrypt.hashpw(pwd.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    nuevo = Cliente(
        id_cliente=nuevo_id,
        nombre_completo=nom,
        telefono=tel,
        direccion=None,
        tipo_cliente='Particular',
        numero_pedidos=0,
        contrasenia=h
    )
    db.session.add(nuevo)
    db.session.commit()
    socketio.emit('actualizacion_dashboard', {'tipo': 'cliente_nuevo'})
    return jsonify({'message': 'Cuenta creada con éxito', 'id_cliente': nuevo_id})

# =================================================================== PROCESAMIENTO PARALELO (COMPUTACIÓN MULTINÚCLEO) 
# ===================================================================
# PROCESAMIENTO PARALELO: DASHBOARD GERENCIAL Y FINANCIERO
# ===================================================================
def calc_dashboard_parallel(dataset_json, user_rol):
    import math
    records = json.loads(dataset_json)
    total = len(records)
    if total == 0:
        return {
            'kpis': {
                'ingresos': 0.0, 'ganancia': 0.0, 'activos': 0,
                'merma_proyectada_ml': '0%', 'eficiencia_entrega': '0%'
            },
            'tabla_ejecutiva': [],
            'chart_finanzas': {'labels': [], 'ventas': [], 'costos': []},
            'chart_tiempos': {'labels': [], 'real': [], 'proyectado': []},
            'chart_segmentos': {'labels': [], 'ingresos': [], 'pedidos': []},
            'chart_vendedores': {'labels': [], 'ventas': [], 'conversion': []}
        }

    completados = [r for r in records if r['estado'] == 'Completado']
    ingresos = sum(r['monto'] for r in completados)
    costos = sum(r['costo'] for r in completados) if user_rol != 'Ventas' else 0.0
    ganancia = ingresos - costos if user_rol != 'Ventas' else 0.0
    activos = sum(1 for r in records if r['estado'] in ['Pendiente', 'En Producción', 'En Acabado'])

    # KPI proyectado por el modelo predictivo ML
    merma_ml_prom = round(sum(r['desperdicio_ml'] for r in records) / total, 2)

    # Cálculo estadístico interno para cumplimiento de plazos (sin exponer varianzas crudas)
    dias_arr = [r['dias'] for r in records]
    media_d = sum(dias_arr) / total
    std_d = math.sqrt(sum((x - media_d) ** 2 for x in dias_arr) / total)
    cumplimiento_pct = max(0, min(100, round(100 - ((std_d / media_d) * 100), 1))) if media_d > 0 else 0

    # Balance ejecutivo por línea de mueble
    muebles_grp = {}
    for r in records:
        m = r['mueble']
        if m not in muebles_grp:
            muebles_grp[m] = {'ingresos': 0.0, 'costos': 0.0, 'dias': [], 'ordenes': 0, 'cerradas': 0, 'merma_ml': []}
        muebles_grp[m]['ordenes'] += 1
        muebles_grp[m]['dias'].append(r['dias'])
        muebles_grp[m]['merma_ml'].append(r['desperdicio_ml'])
        if r['estado'] == 'Completado':
            muebles_grp[m]['ingresos'] += r['monto']
            muebles_grp[m]['costos'] += r['costo']
            muebles_grp[m]['cerradas'] += 1

    tabla_ejecutiva = []
    for m, data in muebles_grp.items():
        n = data['ordenes']
        m_t = sum(data['dias']) / n
        std_t = math.sqrt(sum((x - m_t) ** 2 for x in data['dias']) / n)
        plazo_seguro = math.ceil(m_t + std_t)
        utilidad_linea = data['ingresos'] - data['costos']
        merma_pred_linea = round(sum(data['merma_ml']) / n, 1)

        estado_op = 'Rentabilidad Óptima' if utilidad_linea > 0 and (std_t / m_t) < 0.25 else 'Ajustar Plazo Comercial'

        tabla_ejecutiva.append({
            'mueble': m,
            'ordenes_totales': f"{data['cerradas']} cerradas / {n} totales",
            'ingresos_totales': data['ingresos'],
            'ganancia_neta': utilidad_linea,
            'plazo_prom': f"{round(m_t, 1)} días",
            'plazo_compromiso': f"{plazo_seguro} días hábiles",
            'merma_ml': f"{merma_pred_linea}%",
            'estado_operativo': estado_op
        })

    # Agregación para las 4 gráficas empresariales del Dashboard Gerencial
    evolucion, tiempos, segmentos, vendedores = {}, {}, {}, {}

    for r in records:
        # 1. Finanzas mensuales
        mes = r['fecha'][:7]
        if mes not in evolucion:
            evolucion[mes] = {'ventas': 0.0, 'costos': 0.0}
        if r['estado'] == 'Completado':
            evolucion[mes]['ventas'] += r['monto']
            evolucion[mes]['costos'] += r['costo']

        # 2. Tiempos por mueble
        prod = r['mueble']
        if prod not in tiempos:
            tiempos[prod] = []
        tiempos[prod].append(r['dias'])

        # 3. Nueva Gráfica Empresarial: Segmentación de Clientes (Empresa vs Particular)
        seg = r['tipo_cliente']
        if seg not in segmentos:
            segmentos[seg] = {'ingresos': 0.0, 'pedidos': 0}
        segmentos[seg]['pedidos'] += 1
        if r['estado'] == 'Completado':
            segmentos[seg]['ingresos'] += r['monto']

        # 4. Rendimiento por Vendedor
        ven = r['vendedor']
        if ven not in vendedores:
            vendedores[ven] = {'total': 0, 'completados': 0, 'ventas': 0.0}
        vendedores[ven]['total'] += 1
        if r['estado'] == 'Completado':
            vendedores[ven]['completados'] += 1
            vendedores[ven]['ventas'] += r['monto']

    meses = sorted(evolucion.keys())
    t_prods = list(tiempos.keys())
    seg_names = list(segmentos.keys())
    ven_names = list(vendedores.keys())

    return {
        'kpis': {
            'ingresos': ingresos,
            'ganancia': ganancia,
            'activos': activos,
            'merma_proyectada_ml': f"{merma_ml_prom}%",
            'eficiencia_entrega': f"{cumplimiento_pct}%"
        },
        'tabla_ejecutiva': tabla_ejecutiva,
        'chart_finanzas': {
            'labels': meses,
            'ventas': [evolucion[m]['ventas'] for m in meses],
            'costos': [evolucion[m]['costos'] for m in meses] if user_rol != 'Ventas' else [0 for _ in meses]
        },
        'chart_tiempos': {
            'labels': t_prods,
            'real': [round(sum(tiempos[p]) / len(tiempos[p]), 1) for p in t_prods],
            'proyectado': [15 for _ in t_prods]
        },
        'chart_segmentos': {
            'labels': seg_names,
            'ingresos': [segmentos[s]['ingresos'] for s in seg_names],
            'pedidos': [segmentos[s]['pedidos'] for s in seg_names]
        },
        'chart_vendedores': {
            'labels': ven_names,
            'ventas': [vendedores[v]['ventas'] for v in ven_names],
            'conversion': [round((vendedores[v]['completados'] / vendedores[v]['total'] * 100), 1) if vendedores[v]['total'] > 0 else 0 for v in ven_names]
        }
    }

@app.route('/api/dashboard-analytics', methods=['GET'])
@token_required
def api_dashboard_analytics(cur_user, is_client):
    """Endpoint de analítica gerencial con filtros completos."""
    if is_client:
        return jsonify({'error': 'Acceso no permitido'}), 403

    mueble = request.args.get('mueble', '').strip()
    cliente = request.args.get('cliente', '').strip()
    artesano = request.args.get('artesano', '').strip()
    vendedor = request.args.get('vendedor', '').strip()
    fecha_desde = request.args.get('fecha_desde', '').strip()
    fecha_hasta = request.args.get('fecha_hasta', '').strip()

    query = db.session.query(Pedido, Cliente, Producto)\
        .outerjoin(Cliente, Pedido.id_cliente == Cliente.id_cliente)\
        .outerjoin(Producto, Pedido.tipo_mueble == Producto.nombre_producto)

    if mueble: query = query.filter(Pedido.tipo_mueble == mueble)
    if cliente: query = query.filter(Pedido.id_cliente == cliente)
    if artesano: query = query.filter(Pedido.artesano_nombre.ilike(f'%{artesano}%'))
    if vendedor: query = query.filter(Pedido.id_vendedor == int(vendedor))
    if fecha_desde: query = query.filter(Pedido.fecha_pedido >= f"{fecha_desde}-01")
    if fecha_hasta: query = query.filter(Pedido.fecha_pedido <= f"{fecha_hasta}-31")

    results = query.all()
    vendedores_lookup = {u.id_usuario: u.nombre_completo for u in Usuario.query.filter_by(rol='Ventas').all()}

    all_ped = Pedido.query.all()
    df_all = pd.DataFrame([{
        'tipo_mueble': x.tipo_mueble, 'material_principal': x.material_principal,
        'largo_cm': float(x.largo_cm), 'ancho_cm': float(x.ancho_cm), 'alto_cm': float(x.alto_cm),
        'cantidad_piezas': int(x.cantidad_piezas), 'requiere_canto': bool(x.requiere_canto),
        'requiere_laca_sellador': bool(x.requiere_laca_sellador),
        'desperdicio_total_pct': float(x.desperdicio_total_pct)
    } for x in all_ped])
    modelo_ml = entrenar_o_cargar(df_all)

    records = []
    for p, c, pr in results:
        pred_ml = predecir_desperdicio_pedido(
            modelo_ml, p.tipo_mueble, p.material_principal,
            p.largo_cm, p.ancho_cm, p.alto_cm, p.cantidad_piezas,
            p.requiere_canto, p.requiere_laca_sellador
        )
        records.append({
            'monto': float(p.monto_total),
            'costo': float(pr.costo_estimado) if pr else float(p.monto_total) * 0.6,
            'estado': p.estado_pedido,
            'fecha': str(p.fecha_pedido),
            'mueble': p.tipo_mueble,
            'tipo_cliente': c.tipo_cliente if c else 'Particular',
            'dias': p.dias_fabricacion,
            'vendedor': vendedores_lookup.get(p.id_vendedor, f'Vendedor {p.id_vendedor}'),
            'desperdicio_ml': pred_ml['desperdicio_total_pct']
        })

    with ProcessPoolExecutor(max_workers=2) as executor:
        future = executor.submit(calc_dashboard_parallel, json.dumps(records), cur_user.rol)
        res = future.result()

    res['catalogos'] = {
        'artesanos': [{'id': a[0], 'nombre': a[0]} for a in db.session.query(Pedido.artesano_nombre).distinct().all() if a[0]],
        'vendedores': [{'id': u.id_usuario, 'nombre': u.nombre_completo} for u in Usuario.query.filter_by(rol='Ventas').all()],
        'clientes': [{'id': c.id_cliente, 'nombre': c.nombre_completo} for c in Cliente.query.all()]
    }

    return jsonify({'payload': encrypt_payload(res)})

@app.route('/api/ml-predictive-dashboard', methods=['GET'])
@token_required
def api_ml_predictive_dashboard(cur_user, is_client):
    """Endpoint del Dashboard Predictivo ML (solo Administrador y Contador)."""
    if is_client or cur_user.rol not in ['Administrador', 'Contador']:
        return jsonify({'error': 'Acceso restringido a Administrador y Contador'}), 403

    filtro_mueble = request.args.get('mueble', '').strip()
    filtro_material = request.args.get('material', '').strip()

    pedidos = Pedido.query.all()
    records = [{
        'tipo_mueble': p.tipo_mueble,
        'material_principal': p.material_principal,
        'largo_cm': float(p.largo_cm),
        'ancho_cm': float(p.ancho_cm),
        'alto_cm': float(p.alto_cm),
        'cantidad_piezas': int(p.cantidad_piezas),
        'requiere_canto': bool(p.requiere_canto),
        'requiere_laca_sellador': bool(p.requiere_laca_sellador),
        'desperdicio_total_pct': float(p.desperdicio_total_pct)
    } for p in pedidos]

    res_ml = generar_dashboard_ml(records, filtro_mueble, filtro_material)
    return jsonify({'payload': encrypt_payload(res_ml)})

@app.route('/api/ml-simular', methods=['POST'])
@token_required
def api_ml_simular(cur_user, is_client):
    """Simulador interactivo de predicción de desperdicio, retal y viruta."""
    if is_client or cur_user.rol not in ['Administrador', 'Contador']:
        return jsonify({'error': 'Acceso restringido'}), 403

    data = request.json
    pedidos = Pedido.query.all()
    df_all = pd.DataFrame([{
        'tipo_mueble': x.tipo_mueble, 'material_principal': x.material_principal,
        'largo_cm': float(x.largo_cm), 'ancho_cm': float(x.ancho_cm), 'alto_cm': float(x.alto_cm),
        'cantidad_piezas': int(x.cantidad_piezas), 'requiere_canto': bool(x.requiere_canto),
        'requiere_laca_sellador': bool(x.requiere_laca_sellador),
        'desperdicio_total_pct': float(x.desperdicio_total_pct)
    } for x in pedidos])
    modelo_ml = entrenar_o_cargar(df_all)

    pred = predecir_desperdicio_pedido(
        modelo_ml,
        data['tipo_mueble'], data['material_principal'],
        data['largo_cm'], data['ancho_cm'], data['alto_cm'],
        data['cantidad_piezas'], data.get('requiere_canto', True), data.get('requiere_laca_sellador', False)
    )
    return jsonify({'payload': encrypt_payload(pred)})
# ===============================================================
# ENDPOINTS CRUD: PEDIDOS (CREAR, EDITAR ESTADO/DATOS, ELIMINAR)
# ===============================================================
@app.route('/api/pedidos', methods=['GET', 'POST'])
@app.route('/api/pedidos/<id_pedido>', methods=['PUT', 'DELETE'])
@token_required
def api_pedidos_crud(cur_user, is_client, id_pedido=None):
    if is_client and request.method != 'POST':
        return jsonify({'error': 'No autorizado'}), 403
    if not is_client and cur_user.rol == 'Contador' and request.method != 'GET':
        return jsonify({'error': 'El Contador tiene perfil de solo lectura en pedidos'}), 403

    if request.method == 'GET':
        query_ped = db.session.query(Pedido, Venta)            .outerjoin(Venta, Pedido.id_pedido == Venta.id_pedido).all()
        data = [{
            'id_pedido': p.id_pedido,
            'id_cliente': p.id_cliente,
            'tipo_mueble': p.tipo_mueble,
            'material_principal': p.material_principal,
            'monto_total': float(p.monto_total),
            'desperdicio_total_pct': float(p.desperdicio_total_pct),
            'estado_pedido': p.estado_pedido,
            'artesano_nombre': p.artesano_nombre or 'Taller Maestro',
            'metodo_pago': v.metodo_pago if v else 'Pendiente de Pago',
            'fecha_pedido': str(p.fecha_pedido),
            'fecha_entrega': str(p.fecha_entrega_estimada)
        } for p, v in query_ped]
        return jsonify({'payload': encrypt_payload(data)})

    if request.method == 'POST':
        d = request.json or {}
        items = d.get('items', [])
        cli_id = d.get('id_cliente', cur_user.id_cliente if is_client else 'CLI-108')
        ven_id = 14 if is_client else cur_user.id_usuario
        import random

        # Soporte tanto para cotizador multiproducto como para modal CRUD individual
        if not items and d.get('tipo_mueble'):
            items = [d]

        cli_obj = Cliente.query.get(cli_id)
        if cli_obj:
            cli_obj.numero_pedidos = (cli_obj.numero_pedidos or 0) + len(items)

        for item in items:
            p_id = item.get('id_pedido') or f"PED-{random.randint(10000, 99999)}"
            nuevo = Pedido(
                id_pedido=p_id,
                id_cliente=cli_id,
                id_vendedor=ven_id,
                id_artesano=None,
                artesano_nombre=item.get('artesano_nombre', 'Jorge Tello'),
                tipo_mueble=item['tipo_mueble'],
                material_principal=item['material_principal'],
                largo_cm=float(item.get('largo_cm', 100)),
                ancho_cm=float(item.get('ancho_cm', 50)),
                alto_cm=float(item.get('alto_cm', 80)),
                cantidad_piezas=int(item.get('cantidad_piezas', 1)),
                requiere_canto=bool(item.get('requiere_canto', False)),
                requiere_laca_sellador=bool(item.get('requiere_laca_sellador', False)),
                desperdicio_total_pct=15.5,
                desperdicio_reutilizable_m2=2.2,
                desperdicio_inservible_viruta_kg=5.0,
                monto_total=float(item['monto_total']),
                estado_pedido=item.get('estado_pedido', 'En Producción'),
                fecha_pedido=datetime.utcnow().date(),
                fecha_entrega_estimada=datetime.utcnow().date() + timedelta(days=int(item.get('dias_fabricacion', 20)))
            )
            db.session.add(nuevo)

        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'pedidos_creados'})
        return jsonify({'message': 'Pedido guardado correctamente'})

    if request.method == 'PUT' and id_pedido:
        if cur_user.rol not in ['Administrador', 'Ventas']:
            return jsonify({'error': 'Permiso denegado'}), 403

        p = Pedido.query.get_or_404(id_pedido)
        d = request.json or {}
        nuevo_estado = d.get('estado_pedido', p.estado_pedido)

        p.tipo_mueble = d.get('tipo_mueble', p.tipo_mueble)
        p.material_principal = d.get('material_principal', p.material_principal)
        p.artesano_nombre = d.get('artesano_nombre', p.artesano_nombre)
        if 'monto_total' in d:
            p.monto_total = float(d['monto_total'])
        p.estado_pedido = nuevo_estado

        # Si pasa a Completado, generar automáticamente su venta si aún no existe
        if nuevo_estado == 'Completado' and not Venta.query.filter_by(id_pedido=p.id_pedido).first():
            id_v = f"VEN-{p.id_pedido.replace('PED-', '')}"
            subt = round(float(p.monto_total) / 1.19, 2)
            imp = round(float(p.monto_total) - subt, 2)
            v = Venta(
                id_venta=id_v, id_pedido=p.id_pedido, id_cliente=p.id_cliente,
                id_vendedor=p.id_vendedor, fecha_venta=datetime.utcnow().date(),
                metodo_pago='Transferencia', subtotal=subt, impuestos=imp, total_pagado=p.monto_total
            )
            db.session.add(v)

        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'pedido_actualizado'})
        return jsonify({'message': 'Pedido actualizado'})

    if request.method == 'DELETE' and id_pedido:
        if cur_user.rol != 'Administrador':
            return jsonify({'error': 'Solo el Administrador suprime registros'}), 403
        p = Pedido.query.get_or_404(id_pedido)
        db.session.delete(p)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'pedido_eliminado'})
        return jsonify({'message': 'Pedido suprimido'})
# ===============================================================
# ENDPOINTS CRUD: VENTAS
# ===============================================================
@app.route('/api/ventas', methods=['GET', 'POST'])
@app.route('/api/ventas/<id_venta>', methods=['PUT', 'DELETE'])
@token_required
def api_ventas_crud(cur_user, is_client, id_venta=None):
    if is_client or cur_user.rol == 'Ventas':
        return jsonify({'error': 'Acceso no autorizado'}), 403

    if request.method == 'GET':
        query_v = db.session.query(Venta, Usuario).outerjoin(Usuario, Venta.id_vendedor == Usuario.id_usuario).all()
        data = [{
            'id_venta': v.id_venta,
            'id_pedido': v.id_pedido,
            'id_cliente': v.id_cliente,
            'vendedor_nombre': u.nombre_completo if u else f'Vendedor {v.id_vendedor}',
            'fecha_venta': str(v.fecha_venta),
            'metodo_pago': v.metodo_pago,
            'subtotal': float(v.subtotal),
            'total_pagado': float(v.total_pagado)
        } for v, u in query_v]
        return jsonify({'payload': encrypt_payload(data)})

    if cur_user.rol != 'Administrador':
        return jsonify({'error': 'Solo el Administrador modifica ventas'}), 403

    if request.method == 'POST':
        d = request.json or {}
        tot = float(d['total_pagado'])
        subt = round(tot / 1.19, 2)
        v = Venta(
            id_venta=d['id_venta'], id_pedido=d['id_pedido'], id_cliente=d['id_cliente'],
            id_vendedor=cur_user.id_usuario, fecha_venta=datetime.utcnow().date(),
            metodo_pago=d.get('metodo_pago', 'Transferencia'), subtotal=subt,
            impuestos=round(tot - subt, 2), total_pagado=tot
        )
        db.session.add(v)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'venta_creada'})
        return jsonify({'message': 'Venta registrada'})

    if request.method == 'PUT' and id_venta:
        v = Venta.query.get_or_404(id_venta)
        d = request.json or {}
        v.metodo_pago = d.get('metodo_pago', v.metodo_pago)
        if 'total_pagado' in d:
            tot = float(d['total_pagado'])
            v.total_pagado = tot
            v.subtotal = round(tot / 1.19, 2)
            v.impuestos = round(tot - v.subtotal, 2)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'venta_editada'})
        return jsonify({'message': 'Venta actualizada'})

    if request.method == 'DELETE' and id_venta:
        v = Venta.query.get_or_404(id_venta)
        db.session.delete(v)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'venta_eliminada'})
        return jsonify({'message': 'Venta eliminada'})

# ===============================================================
# ENDPOINTS CRUD: CLIENTES
# ===============================================================
@app.route('/api/clientes', methods=['GET', 'POST'])
@app.route('/api/clientes/<id_cliente>', methods=['PUT', 'DELETE'])
@token_required
def api_clientes_crud(cur_user, is_client, id_cliente=None):
    if is_client or cur_user.rol == 'Contador':
        return jsonify({'error': 'Acceso no autorizado'}), 403

    if request.method == 'GET':
        clis = Cliente.query.all()
        data = [{
            'id_cliente': c.id_cliente, 'nombre_completo': c.nombre_completo,
            'telefono': c.telefono, 'tipo': c.tipo_cliente, 'pedidos_totales': c.numero_pedidos
        } for c in clis]
        return jsonify({'payload': encrypt_payload(data)})

    if request.method == 'POST':
        if cur_user.rol not in ['Administrador', 'Ventas']:
            return jsonify({'error': 'Permiso denegado'}), 403
        d = request.json or {}
        h = bcrypt.hashpw(b'cliente123', bcrypt.gensalt()).decode('utf-8')
        c = Cliente(
            id_cliente=d['id_cliente'], nombre_completo=d['nombre_completo'],
            telefono=d.get('telefono', ''), tipo_cliente=d.get('tipo', 'Particular'),
            numero_pedidos=0, contrasenia=h
        )
        db.session.add(c)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'cliente_creado'})
        return jsonify({'message': 'Cliente registrado'})

    if request.method == 'PUT' and id_cliente:
        if cur_user.rol not in ['Administrador', 'Ventas']:
            return jsonify({'error': 'Permiso denegado'}), 403
        c = Cliente.query.get_or_404(id_cliente)
        d = request.json or {}
        c.nombre_completo = d.get('nombre_completo', c.nombre_completo)
        c.telefono = d.get('telefono', c.telefono)
        c.tipo_cliente = d.get('tipo', c.tipo_cliente)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'cliente_editado'})
        return jsonify({'message': 'Cliente actualizado'})

    if request.method == 'DELETE' and id_cliente:
        if cur_user.rol != 'Administrador':
            return jsonify({'error': 'Solo el Administrador puede eliminar'}), 403
        c = Cliente.query.get_or_404(id_cliente)
        db.session.delete(c)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'cliente_eliminado'})
        return jsonify({'message': 'Cliente eliminado'})

# ===============================================================
# ENDPOINTS CRUD: PRODUCTOS
# ===============================================================
@app.route('/api/productos', methods=['GET', 'POST'])
@app.route('/api/productos/<int:id_producto>', methods=['PUT', 'DELETE'])
@token_required
def api_productos_crud(cur_user, is_client, id_producto=None):
    if request.method == 'GET':
        prods = Producto.query.all()
        data = [{
            'id_producto': p.id_producto, 'nombre_producto': p.nombre_producto,
            'categoria': p.categoria, 'precio_base': float(p.precio_venta_base),
            'costo_estimado': float(p.costo_estimado)
        } for p in prods]
        return jsonify({'payload': encrypt_payload(data)})

    if is_client or cur_user.rol != 'Administrador':
        return jsonify({'error': 'Solo el Administrador modifica productos'}), 403

    if request.method == 'POST':
        d = request.json or {}
        p = Producto(
            nombre_producto=d['nombre_producto'], categoria=d['categoria'],
            precio_venta_base=float(d['precio_base']), costo_estimado=float(d['costo_estimado'])
        )
        db.session.add(p)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'producto_creado'})
        return jsonify({'message': 'Producto creado'})

    if request.method == 'PUT' and id_producto:
        p = Producto.query.get_or_404(id_producto)
        d = request.json or {}
        p.nombre_producto = d.get('nombre_producto', p.nombre_producto)
        p.categoria = d.get('categoria', p.categoria)
        if 'precio_base' in d: p.precio_venta_base = float(d['precio_base'])
        if 'costo_estimado' in d: p.costo_estimado = float(d['costo_estimado'])
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'producto_editado'})
        return jsonify({'message': 'Producto actualizado'})

    if request.method == 'DELETE' and id_producto:
        p = Producto.query.get_or_404(id_producto)
        db.session.delete(p)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'producto_eliminado'})
        return jsonify({'message': 'Producto eliminado'})
# ===============================================================
# ENDPOINTS CRUD: MATERIALES
# ===============================================================
@app.route('/api/materiales', methods=['GET', 'POST'])
@app.route('/api/materiales/<int:id_material>', methods=['PUT', 'DELETE'])
@token_required
def api_materiales_crud(cur_user, is_client, id_material=None):
    if is_client or cur_user.rol in ['Contador', 'Ventas']:
        return jsonify({'error': 'Acceso no autorizado'}), 403

    if request.method == 'GET':
        mats = Material.query.all()
        data = [{
            'id_material': m.id_material, 'nombre_material': m.nombre_material,
            'unidad_medida': m.unidad_medida, 'stock_disponible': float(m.stock_disponible),
            'costo_unitario': float(m.costo_unitario)
        } for m in mats]
        return jsonify({'payload': encrypt_payload(data)})

    if cur_user.rol != 'Administrador':
        return jsonify({'error': 'Solo el Administrador modifica materiales'}), 403

    if request.method == 'POST':
        d = request.json or {}
        m = Material(
            nombre_material=d['nombre_material'], unidad_medida=d['unidad_medida'],
            stock_disponible=float(d['stock_disponible']), costo_unitario=float(d['costo_unitario'])
        )
        db.session.add(m)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'material_creado'})
        return jsonify({'message': 'Material creado'})

    if request.method == 'PUT' and id_material:
        m = Material.query.get_or_404(id_material)
        d = request.json or {}
        m.nombre_material = d.get('nombre_material', m.nombre_material)
        m.unidad_medida = d.get('unidad_medida', m.unidad_medida)
        if 'stock_disponible' in d: m.stock_disponible = float(d['stock_disponible'])
        if 'costo_unitario' in d: m.costo_unitario = float(d['costo_unitario'])
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'material_actualizado'})
        return jsonify({'message': 'Stock actualizado'})

    if request.method == 'DELETE' and id_material:
        m = Material.query.get_or_404(id_material)
        db.session.delete(m)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'material_eliminado'})
        return jsonify({'message': 'Material eliminado'})

# ===============================================================
# ENDPOINTS CRUD: USUARIOS (SOLO ADMINISTRADOR, VENTAS Y CONTADOR)
# ===============================================================
@app.route('/api/usuarios', methods=['GET', 'POST'])
@app.route('/api/usuarios/<int:id_usuario>', methods=['PUT', 'DELETE'])
@token_required
def api_usuarios_crud(cur_user, is_client, id_usuario=None):
    if is_client or cur_user.rol != 'Administrador':
        return jsonify({'error': 'Acceso reservado al Administrador'}), 403

    if request.method == 'GET':
        users = Usuario.query.filter(Usuario.rol.in_(['Administrador', 'Ventas', 'Contador'])).all()
        data = [{
            'id_usuario': u.id_usuario, 'usuario': u.usuario,
            'nombre_completo': u.nombre_completo, 'rol': u.rol
        } for u in users]
        return jsonify({'payload': encrypt_payload(data)})

    if request.method == 'POST':
        d = request.json or {}
        if d.get('rol') not in ['Administrador', 'Ventas', 'Contador']:
            return jsonify({'error': 'Rol no permitido'}), 400
        h = bcrypt.hashpw(d['contrasenia'].encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
        u = Usuario(usuario=d['usuario'], contrasenia=h, nombre_completo=d['nombre_completo'], rol=d['rol'])
        db.session.add(u)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'usuario_creado'})
        return jsonify({'message': 'Usuario creado'})

    if request.method == 'PUT' and id_usuario:
        u = Usuario.query.get_or_404(id_usuario)
        d = request.json or {}
        u.usuario = d.get('usuario', u.usuario)
        u.nombre_completo = d.get('nombre_completo', u.nombre_completo)
        if d.get('rol') in ['Administrador', 'Ventas', 'Contador']:
            u.rol = d['rol']
        if d.get('contrasenia'):
            u.contrasenia = bcrypt.hashpw(d['contrasenia'].encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'usuario_editado'})
        return jsonify({'message': 'Usuario actualizado'})

    if request.method == 'DELETE' and id_usuario:
        u = Usuario.query.get_or_404(id_usuario)
        db.session.delete(u)
        db.session.commit()
        socketio.emit('actualizacion_dashboard', {'tipo': 'usuario_eliminado'})
        return jsonify({'message': 'Usuario revocado'})

# ===============================================================
# ENDPOINT RESUMEN EJECUTIVO: VENDEDORES Y TOP CLIENTES
# ===============================================================
@app.route('/api/dashboard-resumen-entidades', methods=['GET'])
@token_required
def api_dashboard_resumen_entidades(cur_user, is_client):
    if is_client:
        return jsonify({'error': 'Acceso no permitido'}), 403

    ventas_all = db.session.query(Venta, Usuario, Cliente)        .outerjoin(Usuario, Venta.id_vendedor == Usuario.id_usuario)        .outerjoin(Cliente, Venta.id_cliente == Cliente.id_cliente).all()

    ven_stats, cli_stats = {}, {}
    for v, u, c in ventas_all:
        nom_v = u.nombre_completo if u else f'Asesor {v.id_vendedor}'
        if nom_v not in ven_stats:
            ven_stats[nom_v] = {'vendedor': nom_v, 'ventas': 0, 'facturacion': 0.0}
        ven_stats[nom_v]['ventas'] += 1
        ven_stats[nom_v]['facturacion'] += float(v.total_pagado)

        cid = v.id_cliente
        if cid not in cli_stats:
            cli_stats[cid] = {
                'id_cliente': cid,
                'cliente': c.nombre_completo if c else cid,
                'tipo': c.tipo_cliente if c else 'Particular',
                'compras': 0,
                'total': 0.0
            }
        cli_stats[cid]['compras'] += 1
        cli_stats[cid]['total'] += float(v.total_pagado)

    top_vendedores = sorted(ven_stats.values(), key=lambda x: x['facturacion'], reverse=True)
    for tv in top_vendedores:
        tv['ticket_promedio'] = round(tv['facturacion'] / tv['ventas'], 2) if tv['ventas'] else 0.0

    top_clientes = sorted(cli_stats.values(), key=lambda x: x['total'], reverse=True)[:10]

    return jsonify({'payload': encrypt_payload({
        'vendedores': top_vendedores,
        'clientes': top_clientes
    })})
# ===============================================================
# PUNTO DE ENTRADA PRINCIPAL
# ===============================================================
if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=80, debug=True)
