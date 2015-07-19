BEGIN TRANSACTION;
CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
INSERT INTO "schema_migrations" VALUES('20131103142222');
INSERT INTO "schema_migrations" VALUES('20141010133701');
INSERT INTO "schema_migrations" VALUES('20150509230334');
INSERT INTO "schema_migrations" VALUES('20150509230409');
INSERT INTO "schema_migrations" VALUES('20150509230418');
INSERT INTO "schema_migrations" VALUES('20150509231852');
INSERT INTO "schema_migrations" VALUES('20150509232959');
INSERT INTO "schema_migrations" VALUES('20150510050314');
INSERT INTO "schema_migrations" VALUES('20150510050937');
INSERT INTO "schema_migrations" VALUES('20150510051421');
INSERT INTO "schema_migrations" VALUES('20150510051819');
INSERT INTO "schema_migrations" VALUES('20150511035640');
INSERT INTO "schema_migrations" VALUES('20150511040012');
INSERT INTO "schema_migrations" VALUES('20150511043120');
INSERT INTO "schema_migrations" VALUES('20150511162215');
INSERT INTO "schema_migrations" VALUES('20150511162221');
INSERT INTO "schema_migrations" VALUES('20150511162234');
INSERT INTO "schema_migrations" VALUES('20150511165022');
INSERT INTO "schema_migrations" VALUES('20150511165405');
INSERT INTO "schema_migrations" VALUES('20150511171540');
INSERT INTO "schema_migrations" VALUES('20150511200055');
INSERT INTO "schema_migrations" VALUES('20150511201616');
INSERT INTO "schema_migrations" VALUES('20150511202805');
INSERT INTO "schema_migrations" VALUES('20150511222507');
INSERT INTO "schema_migrations" VALUES('20150511223519');
INSERT INTO "schema_migrations" VALUES('20150512160330');
INSERT INTO "schema_migrations" VALUES('20150513042954');
INSERT INTO "schema_migrations" VALUES('20150513174652');
INSERT INTO "schema_migrations" VALUES('20150513210430');
INSERT INTO "schema_migrations" VALUES('20150518174541');
INSERT INTO "schema_migrations" VALUES('20150519043418');
INSERT INTO "schema_migrations" VALUES('20150519161001');
INSERT INTO "schema_migrations" VALUES('20150526233824');
INSERT INTO "schema_migrations" VALUES('20150527002604');
INSERT INTO "schema_migrations" VALUES('20150527022922');
INSERT INTO "schema_migrations" VALUES('20150527025845');
INSERT INTO "schema_migrations" VALUES('20150527033905');
INSERT INTO "schema_migrations" VALUES('20150527034259');
INSERT INTO "schema_migrations" VALUES('20150527182057');
INSERT INTO "schema_migrations" VALUES('20150527220733');
INSERT INTO "schema_migrations" VALUES('20150531200816');
INSERT INTO "schema_migrations" VALUES('20150612185914');
INSERT INTO "schema_migrations" VALUES('20150614182303');
INSERT INTO "schema_migrations" VALUES('20150615170722');
INSERT INTO "schema_migrations" VALUES('20150619171544');
INSERT INTO "schema_migrations" VALUES('20150619202519');
INSERT INTO "schema_migrations" VALUES('20150619223300');
INSERT INTO "schema_migrations" VALUES('20150622234152');
INSERT INTO "schema_migrations" VALUES('20150623033151');
INSERT INTO "schema_migrations" VALUES('20150624152346');
INSERT INTO "schema_migrations" VALUES('20150625222049');
INSERT INTO "schema_migrations" VALUES('20150626000233');
INSERT INTO "schema_migrations" VALUES('20150626154048');
INSERT INTO "schema_migrations" VALUES('20150626162058');
INSERT INTO "schema_migrations" VALUES('20150627042508');
INSERT INTO "schema_migrations" VALUES('20150701143307');
INSERT INTO "schema_migrations" VALUES('20150701212743');
INSERT INTO "schema_migrations" VALUES('20150702165538');
INSERT INTO "schema_migrations" VALUES('20150702172223');
INSERT INTO "schema_migrations" VALUES('20150702190508');
INSERT INTO "schema_migrations" VALUES('20150702221040');
INSERT INTO "schema_migrations" VALUES('20150703175824');
INSERT INTO "schema_migrations" VALUES('20150703180104');
INSERT INTO "schema_migrations" VALUES('20150703202211');
INSERT INTO "schema_migrations" VALUES('20150704234651');
INSERT INTO "schema_migrations" VALUES('20150707164249');
INSERT INTO "schema_migrations" VALUES('20150707165048');
INSERT INTO "schema_migrations" VALUES('20150708040750');
INSERT INTO "schema_migrations" VALUES('20150708043126');
INSERT INTO "schema_migrations" VALUES('20150709235751');
INSERT INTO "schema_migrations" VALUES('20150710233747');
INSERT INTO "schema_migrations" VALUES('20150711044841');
INSERT INTO "schema_migrations" VALUES('20150711200755');
INSERT INTO "schema_migrations" VALUES('20150711201202');
INSERT INTO "schema_migrations" VALUES('20150713183652');
INSERT INTO "schema_migrations" VALUES('20150713184208');
INSERT INTO "schema_migrations" VALUES('20150713224352');
INSERT INTO "schema_migrations" VALUES('20150714161947');
INSERT INTO "schema_migrations" VALUES('20150716173717');
CREATE TABLE "friendly_id_slugs" ("id" SERIAL PRIMARY KEY NOT NULL, "slug" varchar NOT NULL, "sluggable_id" integer NOT NULL, "sluggable_type" varchar(50), "scope" varchar, "created_at" timestamp);
CREATE TABLE "users" ("id" SERIAL PRIMARY KEY NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "admin" boolean DEFAULT 'f' NOT NULL, "locked" boolean DEFAULT 'f' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" timestamp, "remember_created_at" timestamp, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" timestamp, "last_sign_in_at" timestamp, "current_sign_in_ip" varchar, "last_sign_in_ip" varchar, "confirmation_token" varchar, "confirmed_at" timestamp, "confirmation_sent_at" timestamp, "unconfirmed_email" varchar, "created_at" timestamp, "updated_at" timestamp, "name" varchar DEFAULT '' NOT NULL);
INSERT INTO "users" VALUES(1,'admin@example.com','$2a$10$L1HIzDYQ1aG6GH781RQ9PuWHOGfrQ/15UAkWREWGBqq3l.dHOsmHS','t','f',NULL,NULL,NULL,19,'2015-06-12 17:08:55.003272','2015-06-01 18:00:40.037781','::1','::1',NULL,'2015-05-09 22:49:46.305159',NULL,NULL,'2015-05-09 22:49:46.316995','2015-06-22 23:47:42.471148','Stuart Henry');
INSERT INTO "users" VALUES(2,'stuart@xwinery.com','$2a$10$mhjZ8Mba0GIhu6XhNQJbOOwWIIzOXn4ynY8tenvsb9PMWDr1OEozi','t','f',NULL,NULL,NULL,10,'2015-07-13 05:09:36.939520','2015-07-09 17:48:56.695976','::1','::1',NULL,'2015-06-25 18:27:25.125294',NULL,NULL,'2015-06-25 18:27:25.141739','2015-07-13 05:09:36.940993','Stuart Henry');
INSERT INTO "users" VALUES(3,'cmac@xwinery.com','$2a$10$qTL6ucogMRJGzoSg23BWPeeULoppjTkwK9S/k1RdqyXpHoktz4Bu.','t','f',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'2015-06-25 18:27:25.211825',NULL,NULL,'2015-06-25 18:27:25.213250','2015-06-25 18:27:25.213250','Christine Adams');
INSERT INTO "users" VALUES(4,'reed@xwinery.com','$2a$10$v00MNfgXDTk1p7pPxPwQu.m2X1IbFRpXTWMjHxvMcJifpEOsE70lG','t','f',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'2015-06-25 18:27:25.285220',NULL,NULL,'2015-06-25 18:27:25.286605','2015-06-25 18:27:25.286605','Reed Renaudin');
INSERT INTO "users" VALUES(5,'barrett@xwinery.com','$2a$10$F/mdLIY0kfSG0/v.vFVIyunMs/GAJ/F/R1eATYJjhancjDWTvwm6q','f','f',NULL,NULL,NULL,2,'2015-06-30 00:49:29.591292','2015-06-25 18:39:28.590688','::1','::1',NULL,'2015-06-25 18:27:25.358576',NULL,NULL,'2015-06-25 18:27:25.359777','2015-06-30 00:49:29.592591','Barrett Marsalek');
CREATE TABLE "firms" ("id" SERIAL PRIMARY KEY NOT NULL, "type" varchar, "name" varchar DEFAULT '' NOT NULL, "description" varchar DEFAULT '' NOT NULL, "contact_name" varchar, "contact_email" varchar, "contact_phone" varchar, "address_line_1" varchar, "address_line_2" varchar, "city" varchar, "state" varchar, "zip" varchar, "bond" varchar, "account_number" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "projects_count" integer, "code" varchar);
INSERT INTO "firms" VALUES(10,'Customer','WTSO','','John Doe','jdoe@wtso.com','5551234567','1234 Wine Lane','','Sonoma','CA','95476',NULL,NULL,'2015-05-12 19:51:00.709926','2015-05-13 02:48:45.546175',3,NULL);
INSERT INTO "firms" VALUES(11,'Customer','Bowler','A wonderfully small family car.','Henry Ford','henry@ford.com','7075551212','123 Detroit Lane','','Detroit','AL','95959',NULL,NULL,'2015-05-12 20:04:39.549392','2015-06-12 18:57:14.496300',3,'');
INSERT INTO "firms" VALUES(12,'Vendor','Encore','','George Glass','george@encore.com','(555) 444-3333','555 Encore Blvd.','','Benicia','CA','95959',NULL,NULL,'2015-05-13 18:34:45.203282','2015-07-01 13:40:47.778287',NULL,'ENC');
INSERT INTO "firms" VALUES(13,'Vendor','Portocork','','Ronaldo Donaldo','ron@portocork.com','(444) 333-2222','5000 Cork Ct.','','Napa','CA','94559',NULL,NULL,'2015-05-13 19:55:58.096730','2015-07-01 13:40:55.099609',NULL,'PRT');
INSERT INTO "firms" VALUES(14,'Vendor','Stelvin','','Jack Screwcap','jack@stelvin.com','(555) 121-3434','7676 Alternative Ave.','','Los Angeles','CA','54321',NULL,NULL,'2015-05-13 19:59:28.338437','2015-07-01 13:41:10.187087',NULL,'STE');
INSERT INTO "firms" VALUES(15,'Vendor','Collotype','','Tom Labeler','tom@collotype.com','(707) 898-4564','900 Gateway Ct','','Napa ','CA','94558',NULL,NULL,'2015-05-13 21:17:42.203268','2015-07-01 13:40:41.523557',NULL,'COL');
INSERT INTO "firms" VALUES(16,'Vendor','Ramondin','','Cap Capsuled','cap@ramondin.com','(989) 555-6565','500 Capsule Park Way','','Novato','CA','98985',NULL,NULL,'2015-05-18 17:31:04.158689','2015-07-01 13:41:03.916816',NULL,'RMD');
INSERT INTO "firms" VALUES(17,'Vendor','Frye''s Printing','','Ron Frye','ron@fryesprinting.com','(123) 456-7890','100 Lincoln Ave.','','Napa','CA','94558',NULL,NULL,'2015-07-01 13:37:54.464793','2015-07-01 13:40:31.045972',NULL,'FRY');
INSERT INTO "firms" VALUES(18,'Vendor','Demptos','','Danny Demptos','d@d.com','(123) 123-1234','Demptos Village','','Vallejo','CA','95955',NULL,NULL,'2015-07-05 22:57:23.205819','2015-07-05 22:57:23.205819',NULL,'DPT');
CREATE TABLE "attachments" ("id" SERIAL PRIMARY KEY NOT NULL, "asset" varchar, "parent_id" integer, "parent_type" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "title" varchar DEFAULT '', "description" text DEFAULT '');
CREATE TABLE "comments" ("id" SERIAL PRIMARY KEY NOT NULL, "project_id" integer, "author_id" integer, "body" text DEFAULT '' NOT NULL, "actionable" boolean DEFAULT 'f' NOT NULL, "resolved" boolean DEFAULT 'f' NOT NULL, "resolver_id" integer, "resolved_at" timestamp, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
INSERT INTO "comments" VALUES(128,2,2,'This comment has *a lot* of _style_.','t','f',2,'2015-06-29 23:56:09.277319','2015-06-29 17:25:55.208174','2015-06-29 23:56:12.623883');
INSERT INTO "comments" VALUES(129,2,2,'**bold** wines! And now with more flavor! woo whoo! asdasdsadasda','t','t',2,'2015-06-29 23:56:07.910944','2015-06-29 19:54:58.120290','2015-06-29 23:56:07.911395');
INSERT INTO "comments" VALUES(130,3,5,'Let''s not forget to make it good!','t','t',5,'2015-06-30 04:01:53.204297','2015-06-30 04:01:00.135341','2015-06-30 04:01:53.204716');
INSERT INTO "comments" VALUES(131,2,2,'need new COLA *itlic*','t','f',2,'2015-07-01 18:06:41.225159','2015-07-01 18:05:49.359522','2015-07-01 18:06:51.206303');
INSERT INTO "comments" VALUES(132,7,2,'this is a comment
','f','f',NULL,NULL,'2015-07-14 22:34:23.191943','2015-07-14 22:34:23.191943');
CREATE TABLE "wines" ("id" SERIAL PRIMARY KEY NOT NULL, "appellation" varchar, "variety" varchar, "vintage" varchar, "alc" varchar, "sample_number" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "treatments" text, "description" text, "vinx2_reference" varchar);
INSERT INTO "wines" VALUES(1,'California','Chardonnay','2013','13.8','5050','2015-06-14 18:31:36.695991','2015-06-29 17:05:42.623994','* 0.2% MegaPurple
* 0.25 g/L K2CO3','Oaky with ripe fruit and moderate tannins.',NULL);
INSERT INTO "wines" VALUES(2,'Sonoma Valley','Merlot','2014','14.6','5088','2015-07-01 05:00:37.463487','2015-07-01 22:04:11.683051','**Maintain 40ppm FSO2** - Brett +

* 2 g/L Merlot Concentrate
* 25 ppm Autolees','','14MESVGB');
INSERT INTO "wines" VALUES(3,'Napa Carneros','Pinot Noir','2014','14.2','5070','2015-07-01 13:56:36.173083','2015-07-01 14:09:14.817722','* 0.2% Pinot Noir Concentrate','','14PNNCGRACE15-50');
CREATE TABLE "components" ("id" SERIAL PRIMARY KEY NOT NULL, "wine_id" integer, "lot_number" varchar, "volume" integer, "description" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "cogs" float, "appellation_percent" float DEFAULT 100.0, "vintage_percent" float DEFAULT 100.0, "variety_percent" float DEFAULT 100.0);
INSERT INTO "components" VALUES(48,2,'14CSNVA',1000,'','2015-07-02 21:20:24.093301','2015-07-02 21:20:24.093301',12.0,100.0,100.0,100.0);
INSERT INTO "components" VALUES(49,2,'13MESCA',1000,'','2015-07-02 21:20:57.010933','2015-07-02 21:20:57.010933',8.0,0.0,0.0,0.0);
INSERT INTO "components" VALUES(50,2,'12CSNVA',2550,'','2015-07-02 21:22:41.261615','2015-07-02 21:22:41.261615',10.11,100.0,0.0,100.0);
CREATE TABLE "wine_shipments" ("id" SERIAL PRIMARY KEY NOT NULL, "customer_id" integer, "wine_id" integer, "tracking_number" varchar, "ship_date" timestamp, "feedback" varchar, "carrier" varchar, "approved" boolean DEFAULT 'f' NOT NULL, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
INSERT INTO "wine_shipments" VALUES(4,11,2,'1Z879E930346834440','2015-07-03 07:00:00.000000',NULL,NULL,'f','2015-07-03 17:09:19.540882','2015-07-03 17:09:19.540882');
CREATE TABLE "component_requirements" ("id" SERIAL PRIMARY KEY NOT NULL, "project_id" integer, "packageable_id" integer, "packageable_type" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
INSERT INTO "component_requirements" VALUES(133,6,3,'FrontLabel','2015-07-15 05:01:43.542066','2015-07-15 05:01:43.542066');
INSERT INTO "component_requirements" VALUES(134,6,4,'BackLabel','2015-07-15 05:01:47.409140','2015-07-15 05:01:47.409140');
INSERT INTO "component_requirements" VALUES(135,6,14,'Bottle','2015-07-15 05:02:02.260900','2015-07-15 05:02:02.260900');
INSERT INTO "component_requirements" VALUES(136,6,3,'Closure','2015-07-15 05:02:06.735696','2015-07-15 05:02:06.735696');
INSERT INTO "component_requirements" VALUES(137,2,3,'FrontLabel','2015-07-15 05:02:21.042083','2015-07-15 05:02:21.042083');
INSERT INTO "component_requirements" VALUES(138,2,4,'BackLabel','2015-07-15 05:02:23.192549','2015-07-15 05:02:23.192549');
INSERT INTO "component_requirements" VALUES(139,2,14,'Bottle','2015-07-15 13:24:53.001500','2015-07-15 13:24:53.001500');
INSERT INTO "component_requirements" VALUES(140,2,4,'Closure','2015-07-15 13:48:35.500221','2015-07-15 13:48:42.527220');
INSERT INTO "component_requirements" VALUES(141,4,3,'FrontLabel','2015-07-16 04:07:34.792003','2015-07-16 04:07:34.792003');
INSERT INTO "component_requirements" VALUES(142,4,4,'BackLabel','2015-07-16 04:08:09.126667','2015-07-16 04:08:09.126667');
INSERT INTO "component_requirements" VALUES(143,4,14,'Bottle','2015-07-16 04:10:40.159158','2015-07-16 04:10:40.159158');
INSERT INTO "component_requirements" VALUES(144,4,3,'Closure','2015-07-16 04:11:18.120282','2015-07-16 04:11:18.120282');
INSERT INTO "component_requirements" VALUES(145,4,5,'Capsule','2015-07-16 04:11:41.220153','2015-07-16 04:11:41.220153');
INSERT INTO "component_requirements" VALUES(146,3,3,'FrontLabel','2015-07-16 04:14:46.600027','2015-07-16 04:14:46.600027');
INSERT INTO "component_requirements" VALUES(147,3,4,'BackLabel','2015-07-16 04:16:25.027786','2015-07-16 04:16:25.027786');
INSERT INTO "component_requirements" VALUES(148,3,14,'Bottle','2015-07-16 04:17:42.931334','2015-07-16 04:17:42.931334');
INSERT INTO "component_requirements" VALUES(149,3,3,'Closure','2015-07-16 04:19:02.401033','2015-07-16 04:19:02.401033');
INSERT INTO "component_requirements" VALUES(150,3,5,'Capsule','2015-07-16 04:19:04.777162','2015-07-16 04:19:04.777162');
INSERT INTO "component_requirements" VALUES(151,7,3,'FrontLabel','2015-07-16 15:52:07.165100','2015-07-16 15:52:07.165100');
INSERT INTO "component_requirements" VALUES(152,7,4,'BackLabel','2015-07-16 15:52:13.101831','2015-07-16 15:52:13.101831');
INSERT INTO "component_requirements" VALUES(153,7,14,'Bottle','2015-07-16 16:05:17.511031','2015-07-16 16:05:17.511031');
INSERT INTO "component_requirements" VALUES(154,7,3,'Closure','2015-07-16 16:06:22.140056','2015-07-16 16:06:22.140056');
INSERT INTO "component_requirements" VALUES(155,7,5,'Capsule','2015-07-16 16:06:29.294266','2015-07-16 16:06:29.294266');
INSERT INTO "component_requirements" VALUES(156,2,5,'Capsule','2015-07-16 16:07:30.155407','2015-07-16 16:07:30.155407');
INSERT INTO "component_requirements" VALUES(157,6,5,'Capsule','2015-07-16 18:03:38.588023','2015-07-16 18:03:38.588023');
CREATE TABLE "vendor_products" ("id" SERIAL PRIMARY KEY NOT NULL, "vendable_id" integer, "vendable_type" varchar, "vendor_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
INSERT INTO "vendor_products" VALUES(1,14,'Bottle',12,'2015-07-09 23:59:19.208207','2015-07-09 23:59:19.208207');
INSERT INTO "vendor_products" VALUES(5,5,'Capsule',16,'2015-07-10 21:42:17.138110','2015-07-10 21:42:17.138110');
INSERT INTO "vendor_products" VALUES(6,3,'Closure',13,'2015-07-10 22:49:07.216565','2015-07-10 22:49:07.216565');
INSERT INTO "vendor_products" VALUES(7,4,'Closure',14,'2015-07-10 23:05:22.688941','2015-07-10 23:05:22.688941');
INSERT INTO "vendor_products" VALUES(13,3,'FrontLabel',15,'2015-07-11 19:47:50.259913','2015-07-11 19:47:50.259913');
INSERT INTO "vendor_products" VALUES(16,4,'FrontLabel',15,'2015-07-11 20:13:21.555956','2015-07-11 20:13:21.555956');
INSERT INTO "vendor_products" VALUES(17,4,'BackLabel',15,'2015-07-11 20:17:10.816742','2015-07-11 20:17:10.816742');
CREATE TABLE "bottles" ("id" SERIAL PRIMARY KEY NOT NULL, "item_number" varchar, "mould" varchar, "shape" varchar, "color" varchar, "height" varchar, "width" varchar, "neck_diameter" varchar, "units" varchar, "finish" varchar, "fill_point" varchar, "capacity" integer, "capacity_units" varchar, "bottles_per_case" varchar, "case_dimensions" varchar, "pallet_config" varchar, "case_weight" varchar, "image" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "active" boolean DEFAULT 't');
INSERT INTO "bottles" VALUES(14,'2103ENCCLAGCF750','2103','Burgundy','Antique Green','301','72.7','28.9','mm','Cork','54.2',750,'mL','12','12 1/4 x 9 5/16 x 12 1/6','14x4=56','33.51','v1436478181/kdtfamscbtzzljarcdg3.pdf','2015-07-09 21:43:10.784257','2015-07-09 22:47:52.987812','t');
CREATE TABLE "capsules" ("id" SERIAL PRIMARY KEY NOT NULL, "item_number" varchar, "height" varchar, "width" varchar, "units" varchar, "material" varchar, "color" varchar, "has_artwork" boolean DEFAULT 'f' NOT NULL, "image" varchar, "artwork" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "active" boolean DEFAULT 't');
INSERT INTO "capsules" VALUES(5,'RMDTINCUSTOMREDJCK32X35','35','32','mm','Tin','Dark Red','f','v1436564529/hzmv8hzaidckjcxfdsxx.png','v1436564532/jaserizxvdfreefkf8ec.png','2015-07-10 21:42:17.132879','2015-07-10 21:42:17.132879','t');
CREATE TABLE "closures" ("id" SERIAL PRIMARY KEY NOT NULL, "type" varchar, "item_number" varchar, "material" varchar, "color" varchar, "height" varchar, "width" varchar, "units" varchar, "has_artwork" boolean DEFAULT 'f' NOT NULL, "artwork" varchar, "image" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "active" boolean DEFAULT 't');
INSERT INTO "closures" VALUES(3,'Cork','CSUNATB45X1A45X24','Natural','Natural','45','24','mm','f',NULL,'v1436568490/ydi6xovhvzlsqatb1olf.jpg','2015-07-10 22:49:07.200771','2015-07-10 22:49:07.200771','t');
INSERT INTO "closures" VALUES(4,'Screwcap','JANSARSCREWCAPBLK30','Saranex','Ugly Yellow','65','28','mm','f',NULL,'v1436569519/y3scmnklbzodmyob9mv4.jpg','2015-07-10 23:05:22.683374','2015-07-10 23:05:22.683374','t');
CREATE TABLE "front_labels" ("id" SERIAL PRIMARY KEY NOT NULL, "item_number" varchar, "height" varchar, "width" varchar, "units" varchar, "material" varchar, "alc" varchar, "upc" varchar, "rewind" varchar, "cut" varchar, "position" varchar, "treatment" varchar, "artwork_source" varchar, "image" varchar, "artwork" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "active" boolean DEFAULT 't');
INSERT INTO "front_labels" VALUES(3,'FF3212JH45x55','3.47','2.891','in','Killer White','14.5','','#4','Die','45','Matte',NULL,'v1436571942/gklkcybbv4tksmjbmbrq.png',NULL,'2015-07-10 23:51:14.468275','2015-07-11 20:04:35.209161','t');
CREATE TABLE "back_labels" ("id" SERIAL PRIMARY KEY NOT NULL, "vendor_id" integer, "item_number" varchar, "height" varchar, "width" varchar, "units" varchar, "material" varchar, "alc" varchar, "upc" varchar, "rewind" varchar, "cut" varchar, "position" varchar, "treatment" varchar, "artwork_source" varchar, "image" varchar, "artwork" varchar, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "active" boolean DEFAULT 't');
INSERT INTO "back_labels" VALUES(4,NULL,'BACK12345','4.125','3.125','in','Killer White','14.5','','#4','Die','55','Matte',NULL,NULL,NULL,'2015-07-11 03:54:41.940099','2015-07-11 04:08:11.391148','t');
CREATE TABLE "projects" ("id" SERIAL PRIMARY KEY NOT NULL, "wine_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "customer_id" integer, "qb_code" varchar, "project_number" varchar, "target_cases" integer, "brand" varchar DEFAULT '' NOT NULL, "description" varchar DEFAULT '' NOT NULL, "bottling_date" timestamp, "variety" varchar, "winemaker" varchar, "no_capsule" boolean DEFAULT 'f' NOT NULL, "vintage" varchar, "appellation" varchar, "closure_type" varchar, "trucker" varchar, "cases_to_customer" integer DEFAULT 0 NOT NULL, "comments_count" integer, "fob" float, "taxes" varchar, "fso2_target" varchar, "max_do" varchar, "notes" text DEFAULT '');
INSERT INTO "projects" VALUES(2,3,'2015-06-19 03:46:27.355301','2015-07-16 19:43:17.794673',11,'','15-50',200,'Gracenote','','2015-08-23 07:00:00.000000','Pinot Noir','Mike Tyson','t','2014','California','PackagingComponent','JPS',0,3,NULL,'','','','**One tasting sheet into each case**

* 2 cases off line to customer');
INSERT INTO "projects" VALUES(3,NULL,'2015-06-19 20:49:08.657493','2015-07-16 04:23:33.158467',11,'','15-15',2200,'Adele','','2015-09-06 07:00:00.000000','Cabernet Sauvignon','Barrett Marsalek','t','2010','Napa Valley','PackagingComponent',NULL,0,1,NULL,NULL,NULL,NULL,'');
INSERT INTO "projects" VALUES(4,NULL,'2015-07-01 00:02:15.608277','2015-07-16 04:23:33.160332',10,'','15-22',1200,'Johnson Family','','2015-07-31 07:00:00.000000','Merlot','','f','2014','Merlot',NULL,'Biagi',2,NULL,NULL,'','','','');
INSERT INTO "projects" VALUES(5,NULL,'2015-07-01 00:02:53.708741','2015-07-16 04:23:33.162088',10,'','15-42',336,'Mockingbird Hill','','2015-10-20 07:00:00.000000','Petite Verdot','','f','2013','Napa Valley',NULL,'JPS',0,NULL,NULL,NULL,'','','');
INSERT INTO "projects" VALUES(6,NULL,'2015-07-01 18:03:03.693103','2015-07-16 04:23:33.164191',11,'','15-45',1200,'Gracenote','','2015-08-06 07:00:00.000000','Chardonnay','','f','2014','Napa',NULL,'',0,NULL,NULL,'','','','');
INSERT INTO "projects" VALUES(7,1,'2015-07-12 20:34:22.534546','2015-07-16 04:23:38.827560',10,'','15-01',1200,'Stevedore','','2015-07-25 07:00:00.000000','Red Blend','','f','2013','Sonoma Coast',NULL,'Biagi',0,1,150.0,'','','','');
CREATE TABLE "purchase_orders" ("id" SERIAL PRIMARY KEY NOT NULL, "vendor_id" integer, "number" varchar DEFAULT '' NOT NULL, "po_image" varchar, "bol_image" varchar, "total" float, "receive_date" timestamp, "order_date" timestamp, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "line_items_count" integer, "overhead" float DEFAULT 0.0);
INSERT INTO "purchase_orders" VALUES(1,15,'12345',NULL,NULL,NULL,NULL,'0007-05-15 08:00:00.000000','2015-07-05 21:26:32.835473','2015-07-16 18:02:53.630009',3,500.5);
CREATE TABLE "packaging_component_orders" ("id" SERIAL PRIMARY KEY NOT NULL, "component_requirement_id" integer, "purchase_order_id" integer, "quantity" float DEFAULT 0.0, "price" float DEFAULT 0.0, "received" boolean DEFAULT 'f' NOT NULL);
INSERT INTO "packaging_component_orders" VALUES(4,134,1,1000.0,500.0,'f');
INSERT INTO "packaging_component_orders" VALUES(5,138,1,2000.0,30.0,'t');
INSERT INTO "packaging_component_orders" VALUES(6,137,1,2500.0,500.0,'t');
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE INDEX "index_friendly_id_slugs_on_sluggable_id" ON "friendly_id_slugs" ("sluggable_id");
CREATE INDEX "index_friendly_id_slugs_on_slug_and_sluggable_type" ON "friendly_id_slugs" ("slug", "sluggable_type");
CREATE UNIQUE INDEX "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope" ON "friendly_id_slugs" ("slug", "sluggable_type", "scope");
CREATE INDEX "index_friendly_id_slugs_on_sluggable_type" ON "friendly_id_slugs" ("sluggable_type");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "index_users_on_confirmation_token" ON "users" ("confirmation_token");
CREATE INDEX "index_attachments_on_parent_type_and_parent_id" ON "attachments" ("parent_type", "parent_id");
CREATE INDEX "index_comments_on_project_id" ON "comments" ("project_id");
CREATE INDEX "index_comments_on_author_id" ON "comments" ("author_id");
CREATE INDEX "index_comments_on_resolver_id" ON "comments" ("resolver_id");
CREATE INDEX "index_wines_on_variety" ON "wines" ("variety");
CREATE INDEX "index_wines_on_appellation" ON "wines" ("appellation");
CREATE UNIQUE INDEX "index_wines_on_sample_number" ON "wines" ("sample_number");
CREATE INDEX "index_components_on_lot_number" ON "components" ("lot_number");
CREATE INDEX "index_components_on_wine_id" ON "components" ("wine_id");
CREATE INDEX "index_wine_shipments_on_customer_id" ON "wine_shipments" ("customer_id");
CREATE INDEX "index_wine_shipments_on_wine_id" ON "wine_shipments" ("wine_id");
CREATE INDEX "index_wine_shipments_on_tracking_number" ON "wine_shipments" ("tracking_number");
CREATE INDEX "index_component_requirements_on_project_id" ON "component_requirements" ("project_id");
CREATE INDEX "index_component_requirements_on_packageable_id" ON "component_requirements" ("packageable_id");
CREATE INDEX "index_component_requirements_on_packageable_type" ON "component_requirements" ("packageable_type");
CREATE INDEX "index_vendor_products_on_vendable_id" ON "vendor_products" ("vendable_id");
CREATE INDEX "index_vendor_products_on_vendable_type" ON "vendor_products" ("vendable_type");
CREATE INDEX "index_vendor_products_on_vendor_id" ON "vendor_products" ("vendor_id");
CREATE INDEX "index_back_labels_on_vendor_id" ON "back_labels" ("vendor_id");
CREATE INDEX "index_projects_on_wine_id" ON "projects" ("wine_id");
CREATE INDEX "index_projects_on_customer_id" ON "projects" ("customer_id");
CREATE INDEX "index_projects_on_brand" ON "projects" ("brand");
CREATE UNIQUE INDEX "index_projects_on_project_number" ON "projects" ("project_number");
CREATE INDEX "index_purchase_orders_on_vendor_id" ON "purchase_orders" ("vendor_id");
CREATE INDEX "index_packaging_component_orders_on_purchase_order_id" ON "packaging_component_orders" ("purchase_order_id");
CREATE UNIQUE INDEX "index_packaging_component_orders_on_component_requirement_id" ON "packaging_component_orders" ("component_requirement_id");
COMMIT;
