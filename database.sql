CREATE DATABASE IF NOT EXISTS greenbasket CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE greenbasket;
DROP TABLE IF EXISTS order_items; DROP TABLE IF EXISTS orders; DROP TABLE IF EXISTS subscribers; DROP TABLE IF EXISTS messages; DROP TABLE IF EXISTS users; DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT PRIMARY KEY,name VARCHAR(120),category VARCHAR(80),price INT,unit VARCHAR(30),image VARCHAR(255),stock INT DEFAULT 100,featured TINYINT DEFAULT 1);
INSERT INTO products(id,name,category,price,unit,image) VALUES
(1,'Nyanya','Mboga',4000,'kg','assets/products/nyanya.jpg'),
(2,'Karoti','Mboga',2500,'kg','assets/products/karoti.jpg'),
(3,'Brokoli','Mboga',4500,'kg','assets/products/broccoli.jpg'),
(4,'Lettuce','Mboga',3000,'fungu','assets/products/lettuce.jpg'),
(5,'Pilipili Hoho Nyekundu','Mboga',5000,'kg','assets/products/pilipili_ny.jpg'),
(6,'Pilipili Hoho Njano','Mboga',5000,'kg','assets/products/pilipili_nj.jpg'),
(7,'Zucchini','Mboga',5000,'kg','assets/products/zucchini.jpg'),
(8,'Vitunguu','Mboga',2500,'kg','assets/products/kitunguu.jpg'),
(9,'Kitunguu Saumu','Viungo',2000,'pakiti','assets/products/kitunguu_saumu.jpg'),
(10,'Mchicha','Mboga za Majani',1000,'fungu','assets/products/mchicha.jpg'),
(11,'Tufaha','Matunda',1000,'moja','assets/products/tufaha.jpg'),
(12,'Machungwa','Matunda',500,'moja','assets/products/machungwa.jpg'),
(13,'Zabibu','Matunda',12000,'pakiti','assets/products/zabibu.jpg'),
(14,'Nanasi','Matunda',3000,'moja','assets/products/matunda_mchanganyiko.jpg'),
(15,'Embe','Matunda',1000,'moja','assets/products/matunda_mchanganyiko.jpg'),
(16,'Parachichi','Matunda',3000,'moja','assets/products/tufaha.jpg'),
(17,'Papai','Matunda',4000,'moja','assets/products/matunda_mchanganyiko.jpg'),
(18,'Passion','Matunda',6000,'kg','assets/products/matunda_mchanganyiko.jpg'),
(19,'Maziwa Fresh 1L','Maziwa na Mayai',3500,'lita','assets/products/maziwa.jpg'),
(20,'Mayai Tray 30','Maziwa na Mayai',8000,'trei','assets/products/mayai.jpg'),
(21,'Jibini','Maziwa na Mayai',8000,'pakiti','assets/products/jibini.jpg'),
(22,'Yoghurt 500ml','Maziwa na Mayai',3500,'chupa','assets/products/maziwa.jpg'),
(23,'Karanga','Karanga na Mbegu',8000,'pakiti','assets/products/karanga.jpg'),
(24,'Korosho','Karanga na Mbegu',12000,'pakiti','assets/products/karanga.jpg'),
(25,'Mchanganyiko wa Karanga','Karanga na Mbegu',10000,'pakiti','assets/products/karanga.jpg'),
(26,'Mchele 1kg','Vyakula vya Msingi',3800,'kg','assets/products/matunda_mchanganyiko.jpg'),
(27,'Unga wa Sembe 2kg','Vyakula vya Msingi',3000,'pakiti','assets/products/matunda_mchanganyiko.jpg'),
(28,'Sukari 1kg','Vyakula vya Msingi',3200,'kg','assets/products/karanga.jpg'),
(29,'Chumvi 1kg','Vyakula vya Msingi',1800,'pakiti','assets/products/karanga.jpg'),
(30,'Mafuta ya Kula 1L','Vyakula vya Msingi',7050,'lita','assets/products/maziwa.jpg'),
(31,'Nyama ya Ng’ombe','Nyama na Samaki',20000,'kg','assets/products/mboga_mchanganyiko.jpg'),
(32,'Kuku wa Kisasa','Nyama na Samaki',8000,'kuku','assets/products/mboga_mchanganyiko.jpg'),
(33,'Kuku wa Kienyeji','Nyama na Samaki',25000,'kuku','assets/products/mboga_mchanganyiko.jpg'),
(34,'Kambale','Nyama na Samaki',19000,'fungu','assets/products/mboga_mchanganyiko.jpg'),
(35,'Maji ya Chupa 1.5L','Vinywaji',1500,'chupa','assets/products/maziwa.jpg'),
(36,'Juisi 1L','Vinywaji',4000,'chupa','assets/products/matunda_mchanganyiko.jpg'),
(37,'Chai 100 Bags','Vinywaji',4000,'pakiti','assets/products/karanga.jpg'),
(38,'Kahawa 250g','Vinywaji',12000,'pakiti','assets/products/karanga.jpg'),
(39,'Sabuni ya Kufulia','Nyumbani',3500,'pakiti','assets/products/karanga.jpg'),
(40,'Sabuni ya Kuogea','Afya na Urembo',2000,'kipande','assets/products/karanga.jpg'),
(41,'Toothpaste','Afya na Urembo',3500,'tube','assets/products/karanga.jpg'),
(42,'Tissue Roll','Nyumbani',4500,'pakiti','assets/products/karanga.jpg'),
(43,'Sanitary Pads','Afya na Urembo',3300,'pakiti','assets/products/karanga.jpg'),
(44,'Tomato Paste 400g','Vyakula vya Msingi',1750,'kopi','assets/products/nyanya.jpg'),
(45,'Spaghetti 450g','Vyakula vya Msingi',2500,'pakiti','assets/products/karanga.jpg'),
(46,'Margarine 500g','Vyakula vya Msingi',5500,'pakiti','assets/products/maziwa.jpg'),
(47,'Biscuits 200g','Vitafunwa',2500,'pakiti','assets/products/karanga.jpg'),
(48,'Oats 500g','Kifungua Kinywa',7500,'pakiti','assets/products/karanga.jpg'),
(49,'Asali 500g','Kifungua Kinywa',12000,'chupa','assets/products/karanga.jpg');
CREATE TABLE users(id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(120),email VARCHAR(160) UNIQUE,password VARCHAR(255),role ENUM('customer','admin') DEFAULT 'customer',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
INSERT INTO users(name,email,password,role) VALUES ('Msimamizi','admin@greenbasket.co.tz', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC8mLhN3y1vM4G0j8e7m', 'admin');
CREATE TABLE orders(id INT AUTO_INCREMENT PRIMARY KEY,user_id INT NULL,customer_name VARCHAR(120),phone VARCHAR(40),address VARCHAR(255),total INT,status VARCHAR(40) DEFAULT 'Pending',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE order_items(id INT AUTO_INCREMENT PRIMARY KEY,order_id INT,product_id INT,qty INT,price INT);
CREATE TABLE subscribers(id INT AUTO_INCREMENT PRIMARY KEY,email VARCHAR(160) UNIQUE,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE messages(id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(120),email VARCHAR(160),message TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
