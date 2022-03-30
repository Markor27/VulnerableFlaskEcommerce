PRAGMA foreign_keys=OFF;
PRAGMA writable_schema = 1;
delete from sqlite_master where type in ('table', 'index', 'trigger');
PRAGMA writable_schema = 0;
VACUUM;
PRAGMA INTEGRITY_CHECK;
BEGIN TRANSACTION;
CREATE TABLE user (
	id INTEGER NOT NULL, 
	name VARCHAR(50) NOT NULL, 
	username VARCHAR(80) NOT NULL, 
	email VARCHAR(120) NOT NULL, 
	password VARCHAR(180) NOT NULL, 
	profile VARCHAR(180) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (username), 
	UNIQUE (email)
);
INSERT INTO user VALUES(1,'root','root','root@projex.com','63a9f0ea7bb98050796b649e85481845','profile.jpg');
INSERT INTO user VALUES(2,'admin','admin','admin@projex.com','21232f297a57a5a743894a0e4a801fc3','profile.jpg');
CREATE TABLE brand (
	id INTEGER NOT NULL, 
	name VARCHAR(30) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
INSERT INTO brand VALUES(1,'Bang for your buck');
INSERT INTO brand VALUES(8,'Guns');
INSERT INTO brand VALUES(10,'Humvee');
INSERT INTO brand VALUES(11,'Swords R us');
INSERT INTO brand VALUES(12,'Bell');
INSERT INTO brand VALUES(13,'Smith & Wesson');
INSERT INTO brand VALUES(14,'Metro-Cammell');
INSERT INTO brand VALUES(17,'Boeing');
INSERT INTO brand VALUES(18,'Messerschmitt ');
INSERT INTO brand VALUES(19,'Supermarine');
INSERT INTO brand VALUES(20,'AEC');
INSERT INTO brand VALUES(21,'Webley');
INSERT INTO brand VALUES(22,'Ye Oldie Armour');
INSERT INTO brand VALUES(23,'Old Clobber');
INSERT INTO brand VALUES(24,'Roman');
INSERT INTO brand VALUES(25,'Japanese');
INSERT INTO brand VALUES(26,'Penguin R Us');
INSERT INTO brand VALUES(27,'Dolphins R Us');
INSERT INTO brand VALUES(28,'fighting dogs');
CREATE TABLE category (
	id INTEGER NOT NULL, 
	name VARCHAR(30) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
INSERT INTO category VALUES(8,'Weapons');
INSERT INTO category VALUES(9,'Ammo ');
INSERT INTO category VALUES(10,'Vehicles');
INSERT INTO category VALUES(12,'Uniform');
INSERT INTO category VALUES(13,'Animals');
CREATE TABLE addproduct (
	id INTEGER NOT NULL, 
	name VARCHAR(80) NOT NULL, 
	price NUMERIC(10, 2) NOT NULL, 
	discount INTEGER, 
	stock INTEGER NOT NULL, 
	colors TEXT NOT NULL, 
	"desc" TEXT NOT NULL, 
	pub_date DATETIME NOT NULL, 
	category_id INTEGER NOT NULL, 
	brand_id INTEGER NOT NULL, 
	image_1 VARCHAR(150) NOT NULL, 
	image_2 VARCHAR(150) NOT NULL, 
	image_3 VARCHAR(150) NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(category_id) REFERENCES category (id), 
	FOREIGN KEY(brand_id) REFERENCES brand (id)
);
INSERT INTO addproduct VALUES(5,'British WW1 Tank',1000,15,3,'green','Original WW1 British tank used in the trenches. An iconic symbol or the Great War!!','2020-02-16 20:14:20.388327',10,14,'bec17b2b141b5ed09fb9.jpg','fcbb3498bff4dda75680.jpg','36de8850dd7cf14f47a4.jpg');
INSERT INTO addproduct VALUES(12,'M60-Rambo Style',1000,0,10,'black','M60 as used by Rambo and get a free copy of the movie thrown in!!','2020-02-17 18:29:29.190442',8,8,'789045ff19463ccfcd65.jpeg','550cc811f69f989c5b2e.jpeg','3aae45e269ef882a86e5.jpeg');
INSERT INTO addproduct VALUES(14,'1822 Musket',1000,0,5,'brown,grey','Iconic musket from 1822','2022-02-07 15:25:07.915591',8,8,'ff31a06e13e6e85db9e1.jpg','666b48529f66390f37a1.jpg','9348bbc3e4960ace4f4f.jpg');
INSERT INTO addproduct VALUES(15,'Flintlock pistol',2000,0,2,'brown,grey','Classic pirate pistol ','2022-02-07 15:29:39.494146',8,8,'d847c8caed126a8f1b5b.jpg','6e839b82e7ecfa07141f.jpg','4657116c4dd78ac3aff0.jpg');
INSERT INTO addproduct VALUES(17,'Humvee',100000,0,2,'Beige or custom','Be king of the road ','2022-02-07 15:51:18.839205',10,10,'ada158d4085c5289aad6.jpg','ba4e146586a532de969b.jpg','063217f7a23b956857b1.jpg');
INSERT INTO addproduct VALUES(18,'Georgian Naval Cutlass',1500,0,4,'grey, black','A 1700''s Naval Classic ','2022-02-07 15:56:51.443653',8,11,'dbd706d1e545dbec162a.jpg','b4d8178152ab8a3ec17f.jpg','1904fd07adc833bb7fbd.jpg');
INSERT INTO addproduct VALUES(19,'Vietnam Bell Helicopter',1000000,0,2,'green','A chopper good enough to fly into NAM','2022-02-07 16:03:16.672582',10,12,'238c31a12cf0509d81eb.jpg','2d823f7ea5af86e2e64a.jpg','fc013953b76f70712f72.jpg');
INSERT INTO addproduct VALUES(20,'Lee-Enfield Rifle',1500,0,10,'brown,grey','Authentic WW1 rifle seen action during the Battle of the Somme','2022-02-07 16:05:31.312214',8,8,'6fa69d53bf582f19159a.jpg','48f222ae9ab7d5fa2bf3.jpg','d27f028ef19cf2b18421.jpg');
INSERT INTO addproduct VALUES(21,'WW1 Stick Grenade ',100,0,15,'grey ','Authentic case of a WW1 stick grenade','2022-02-07 16:09:37.453990',9,1,'0634aca4f4f9237cb638.jpg','13754ed8fe96bcb404da.jpg','dfc1a8bc43dca5ddb72c.jpg');
INSERT INTO addproduct VALUES(22,'Tommy Gun',2000,0,5,'brown and grey','Typical New York, Chicago gangster style. Watch out pretty boy!!','2022-02-07 16:12:23.074294',8,8,'0ec4fb7d0ced21d6a706.jpg','df8d62c32d46dfc284f8.jpg','9edd82790057fd79aea1.jpg');
INSERT INTO addproduct VALUES(23,'WW2 - Webley Revolver',1500,0,4,'black,grey','Authentic heavily used WW2 Webley Revolver in excellent preserved condition','2022-02-07 16:30:36.286665',8,21,'1ae826ea569c5958435e.jpg','257464157573747320ef.jpg','fb841346f3244e33fea2.jpg');
INSERT INTO addproduct VALUES(24,'Naval Cannon',50,0,2,'brown,grey','Typical 1700''s naval cannon','2022-02-07 16:32:47.592939',8,8,'29525644931df7a35802.jpg','d61dbbcb7f818f3b40e5.jpg','4e272ffd11bcff7050db.jpg');
INSERT INTO addproduct VALUES(25,'Smith & Wesson M76 - Vietnam War',2000,0,4,'grey','Original Smith & Wesson M76 Machine Gun from the Vietnam War','2022-02-08 11:21:54.997092',8,13,'4d7d636eeab611ba6a15.jpeg','2210cfaacd7409edab13.jpeg','be6d01128e328056bb62.jpeg');
INSERT INTO addproduct VALUES(28,'German Luger',1000,0,10,'grey, brown','Authentic German WW2 Luger pistol','2022-02-09 15:25:17.821954',8,1,'2583a378ae7289526211.jpeg','9b2ac3183fd004efdc58.jpeg','ddb21869115daf333dac.jpeg');
INSERT INTO addproduct VALUES(29,'Tiger I',100,0,2,'desert tan ','Tiger WW2 tank','2022-02-10 17:21:30.411158',10,1,'2b5f4c220295537dd8b5.jpg','303d954ab19496400c0f.jpg','690401a5d3a2d5b7b338.jpg');
INSERT INTO addproduct VALUES(30,'Panther tank',100,0,3,'camo','Panther Tank WW2 ','2022-02-10 17:23:01.409916',10,1,'ef250ede5d4568c60882.jpeg','405a752b1e273f096a43.jpeg','c007206bd85b3f046070.jpeg');
INSERT INTO addproduct VALUES(31,'T34 Tank - Russian',1000,0,3,'green ','WW2 Russian T34 tank ','2022-02-10 17:24:46.347849',10,1,'233e2cd7b603a0c3e6f0.jpeg','ba4dbba3d60285f13d18.jpeg','e719107405c6cd4bc0fa.jpeg');
INSERT INTO addproduct VALUES(32,'M1 - Rifle',1000,0,6,'brown, grey','WW2 M1 rifle','2022-02-10 17:26:17.285851',8,1,'4936e6500d8c910d516e.jpeg','24d7c2eedaa8c52710dc.jpeg','37c490e8909be91331e9.jpeg');
INSERT INTO addproduct VALUES(33,'Russian Sniper',1000,0,2,'brown,grey','WW2 - Russian Sniper rifle','2022-02-10 17:28:10.700122',8,1,'db6541a11e260e3e83a2.jpg','75688dd2487657a6b666.jpg','39b6d421cea0c1ca20f6.jpg');
INSERT INTO addproduct VALUES(34,'DUKW - Amphibious Vehicle ',100,0,1,'camo','Amphibious vehicle a vehicle for all situations, the real all rounder','2022-02-10 17:30:48.862545',10,1,'952d4d4a06c7b555b50d.jpg','49dd7878e79483528aa3.jpg','96f06f9f7c9f55670113.jpg');
INSERT INTO addproduct VALUES(35,'Boeing B17 - WW2 Bomber',1000,0,2,'green, gloss aluminium','B17 - A WW2 American icon','2022-02-10 17:34:14.279621',10,17,'44ef50d82330e12e38c9.jpeg','4ed4586b91ac38944a25.jpeg','4caae2a02eaf8e947079.jpeg');
INSERT INTO addproduct VALUES(36,'Messerschmitt 109 _ WW2 German Fighter',100,0,3,'grey black yellow','A WW2 German Luftwaffe icon ','2022-02-10 17:37:42.340650',10,18,'c9bd6bc74d410f819dfc.jpeg','a5f8d8eaff6b9289993c.jpeg','3dae44ff1f7f615df302.jpeg');
INSERT INTO addproduct VALUES(37,'Spitfire',100,0,2,'green brown','WW2 Spitfire a British Icon','2022-02-10 17:41:11.468220',10,19,'da82433594fdf5b41153.jpg','8cc0913873f2d2268b0e.jpg','3f715df0c4022c34c53a.jpg');
INSERT INTO addproduct VALUES(38,'Trebuchet ',1000,0,2,'brown','Swinging menace','2022-02-10 17:44:01.862743',8,1,'1b1492a1c0ae0a0291cf.jpeg','b73841168ebf32a2b1e5.jpeg','ccca342b691045cee231.jpeg');
INSERT INTO addproduct VALUES(39,'Medieval Sword Breaker',250,0,5,'black,grey','Medieval sword breaker used to snap an opponents weapon with a single twist','2022-02-10 17:47:14.323302',8,1,'bef5b99f17d4bab7f744.jpg','56465685837e4aef9539.jpg','3750ef9f7090e1af044b.jpg');
INSERT INTO addproduct VALUES(40,'AEC Armoured Car',100000,0,3,'green/camo','AEC Armoured Car ','2022-02-13 21:30:10.201172',10,20,'b3859f9dd34a101739ee.jpg','84fcb42a700e044fd3cc.jpg','76ace1ffdba796b9e56f.jpg');
INSERT INTO addproduct VALUES(41,'Medieval Knight''s Armour',1000,0,5,'silver','Hear ye hear ye!! Get your hands on this ICONIC  piece of Medieval armour!! Feel like a knight from day 1','2022-02-13 22:33:24.446675',12,22,'6b5c06011c636828064b.jpg','96cd80e4dd2018608a9d.jpg','2b26c18090f3cfe18f7d.jpg');
INSERT INTO addproduct VALUES(42,'Medieval Mace',300,50,10,'silver, black','A typical medieval weapon, comes half price with the suit of armour!!','2022-02-13 22:36:24.994869',8,23,'c027c8006841ecd99e17.jpeg','acbe0967a28778334d0d.jpeg','c66fc7cb903b235c4886.jpeg');
INSERT INTO addproduct VALUES(43,'Escalibur ',500,0,4,'silver, brown, gold','Replica of the legendary sword. HAIL KING ARTHUR!!','2022-02-13 22:40:45.738333',8,23,'2bf9e760730ee569c27e.jpg','39c104be05c6881221bd.jpg','ea702e8cec7b5de9926b.jpg');
INSERT INTO addproduct VALUES(44,'Roman Armour Set',500,0,4,'silver,red and gold','Roman Solider uniform','2022-02-16 18:22:03.327466',12,24,'a91bfbbc0749984493d9.jpg','486dda2e155bb587814b.jpg','126b80d3bfd197ef25b3.jpg');
INSERT INTO addproduct VALUES(45,'Vintage Samurai Sword',1000,15,6,'Black, gold silver','Authentic original Japanese Samurai Sword','2022-02-16 18:27:59.121186',8,25,'9dea368cbab4c7095af2.jpg','2fae855fbae7f9c85e6c.jpg','53d74074757fdad6bedd.jpg');
INSERT INTO addproduct VALUES(46,'Anti Aircraft Gun',10000,0,1,'green ','Anti Aircraft Gun from WW2','2022-02-16 18:30:26.596172',8,8,'6e28d7254ab16a1efd9a.jpg','88a2cb9e4fc80c41bfd2.jpg','630ff5b24e2fb6abd48c.jpg');
INSERT INTO addproduct VALUES(47,'Anti Aircraft Shell Case - British',300,10,10,'green and brass','Anti Aircraft Shell Casing','2022-02-16 18:32:24.013168',9,1,'51b0df55b76e7a6d88bd.jpeg','45495ea3c87901c80492.jpeg','cb3ecccb898a6b6af46d.jpeg');
INSERT INTO addproduct VALUES(48,'Ex-Minefield Penguin',200,10,20,'black, white and red','Light-foot legends these little guys can survive anything! ','2022-02-21 11:00:57.425731',13,26,'2e0449d4b024b32cfa60.jpg','154ca47bbc3f1eba2330.jpg','8d791f98e3703e3b45cf.jpg');
INSERT INTO addproduct VALUES(49,'Ex-Bomb Detection Dog',200,15,10,'brown, black','Want a dog that can detect anything these hardy guys can do just that. Just because their ex-military don''t mean they can''t be a good pet or even guard dog (up to you!!)','2022-02-21 11:04:32.955441',13,28,'38f608db61da44b345b0.jpg','b391a2b75bbd0b177f5d.jpg','5e7833420ad63acec6ef.jpg');
INSERT INTO addproduct VALUES(50,'Ex-Military Dolphin',1000,0,5,'grey, white','Who doesn''t want a dolphin as a pet!! Not only that an ex-military dolphin, these animals are one of the most intelligent creatures on earth but these guys take it to a whole new level!!','2022-02-21 11:07:04.492326',13,27,'73bcefedcd318d59b7d9.jpeg','55a2e43046b90ef6e4a8.jpeg','d9d9305a9347f26e3e43.jpeg');
CREATE TABLE IF NOT EXISTS "register" (
	id INTEGER NOT NULL, 
	name VARCHAR(50), 
	username VARCHAR(50), 
	email VARCHAR(50), 
	password VARCHAR(200), 
	country VARCHAR(50), 
	city VARCHAR(50), 
	contact VARCHAR(50), 
	address VARCHAR(50), 
	zipcode VARCHAR(50), 
	profile VARCHAR(200), 
	date_created DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (username), 
	UNIQUE (email)
);
INSERT INTO register VALUES(1,'bob','bob','bob@projex.com','9f9d51bc70ef21ca5c14f307980a29d8','UK','Edinburgh','078944625412','Edinburgh','EH','profile.png','2022-02-23 22:52:08.829218');
INSERT INTO register VALUES(2,'alice','alice','alice@projex.com','6384e2b2184bcbf58eccf10ca7a6563c','UK','Edinburgh','07814265941582','Edinburgh','EH','MyPhoto_1.jpg','2022-02-23 22:53:49.676353');
INSERT INTO register VALUES(3,'bill','bill','bill@projex.com','e8375d7cd983efcbf956da5937050ffc','UK','Edinburgh','07821212121','Edinburgh','EH','billProfile_2.jpeg','2022-03-03 15:32:23');
INSERT INTO register VALUES(4,'hacker','hacker','hacker@projex.com','d6a6bc0db10694a2d90e3a69648f3a03','UK','Edinburgh','07788','Edinburgh','EH','phpshell.php','2022-03-14 12:45:55');
CREATE TABLE customer_order (
	id INTEGER NOT NULL, 
	invoice VARCHAR(20) NOT NULL, 
	status VARCHAR(20) NOT NULL, 
	customer_id INTEGER NOT NULL, 
	date_created DATETIME NOT NULL, 
	orders TEXT, 
	PRIMARY KEY (id), 
	UNIQUE (invoice)
);
INSERT INTO customer_order VALUES(1,'5cb3282fd9','Pending',1,'2020-05-05 19:08:39.240926','{"10": {"color": "golden", "colors": "golden,white,black", "discount": 0, "image": "b85904527fd0cea93c90.jpeg", "name": "Rado watch", "price": 1200.99, "quantity": 1}, "11": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "dc900c380baf7d227ef0.png", "name": "Canon camera ", "price": 560.89, "quantity": 1}, "12": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "09f788f8cb89c480faa7.png", "name": "Apple watch", "price": 450.89, "quantity": 1}}');
INSERT INTO customer_order VALUES(2,'a6e8a7bf3b','Pending',2,'2020-05-06 11:31:17.614707','{"10": {"color": "golden", "colors": "golden,white,black", "discount": 0, "image": "b85904527fd0cea93c90.jpeg", "name": "Rado watch", "price": 1200.99, "quantity": 1}, "11": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "dc900c380baf7d227ef0.png", "name": "Canon camera ", "price": 560.89, "quantity": 1}, "12": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "09f788f8cb89c480faa7.png", "name": "Apple watch", "price": 450.89, "quantity": 1}}');
INSERT INTO customer_order VALUES(3,'2c1dba9580','Pending',2,'2020-05-06 11:31:27.139262','{"11": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "dc900c380baf7d227ef0.png", "name": "Canon camera ", "price": 560.89, "quantity": 1}, "12": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "09f788f8cb89c480faa7.png", "name": "Apple watch", "price": 450.89, "quantity": 1}}');
INSERT INTO customer_order VALUES(4,'09fefc3d3c','Pending',2,'2020-05-06 11:36:27.669339','{"10": {"color": "golden", "colors": "golden,white,black", "discount": 0, "image": "b85904527fd0cea93c90.jpeg", "name": "Rado watch", "price": 1200.99, "quantity": 1}, "12": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "09f788f8cb89c480faa7.png", "name": "Apple watch", "price": 450.89, "quantity": "2"}}');
INSERT INTO customer_order VALUES(5,'9bb1b9c3d5','Pending',2,'2020-05-06 11:39:05.303821','{"10": {"color": "golden", "colors": "golden,white,black", "discount": 0, "image": "b85904527fd0cea93c90.jpeg", "name": "Rado watch", "price": 1200.99, "quantity": 1}, "11": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "dc900c380baf7d227ef0.png", "name": "Canon camera ", "price": 560.89, "quantity": "2"}}');
INSERT INTO customer_order VALUES(6,'31b57e2fef','Pending',2,'2020-05-11 18:06:29.579892','{"10": {"color": "golden", "colors": "golden,white,black", "discount": 0, "image": "b85904527fd0cea93c90.jpeg", "name": "Rado watch", "price": 1200.99, "quantity": 1}, "11": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "dc900c380baf7d227ef0.png", "name": "Canon camera ", "price": 560.89, "quantity": 1}}');
INSERT INTO customer_order VALUES(7,'ebdbf60f1b','Paid',2,'2020-05-11 18:42:51.527684','{"10": {"color": "golden", "discount": 0, "name": "Rado watch", "price": 1200.99, "quantity": 1}, "12": {"color": "blue", "discount": 10, "name": "Apple watch", "price": 450.89, "quantity": 1}, "9": {"color": "blue", "discount": 15, "name": "Samsang mobile", "price": 780.5, "quantity": 1}}');
INSERT INTO customer_order VALUES(8,'347bcdf796','Paid',2,'2020-05-11 18:56:24.106484','{"12": {"color": "blue", "discount": 10, "name": "Apple watch", "price": 450.89, "quantity": "1"}}');
INSERT INTO customer_order VALUES(9,'edb912eac8','Pending',3,'2022-01-27 11:08:36.857576','{"11": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "dc900c380baf7d227ef0.png", "name": "Canon camera ", "price": 560.89, "quantity": 1}, "12": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "09f788f8cb89c480faa7.png", "name": "Apple watch", "price": 450.89, "quantity": 1}}');
INSERT INTO customer_order VALUES(10,'1a1afb4475','Paid',3,'2022-01-27 11:58:37.122248','{"11": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "dc900c380baf7d227ef0.png", "name": "Canon camera ", "price": 560.89, "quantity": 1}, "12": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "09f788f8cb89c480faa7.png", "name": "Apple watch", "price": 450.89, "quantity": 1}}');
INSERT INTO customer_order VALUES(11,'1bcdbbe032','Pending',3,'2022-01-27 12:06:56.862143','{"11": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "dc900c380baf7d227ef0.png", "name": "Canon camera ", "price": 560.89, "quantity": 1}, "12": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "09f788f8cb89c480faa7.png", "name": "Apple watch", "price": 450.89, "quantity": 1}}');
INSERT INTO customer_order VALUES(12,'38803d975f','Paid',4,'2022-01-27 12:19:15.582735','{"12": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "09f788f8cb89c480faa7.png", "name": "Apple watch", "price": 450.89, "quantity": 1}, "5": {"color": "pink", "colors": "pink,gray,white,black,blue", "discount": 0, "image": "87fcab43cab157ab14b7.jpg", "name": "sony tv", "price": 980.5, "quantity": 1}, "8": {"color": "blue", "colors": "blue,gray,white,black", "discount": 5, "image": "c8cd10e2fd79892fd1f1.jpeg", "name": "Dell", "price": 780.5, "quantity": 1}, "9": {"color": "blue", "colors": "blue,gray,white,black", "discount": 15, "image": "b93a85f9a61f2a7856d8.png", "name": "Samsang mobile", "price": 780.5, "quantity": 1}}');
INSERT INTO customer_order VALUES(13,'ecc7880f71','Paid',3,'2022-01-27 12:55:40.341469','{"10": {"color": "golden", "colors": "golden,white,black", "discount": 0, "image": "b85904527fd0cea93c90.jpeg", "name": "Rado watch", "price": 1200.99, "quantity": 1}, "6": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "040f3c7cb7d97ac64e6e.jpeg", "name": "sony mobile", "price": 780.5, "quantity": 1}}');
INSERT INTO customer_order VALUES(14,'f66a922b1e','Paid',3,'2022-02-07 13:39:30.505480','{"11": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "dc900c380baf7d227ef0.png", "name": "Canon camera ", "price": 560.89, "quantity": 1}, "12": {"color": "blue", "colors": "blue,gray,white,black", "discount": 10, "image": "09f788f8cb89c480faa7.png", "name": "Apple watch", "price": 450.89, "quantity": 1}, "2": {"color": "gray", "colors": "gray,white,black", "discount": 0, "image": "1b6b45a578914ed1fde8.jpg", "name": "iphone x", "price": 1150.99, "quantity": 1}, "9": {"color": "blue", "colors": "blue,gray,white,black", "discount": 15, "image": "b93a85f9a61f2a7856d8.png", "name": "Samsang mobile", "price": 780.5, "quantity": 1}}');
INSERT INTO customer_order VALUES(15,'0712571037','Paid',3,'2022-02-22 19:54:05.011774','{"47": {"color": "green and brass", "colors": "green and brass", "discount": 10, "image": "51b0df55b76e7a6d88bd.jpeg", "name": "Anti Aircraft Shell Case - British", "price": 300.0, "quantity": 1}, "50": {"color": "grey", "colors": "grey, white", "discount": 0, "image": "73bcefedcd318d59b7d9.jpeg", "name": "Ex-Military Dolphin", "price": 1000.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(16,'90b49c7adb','Paid',5,'2022-02-23 15:52:19.669101','{"43": {"color": "silver", "colors": "silver, brown, gold", "discount": 0, "image": "2bf9e760730ee569c27e.jpg", "name": "Escalibur ", "price": 500.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(17,'53b6fe36cf','Paid',5,'2022-02-23 15:58:43.416525','{"48": {"color": "black", "colors": "black, white and red", "discount": 10, "image": "2e0449d4b024b32cfa60.jpg", "name": "Ex-Minefield Penguin", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(18,'5cbdab54b1','Paid',5,'2022-02-23 16:03:04.380747','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(19,'bb9c9231aa','Paid',5,'2022-02-23 16:14:46.396242','{"24": {"color": "brown", "colors": "brown,grey", "discount": 0, "image": "29525644931df7a35802.jpg", "name": "Naval Cannon", "price": 50.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(20,'0220252cb4','Paid',5,'2022-02-23 16:23:34.161441','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(21,'911bd969e9','Paid',2,'2022-02-23 23:08:56.057263','{"50": {"color": "grey", "colors": "grey, white", "discount": 0, "image": "73bcefedcd318d59b7d9.jpeg", "name": "Ex-Military Dolphin", "price": 1000.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(22,'3e6e5c9c38','Pending',1,'2022-02-23 23:14:54.169353','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(23,'e20afcbec3','Pending',1,'2022-02-23 23:17:31.350802','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(24,'8bb2d9545f','Pending',1,'2022-02-23 23:18:35.525490','{"48": {"color": "black", "colors": "black, white and red", "discount": 10, "image": "2e0449d4b024b32cfa60.jpg", "name": "Ex-Minefield Penguin", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(25,'55759612a5','Pending',1,'2022-02-23 23:19:03.148054','{"48": {"color": "black", "colors": "black, white and red", "discount": 10, "image": "2e0449d4b024b32cfa60.jpg", "name": "Ex-Minefield Penguin", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(26,'ca4a306a35','Pending',1,'2022-02-23 23:35:18.423560','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(27,'f347042aa3','Pending',1,'2022-02-23 23:37:13.906840','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(28,'47bc002521','Paid',1,'2022-03-03 16:14:51.767639','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(29,'63b9dda2e1','Pending',2,'2022-03-09 10:07:29.814372','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(30,'242986b647','Pending',2,'2022-03-09 12:10:12.964088','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(31,'b3aef28537','Pending',1,'2022-03-09 12:13:05.687104','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(32,'4e369c6191','Pending',1,'2022-03-09 19:59:05.543555','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(33,'6e73797d7f','Pending',1,'2022-03-09 20:39:57.442292','{"49": {"color": "brown", "colors": "brown, black", "discount": 15, "image": "38f608db61da44b345b0.jpg", "name": "Ex-Bomb Detection Dog", "price": 200.0, "quantity": 1}}');
INSERT INTO customer_order VALUES(34,'b661ce62d9','Pending',1,'2022-03-09 23:49:44.070094','{"20": {"color": "brown", "colors": "brown,grey", "discount": 0, "image": "6fa69d53bf582f19159a.jpg", "name": "Lee-Enfield Rifle", "price": 1500.0, "quantity": 1}}');
CREATE TABLE alembic_version (
	version_num VARCHAR(32) NOT NULL, 
	CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);
COMMIT;
PRAGMA foreign_keys=ON;
PRAGMA INTEGRITY_CHECK;