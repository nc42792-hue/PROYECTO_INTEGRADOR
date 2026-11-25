/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mueble_arte_db
-- ------------------------------------------------------
-- Server version	11.8.6-MariaDB-0+deb13u1 from Debian

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` varchar(50) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `tipo_cliente` varchar(50) NOT NULL DEFAULT 'Particular',
  `numero_pedidos` int(11) NOT NULL DEFAULT 0,
  `contrasenia` varchar(255) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES
('CLI-101','Inmobiliaria Alfa S.A.S.','3101112233',NULL,'Empresa',12,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-102','Arquitectura & Diseños Modernos','3112223344',NULL,'Empresa',14,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-103','Restaurante El Roble','3123334455',NULL,'Empresa',14,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-104','Hotel Casona Real','3134445566',NULL,'Empresa',14,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-105','Constructora Boyacá','3156667788',NULL,'Empresa',14,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-106','Café del Valle','3167778899',NULL,'Empresa',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-107','Colegio Campestre','3178889900',NULL,'Empresa',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-108','Carlos Eduardo Mendoza','3001234567',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-109','Andrea Valentina Gómez','3012345678',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-110','Juan Felipe Salamanca','3023456789',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-111','Diana Marcela Rojas','3034567890',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-112','Gustavo Adolfo Becerra','3045678901',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-113','Lina María Rodríguez','3056789012',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-114','Santiago Ortiz','3067890123',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-115','Claudia Niño','3078901234',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-116','Andrés Castro','3089012345',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-117','Natalia Guerrero','3090123456',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-118','Jorge Vargas','3109876543',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-119','Paula Alarcón','3118765432',NULL,'Particular',13,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-120','Mauricio Pinzón','3127654321',NULL,'Particular',10,'$2b$12$acfpCcoe7Prcegz/pgXgJ.9Q7OBZeNePe6onS9kD90BGmqC.N.eiC'),
('CLI-488','Sara','3113428402',NULL,'Particular',3,'$2b$12$PKqE84yr/fik9xq4fM7wYuPGab7pGHaqK0WBlVJewySqinKhp7DqK');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `materiales`
--

DROP TABLE IF EXISTS `materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiales` (
  `id_material` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_material` varchar(100) NOT NULL,
  `unidad_medida` varchar(20) NOT NULL,
  `stock_disponible` decimal(10,2) NOT NULL DEFAULT 0.00,
  `costo_unitario` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_material`),
  UNIQUE KEY `nombre_material` (`nombre_material`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiales`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `materiales` WRITE;
/*!40000 ALTER TABLE `materiales` DISABLE KEYS */;
INSERT INTO `materiales` VALUES
(1,'Madecor 15mm (Melamina)','Lámina',160.00,120000.00),
(2,'Triplex Okume','Lámina',95.00,95000.00),
(3,'Triplex Otobo','Lámina',85.00,88000.00),
(4,'Triplex Flor Morado','Lámina',75.00,110000.00),
(5,'Madera Cedro','m2',55.00,85000.00),
(6,'Madera Flor Morado','m2',40.00,92000.00),
(7,'Madera Pino','m2',70.00,60000.00),
(8,'Lámina Alto Brillo/Mate','Lámina',45.00,140000.00);
/*!40000 ALTER TABLE `materiales` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedido` varchar(30) NOT NULL,
  `id_cliente` varchar(50) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `id_artesano` int(11) DEFAULT NULL,
  `tipo_mueble` varchar(100) NOT NULL,
  `material_principal` varchar(100) NOT NULL,
  `largo_cm` decimal(8,2) NOT NULL,
  `ancho_cm` decimal(8,2) NOT NULL,
  `alto_cm` decimal(8,2) NOT NULL,
  `cantidad_piezas` int(11) NOT NULL,
  `requiere_canto` tinyint(1) NOT NULL DEFAULT 0,
  `requiere_laca_sellador` tinyint(1) NOT NULL DEFAULT 0,
  `desperdicio_total_pct` decimal(5,2) NOT NULL,
  `desperdicio_reutilizable_m2` decimal(8,2) NOT NULL,
  `desperdicio_inservible_viruta_kg` decimal(8,2) NOT NULL,
  `monto_total` decimal(12,2) NOT NULL,
  `dias_fabricacion` int(11) NOT NULL DEFAULT 15,
  `estado_pedido` enum('Pendiente','En Producción','En Acabado','Completado','Cancelado') DEFAULT 'Pendiente',
  `fecha_pedido` date NOT NULL,
  `fecha_entrega_estimada` date NOT NULL,
  `artesano_nombre` varchar(100) DEFAULT 'Taller Maestro',
  PRIMARY KEY (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_vendedor` (`id_vendedor`),
  KEY `id_artesano` (`id_artesano`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON UPDATE CASCADE,
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`id_vendedor`) REFERENCES `usuarios` (`id_usuario`) ON UPDATE CASCADE,
  CONSTRAINT `pedidos_ibfk_3` FOREIGN KEY (`id_artesano`) REFERENCES `usuarios` (`id_usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES
('PED-1001','CLI-101',14,NULL,'Closet Modular','Madecor 15mm (Melamina)',81.00,46.00,71.00,5,0,0,11.90,1.80,3.50,1236000.00,11,'En Producción','2026-01-04','2026-01-15','Jorge Tello'),
('PED-1002','CLI-102',15,NULL,'Cocina Integral','Triplex Okume',82.00,47.00,72.00,6,0,0,12.80,2.60,5.00,3885000.00,12,'En Acabado','2026-01-07','2026-01-19','Andrés Silva'),
('PED-1003','CLI-103',16,NULL,'Puerta Tamborada','Triplex Otobo',83.00,48.00,73.00,7,0,0,13.70,3.40,6.50,452000.00,13,'Completado','2026-01-10','2026-01-23','Ricardo Palacios'),
('PED-1004','CLI-104',17,NULL,'Piso en Madera','Triplex Flor Morado',84.00,49.00,74.00,8,0,0,14.60,4.20,8.00,190000.00,14,'Pendiente','2026-01-13','2026-01-27','Manuel Ortiz'),
('PED-1005','CLI-105',18,NULL,'Escalera en Madera','Madera Cedro',85.00,50.00,75.00,9,0,0,15.50,5.00,9.50,2660000.00,15,'En Producción','2026-01-16','2026-01-31','Pedro Alcázar'),
('PED-1006','CLI-106',19,NULL,'Mueble de Baño','Madera Flor Morado',86.00,51.00,76.00,10,0,0,16.40,5.80,11.00,670000.00,16,'En Acabado','2026-01-19','2026-02-04','Sergio Ramos'),
('PED-1007','CLI-107',20,NULL,'Closet Modular','Madera Pino',87.00,52.00,77.00,11,0,0,17.30,1.00,12.50,1332000.00,17,'Completado','2026-01-22','2026-02-08','Mateo Díaz'),
('PED-1008','CLI-108',14,NULL,'Cocina Integral','Lámina Alto Brillo/Mate',88.00,53.00,78.00,12,0,0,18.20,1.80,14.00,4165000.00,18,'Pendiente','2026-01-25','2026-02-12','Lucas Herrera'),
('PED-1009','CLI-109',15,NULL,'Puerta Tamborada','Madecor 15mm (Melamina)',89.00,54.00,79.00,13,0,0,19.10,2.60,2.00,483000.00,19,'En Producción','2026-01-28','2026-02-16','Jorge Tello'),
('PED-1010','CLI-110',16,NULL,'Piso en Madera','Triplex Okume',90.00,55.00,80.00,14,0,0,20.00,3.40,3.50,142000.00,20,'En Acabado','2026-01-31','2026-02-20','Andrés Silva'),
('PED-1011','CLI-111',17,NULL,'Escalera en Madera','Triplex Otobo',91.00,56.00,81.00,15,0,0,20.90,4.20,5.00,2884000.00,21,'Completado','2026-02-03','2026-02-24','Ricardo Palacios'),
('PED-1012','CLI-112',18,NULL,'Mueble de Baño','Triplex Flor Morado',92.00,57.00,82.00,16,0,0,11.00,5.00,6.50,721000.00,22,'Pendiente','2026-02-06','2026-02-28','Manuel Ortiz'),
('PED-1013','CLI-113',19,NULL,'Closet Modular','Madera Cedro',93.00,58.00,83.00,17,0,0,11.90,5.80,8.00,1428000.00,23,'En Producción','2026-02-09','2026-03-04','Pedro Alcázar'),
('PED-1014','CLI-114',20,NULL,'Cocina Integral','Madera Flor Morado',94.00,59.00,84.00,18,0,0,12.80,1.00,9.50,4445000.00,24,'En Acabado','2026-02-12','2026-03-08','Sergio Ramos'),
('PED-1015','CLI-115',14,NULL,'Puerta Tamborada','Madera Pino',95.00,60.00,85.00,19,0,0,13.70,1.80,11.00,361000.00,25,'Completado','2026-02-15','2026-03-12','Mateo Díaz'),
('PED-1016','CLI-116',15,NULL,'Piso en Madera','Lámina Alto Brillo/Mate',96.00,61.00,86.00,20,0,0,14.60,2.60,12.50,154000.00,26,'Pendiente','2026-02-18','2026-03-16','Lucas Herrera'),
('PED-1017','CLI-117',16,NULL,'Escalera en Madera','Madecor 15mm (Melamina)',97.00,62.00,87.00,21,0,0,15.50,3.40,14.00,3108000.00,27,'En Producción','2026-02-21','2026-03-20','Jorge Tello'),
('PED-1018','CLI-118',17,NULL,'Mueble de Baño','Triplex Okume',98.00,63.00,88.00,22,0,0,16.40,4.20,2.00,774000.00,10,'En Acabado','2026-02-24','2026-03-06','Andrés Silva'),
('PED-1019','CLI-119',18,NULL,'Closet Modular','Triplex Otobo',99.00,64.00,89.00,23,0,0,17.30,5.00,3.50,1524000.00,11,'Completado','2026-02-27','2026-03-10','Ricardo Palacios'),
('PED-1020','CLI-120',19,NULL,'Cocina Integral','Triplex Flor Morado',100.00,65.00,90.00,24,0,0,18.20,5.80,5.00,3325000.00,12,'Pendiente','2026-03-02','2026-03-14','Manuel Ortiz'),
('PED-1021','CLI-101',20,NULL,'Puerta Tamborada','Madera Cedro',101.00,66.00,91.00,25,0,0,19.10,1.00,6.50,391000.00,13,'En Producción','2026-03-05','2026-03-18','Pedro Alcázar'),
('PED-1022','CLI-102',14,NULL,'Piso en Madera','Madera Flor Morado',102.00,67.00,92.00,26,0,0,20.00,1.80,8.00,166000.00,14,'En Acabado','2026-03-08','2026-03-22','Sergio Ramos'),
('PED-1023','CLI-103',15,NULL,'Escalera en Madera','Madera Pino',103.00,68.00,93.00,27,0,0,20.90,2.60,9.50,3332000.00,15,'Completado','2026-03-11','2026-03-26','Mateo Díaz'),
('PED-1024','CLI-104',16,NULL,'Mueble de Baño','Lámina Alto Brillo/Mate',104.00,69.00,94.00,28,0,0,11.00,3.40,11.00,826000.00,16,'Pendiente','2026-03-14','2026-03-30','Lucas Herrera'),
('PED-1025','CLI-105',17,NULL,'Closet Modular','Madecor 15mm (Melamina)',105.00,70.00,95.00,29,0,0,11.90,4.20,12.50,1140000.00,17,'En Producción','2026-03-17','2026-04-03','Jorge Tello'),
('PED-1026','CLI-106',18,NULL,'Cocina Integral','Triplex Okume',106.00,71.00,96.00,30,0,0,12.80,5.00,14.00,3605000.00,18,'En Acabado','2026-03-20','2026-04-07','Andrés Silva'),
('PED-1027','CLI-107',19,NULL,'Puerta Tamborada','Triplex Otobo',107.00,72.00,97.00,31,0,0,13.70,5.80,2.00,422000.00,19,'Completado','2026-03-23','2026-04-11','Ricardo Palacios'),
('PED-1028','CLI-108',20,NULL,'Piso en Madera','Triplex Flor Morado',108.00,73.00,98.00,32,0,0,14.60,1.00,3.50,178000.00,20,'Pendiente','2026-03-26','2026-04-15','Manuel Ortiz'),
('PED-1029','CLI-109',14,NULL,'Escalera en Madera','Madera Cedro',109.00,74.00,99.00,33,0,0,15.50,1.80,5.00,3556000.00,21,'En Producción','2026-03-29','2026-04-19','Pedro Alcázar'),
('PED-1030','CLI-110',15,NULL,'Mueble de Baño','Madera Flor Morado',110.00,75.00,100.00,4,0,0,16.40,2.60,6.50,618000.00,22,'En Acabado','2026-04-01','2026-04-23','Sergio Ramos'),
('PED-1031','CLI-111',16,NULL,'Closet Modular','Madera Pino',111.00,76.00,101.00,5,0,0,17.30,3.40,8.00,1236000.00,23,'Completado','2026-04-04','2026-04-27','Mateo Díaz'),
('PED-1032','CLI-112',17,NULL,'Cocina Integral','Lámina Alto Brillo/Mate',112.00,77.00,102.00,6,0,0,18.20,4.20,9.50,3885000.00,24,'Pendiente','2026-04-07','2026-05-01','Lucas Herrera'),
('PED-1033','CLI-113',18,NULL,'Puerta Tamborada','Madecor 15mm (Melamina)',113.00,78.00,103.00,7,0,0,19.10,5.00,11.00,452000.00,25,'En Producción','2026-04-10','2026-05-05','Jorge Tello'),
('PED-1034','CLI-114',19,NULL,'Piso en Madera','Triplex Okume',114.00,79.00,104.00,8,0,0,20.00,5.80,12.50,190000.00,26,'En Acabado','2026-04-13','2026-05-09','Andrés Silva'),
('PED-1035','CLI-115',20,NULL,'Escalera en Madera','Triplex Otobo',115.00,80.00,105.00,9,0,0,20.90,1.00,14.00,2660000.00,27,'Completado','2026-04-16','2026-05-13','Ricardo Palacios'),
('PED-1036','CLI-116',14,NULL,'Mueble de Baño','Triplex Flor Morado',116.00,81.00,106.00,10,0,0,11.00,1.80,2.00,670000.00,10,'Pendiente','2026-04-19','2026-04-29','Manuel Ortiz'),
('PED-1037','CLI-117',15,NULL,'Closet Modular','Madera Cedro',117.00,82.00,107.00,11,0,0,11.90,2.60,3.50,1332000.00,11,'En Producción','2026-04-22','2026-05-03','Pedro Alcázar'),
('PED-1038','CLI-118',16,NULL,'Cocina Integral','Madera Flor Morado',118.00,83.00,108.00,12,0,0,12.80,3.40,5.00,4165000.00,12,'En Acabado','2026-04-25','2026-05-07','Sergio Ramos'),
('PED-1039','CLI-119',17,NULL,'Puerta Tamborada','Madera Pino',119.00,84.00,109.00,13,0,0,13.70,4.20,6.50,483000.00,13,'Completado','2026-04-28','2026-05-11','Mateo Díaz'),
('PED-1040','CLI-120',18,NULL,'Piso en Madera','Lámina Alto Brillo/Mate',120.00,85.00,110.00,14,0,0,14.60,5.00,8.00,142000.00,14,'Pendiente','2026-05-01','2026-05-15','Lucas Herrera'),
('PED-1041','CLI-101',19,NULL,'Escalera en Madera','Madecor 15mm (Melamina)',121.00,86.00,111.00,15,0,0,15.50,5.80,9.50,2884000.00,15,'En Producción','2026-05-04','2026-05-19','Jorge Tello'),
('PED-1042','CLI-102',20,NULL,'Mueble de Baño','Triplex Okume',122.00,87.00,112.00,16,0,0,16.40,1.00,11.00,721000.00,16,'En Acabado','2026-05-07','2026-05-23','Andrés Silva'),
('PED-1043','CLI-103',14,NULL,'Closet Modular','Triplex Otobo',123.00,88.00,113.00,17,0,0,17.30,1.80,12.50,1428000.00,17,'Completado','2026-05-10','2026-05-27','Ricardo Palacios'),
('PED-1044','CLI-104',15,NULL,'Cocina Integral','Triplex Flor Morado',124.00,89.00,114.00,18,0,0,18.20,2.60,14.00,4445000.00,18,'Pendiente','2026-05-13','2026-05-31','Manuel Ortiz'),
('PED-1045','CLI-105',16,NULL,'Puerta Tamborada','Madera Cedro',125.00,90.00,115.00,19,0,0,19.10,3.40,2.00,361000.00,19,'En Producción','2026-05-16','2026-06-04','Pedro Alcázar'),
('PED-1046','CLI-106',17,NULL,'Piso en Madera','Madera Flor Morado',126.00,91.00,116.00,20,0,0,20.00,4.20,3.50,154000.00,20,'En Acabado','2026-05-19','2026-06-08','Sergio Ramos'),
('PED-1047','CLI-107',18,NULL,'Escalera en Madera','Madera Pino',127.00,92.00,117.00,21,0,0,20.90,5.00,5.00,3108000.00,21,'Completado','2026-05-22','2026-06-12','Mateo Díaz'),
('PED-1048','CLI-108',19,NULL,'Mueble de Baño','Lámina Alto Brillo/Mate',128.00,93.00,118.00,22,0,0,11.00,5.80,6.50,774000.00,22,'Pendiente','2026-05-25','2026-06-16','Lucas Herrera'),
('PED-1049','CLI-109',20,NULL,'Closet Modular','Madecor 15mm (Melamina)',129.00,94.00,119.00,23,0,0,11.90,1.00,8.00,1524000.00,23,'En Producción','2026-05-28','2026-06-20','Jorge Tello'),
('PED-1050','CLI-110',14,NULL,'Cocina Integral','Triplex Okume',130.00,95.00,120.00,24,0,0,12.80,1.80,9.50,3325000.00,24,'En Acabado','2026-05-31','2026-06-24','Andrés Silva'),
('PED-1051','CLI-111',15,NULL,'Puerta Tamborada','Triplex Otobo',131.00,96.00,121.00,25,0,0,13.70,2.60,11.00,391000.00,25,'Completado','2026-06-03','2026-06-28','Ricardo Palacios'),
('PED-1052','CLI-112',16,NULL,'Piso en Madera','Triplex Flor Morado',132.00,97.00,122.00,26,0,0,14.60,3.40,12.50,166000.00,26,'Pendiente','2026-06-06','2026-07-02','Manuel Ortiz'),
('PED-1053','CLI-113',17,NULL,'Escalera en Madera','Madera Cedro',133.00,98.00,123.00,27,0,0,15.50,4.20,14.00,3332000.00,27,'En Producción','2026-06-09','2026-07-06','Pedro Alcázar'),
('PED-1054','CLI-114',18,NULL,'Mueble de Baño','Madera Flor Morado',134.00,99.00,124.00,28,0,0,16.40,5.00,2.00,826000.00,10,'En Acabado','2026-06-12','2026-06-22','Sergio Ramos'),
('PED-1055','CLI-115',19,NULL,'Closet Modular','Madera Pino',135.00,100.00,125.00,29,0,0,17.30,5.80,3.50,1140000.00,11,'Completado','2026-06-15','2026-06-26','Mateo Díaz'),
('PED-1056','CLI-116',20,NULL,'Cocina Integral','Lámina Alto Brillo/Mate',136.00,101.00,126.00,30,0,0,18.20,1.00,5.00,3605000.00,12,'Pendiente','2026-06-18','2026-06-30','Lucas Herrera'),
('PED-1057','CLI-117',14,NULL,'Puerta Tamborada','Madecor 15mm (Melamina)',137.00,102.00,127.00,31,0,0,19.10,1.80,6.50,422000.00,13,'En Producción','2026-06-21','2026-07-04','Jorge Tello'),
('PED-1058','CLI-118',15,NULL,'Piso en Madera','Triplex Okume',138.00,103.00,128.00,32,0,0,20.00,2.60,8.00,178000.00,14,'En Acabado','2026-06-24','2026-07-08','Andrés Silva'),
('PED-1059','CLI-119',16,NULL,'Escalera en Madera','Triplex Otobo',139.00,104.00,129.00,33,0,0,20.90,3.40,9.50,3556000.00,15,'Completado','2026-06-27','2026-07-12','Ricardo Palacios'),
('PED-1060','CLI-120',17,NULL,'Mueble de Baño','Triplex Flor Morado',140.00,105.00,130.00,4,0,0,11.00,4.20,11.00,618000.00,16,'Pendiente','2026-06-30','2026-07-16','Manuel Ortiz'),
('PED-1061','CLI-101',18,NULL,'Closet Modular','Madera Cedro',141.00,106.00,131.00,5,0,0,11.90,5.00,12.50,1236000.00,17,'En Producción','2026-07-03','2026-07-20','Pedro Alcázar'),
('PED-1062','CLI-102',19,NULL,'Cocina Integral','Madera Flor Morado',142.00,107.00,132.00,6,0,0,12.80,5.80,14.00,3885000.00,18,'En Acabado','2026-07-06','2026-07-24','Sergio Ramos'),
('PED-1063','CLI-103',20,NULL,'Puerta Tamborada','Madera Pino',143.00,108.00,133.00,7,0,0,13.70,1.00,2.00,452000.00,19,'Completado','2026-07-09','2026-07-28','Mateo Díaz'),
('PED-1064','CLI-104',14,NULL,'Piso en Madera','Lámina Alto Brillo/Mate',144.00,109.00,134.00,8,0,0,14.60,1.80,3.50,190000.00,20,'Pendiente','2026-07-12','2026-08-01','Lucas Herrera'),
('PED-1065','CLI-105',15,NULL,'Escalera en Madera','Madecor 15mm (Melamina)',145.00,110.00,135.00,9,0,0,15.50,2.60,5.00,2660000.00,21,'En Producción','2026-07-15','2026-08-05','Jorge Tello'),
('PED-1066','CLI-106',16,NULL,'Mueble de Baño','Triplex Okume',146.00,111.00,136.00,10,0,0,16.40,3.40,6.50,670000.00,22,'En Acabado','2026-07-18','2026-08-09','Andrés Silva'),
('PED-1067','CLI-107',17,NULL,'Closet Modular','Triplex Otobo',147.00,112.00,137.00,11,0,0,17.30,4.20,8.00,1332000.00,23,'Completado','2026-07-21','2026-08-13','Ricardo Palacios'),
('PED-1068','CLI-108',18,NULL,'Cocina Integral','Triplex Flor Morado',148.00,113.00,138.00,12,0,0,18.20,5.00,9.50,4165000.00,24,'Pendiente','2026-07-24','2026-08-17','Manuel Ortiz'),
('PED-1069','CLI-109',19,NULL,'Puerta Tamborada','Madera Cedro',149.00,114.00,139.00,13,0,0,19.10,5.80,11.00,483000.00,25,'En Producción','2026-07-27','2026-08-21','Pedro Alcázar'),
('PED-1070','CLI-110',20,NULL,'Piso en Madera','Madera Flor Morado',150.00,115.00,140.00,14,0,0,20.00,1.00,12.50,142000.00,26,'En Acabado','2026-07-30','2026-08-25','Sergio Ramos'),
('PED-1071','CLI-111',14,NULL,'Escalera en Madera','Madera Pino',151.00,116.00,141.00,15,0,0,20.90,1.80,14.00,2884000.00,27,'Completado','2026-08-02','2026-08-29','Mateo Díaz'),
('PED-1072','CLI-112',15,NULL,'Mueble de Baño','Lámina Alto Brillo/Mate',152.00,117.00,142.00,16,0,0,11.00,2.60,2.00,721000.00,10,'Pendiente','2026-08-05','2026-08-15','Lucas Herrera'),
('PED-1073','CLI-113',16,NULL,'Closet Modular','Madecor 15mm (Melamina)',153.00,118.00,143.00,17,0,0,11.90,3.40,3.50,1428000.00,11,'En Producción','2026-08-08','2026-08-19','Jorge Tello'),
('PED-1074','CLI-114',17,NULL,'Cocina Integral','Triplex Okume',154.00,119.00,144.00,18,0,0,12.80,4.20,5.00,4445000.00,12,'En Acabado','2026-08-11','2026-08-23','Andrés Silva'),
('PED-1075','CLI-115',18,NULL,'Puerta Tamborada','Triplex Otobo',155.00,120.00,145.00,19,0,0,13.70,5.00,6.50,361000.00,13,'Completado','2026-08-14','2026-08-27','Ricardo Palacios'),
('PED-1076','CLI-116',19,NULL,'Piso en Madera','Triplex Flor Morado',156.00,121.00,146.00,20,0,0,14.60,5.80,8.00,154000.00,14,'Pendiente','2026-08-17','2026-08-31','Manuel Ortiz'),
('PED-1077','CLI-117',20,NULL,'Escalera en Madera','Madera Cedro',157.00,122.00,147.00,21,0,0,15.50,1.00,9.50,3108000.00,15,'En Producción','2026-08-20','2026-09-04','Pedro Alcázar'),
('PED-1078','CLI-118',14,NULL,'Mueble de Baño','Madera Flor Morado',158.00,123.00,148.00,22,0,0,16.40,1.80,11.00,774000.00,16,'En Acabado','2026-08-23','2026-09-08','Sergio Ramos'),
('PED-1079','CLI-119',15,NULL,'Closet Modular','Madera Pino',159.00,124.00,149.00,23,0,0,17.30,2.60,12.50,1524000.00,17,'Completado','2026-08-26','2026-09-12','Mateo Díaz'),
('PED-1080','CLI-120',16,NULL,'Cocina Integral','Lámina Alto Brillo/Mate',160.00,125.00,150.00,24,0,0,18.20,3.40,14.00,3325000.00,18,'Pendiente','2026-08-29','2026-09-16','Lucas Herrera'),
('PED-1081','CLI-101',17,NULL,'Puerta Tamborada','Madecor 15mm (Melamina)',161.00,126.00,151.00,25,0,0,19.10,4.20,2.00,391000.00,19,'En Producción','2026-09-01','2026-09-20','Jorge Tello'),
('PED-1082','CLI-102',18,NULL,'Piso en Madera','Triplex Okume',162.00,127.00,152.00,26,0,0,20.00,5.00,3.50,166000.00,20,'En Acabado','2026-09-04','2026-09-24','Andrés Silva'),
('PED-1083','CLI-103',19,NULL,'Escalera en Madera','Triplex Otobo',163.00,128.00,153.00,27,0,0,20.90,5.80,5.00,3332000.00,21,'Completado','2026-09-07','2026-09-28','Ricardo Palacios'),
('PED-1084','CLI-104',20,NULL,'Mueble de Baño','Triplex Flor Morado',164.00,129.00,154.00,28,0,0,11.00,1.00,6.50,826000.00,22,'Pendiente','2026-09-10','2026-10-02','Manuel Ortiz'),
('PED-1085','CLI-105',14,NULL,'Closet Modular','Madera Cedro',165.00,130.00,155.00,29,0,0,11.90,1.80,8.00,1140000.00,23,'En Producción','2026-09-13','2026-10-06','Pedro Alcázar'),
('PED-1086','CLI-106',15,NULL,'Cocina Integral','Madera Flor Morado',166.00,131.00,156.00,30,0,0,12.80,2.60,9.50,3605000.00,24,'En Acabado','2026-09-16','2026-10-10','Sergio Ramos'),
('PED-1087','CLI-107',16,NULL,'Puerta Tamborada','Madera Pino',167.00,132.00,157.00,31,0,0,13.70,3.40,11.00,422000.00,25,'Completado','2026-09-19','2026-10-14','Mateo Díaz'),
('PED-1088','CLI-108',17,NULL,'Piso en Madera','Lámina Alto Brillo/Mate',168.00,133.00,158.00,32,0,0,14.60,4.20,12.50,178000.00,26,'Pendiente','2026-09-22','2026-10-18','Lucas Herrera'),
('PED-1089','CLI-109',18,NULL,'Escalera en Madera','Madecor 15mm (Melamina)',169.00,134.00,159.00,33,0,0,15.50,5.00,14.00,3556000.00,27,'En Producción','2026-09-25','2026-10-22','Jorge Tello'),
('PED-1090','CLI-110',19,NULL,'Mueble de Baño','Triplex Okume',170.00,45.00,160.00,4,0,0,16.40,5.80,2.00,618000.00,10,'En Acabado','2026-01-01','2026-01-11','Andrés Silva'),
('PED-1091','CLI-111',20,NULL,'Closet Modular','Triplex Otobo',171.00,46.00,161.00,5,0,0,17.30,1.00,3.50,1236000.00,11,'Completado','2026-01-04','2026-01-15','Ricardo Palacios'),
('PED-1092','CLI-112',14,NULL,'Cocina Integral','Triplex Flor Morado',172.00,47.00,162.00,6,0,0,18.20,1.80,5.00,3885000.00,12,'Pendiente','2026-01-07','2026-01-19','Manuel Ortiz'),
('PED-1093','CLI-113',15,NULL,'Puerta Tamborada','Madera Cedro',173.00,48.00,163.00,7,0,0,19.10,2.60,6.50,452000.00,13,'En Producción','2026-01-10','2026-01-23','Pedro Alcázar'),
('PED-1094','CLI-114',16,NULL,'Piso en Madera','Madera Flor Morado',174.00,49.00,164.00,8,0,0,20.00,3.40,8.00,190000.00,14,'En Acabado','2026-01-13','2026-01-27','Sergio Ramos'),
('PED-1095','CLI-115',17,NULL,'Escalera en Madera','Madera Pino',175.00,50.00,165.00,9,0,0,20.90,4.20,9.50,2660000.00,15,'Completado','2026-01-16','2026-01-31','Mateo Díaz'),
('PED-1096','CLI-116',18,NULL,'Mueble de Baño','Lámina Alto Brillo/Mate',176.00,51.00,166.00,10,0,0,11.00,5.00,11.00,670000.00,16,'Pendiente','2026-01-19','2026-02-04','Lucas Herrera'),
('PED-1097','CLI-117',19,NULL,'Closet Modular','Madecor 15mm (Melamina)',177.00,52.00,167.00,11,0,0,11.90,5.80,12.50,1332000.00,17,'En Producción','2026-01-22','2026-02-08','Jorge Tello'),
('PED-1098','CLI-118',20,NULL,'Cocina Integral','Triplex Okume',178.00,53.00,168.00,12,0,0,12.80,1.00,14.00,4165000.00,18,'En Acabado','2026-01-25','2026-02-12','Andrés Silva'),
('PED-1099','CLI-119',14,NULL,'Puerta Tamborada','Triplex Otobo',179.00,54.00,169.00,13,0,0,13.70,1.80,2.00,483000.00,19,'Completado','2026-01-28','2026-02-16','Ricardo Palacios'),
('PED-1100','CLI-120',15,NULL,'Piso en Madera','Triplex Flor Morado',180.00,55.00,170.00,14,0,0,14.60,2.60,3.50,142000.00,20,'Pendiente','2026-01-31','2026-02-20','Manuel Ortiz'),
('PED-1101','CLI-101',16,NULL,'Escalera en Madera','Madera Cedro',181.00,56.00,171.00,15,0,0,15.50,3.40,5.00,2884000.00,21,'En Producción','2026-02-03','2026-02-24','Pedro Alcázar'),
('PED-1102','CLI-102',17,NULL,'Mueble de Baño','Madera Flor Morado',182.00,57.00,172.00,16,0,0,16.40,4.20,6.50,721000.00,22,'En Acabado','2026-02-06','2026-02-28','Sergio Ramos'),
('PED-1103','CLI-103',18,NULL,'Closet Modular','Madera Pino',183.00,58.00,173.00,17,0,0,17.30,5.00,8.00,1428000.00,23,'Completado','2026-02-09','2026-03-04','Mateo Díaz'),
('PED-1104','CLI-104',19,NULL,'Cocina Integral','Lámina Alto Brillo/Mate',184.00,59.00,174.00,18,0,0,18.20,5.80,9.50,4445000.00,24,'Pendiente','2026-02-12','2026-03-08','Lucas Herrera'),
('PED-1105','CLI-105',20,NULL,'Puerta Tamborada','Madecor 15mm (Melamina)',185.00,60.00,175.00,19,0,0,19.10,1.00,11.00,361000.00,25,'En Producción','2026-02-15','2026-03-12','Jorge Tello'),
('PED-1106','CLI-106',14,NULL,'Piso en Madera','Triplex Okume',186.00,61.00,176.00,20,0,0,20.00,1.80,12.50,154000.00,26,'En Acabado','2026-02-18','2026-03-16','Andrés Silva'),
('PED-1107','CLI-107',15,NULL,'Escalera en Madera','Triplex Otobo',187.00,62.00,177.00,21,0,0,20.90,2.60,14.00,3108000.00,27,'Completado','2026-02-21','2026-03-20','Ricardo Palacios'),
('PED-1108','CLI-108',16,NULL,'Mueble de Baño','Triplex Flor Morado',188.00,63.00,178.00,22,0,0,11.00,3.40,2.00,774000.00,10,'Pendiente','2026-02-24','2026-03-06','Manuel Ortiz'),
('PED-1109','CLI-109',17,NULL,'Closet Modular','Madera Cedro',189.00,64.00,179.00,23,0,0,11.90,4.20,3.50,1524000.00,11,'En Producción','2026-02-27','2026-03-10','Pedro Alcázar'),
('PED-1110','CLI-110',18,NULL,'Cocina Integral','Madera Flor Morado',190.00,65.00,180.00,24,0,0,12.80,5.00,5.00,3325000.00,12,'En Acabado','2026-03-02','2026-03-14','Sergio Ramos'),
('PED-1111','CLI-111',19,NULL,'Puerta Tamborada','Madera Pino',191.00,66.00,181.00,25,0,0,13.70,5.80,6.50,391000.00,13,'Completado','2026-03-05','2026-03-18','Mateo Díaz'),
('PED-1112','CLI-112',20,NULL,'Piso en Madera','Lámina Alto Brillo/Mate',192.00,67.00,182.00,26,0,0,14.60,1.00,8.00,166000.00,14,'Pendiente','2026-03-08','2026-03-22','Lucas Herrera'),
('PED-1113','CLI-113',14,NULL,'Escalera en Madera','Madecor 15mm (Melamina)',193.00,68.00,183.00,27,0,0,15.50,1.80,9.50,3332000.00,15,'En Producción','2026-03-11','2026-03-26','Jorge Tello'),
('PED-1114','CLI-114',15,NULL,'Mueble de Baño','Triplex Okume',194.00,69.00,184.00,28,0,0,16.40,2.60,11.00,826000.00,16,'En Acabado','2026-03-14','2026-03-30','Andrés Silva'),
('PED-1115','CLI-115',16,NULL,'Closet Modular','Triplex Otobo',195.00,70.00,185.00,29,0,0,17.30,3.40,12.50,1140000.00,17,'Completado','2026-03-17','2026-04-03','Ricardo Palacios'),
('PED-1116','CLI-116',17,NULL,'Cocina Integral','Triplex Flor Morado',196.00,71.00,186.00,30,0,0,18.20,4.20,14.00,3605000.00,18,'Pendiente','2026-03-20','2026-04-07','Manuel Ortiz'),
('PED-1117','CLI-117',18,NULL,'Puerta Tamborada','Madera Cedro',197.00,72.00,187.00,31,0,0,19.10,5.00,2.00,422000.00,19,'En Producción','2026-03-23','2026-04-11','Pedro Alcázar'),
('PED-1118','CLI-118',19,NULL,'Piso en Madera','Madera Flor Morado',198.00,73.00,188.00,32,0,0,20.00,5.80,3.50,178000.00,20,'En Acabado','2026-03-26','2026-04-15','Sergio Ramos'),
('PED-1119','CLI-119',20,NULL,'Escalera en Madera','Madera Pino',199.00,74.00,189.00,33,0,0,20.90,1.00,5.00,3556000.00,21,'Completado','2026-03-29','2026-04-19','Mateo Díaz'),
('PED-1120','CLI-120',14,NULL,'Mueble de Baño','Lámina Alto Brillo/Mate',200.00,75.00,190.00,4,0,0,11.00,1.80,6.50,618000.00,22,'Pendiente','2026-04-01','2026-04-23','Lucas Herrera'),
('PED-1121','CLI-101',15,NULL,'Closet Modular','Madecor 15mm (Melamina)',201.00,76.00,191.00,5,0,0,11.90,2.60,8.00,1236000.00,23,'En Producción','2026-04-04','2026-04-27','Jorge Tello'),
('PED-1122','CLI-102',16,NULL,'Cocina Integral','Triplex Okume',202.00,77.00,192.00,6,0,0,12.80,3.40,9.50,3885000.00,24,'En Acabado','2026-04-07','2026-05-01','Andrés Silva'),
('PED-1123','CLI-103',17,NULL,'Puerta Tamborada','Triplex Otobo',203.00,78.00,193.00,7,0,0,13.70,4.20,11.00,452000.00,25,'Completado','2026-04-10','2026-05-05','Ricardo Palacios'),
('PED-1124','CLI-104',18,NULL,'Piso en Madera','Triplex Flor Morado',204.00,79.00,194.00,8,0,0,14.60,5.00,12.50,190000.00,26,'Pendiente','2026-04-13','2026-05-09','Manuel Ortiz'),
('PED-1125','CLI-105',19,NULL,'Escalera en Madera','Madera Cedro',205.00,80.00,195.00,9,0,0,15.50,5.80,14.00,2660000.00,27,'En Producción','2026-04-16','2026-05-13','Pedro Alcázar'),
('PED-1126','CLI-106',20,NULL,'Mueble de Baño','Madera Flor Morado',206.00,81.00,196.00,10,0,0,16.40,1.00,2.00,670000.00,10,'En Acabado','2026-04-19','2026-04-29','Sergio Ramos'),
('PED-1127','CLI-107',14,NULL,'Closet Modular','Madera Pino',207.00,82.00,197.00,11,0,0,17.30,1.80,3.50,1332000.00,11,'Completado','2026-04-22','2026-05-03','Mateo Díaz'),
('PED-1128','CLI-108',15,NULL,'Cocina Integral','Lámina Alto Brillo/Mate',208.00,83.00,198.00,12,0,0,18.20,2.60,5.00,4165000.00,12,'Pendiente','2026-04-25','2026-05-07','Lucas Herrera'),
('PED-1129','CLI-109',16,NULL,'Puerta Tamborada','Madecor 15mm (Melamina)',209.00,84.00,199.00,13,0,0,19.10,3.40,6.50,483000.00,13,'En Producción','2026-04-28','2026-05-11','Jorge Tello'),
('PED-1130','CLI-110',17,NULL,'Piso en Madera','Triplex Okume',210.00,85.00,200.00,14,0,0,20.00,4.20,8.00,142000.00,14,'En Acabado','2026-05-01','2026-05-15','Andrés Silva'),
('PED-1131','CLI-111',18,NULL,'Escalera en Madera','Triplex Otobo',211.00,86.00,201.00,15,0,0,20.90,5.00,9.50,2884000.00,15,'Completado','2026-05-04','2026-05-19','Ricardo Palacios'),
('PED-1132','CLI-112',19,NULL,'Mueble de Baño','Triplex Flor Morado',212.00,87.00,202.00,16,0,0,11.00,5.80,11.00,721000.00,16,'Pendiente','2026-05-07','2026-05-23','Manuel Ortiz'),
('PED-1133','CLI-113',20,NULL,'Closet Modular','Madera Cedro',213.00,88.00,203.00,17,0,0,11.90,1.00,12.50,1428000.00,17,'En Producción','2026-05-10','2026-05-27','Pedro Alcázar'),
('PED-1134','CLI-114',14,NULL,'Cocina Integral','Madera Flor Morado',214.00,89.00,204.00,18,0,0,12.80,1.80,14.00,4445000.00,18,'En Acabado','2026-05-13','2026-05-31','Sergio Ramos'),
('PED-1135','CLI-115',15,NULL,'Puerta Tamborada','Madera Pino',215.00,90.00,205.00,19,0,0,13.70,2.60,2.00,361000.00,19,'Completado','2026-05-16','2026-06-04','Mateo Díaz'),
('PED-1136','CLI-116',16,NULL,'Piso en Madera','Lámina Alto Brillo/Mate',216.00,91.00,206.00,20,0,0,14.60,3.40,3.50,154000.00,20,'Pendiente','2026-05-19','2026-06-08','Lucas Herrera'),
('PED-1137','CLI-117',17,NULL,'Escalera en Madera','Madecor 15mm (Melamina)',217.00,92.00,207.00,21,0,0,15.50,4.20,5.00,3108000.00,21,'En Producción','2026-05-22','2026-06-12','Jorge Tello'),
('PED-1138','CLI-118',18,NULL,'Mueble de Baño','Triplex Okume',218.00,93.00,208.00,22,0,0,16.40,5.00,6.50,774000.00,22,'En Acabado','2026-05-25','2026-06-16','Andrés Silva'),
('PED-1139','CLI-119',19,NULL,'Closet Modular','Triplex Otobo',219.00,94.00,209.00,23,0,0,17.30,5.80,8.00,1524000.00,23,'Completado','2026-05-28','2026-06-20','Ricardo Palacios'),
('PED-1140','CLI-120',20,NULL,'Cocina Integral','Triplex Flor Morado',220.00,95.00,70.00,24,0,0,18.20,1.00,9.50,3325000.00,24,'Pendiente','2026-05-31','2026-06-24','Manuel Ortiz'),
('PED-1141','CLI-101',14,NULL,'Puerta Tamborada','Madera Cedro',221.00,96.00,71.00,25,0,0,19.10,1.80,11.00,391000.00,25,'En Producción','2026-06-03','2026-06-28','Pedro Alcázar'),
('PED-1142','CLI-102',15,NULL,'Piso en Madera','Madera Flor Morado',222.00,97.00,72.00,26,0,0,20.00,2.60,12.50,166000.00,26,'En Acabado','2026-06-06','2026-07-02','Sergio Ramos'),
('PED-1143','CLI-103',16,NULL,'Escalera en Madera','Madera Pino',223.00,98.00,73.00,27,0,0,20.90,3.40,14.00,3332000.00,27,'Completado','2026-06-09','2026-07-06','Mateo Díaz'),
('PED-1144','CLI-104',17,NULL,'Mueble de Baño','Lámina Alto Brillo/Mate',224.00,99.00,74.00,28,0,0,11.00,4.20,2.00,826000.00,10,'Pendiente','2026-06-12','2026-06-22','Lucas Herrera'),
('PED-1145','CLI-105',18,NULL,'Closet Modular','Madecor 15mm (Melamina)',225.00,100.00,75.00,29,0,0,11.90,5.00,3.50,1140000.00,11,'En Producción','2026-06-15','2026-06-26','Jorge Tello'),
('PED-1146','CLI-106',19,NULL,'Cocina Integral','Triplex Okume',226.00,101.00,76.00,30,0,0,12.80,5.80,5.00,3605000.00,12,'En Acabado','2026-06-18','2026-06-30','Andrés Silva'),
('PED-1147','CLI-107',20,NULL,'Puerta Tamborada','Triplex Otobo',227.00,102.00,77.00,31,0,0,13.70,1.00,6.50,422000.00,13,'Completado','2026-06-21','2026-07-04','Ricardo Palacios'),
('PED-1148','CLI-108',14,NULL,'Piso en Madera','Triplex Flor Morado',228.00,103.00,78.00,32,0,0,14.60,1.80,8.00,178000.00,14,'Pendiente','2026-06-24','2026-07-08','Manuel Ortiz'),
('PED-1149','CLI-109',15,NULL,'Escalera en Madera','Madera Cedro',229.00,104.00,79.00,33,0,0,15.50,2.60,9.50,3556000.00,15,'En Producción','2026-06-27','2026-07-12','Pedro Alcázar'),
('PED-1150','CLI-110',16,NULL,'Mueble de Baño','Madera Flor Morado',230.00,105.00,80.00,4,0,0,16.40,3.40,11.00,618000.00,16,'En Acabado','2026-06-30','2026-07-16','Sergio Ramos'),
('PED-1151','CLI-111',17,NULL,'Closet Modular','Madera Pino',231.00,106.00,81.00,5,0,0,17.30,4.20,12.50,1236000.00,17,'Completado','2026-07-03','2026-07-20','Mateo Díaz'),
('PED-1152','CLI-112',18,NULL,'Cocina Integral','Lámina Alto Brillo/Mate',232.00,107.00,82.00,6,0,0,18.20,5.00,14.00,3885000.00,18,'Pendiente','2026-07-06','2026-07-24','Lucas Herrera'),
('PED-1153','CLI-113',19,NULL,'Puerta Tamborada','Madecor 15mm (Melamina)',233.00,108.00,83.00,7,0,0,19.10,5.80,2.00,452000.00,19,'En Producción','2026-07-09','2026-07-28','Jorge Tello'),
('PED-1154','CLI-114',20,NULL,'Piso en Madera','Triplex Okume',234.00,109.00,84.00,8,0,0,20.00,1.00,3.50,190000.00,20,'En Acabado','2026-07-12','2026-08-01','Andrés Silva'),
('PED-1155','CLI-115',14,NULL,'Escalera en Madera','Triplex Otobo',235.00,110.00,85.00,9,0,0,20.90,1.80,5.00,2660000.00,21,'Completado','2026-07-15','2026-08-05','Ricardo Palacios'),
('PED-1156','CLI-116',15,NULL,'Mueble de Baño','Triplex Flor Morado',236.00,111.00,86.00,10,0,0,11.00,2.60,6.50,670000.00,22,'Pendiente','2026-07-18','2026-08-09','Manuel Ortiz'),
('PED-1157','CLI-117',16,NULL,'Closet Modular','Madera Cedro',237.00,112.00,87.00,11,0,0,11.90,3.40,8.00,1332000.00,23,'En Producción','2026-07-21','2026-08-13','Pedro Alcázar'),
('PED-1158','CLI-118',17,NULL,'Cocina Integral','Madera Flor Morado',238.00,113.00,88.00,12,0,0,12.80,4.20,9.50,4165000.00,24,'En Acabado','2026-07-24','2026-08-17','Sergio Ramos'),
('PED-1159','CLI-119',18,NULL,'Puerta Tamborada','Madera Pino',239.00,114.00,89.00,13,0,0,13.70,5.00,11.00,483000.00,25,'Completado','2026-07-27','2026-08-21','Mateo Díaz'),
('PED-1160','CLI-120',19,NULL,'Piso en Madera','Lámina Alto Brillo/Mate',80.00,115.00,90.00,14,0,0,14.60,5.80,12.50,142000.00,26,'Pendiente','2026-07-30','2026-08-25','Lucas Herrera'),
('PED-1161','CLI-101',20,NULL,'Escalera en Madera','Madecor 15mm (Melamina)',81.00,116.00,91.00,15,0,0,15.50,1.00,14.00,2884000.00,27,'En Producción','2026-08-02','2026-08-29','Jorge Tello'),
('PED-1162','CLI-102',14,NULL,'Mueble de Baño','Triplex Okume',82.00,117.00,92.00,16,0,0,16.40,1.80,2.00,721000.00,10,'En Acabado','2026-08-05','2026-08-15','Andrés Silva'),
('PED-1163','CLI-103',15,NULL,'Closet Modular','Triplex Otobo',83.00,118.00,93.00,17,0,0,17.30,2.60,3.50,1428000.00,11,'Completado','2026-08-08','2026-08-19','Ricardo Palacios'),
('PED-1164','CLI-104',16,NULL,'Cocina Integral','Triplex Flor Morado',84.00,119.00,94.00,18,0,0,18.20,3.40,5.00,4445000.00,12,'Pendiente','2026-08-11','2026-08-23','Manuel Ortiz'),
('PED-1165','CLI-105',17,NULL,'Puerta Tamborada','Madera Cedro',85.00,120.00,95.00,19,0,0,19.10,4.20,6.50,361000.00,13,'En Producción','2026-08-14','2026-08-27','Pedro Alcázar'),
('PED-1166','CLI-106',18,NULL,'Piso en Madera','Madera Flor Morado',86.00,121.00,96.00,20,0,0,20.00,5.00,8.00,154000.00,14,'En Acabado','2026-08-17','2026-08-31','Sergio Ramos'),
('PED-1167','CLI-107',19,NULL,'Escalera en Madera','Madera Pino',87.00,122.00,97.00,21,0,0,20.90,5.80,9.50,3108000.00,15,'Completado','2026-08-20','2026-09-04','Mateo Díaz'),
('PED-1168','CLI-108',20,NULL,'Mueble de Baño','Lámina Alto Brillo/Mate',88.00,123.00,98.00,22,0,0,11.00,1.00,11.00,774000.00,16,'Pendiente','2026-08-23','2026-09-08','Lucas Herrera'),
('PED-1169','CLI-109',14,NULL,'Closet Modular','Madecor 15mm (Melamina)',89.00,124.00,99.00,23,0,0,11.90,1.80,12.50,1524000.00,17,'En Producción','2026-08-26','2026-09-12','Jorge Tello'),
('PED-1170','CLI-110',15,NULL,'Cocina Integral','Triplex Okume',90.00,125.00,100.00,24,0,0,12.80,2.60,14.00,3325000.00,18,'En Acabado','2026-08-29','2026-09-16','Andrés Silva'),
('PED-1171','CLI-111',16,NULL,'Puerta Tamborada','Triplex Otobo',91.00,126.00,101.00,25,0,0,13.70,3.40,2.00,391000.00,19,'Completado','2026-09-01','2026-09-20','Ricardo Palacios'),
('PED-1172','CLI-112',17,NULL,'Piso en Madera','Triplex Flor Morado',92.00,127.00,102.00,26,0,0,14.60,4.20,3.50,166000.00,20,'Pendiente','2026-09-04','2026-09-24','Manuel Ortiz'),
('PED-1173','CLI-113',18,NULL,'Escalera en Madera','Madera Cedro',93.00,128.00,103.00,27,0,0,15.50,5.00,5.00,3332000.00,21,'En Producción','2026-09-07','2026-09-28','Pedro Alcázar'),
('PED-1174','CLI-114',19,NULL,'Mueble de Baño','Madera Flor Morado',94.00,129.00,104.00,28,0,0,16.40,5.80,6.50,826000.00,22,'En Acabado','2026-09-10','2026-10-02','Sergio Ramos'),
('PED-1175','CLI-115',20,NULL,'Closet Modular','Madera Pino',95.00,130.00,105.00,29,0,0,17.30,1.00,8.00,1140000.00,23,'Completado','2026-09-13','2026-10-06','Mateo Díaz'),
('PED-1176','CLI-116',14,NULL,'Cocina Integral','Lámina Alto Brillo/Mate',96.00,131.00,106.00,30,0,0,18.20,1.80,9.50,3605000.00,24,'Pendiente','2026-09-16','2026-10-10','Lucas Herrera'),
('PED-1177','CLI-117',15,NULL,'Puerta Tamborada','Madecor 15mm (Melamina)',97.00,132.00,107.00,31,0,0,19.10,2.60,11.00,422000.00,25,'En Producción','2026-09-19','2026-10-14','Jorge Tello'),
('PED-1178','CLI-118',16,NULL,'Piso en Madera','Triplex Okume',98.00,133.00,108.00,32,0,0,20.00,3.40,12.50,178000.00,26,'En Acabado','2026-09-22','2026-10-18','Andrés Silva'),
('PED-1179','CLI-119',17,NULL,'Escalera en Madera','Triplex Otobo',99.00,134.00,109.00,33,0,0,20.90,4.20,14.00,3556000.00,27,'Completado','2026-09-25','2026-10-22','Ricardo Palacios'),
('PED-1180','CLI-120',18,NULL,'Mueble de Baño','Triplex Flor Morado',100.00,45.00,110.00,4,0,0,11.00,5.00,2.00,618000.00,10,'Pendiente','2026-01-01','2026-01-11','Manuel Ortiz'),
('PED-73179','CLI-488',14,NULL,'Mueble de Baño','Madera Flor Morado',180.00,80.00,120.00,1,0,0,15.50,2.20,5.00,1392300.00,15,'Pendiente','2026-10-29','2026-11-18','Jorge Tello'),
('PED-87440','CLI-488',14,NULL,'Mueble de Baño','Triplex Okume',120.00,60.00,90.00,1,0,1,15.50,2.20,5.00,1130500.00,15,'Pendiente','2026-10-28','2026-11-17','Jorge Tello'),
('PED-92212','CLI-488',14,NULL,'Piso en Madera','Madecor 15mm (Melamina)',120.00,60.00,90.00,1,1,0,15.50,2.20,5.00,255850.00,15,'Pendiente','2026-10-28','2026-11-17','Jorge Tello'),
('PED-BAL-1001','CLI-102',14,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,13,'Completado','2026-02-02','2026-02-15','Jorge Tello'),
('PED-BAL-1002','CLI-103',15,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,14,'Completado','2026-02-03','2026-02-17','Jorge Tello'),
('PED-BAL-1003','CLI-104',16,NULL,'Escalera en Madera','Madera Flor Morado',120.00,60.00,90.00,8,0,0,15.00,2.80,3.50,2800000.00,15,'Completado','2026-02-04','2026-02-19','Jorge Tello'),
('PED-BAL-1004','CLI-105',17,NULL,'Mueble de Baño','Triplex Otobo',120.00,60.00,90.00,8,0,0,16.00,2.80,3.50,650000.00,16,'Completado','2026-02-05','2026-02-21','Jorge Tello'),
('PED-BAL-1005','CLI-106',18,NULL,'Piso en Madera','Madera Pino',120.00,60.00,90.00,8,0,0,17.00,2.80,3.50,2250000.00,17,'Completado','2026-02-06','2026-02-23','Jorge Tello'),
('PED-BAL-1006','CLI-107',19,NULL,'Closet Modular','Madecor 15mm (Melamina)',120.00,60.00,90.00,8,0,0,12.00,2.80,3.50,1200000.00,18,'Completado','2026-02-07','2026-02-25','Jorge Tello'),
('PED-BAL-1007','CLI-108',20,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,19,'Completado','2026-02-08','2026-02-27','Jorge Tello'),
('PED-BAL-1008','CLI-109',14,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,12,'Completado','2026-02-09','2026-02-21','Andrés Silva'),
('PED-BAL-1009','CLI-110',15,NULL,'Escalera en Madera','Madera Flor Morado',120.00,60.00,90.00,8,0,0,15.00,2.80,3.50,2800000.00,13,'Completado','2026-02-10','2026-02-23','Andrés Silva'),
('PED-BAL-1010','CLI-111',16,NULL,'Mueble de Baño','Triplex Otobo',120.00,60.00,90.00,8,0,0,16.00,2.80,3.50,650000.00,14,'Completado','2026-02-11','2026-02-25','Andrés Silva'),
('PED-BAL-1011','CLI-112',17,NULL,'Piso en Madera','Madera Pino',120.00,60.00,90.00,8,0,0,17.00,2.80,3.50,2250000.00,15,'Completado','2026-02-12','2026-02-27','Andrés Silva'),
('PED-BAL-1012','CLI-113',18,NULL,'Closet Modular','Madecor 15mm (Melamina)',120.00,60.00,90.00,8,0,0,12.00,2.80,3.50,1200000.00,16,'Completado','2026-02-13','2026-03-01','Andrés Silva'),
('PED-BAL-1013','CLI-114',19,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,17,'Completado','2026-02-14','2026-03-03','Andrés Silva'),
('PED-BAL-1014','CLI-115',20,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,18,'Completado','2026-02-15','2026-03-05','Andrés Silva'),
('PED-BAL-1015','CLI-116',14,NULL,'Escalera en Madera','Madera Flor Morado',120.00,60.00,90.00,8,0,0,15.00,2.80,3.50,2800000.00,19,'Completado','2026-02-16','2026-03-07','Ricardo Palacios'),
('PED-BAL-1016','CLI-117',15,NULL,'Mueble de Baño','Triplex Otobo',120.00,60.00,90.00,8,0,0,16.00,2.80,3.50,650000.00,12,'Completado','2026-02-17','2026-03-01','Ricardo Palacios'),
('PED-BAL-1017','CLI-118',16,NULL,'Piso en Madera','Madera Pino',120.00,60.00,90.00,8,0,0,17.00,2.80,3.50,2250000.00,13,'Completado','2026-02-18','2026-03-03','Ricardo Palacios'),
('PED-BAL-1018','CLI-119',17,NULL,'Closet Modular','Madecor 15mm (Melamina)',120.00,60.00,90.00,8,0,0,12.00,2.80,3.50,1200000.00,14,'Completado','2026-02-19','2026-03-05','Ricardo Palacios'),
('PED-BAL-1019','CLI-101',18,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,15,'Completado','2026-02-20','2026-03-07','Ricardo Palacios'),
('PED-BAL-1020','CLI-102',19,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,16,'Completado','2026-02-21','2026-03-09','Ricardo Palacios'),
('PED-BAL-1021','CLI-103',20,NULL,'Escalera en Madera','Madera Flor Morado',120.00,60.00,90.00,8,0,0,15.00,2.80,3.50,2800000.00,17,'Completado','2026-02-22','2026-03-11','Ricardo Palacios'),
('PED-BAL-1022','CLI-104',14,NULL,'Mueble de Baño','Triplex Otobo',120.00,60.00,90.00,8,0,0,16.00,2.80,3.50,650000.00,18,'Completado','2026-02-23','2026-03-13','Manuel Ortiz'),
('PED-BAL-1023','CLI-105',15,NULL,'Piso en Madera','Madera Pino',120.00,60.00,90.00,8,0,0,17.00,2.80,3.50,2250000.00,19,'Completado','2026-02-24','2026-03-15','Manuel Ortiz'),
('PED-BAL-1024','CLI-106',16,NULL,'Closet Modular','Madecor 15mm (Melamina)',120.00,60.00,90.00,8,0,0,12.00,2.80,3.50,1200000.00,12,'Completado','2026-02-25','2026-03-09','Manuel Ortiz'),
('PED-BAL-1025','CLI-107',17,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,13,'Completado','2026-02-26','2026-03-11','Manuel Ortiz'),
('PED-BAL-1026','CLI-108',18,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,14,'Completado','2026-02-27','2026-03-13','Manuel Ortiz'),
('PED-BAL-1027','CLI-109',19,NULL,'Escalera en Madera','Madera Flor Morado',120.00,60.00,90.00,8,0,0,15.00,2.80,3.50,2800000.00,15,'Completado','2026-02-28','2026-03-15','Manuel Ortiz'),
('PED-BAL-1028','CLI-110',20,NULL,'Mueble de Baño','Triplex Otobo',120.00,60.00,90.00,8,0,0,16.00,2.80,3.50,650000.00,16,'Completado','2026-03-01','2026-03-17','Manuel Ortiz'),
('PED-BAL-1029','CLI-111',14,NULL,'Piso en Madera','Madera Pino',120.00,60.00,90.00,8,0,0,17.00,2.80,3.50,2250000.00,17,'Completado','2026-03-02','2026-03-19','Pedro Alcázar'),
('PED-BAL-1030','CLI-112',15,NULL,'Closet Modular','Madecor 15mm (Melamina)',120.00,60.00,90.00,8,0,0,12.00,2.80,3.50,1200000.00,18,'Completado','2026-03-03','2026-03-21','Pedro Alcázar'),
('PED-BAL-1031','CLI-113',16,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,19,'Completado','2026-03-04','2026-03-23','Pedro Alcázar'),
('PED-BAL-1032','CLI-114',17,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,12,'Completado','2026-03-05','2026-03-17','Pedro Alcázar'),
('PED-BAL-1033','CLI-115',18,NULL,'Escalera en Madera','Madera Flor Morado',120.00,60.00,90.00,8,0,0,15.00,2.80,3.50,2800000.00,13,'Completado','2026-03-06','2026-03-19','Pedro Alcázar'),
('PED-BAL-1034','CLI-116',19,NULL,'Mueble de Baño','Triplex Otobo',120.00,60.00,90.00,8,0,0,16.00,2.80,3.50,650000.00,14,'Completado','2026-03-07','2026-03-21','Pedro Alcázar'),
('PED-BAL-1035','CLI-117',20,NULL,'Piso en Madera','Madera Pino',120.00,60.00,90.00,8,0,0,17.00,2.80,3.50,2250000.00,15,'Completado','2026-03-08','2026-03-23','Pedro Alcázar'),
('PED-BAL-1036','CLI-118',14,NULL,'Closet Modular','Madecor 15mm (Melamina)',120.00,60.00,90.00,8,0,0,12.00,2.80,3.50,1200000.00,16,'Completado','2026-03-09','2026-03-25','Sergio Ramos'),
('PED-BAL-1037','CLI-119',15,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,17,'Completado','2026-03-10','2026-03-27','Sergio Ramos'),
('PED-BAL-1038','CLI-101',16,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,18,'Completado','2026-03-11','2026-03-29','Sergio Ramos'),
('PED-BAL-1039','CLI-102',17,NULL,'Escalera en Madera','Madera Flor Morado',120.00,60.00,90.00,8,0,0,15.00,2.80,3.50,2800000.00,19,'Completado','2026-03-12','2026-03-31','Sergio Ramos'),
('PED-BAL-1040','CLI-103',18,NULL,'Mueble de Baño','Triplex Otobo',120.00,60.00,90.00,8,0,0,16.00,2.80,3.50,650000.00,12,'Completado','2026-03-13','2026-03-25','Sergio Ramos'),
('PED-BAL-1041','CLI-104',19,NULL,'Piso en Madera','Madera Pino',120.00,60.00,90.00,8,0,0,17.00,2.80,3.50,2250000.00,13,'Completado','2026-03-14','2026-03-27','Sergio Ramos'),
('PED-BAL-1042','CLI-105',20,NULL,'Closet Modular','Madecor 15mm (Melamina)',120.00,60.00,90.00,8,0,0,12.00,2.80,3.50,1200000.00,14,'Completado','2026-03-15','2026-03-29','Sergio Ramos'),
('PED-BAL-1043','CLI-106',14,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,15,'Completado','2026-03-16','2026-03-31','Mateo Díaz'),
('PED-BAL-1044','CLI-107',15,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,16,'Completado','2026-03-17','2026-04-02','Mateo Díaz'),
('PED-BAL-1045','CLI-108',16,NULL,'Escalera en Madera','Madera Flor Morado',120.00,60.00,90.00,8,0,0,15.00,2.80,3.50,2800000.00,17,'Completado','2026-03-18','2026-04-04','Mateo Díaz'),
('PED-BAL-1046','CLI-109',17,NULL,'Mueble de Baño','Triplex Otobo',120.00,60.00,90.00,8,0,0,16.00,2.80,3.50,650000.00,18,'Completado','2026-03-19','2026-04-06','Mateo Díaz'),
('PED-BAL-1047','CLI-110',18,NULL,'Piso en Madera','Madera Pino',120.00,60.00,90.00,8,0,0,17.00,2.80,3.50,2250000.00,19,'Completado','2026-03-20','2026-04-08','Mateo Díaz'),
('PED-BAL-1048','CLI-111',19,NULL,'Closet Modular','Madecor 15mm (Melamina)',120.00,60.00,90.00,8,0,0,12.00,2.80,3.50,1200000.00,12,'Completado','2026-03-21','2026-04-02','Mateo Díaz'),
('PED-BAL-1049','CLI-112',20,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,13,'Completado','2026-03-22','2026-04-04','Mateo Díaz'),
('PED-BAL-1050','CLI-113',14,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,14,'Completado','2026-03-23','2026-04-06','Lucas Herrera'),
('PED-BAL-1051','CLI-114',15,NULL,'Escalera en Madera','Madera Flor Morado',120.00,60.00,90.00,8,0,0,15.00,2.80,3.50,2800000.00,15,'Completado','2026-03-24','2026-04-08','Lucas Herrera'),
('PED-BAL-1052','CLI-115',16,NULL,'Mueble de Baño','Triplex Otobo',120.00,60.00,90.00,8,0,0,16.00,2.80,3.50,650000.00,16,'Completado','2026-03-25','2026-04-10','Lucas Herrera'),
('PED-BAL-1053','CLI-116',17,NULL,'Piso en Madera','Madera Pino',120.00,60.00,90.00,8,0,0,17.00,2.80,3.50,2250000.00,17,'Completado','2026-03-26','2026-04-12','Lucas Herrera'),
('PED-BAL-1054','CLI-117',18,NULL,'Closet Modular','Madecor 15mm (Melamina)',120.00,60.00,90.00,8,0,0,12.00,2.80,3.50,1200000.00,18,'Completado','2026-03-27','2026-04-14','Lucas Herrera'),
('PED-BAL-1055','CLI-118',19,NULL,'Cocina Integral','Madera Cedro',120.00,60.00,90.00,8,0,0,13.00,2.80,3.50,3500000.00,19,'Completado','2026-03-28','2026-04-16','Lucas Herrera'),
('PED-BAL-1056','CLI-119',20,NULL,'Puerta Tamborada','Triplex Okume',120.00,60.00,90.00,8,0,0,14.00,2.80,3.50,380000.00,12,'Completado','2026-03-29','2026-04-10','Lucas Herrera'),
('PED-ESP-501','CLI-102',15,NULL,'Cocina Integral','Madera Cedro',300.00,60.00,90.00,6,0,0,14.50,2.50,4.00,4200000.00,15,'Completado','2026-01-25','2026-02-09','Andrés Silva'),
('PED-ESP-502','CLI-103',16,NULL,'Piso en Madera','Madera Flor Morado',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2700000.00,16,'Completado','2026-02-04','2026-02-20','Ricardo Palacios'),
('PED-ESP-503','CLI-104',17,NULL,'Piso en Madera','Madera Pino',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2250000.00,17,'Completado','2026-02-14','2026-03-03','Manuel Ortiz'),
('PED-ESP-504','CLI-105',18,NULL,'Cocina Integral','Madecor 15mm (Melamina)',240.00,60.00,90.00,6,0,0,14.50,2.50,4.00,3500000.00,18,'Completado','2026-02-24','2026-03-14','Pedro Alcázar'),
('PED-ESP-505','CLI-106',19,NULL,'Cocina Integral','Madera Cedro',300.00,60.00,90.00,6,0,0,14.50,2.50,4.00,4200000.00,14,'Completado','2026-03-06','2026-03-20','Sergio Ramos'),
('PED-ESP-506','CLI-107',20,NULL,'Piso en Madera','Madera Flor Morado',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2700000.00,15,'Completado','2026-03-16','2026-03-31','Mateo Díaz'),
('PED-ESP-507','CLI-108',14,NULL,'Piso en Madera','Madera Pino',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2250000.00,16,'Completado','2026-03-26','2026-04-11','Lucas Herrera'),
('PED-ESP-508','CLI-109',15,NULL,'Cocina Integral','Madecor 15mm (Melamina)',240.00,60.00,90.00,6,0,0,14.50,2.50,4.00,3500000.00,17,'Completado','2026-04-05','2026-04-22','Jorge Tello'),
('PED-ESP-509','CLI-110',16,NULL,'Cocina Integral','Madera Cedro',300.00,60.00,90.00,6,0,0,14.50,2.50,4.00,4200000.00,18,'Completado','2026-04-15','2026-05-03','Andrés Silva'),
('PED-ESP-510','CLI-111',17,NULL,'Piso en Madera','Madera Flor Morado',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2700000.00,14,'Completado','2026-04-25','2026-05-09','Ricardo Palacios'),
('PED-ESP-511','CLI-112',18,NULL,'Piso en Madera','Madera Pino',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2250000.00,15,'Completado','2026-05-05','2026-05-20','Manuel Ortiz'),
('PED-ESP-512','CLI-113',19,NULL,'Cocina Integral','Madecor 15mm (Melamina)',240.00,60.00,90.00,6,0,0,14.50,2.50,4.00,3500000.00,16,'Completado','2026-05-15','2026-05-31','Pedro Alcázar'),
('PED-ESP-513','CLI-114',20,NULL,'Cocina Integral','Madera Cedro',300.00,60.00,90.00,6,0,0,14.50,2.50,4.00,4200000.00,17,'Completado','2026-05-25','2026-06-11','Sergio Ramos'),
('PED-ESP-514','CLI-115',14,NULL,'Piso en Madera','Madera Flor Morado',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2700000.00,18,'Completado','2026-06-04','2026-06-22','Mateo Díaz'),
('PED-ESP-515','CLI-116',15,NULL,'Piso en Madera','Madera Pino',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2250000.00,14,'Completado','2026-06-14','2026-06-28','Lucas Herrera'),
('PED-ESP-516','CLI-117',16,NULL,'Cocina Integral','Madecor 15mm (Melamina)',240.00,60.00,90.00,6,0,0,14.50,2.50,4.00,3500000.00,15,'Completado','2026-06-24','2026-07-09','Jorge Tello'),
('PED-ESP-517','CLI-118',17,NULL,'Cocina Integral','Madera Cedro',300.00,60.00,90.00,6,0,0,14.50,2.50,4.00,4200000.00,16,'Completado','2026-07-04','2026-07-20','Andrés Silva'),
('PED-ESP-518','CLI-119',18,NULL,'Piso en Madera','Madera Flor Morado',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2700000.00,17,'Completado','2026-07-14','2026-07-31','Ricardo Palacios'),
('PED-ESP-519','CLI-120',19,NULL,'Piso en Madera','Madera Pino',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2250000.00,18,'Completado','2026-07-24','2026-08-11','Manuel Ortiz'),
('PED-ESP-520','CLI-101',20,NULL,'Cocina Integral','Madecor 15mm (Melamina)',240.00,60.00,90.00,6,0,0,14.50,2.50,4.00,3500000.00,14,'Completado','2026-08-03','2026-08-17','Pedro Alcázar'),
('PED-ESP-521','CLI-102',14,NULL,'Cocina Integral','Madera Cedro',300.00,60.00,90.00,6,0,0,14.50,2.50,4.00,4200000.00,15,'Completado','2026-08-13','2026-08-28','Sergio Ramos'),
('PED-ESP-522','CLI-103',15,NULL,'Piso en Madera','Madera Flor Morado',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2700000.00,16,'Completado','2026-08-23','2026-09-08','Mateo Díaz'),
('PED-ESP-523','CLI-104',16,NULL,'Piso en Madera','Madera Pino',100.00,100.00,2.00,6,0,0,14.50,2.50,4.00,2250000.00,17,'Completado','2026-09-02','2026-09-19','Lucas Herrera'),
('PED-ESP-524','CLI-105',17,NULL,'Cocina Integral','Madecor 15mm (Melamina)',240.00,60.00,90.00,6,0,0,14.50,2.50,4.00,3500000.00,18,'Completado','2026-09-12','2026-09-30','Jorge Tello');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(100) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `precio_venta_base` decimal(12,2) NOT NULL,
  `costo_estimado` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `nombre_producto` (`nombre_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES
(1,'Closet Modular','Almacenamiento',1200000.00,750000.00),
(2,'Cocina Integral','Muebles de Cocina',3500000.00,2100000.00),
(3,'Puerta Tamborada','Puertas',380000.00,220000.00),
(4,'Piso en Madera','Revestimientos',150000.00,85000.00),
(5,'Escalera en Madera','Estructuras',2800000.00,1600000.00),
(6,'Mueble de Baño','Almacenamiento',650000.00,380000.00);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `contrasenia` varchar(255) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `rol` varchar(30) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuario` (`usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
(1,'carlos.admin','$2b$12$JR6vBviweVTnbnDYige07eSDljYfK.RWeLxdR6pVJ9.s1T.5MtuDC','Carlos Mendoza','Administrador'),
(2,'elena.admin','$2b$12$dC0fohQdofR.tIxjNmmHFOLClZp6PgYGVZdQb6mT0aytOhlUVuzs.','Elena Rostova','Administrador'),
(3,'ana.conta','$2b$12$m.xSMTDV7Sr/.BFTM7W4g.42e237RcmHWmfDc9dd7MjCEs.jDiFmG','Ana Gómez','Contador'),
(4,'luis.conta','$2b$12$xrftSnYQpXF8ZBS7ozod0ewhz9Lumiq.K3Bh3PKVj0hqIAZFPjPVW','Luis Martínez','Contador'),
(5,'clara.conta','$2b$12$mmq/GzzcNFMsO0xT0jRVpOG2byVD4BxMGeCvKwzN6oc9wI1dg3boa','Clara Benítez','Contador'),
(14,'sofia.ventas','$2b$12$eLnv.kRJpt6VjJ9TI6t/tu.mHFvU.dvQskEE/Cutd/CO/c5tZj8/e','Sofía Castro','Ventas'),
(15,'diego.ventas','$2b$12$oPDNXzpCC6oNC.gPy5vlO.EUEM265Db1iqzGdz6wRhnShSX1N0wh6','Diego Torres','Ventas'),
(16,'valeria.ventas','$2b$12$ALXkqdc7s4xgWO7kKBZhreDTQ4cACjfK7sCHBjIBr..hfi4UPfPXm','Valeria Morales','Ventas'),
(17,'camila.ventas','$2b$12$ORwyrM7bntNb8rZcsmycRuwQYS5v25InHKqyiiLVq4PTlIhwl7iyO','Camila Fuentes','Ventas'),
(18,'laura.ventas','$2b$12$LdhRFvzF9mgoM7vECGsGQOCyyK9IJG7uyTedjE1rfqRJf8nMy2IaG','Laura Espinoza','Ventas'),
(19,'tomas.ventas','$2b$12$8es56DH1K48GLuDOWOqGiOZV0l/yEZIMMBN/S0EZ/cnYYdeBXGUf2','Tomás Duarte','Ventas'),
(20,'hugo.ventas','$2b$12$oNTEjgWlQcbnQ6ue7Jc4he4uf469FwdCLtYc1MCWv4CXLHwH3Lq7y','Hugo Paredes','Ventas');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_venta` varchar(30) NOT NULL,
  `id_pedido` varchar(30) NOT NULL,
  `id_cliente` varchar(50) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `fecha_venta` date NOT NULL,
  `metodo_pago` enum('Efectivo','Transferencia','Tarjeta de Crédito','Tarjeta de Débito') NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `impuestos` decimal(12,2) NOT NULL,
  `total_pagado` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_venta`),
  UNIQUE KEY `id_pedido` (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_vendedor` (`id_vendedor`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`id_vendedor`) REFERENCES `usuarios` (`id_usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES
('VEN-1003','PED-1003','CLI-103',16,'2026-01-24','Tarjeta de Débito',379831.93,72168.07,452000.00),
('VEN-1007','PED-1007','CLI-107',20,'2026-02-09','Tarjeta de Débito',1119327.73,212672.27,1332000.00),
('VEN-1011','PED-1011','CLI-111',17,'2026-02-25','Tarjeta de Débito',2423529.41,460470.59,2884000.00),
('VEN-1015','PED-1015','CLI-115',14,'2026-03-13','Tarjeta de Débito',303361.34,57638.66,361000.00),
('VEN-1019','PED-1019','CLI-119',18,'2026-03-11','Tarjeta de Débito',1280672.27,243327.73,1524000.00),
('VEN-1023','PED-1023','CLI-103',15,'2026-03-27','Tarjeta de Débito',2800000.00,532000.00,3332000.00),
('VEN-1027','PED-1027','CLI-107',19,'2026-04-12','Tarjeta de Débito',354621.85,67378.15,422000.00),
('VEN-1031','PED-1031','CLI-111',16,'2026-04-28','Tarjeta de Débito',1038655.46,197344.54,1236000.00),
('VEN-1035','PED-1035','CLI-115',20,'2026-05-14','Tarjeta de Débito',2235294.12,424705.88,2660000.00),
('VEN-1039','PED-1039','CLI-119',17,'2026-05-12','Tarjeta de Débito',405882.35,77117.65,483000.00),
('VEN-1043','PED-1043','CLI-103',14,'2026-05-28','Tarjeta de Débito',1200000.00,228000.00,1428000.00),
('VEN-1047','PED-1047','CLI-107',18,'2026-06-13','Tarjeta de Débito',2611764.71,496235.29,3108000.00),
('VEN-1051','PED-1051','CLI-111',15,'2026-06-29','Tarjeta de Débito',328571.43,62428.57,391000.00),
('VEN-1055','PED-1055','CLI-115',19,'2026-06-27','Tarjeta de Débito',957983.19,182016.81,1140000.00),
('VEN-1059','PED-1059','CLI-119',16,'2026-07-13','Tarjeta de Débito',2988235.29,567764.71,3556000.00),
('VEN-1063','PED-1063','CLI-103',20,'2026-07-29','Tarjeta de Débito',379831.93,72168.07,452000.00),
('VEN-1067','PED-1067','CLI-107',17,'2026-08-14','Tarjeta de Débito',1119327.73,212672.27,1332000.00),
('VEN-1071','PED-1071','CLI-111',14,'2026-08-30','Tarjeta de Débito',2423529.41,460470.59,2884000.00),
('VEN-1075','PED-1075','CLI-115',18,'2026-08-28','Tarjeta de Débito',303361.34,57638.66,361000.00),
('VEN-1079','PED-1079','CLI-119',15,'2026-09-13','Tarjeta de Débito',1280672.27,243327.73,1524000.00),
('VEN-1083','PED-1083','CLI-103',19,'2026-09-29','Tarjeta de Débito',2800000.00,532000.00,3332000.00),
('VEN-1087','PED-1087','CLI-107',16,'2026-10-15','Tarjeta de Débito',354621.85,67378.15,422000.00),
('VEN-1091','PED-1091','CLI-111',20,'2026-01-16','Tarjeta de Débito',1038655.46,197344.54,1236000.00),
('VEN-1095','PED-1095','CLI-115',17,'2026-02-01','Tarjeta de Débito',2235294.12,424705.88,2660000.00),
('VEN-1099','PED-1099','CLI-119',14,'2026-02-17','Tarjeta de Débito',405882.35,77117.65,483000.00),
('VEN-1103','PED-1103','CLI-103',18,'2026-03-05','Tarjeta de Débito',1200000.00,228000.00,1428000.00),
('VEN-1107','PED-1107','CLI-107',15,'2026-03-21','Tarjeta de Débito',2611764.71,496235.29,3108000.00),
('VEN-1111','PED-1111','CLI-111',19,'2026-03-19','Tarjeta de Débito',328571.43,62428.57,391000.00),
('VEN-1115','PED-1115','CLI-115',16,'2026-04-04','Tarjeta de Débito',957983.19,182016.81,1140000.00),
('VEN-1119','PED-1119','CLI-119',20,'2026-04-20','Tarjeta de Débito',2988235.29,567764.71,3556000.00),
('VEN-1123','PED-1123','CLI-103',17,'2026-05-06','Tarjeta de Débito',379831.93,72168.07,452000.00),
('VEN-1127','PED-1127','CLI-107',14,'2026-05-04','Tarjeta de Débito',1119327.73,212672.27,1332000.00),
('VEN-1131','PED-1131','CLI-111',18,'2026-05-20','Tarjeta de Débito',2423529.41,460470.59,2884000.00),
('VEN-1135','PED-1135','CLI-115',15,'2026-06-05','Tarjeta de Débito',303361.34,57638.66,361000.00),
('VEN-1139','PED-1139','CLI-119',19,'2026-06-21','Tarjeta de Débito',1280672.27,243327.73,1524000.00),
('VEN-1143','PED-1143','CLI-103',16,'2026-07-07','Tarjeta de Débito',2800000.00,532000.00,3332000.00),
('VEN-1147','PED-1147','CLI-107',20,'2026-07-05','Tarjeta de Débito',354621.85,67378.15,422000.00),
('VEN-1151','PED-1151','CLI-111',17,'2026-07-21','Tarjeta de Débito',1038655.46,197344.54,1236000.00),
('VEN-1155','PED-1155','CLI-115',14,'2026-08-06','Tarjeta de Débito',2235294.12,424705.88,2660000.00),
('VEN-1159','PED-1159','CLI-119',18,'2026-08-22','Tarjeta de Débito',405882.35,77117.65,483000.00),
('VEN-1163','PED-1163','CLI-103',15,'2026-08-20','Tarjeta de Débito',1200000.00,228000.00,1428000.00),
('VEN-1167','PED-1167','CLI-107',19,'2026-09-05','Tarjeta de Débito',2611764.71,496235.29,3108000.00),
('VEN-1171','PED-1171','CLI-111',16,'2026-09-21','Tarjeta de Débito',328571.43,62428.57,391000.00),
('VEN-1175','PED-1175','CLI-115',20,'2026-10-07','Tarjeta de Débito',957983.19,182016.81,1140000.00),
('VEN-1179','PED-1179','CLI-119',17,'2026-10-23','Tarjeta de Débito',2988235.29,567764.71,3556000.00),
('VEN-BAL-1001','PED-BAL-1001','CLI-102',14,'2026-02-15','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1002','PED-BAL-1002','CLI-103',15,'2026-02-17','Transferencia',319327.73,60672.27,380000.00),
('VEN-BAL-1003','PED-BAL-1003','CLI-104',16,'2026-02-19','Transferencia',2352941.18,447058.82,2800000.00),
('VEN-BAL-1004','PED-BAL-1004','CLI-105',17,'2026-02-21','Transferencia',546218.49,103781.51,650000.00),
('VEN-BAL-1005','PED-BAL-1005','CLI-106',18,'2026-02-23','Transferencia',1890756.30,359243.70,2250000.00),
('VEN-BAL-1006','PED-BAL-1006','CLI-107',19,'2026-02-25','Transferencia',1008403.36,191596.64,1200000.00),
('VEN-BAL-1007','PED-BAL-1007','CLI-108',20,'2026-02-27','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1008','PED-BAL-1008','CLI-109',14,'2026-02-21','Transferencia',319327.73,60672.27,380000.00),
('VEN-BAL-1009','PED-BAL-1009','CLI-110',15,'2026-02-23','Transferencia',2352941.18,447058.82,2800000.00),
('VEN-BAL-1010','PED-BAL-1010','CLI-111',16,'2026-02-25','Transferencia',546218.49,103781.51,650000.00),
('VEN-BAL-1011','PED-BAL-1011','CLI-112',17,'2026-02-27','Transferencia',1890756.30,359243.70,2250000.00),
('VEN-BAL-1012','PED-BAL-1012','CLI-113',18,'2026-03-01','Transferencia',1008403.36,191596.64,1200000.00),
('VEN-BAL-1013','PED-BAL-1013','CLI-114',19,'2026-03-03','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1014','PED-BAL-1014','CLI-115',20,'2026-03-05','Transferencia',319327.73,60672.27,380000.00),
('VEN-BAL-1015','PED-BAL-1015','CLI-116',14,'2026-03-07','Transferencia',2352941.18,447058.82,2800000.00),
('VEN-BAL-1016','PED-BAL-1016','CLI-117',15,'2026-03-01','Transferencia',546218.49,103781.51,650000.00),
('VEN-BAL-1017','PED-BAL-1017','CLI-118',16,'2026-03-03','Transferencia',1890756.30,359243.70,2250000.00),
('VEN-BAL-1018','PED-BAL-1018','CLI-119',17,'2026-03-05','Transferencia',1008403.36,191596.64,1200000.00),
('VEN-BAL-1019','PED-BAL-1019','CLI-101',18,'2026-03-07','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1020','PED-BAL-1020','CLI-102',19,'2026-03-09','Transferencia',319327.73,60672.27,380000.00),
('VEN-BAL-1021','PED-BAL-1021','CLI-103',20,'2026-03-11','Transferencia',2352941.18,447058.82,2800000.00),
('VEN-BAL-1022','PED-BAL-1022','CLI-104',14,'2026-03-13','Transferencia',546218.49,103781.51,650000.00),
('VEN-BAL-1023','PED-BAL-1023','CLI-105',15,'2026-03-15','Transferencia',1890756.30,359243.70,2250000.00),
('VEN-BAL-1024','PED-BAL-1024','CLI-106',16,'2026-03-09','Transferencia',1008403.36,191596.64,1200000.00),
('VEN-BAL-1025','PED-BAL-1025','CLI-107',17,'2026-03-11','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1026','PED-BAL-1026','CLI-108',18,'2026-03-13','Transferencia',319327.73,60672.27,380000.00),
('VEN-BAL-1027','PED-BAL-1027','CLI-109',19,'2026-03-15','Transferencia',2352941.18,447058.82,2800000.00),
('VEN-BAL-1028','PED-BAL-1028','CLI-110',20,'2026-03-17','Transferencia',546218.49,103781.51,650000.00),
('VEN-BAL-1029','PED-BAL-1029','CLI-111',14,'2026-03-19','Transferencia',1890756.30,359243.70,2250000.00),
('VEN-BAL-1030','PED-BAL-1030','CLI-112',15,'2026-03-21','Transferencia',1008403.36,191596.64,1200000.00),
('VEN-BAL-1031','PED-BAL-1031','CLI-113',16,'2026-03-23','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1032','PED-BAL-1032','CLI-114',17,'2026-03-17','Transferencia',319327.73,60672.27,380000.00),
('VEN-BAL-1033','PED-BAL-1033','CLI-115',18,'2026-03-19','Transferencia',2352941.18,447058.82,2800000.00),
('VEN-BAL-1034','PED-BAL-1034','CLI-116',19,'2026-03-21','Transferencia',546218.49,103781.51,650000.00),
('VEN-BAL-1035','PED-BAL-1035','CLI-117',20,'2026-03-23','Transferencia',1890756.30,359243.70,2250000.00),
('VEN-BAL-1036','PED-BAL-1036','CLI-118',14,'2026-03-25','Transferencia',1008403.36,191596.64,1200000.00),
('VEN-BAL-1037','PED-BAL-1037','CLI-119',15,'2026-03-27','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1038','PED-BAL-1038','CLI-101',16,'2026-03-29','Transferencia',319327.73,60672.27,380000.00),
('VEN-BAL-1039','PED-BAL-1039','CLI-102',17,'2026-03-31','Transferencia',2352941.18,447058.82,2800000.00),
('VEN-BAL-1040','PED-BAL-1040','CLI-103',18,'2026-03-25','Transferencia',546218.49,103781.51,650000.00),
('VEN-BAL-1041','PED-BAL-1041','CLI-104',19,'2026-03-27','Transferencia',1890756.30,359243.70,2250000.00),
('VEN-BAL-1042','PED-BAL-1042','CLI-105',20,'2026-03-29','Transferencia',1008403.36,191596.64,1200000.00),
('VEN-BAL-1043','PED-BAL-1043','CLI-106',14,'2026-03-31','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1044','PED-BAL-1044','CLI-107',15,'2026-04-02','Transferencia',319327.73,60672.27,380000.00),
('VEN-BAL-1045','PED-BAL-1045','CLI-108',16,'2026-04-04','Transferencia',2352941.18,447058.82,2800000.00),
('VEN-BAL-1046','PED-BAL-1046','CLI-109',17,'2026-04-06','Transferencia',546218.49,103781.51,650000.00),
('VEN-BAL-1047','PED-BAL-1047','CLI-110',18,'2026-04-08','Transferencia',1890756.30,359243.70,2250000.00),
('VEN-BAL-1048','PED-BAL-1048','CLI-111',19,'2026-04-02','Transferencia',1008403.36,191596.64,1200000.00),
('VEN-BAL-1049','PED-BAL-1049','CLI-112',20,'2026-04-04','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1050','PED-BAL-1050','CLI-113',14,'2026-04-06','Transferencia',319327.73,60672.27,380000.00),
('VEN-BAL-1051','PED-BAL-1051','CLI-114',15,'2026-04-08','Transferencia',2352941.18,447058.82,2800000.00),
('VEN-BAL-1052','PED-BAL-1052','CLI-115',16,'2026-04-10','Transferencia',546218.49,103781.51,650000.00),
('VEN-BAL-1053','PED-BAL-1053','CLI-116',17,'2026-04-12','Transferencia',1890756.30,359243.70,2250000.00),
('VEN-BAL-1054','PED-BAL-1054','CLI-117',18,'2026-04-14','Transferencia',1008403.36,191596.64,1200000.00),
('VEN-BAL-1055','PED-BAL-1055','CLI-118',19,'2026-04-16','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-BAL-1056','PED-BAL-1056','CLI-119',20,'2026-04-10','Transferencia',319327.73,60672.27,380000.00),
('VEN-ESP-501','PED-ESP-501','CLI-102',15,'2026-02-09','Tarjeta de Crédito',3529411.76,670588.24,4200000.00),
('VEN-ESP-502','PED-ESP-502','CLI-103',16,'2026-02-20','Efectivo',2268907.56,431092.44,2700000.00),
('VEN-ESP-503','PED-ESP-503','CLI-104',17,'2026-03-03','Tarjeta de Débito',1890756.30,359243.70,2250000.00),
('VEN-ESP-504','PED-ESP-504','CLI-105',18,'2026-03-14','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-ESP-505','PED-ESP-505','CLI-106',19,'2026-03-20','Tarjeta de Crédito',3529411.76,670588.24,4200000.00),
('VEN-ESP-506','PED-ESP-506','CLI-107',20,'2026-03-31','Efectivo',2268907.56,431092.44,2700000.00),
('VEN-ESP-507','PED-ESP-507','CLI-108',14,'2026-04-11','Tarjeta de Débito',1890756.30,359243.70,2250000.00),
('VEN-ESP-508','PED-ESP-508','CLI-109',15,'2026-04-22','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-ESP-509','PED-ESP-509','CLI-110',16,'2026-05-03','Tarjeta de Crédito',3529411.76,670588.24,4200000.00),
('VEN-ESP-510','PED-ESP-510','CLI-111',17,'2026-05-09','Efectivo',2268907.56,431092.44,2700000.00),
('VEN-ESP-511','PED-ESP-511','CLI-112',18,'2026-05-20','Tarjeta de Débito',1890756.30,359243.70,2250000.00),
('VEN-ESP-512','PED-ESP-512','CLI-113',19,'2026-05-31','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-ESP-513','PED-ESP-513','CLI-114',20,'2026-06-11','Tarjeta de Crédito',3529411.76,670588.24,4200000.00),
('VEN-ESP-514','PED-ESP-514','CLI-115',14,'2026-06-22','Efectivo',2268907.56,431092.44,2700000.00),
('VEN-ESP-515','PED-ESP-515','CLI-116',15,'2026-06-28','Tarjeta de Débito',1890756.30,359243.70,2250000.00),
('VEN-ESP-516','PED-ESP-516','CLI-117',16,'2026-07-09','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-ESP-517','PED-ESP-517','CLI-118',17,'2026-07-20','Tarjeta de Crédito',3529411.76,670588.24,4200000.00),
('VEN-ESP-518','PED-ESP-518','CLI-119',18,'2026-07-31','Efectivo',2268907.56,431092.44,2700000.00),
('VEN-ESP-519','PED-ESP-519','CLI-120',19,'2026-08-11','Tarjeta de Débito',1890756.30,359243.70,2250000.00),
('VEN-ESP-520','PED-ESP-520','CLI-101',20,'2026-08-17','Transferencia',2941176.47,558823.53,3500000.00),
('VEN-ESP-521','PED-ESP-521','CLI-102',14,'2026-08-28','Tarjeta de Crédito',3529411.76,670588.24,4200000.00),
('VEN-ESP-522','PED-ESP-522','CLI-103',15,'2026-09-08','Efectivo',2268907.56,431092.44,2700000.00),
('VEN-ESP-523','PED-ESP-523','CLI-104',16,'2026-09-19','Tarjeta de Débito',1890756.30,359243.70,2250000.00),
('VEN-ESP-524','PED-ESP-524','CLI-105',17,'2026-09-30','Transferencia',2941176.47,558823.53,3500000.00);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-11-18 21:07:02
