# Mueble arte - Clásicos & Contemporáneos

## Sistema Integral de Gestión, Analítica y Predicción de Desperdicio de Materiales

---

## 1. Arquitectura y Estructura de Carpetas del Proyecto

A continuación se detalla la estructura exacta de directorios y archivos que componen el sistema dentro del servidor y el paquete de entrega:

```text
carpinteria_app/
├── app.py                                    # Servidor Backend Flask, ORM SQLAlchemy, APIs REST, JWT, AES-256-CBC y WebSockets
├── mueble_arte_db.sql                        # Script de creación e inicialización de la base de datos MySQL con dataset completo
├── dataset_carpinteria_real.csv              # Dataset histórico utilizado para estructurar y entrenar el modelo predictivo
├── ml_engine/
│   ├── __init__.py                           # Inicializador del paquete de Machine Learning
│   ├── modelo_ml.py                          # Pipeline de Regresión Lineal, predicción de merma, retal (m²) y viruta (kg)
│   └── modelo_desperdicio_carpintech.pkl     # Modelo predictivo serializado listo para inferencia en tiempo real
├── templates/
│   ├── login.html                            # Interfaz de autenticación y registro de clientes
│   └── dashboard.html                        # Interfaz principal: Home, Cotizador, Dashboard Gerencial, Dashboard ML y CRUD
├── static/
│   ├── css/
│   │   └── styles.css                        # Hoja de estilos corporativos y reglas de diseño
│   └── js/
│       └── carpintech_crud.js                # Controlador auxiliar de operaciones CRUD y sincronización
├── java_security/
│   ├── SecurityService.java                  # Módulo de interoperabilidad criptográfica AES-256 en Java
│   └── SecurityService.class                 # Bytecode compilado para pruebas de cifrado/descifrado
├── Topologías/                               # Topologías de red y simulación de infraestructura (Cisco Packet Tracer)
│   ├── ESTADO ACTUAL RED - TALLER.pkt        # Simulación del estado actual de red plana (192.168.0.0/24)
│   └── MEJORA DE RED - TALLER.pkt            # Simulación de la propuesta segmentada (192.168.10.0/24) con DHCP y aislamiento
└── venv/                                     # Entorno virtual de Python con dependencias instaladas
```

---

## 2. Metodología de Entrenamiento del Modelo de Machine Learning (`ml_engine/modelo_ml.py`)

Cuando se fabrica un mueble a medida, siempre existe pérdida de materia prima en cortes, retales y viruta. Para evitar cálculos empíricos imprecisos, se entrenó un modelo predictivo en 4 etapas que dio origen al módulo `modelo_ml.py` y al modelo serializado (`modelo_desperdicio_carpintech.pkl`):

1. **Simulación del Historial del Taller (10.000 Pedidos / `dataset_carpinteria_real.csv`):**
   * A partir de las reglas reales de producción (6 tipos de muebles y 8 materiales con distintos niveles de dureza y dificultad de corte), se estructuró el dataset histórico añadiendo variación estadística normal (`np.random.normal`) para representar el comportamiento real del taller.
2. **Preprocesamiento y División (`80 % / 20 %`):**
   * **`OneHotEncoder`:** Transforma variables categóricas (tipo de mueble y material) en matrices binarias ($0$ y $1$).
   * **`StandardScaler`:** Estandariza las dimensiones físicas (largo, ancho, alto y cantidad de piezas) a una misma escala numérica.
   * **`train_test_split`:** Divide los datos en $8.000$ registros de entrenamiento ($80\ \%$) y $2.000$ registros de prueba ($20\ \%$).
3. **Evaluación Comparativa de Algoritmos:**
   * Se entrenaron y compararon 5 algoritmos mediante un `Pipeline` automatizado: `LinearRegression`, `Ridge`, `GradientBoosting`, `ElasticNet` y `Lasso`.
   * **Modelo Ganador:** La **Regresión Lineal** obtuvo el mejor desempeño con un coeficiente de determinación **$R^2 = 0.8180$** ($81.8\ \%$ de varianza explicada sin sobreajuste), aprovechando todas las variables geométricas y de material del pedido.
4. **Serialización e Inferencia en Tiempo Real (`joblib`):**
   * El modelo ganador se exportó mediante `joblib.dump` en `ml_engine/modelo_desperdicio_carpintech.pkl` para realizar inferencias instantáneas en la web a través de `predecir_desperdicio_pedido()`, entregando antes de cortar:
     * **Porcentaje total de merma ($\text{\%}$).**
     * **Retal reutilizable ($\text{m}^2$):** Equivalente al $72\ \%$ del sobrante aprovechable para piezas menores o entamborados.
     * **Viruta de desecho ($\text{kg}$):** Equivalente al $28\ \%$ restante convertido en aserrín.

---

## 3. Diseño de Red, Topología e Infraestructura de Comunicaciones (`Topologías/`)

El proyecto incorpora la arquitectura de red corporativa y en la nube (adjunta en la carpeta `Topologías/` del paquete de entrega), diseñada para garantizar disponibilidad, segmentación y seguridad en las comunicaciones:

* **Topología de Estado Actual (`ESTADO ACTUAL RED - TALLER.pkt` — Red Plana `192.168.0.0/24`):** Modela la red inicial sin segmentación lógica, donde clientes/invitados, equipos internos y cámaras IP comparten el mismo dominio de difusión (`192.168.0.0/24`), evidenciando conectividad no deseada desde clientes hacia las cámaras IP.
* **Topología de Propuesta de Mejora (`MEJORA DE RED - TALLER.pkt` — Red Segmentada `192.168.10.0/24`):** Incorpora aislamiento de la red de invitados frente a los dispositivos internos y cámaras IP, configuración inalámbrica de banda dual (**2.4 GHz** y **5 GHz**) y asignación determinística mediante **reservas DHCP** vinculadas por dirección MAC.
* **Interconexión con la Nube (GCP):** Comunicación desde las estaciones administrativas/comerciales del taller (Administración, Contabilidad y Ventas) hacia la instancia alojada en Google Cloud Platform (GCP) mediante IP pública estática.
* **Control de Puertos y Seguridad Perimetral (Firewall / ACL):**
  * **Puerto TCP `80` (HTTP):** Habilitado para el acceso de clientes y personal administrativo a la plataforma web.
  * **Puerto TCP `3306` (MySQL):** Restringido para consultas administrativas y gestión de base de datos en localhost (`127.0.0.1`).
  * **Puerto TCP `22` (SSH):** Canal cifrado exclusivo para administración remota del servidor Linux.
  * **Cifrado en Tránsito y Autenticación:** Complementado a nivel de aplicación mediante tokens **JWT**, contraseñas con hash **Bcrypt** y cifrado simétrico **AES-256-CBC** en las peticiones sensibles de la API.

---

## 4. Configuración Inicial de la Máquina Virtual (Google Cloud)

### 4.1. Acceso y Reglas de Firewall

1. Ingresar a la consola de **Google Cloud Platform (GCP)** -> **Compute Engine** -> **Instancias de VM**.
2. Asegurarse de que la instancia tenga habilitado el tráfico **HTTP** en la configuración de red (creando una regla de firewall permitiendo el puerto TCP `80` hacia `0.0.0.0/0`).
3. Conectarse a la terminal del servidor haciendo clic en el botón **SSH** de la instancia.

### 4.2. Actualización del Sistema e Instalación de Paquetes Base

Ejecutar los siguientes comandos en la terminal SSH para instalar Python, MySQL Server, el compilador de Java y utilidades:

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y python3 python3-pip python3-venv mysql-server default-jdk zip unzip
```

---

## 5. Creación de Carpetas, Entorno Virtual e Instalación de Dependencias Python

### 5.1. Crear el árbol de directorios del proyecto

```bash
mkdir -p /home/nc42792/carpinteria_app/ml_engine
mkdir -p /home/nc42792/carpinteria_app/templates
mkdir -p /home/nc42792/carpinteria_app/static/css
mkdir -p /home/nc42792/carpinteria_app/static/js
mkdir -p /home/nc42792/carpinteria_app/java_security
cd /home/nc42792/carpinteria_app
```

### 5.2. Crear el entorno virtual (`venv`) e instalar librerías de Python

```bash
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install flask flask-sqlalchemy flask-socketio eventlet pymysql cryptography pyjwt bcrypt scikit-learn pandas numpy joblib
```

---

## 6. Configuración de la Base de Datos MySQL

1. Iniciar y habilitar el servicio de MySQL:

   ```bash
   sudo systemctl start mysql
   sudo systemctl enable mysql
   ```

2. Crear el archivo SQL en la raíz del proyecto y pegar el script de la base de datos:

   ```bash
   nano /home/nc42792/carpinteria_app/mueble_arte_db.sql
   ```

   *(Pegar el código completo de `mueble_arte_db.sql`. Guardar con `Ctrl + O`, `Enter`, y salir con `Ctrl + X`).*

3. Crear la base de datos, el usuario administrativo e importar las tablas y registros completos:

   ```bash
   sudo mysql -u root -e "
   CREATE DATABASE IF NOT EXISTS mueble_arte_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   CREATE USER IF NOT EXISTS 'admin_remoto'@'127.0.0.1' IDENTIFIED BY 'Admin_Remoto_2026!';
   GRANT ALL PRIVILEGES ON mueble_arte_db.* TO 'admin_remoto'@'127.0.0.1';
   FLUSH PRIVILEGES;
   "
   sudo mysql -u root mueble_arte_db < /home/nc42792/carpinteria_app/mueble_arte_db.sql
   ```

   *(Nota: En la tabla `usuarios` únicamente existen cuentas operativas con roles `Administrador`, `Ventas` y `Contador`; los artesanos se mantienen como atributo informativo `artesano_nombre` dentro de `pedidos` para consulta y filtrado).*

---

## 7. Carga de los Archivos de Código Fuente

Ubicar cada archivo en su carpeta correspondiente utilizando el editor `nano` (o subiéndolos mediante el botón **Subir archivo** de la consola SSH):

1. **Backend Principal (`app.py`) y Dataset (`dataset_carpinteria_real.csv`):**

   ```bash
   nano /home/nc42792/carpinteria_app/app.py
   ```

   *(Pegar el código completo de `app.py`. Guardar con `Ctrl + O`, `Enter`, y salir con `Ctrl + X`).*

2. **Motor Predictivo de Machine Learning (`ml_engine/modelo_ml.py` y `modelo_desperdicio_carpintech.pkl`):**

   ```bash
   touch /home/nc42792/carpinteria_app/ml_engine/__init__.py
   nano /home/nc42792/carpinteria_app/ml_engine/modelo_ml.py
   ```

   *(Pegar el código completo de `modelo_ml.py`. Guardar con `Ctrl + O`, `Enter`, y salir con `Ctrl + X`).*

3. **Plantillas HTML (`templates/login.html` y `templates/dashboard.html`):**

   ```bash
   nano /home/nc42792/carpinteria_app/templates/login.html
   ```

   *(Pegar el código completo de `login.html`. Guardar con `Ctrl + O`, `Enter`, y salir con `Ctrl + X`).*

   ```bash
   nano /home/nc42792/carpinteria_app/templates/dashboard.html
   ```

   *(Pegar el código completo de `dashboard.html`. Guardar con `Ctrl + O`, `Enter`, y salir con `Ctrl + X`).*

4. **Estilos CSS y Scripts JS (`static/css/styles.css` y `static/js/carpintech_crud.js`):**

   ```bash
   nano /home/nc42792/carpinteria_app/static/css/styles.css
   ```

   *(Pegar el código completo de `styles.css`. Guardar con `Ctrl + O`, `Enter`, y salir con `Ctrl + X`).*

   ```bash
   nano /home/nc42792/carpinteria_app/static/js/carpintech_crud.js
   ```

   *(Pegar el código completo de `carpintech_crud.js`. Guardar con `Ctrl + O`, `Enter`, y salir con `Ctrl + X`).*

5. **Módulo de Seguridad Java (`java_security/SecurityService.java`):**

   ```bash
   nano /home/nc42792/carpinteria_app/java_security/SecurityService.java
   ```

   *(Pegar el código completo de `SecurityService.java`. Guardar con `Ctrl + O`, `Enter`, y salir con `Ctrl + X`).*

   Compilar la clase Java:

   ```bash
   javac /home/nc42792/carpinteria_app/java_security/SecurityService.java
   ```

---

## 8. Ejecución del Servidor y Acceso a la Aplicación Web

1. Asegurarse de que el puerto `80` esté libre e iniciar la aplicación con privilegios de administrador:

   ```bash
   sudo fuser -k 80/tcp 2>/dev/null || true
   cd /home/nc42792/carpinteria_app
   sudo /home/nc42792/carpinteria_app/venv/bin/python3 app.py
   ```

   *(Para dejar el servidor ejecutándose en segundo plano de forma continua tras cerrar la consola SSH, ejecutar: `sudo nohup /home/nc42792/carpinteria_app/venv/bin/python3 /home/nc42792/carpinteria_app/app.py > server.log 2>&1 &`).*

2. **Ingreso desde el Navegador Web:**
   * Copiar la **IP Externa** de la máquina virtual desde la consola de Google Cloud.
   * Abrir un navegador web e ingresar a:

     ```text
     http://<IP_EXTERNA_DE_LA_VM>/
     ```

   * Iniciar sesión con cualquiera de los perfiles configurados:
     * **Administrador:** `carlos.admin` / `admin123` (Acceso total: Dashboard Gerencial con tablas ejecutivas de vendedores y top clientes, Modelo Predictivo ML y tablas CRUD con creación, edición y eliminación).
     * **Contador:** `ana.conta` / `ana789` (Acceso a Dashboard Gerencial, Modelo Predictivo ML y consultas financieras).
     * **Ventas:** `sofia.ventas` / `sofia1` (Acceso a Dashboard Gerencial comercial, creación y edición de pedidos y clientes).
     * **Cliente:** Registro autónomo desde la pestaña *"Crear Cuenta"* para utilizar el cotizador interactivo multiproducto.