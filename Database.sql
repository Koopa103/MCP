DROP TABLE IF EXISTS college;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS major;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS section;
DROP TABLE IF EXISTS student_section;
DROP TABLE IF EXISTS major_class;
DROP TABLE IF EXISTS and_prereq;
DROP TABLE IF EXISTS or_prereq;
DROP TABLE IF EXISTS coreq;
DROP TABLE IF EXISTS student_major;
DROP TABLE IF EXISTS concentration;


-- College table
CREATE TABLE college (id TEXT PRIMARY KEY,name TEXT);

-- Student table
CREATE TABLE student (id int, firstname text, lastname text);

-- Department table
CREATE TABLE department ( id TEXT NOT NULL, name TEXT NOT NULL, collegeID TEXT DEFAULT NULL, PRIMARY KEY (id), FOREIGN KEY (collegeID) REFERENCES college (id));

-- Course table
CREATE TABLE course ( id text, department text, title text, num int, hrs int, PRIMARY KEY(id), FOREIGN KEY (department) REFERENCES department(id) );

-- Major table
CREATE TABLE major ( id text, title text, deptID text, reqtext text, hrs int, gpa float, PRIMARY KEY(id), FOREIGN KEY (deptID) REFERENCES department(id) );

-- Teachers table
CREATE TABLE teachers ( id INT PRIMARY KEY, firstname TEXT, lastname TEXT, departmentID TEXT, adjunct INT, FOREIGN KEY (departmentID) REFERENCES department(id) );

-- Section table
CREATE TABLE section ( crn int, max int, room text, courseID text, term text, startdate date, enddate date, days text, PRIMARY KEY(crn), FOREIGN KEY (courseID) REFERENCES course(id) );

-- Student Section table
CREATE TABLE student_section ( studentID INTEGER, sectionID INTEGER, grade REAL, PRIMARY KEY (studentID, sectionID), FOREIGN KEY (sectionID) REFERENCES section(crn), FOREIGN KEY (studentID) REFERENCES student(id) );

-- Major Class table
CREATE TABLE major_class ( majorID int, classID int, FOREIGN KEY(majorID) REFERENCES major(id), FOREIGN KEY(classID) REFERENCES course(id) );

-- And Prereq table
CREATE TABLE and_prereq ( course TEXT, prereq TEXT, FOREIGN KEY (course) REFERENCES course(id), FOREIGN KEY (prereq) REFERENCES courses(id) );

-- Or Prereq table
CREATE TABLE or_prereq ( course TEXT, prereq TEXT, FOREIGN KEY (course) REFERENCES course(id), FOREIGN KEY (prereq) REFERENCES courses(id) );

-- Coreq table
CREATE TABLE coreq ( course TEXT, prereq TEXT, FOREIGN KEY (course) REFERENCES course(id), FOREIGN KEY (prereq) REFERENCES courses(id) );

-- Student Major table
CREATE TABLE student_major ( studentID INTEGER, major TEXT, PRIMARY KEY (studentID, major), FOREIGN KEY (major) REFERENCES major(id), FOREIGN KEY (studentID) REFERENCES student(id) );

-- Concentration table
CREATE TABLE concentration ( id text PRIMARY KEY, major text, title text, reqtext text, FOREIGN KEY(major) REFERENCES major(id) );



INSERT INTO college (id, name) VALUES
('COAHS', 'College of Arts, Humanities and Social Sciences'),
('COSAE', 'College of Science and Engineering'),
('COBS', 'College of Biblical Studies'),
('COBA', 'College of Business Administration'),
('COHABS', 'College of Health and Behavioral Sciences'),
('COHAHS', 'College of Health and Human Services'),
('COLAPS', 'College of Leadership and Professional Studies'),
('CON', 'College of Nursing'),
('COH', 'College of Honors'),
('COLAD', 'College of Learning and Development');
-- select *from college;


insert into student(id, firstname, lastname) values (1,'Stu1','Student1');
insert into student(id, firstname, lastname) values (2,'Stu2','Student2');
insert into student(id, firstname, lastname) values (3,'Stu3','Student3');
insert into student(id, firstname, lastname) values (4,'Stu4','Student4');
insert into student(id, firstname, lastname) values (5,'Stu5','Student5');
insert into student(id, firstname, lastname) values (6,'Stu6','Student6');
insert into student(id, firstname, lastname) values (7,'Stu7','Student7');
insert into student(id, firstname, lastname) values (8,'Stu8','Student8');
insert into student(id, firstname, lastname) values (9,'Stu9','Student9');
insert into student(id, firstname, lastname) values (10,'Stu10','Student10');
insert into student(id, firstname, lastname) values (11,'Stu11','Student11');
insert into student(id, firstname, lastname) values (12,'Stu12','Student12');
insert into student(id, firstname, lastname) values (13,'Stu13','Student13');
insert into student(id, firstname, lastname) values (14,'Stu14','Student14');
insert into student(id, firstname, lastname) values (15,'Stu15','Student15');
insert into student(id, firstname, lastname) values (16,'Stu16','Student16');
insert into student(id, firstname, lastname) values (17,'Stu17','Student17');
insert into student(id, firstname, lastname) values (18,'Stu18','Student18');
insert into student(id, firstname, lastname) values (19,'Stu19','Student19');
insert into student(id, firstname, lastname) values (20,'Stu20','Student20');
insert into student(id, firstname, lastname) values (21,'Stu21','Student21');
insert into student(id, firstname, lastname) values (22,'Stu22','Student22');
insert into student(id, firstname, lastname) values (23,'Stu23','Student23');
insert into student(id, firstname, lastname) values (24,'Stu24','Student24');
insert into student(id, firstname, lastname) values (25,'Stu25','Student25');
insert into student(id, firstname, lastname) values (26,'Stu26','Student26');
insert into student(id, firstname, lastname) values (27,'Stu27','Student27');
insert into student(id, firstname, lastname) values (28,'Stu28','Student28');
insert into student(id, firstname, lastname) values (29,'Stu29','Student29');
insert into student(id, firstname, lastname) values (30,'Stu30','Student30');
insert into student(id, firstname, lastname) values (31,'Stu31','Student31');
insert into student(id, firstname, lastname) values (32,'Stu32','Student32');
insert into student(id, firstname, lastname) values (33,'Stu33','Student33');
insert into student(id, firstname, lastname) values (34,'Stu34','Student34');
insert into student(id, firstname, lastname) values (35,'Stu35','Student35');
insert into student(id, firstname, lastname) values (36,'Stu36','Student36');
insert into student(id, firstname, lastname) values (37,'Stu37','Student37');
insert into student(id, firstname, lastname) values (38,'Stu38','Student38');
insert into student(id, firstname, lastname) values (39,'Stu39','Student39');
insert into student(id, firstname, lastname) values (40,'Stu40','Student40');
insert into student(id, firstname, lastname) values (41,'Stu41','Student41');
insert into student(id, firstname, lastname) values (42,'Stu42','Student42');
insert into student(id, firstname, lastname) values (43,'Stu43','Student43');
insert into student(id, firstname, lastname) values (44,'Stu44','Student44');
insert into student(id, firstname, lastname) values (45,'Stu45','Student45');
insert into student(id, firstname, lastname) values (46,'Stu46','Student46');
insert into student(id, firstname, lastname) values (47,'Stu47','Student47');
insert into student(id, firstname, lastname) values (48,'Stu48','Student48');
insert into student(id, firstname, lastname) values (49,'Stu49','Student49');
insert into student(id, firstname, lastname) values (50,'Stu50','Student50');
insert into student(id, firstname, lastname) values (51,'Stu51','Student51');
insert into student(id, firstname, lastname) values (52,'Stu52','Student52');
insert into student(id, firstname, lastname) values (53,'Stu53','Student53');
insert into student(id, firstname, lastname) values (54,'Stu54','Student54');
insert into student(id, firstname, lastname) values (55,'Stu55','Student55');
insert into student(id, firstname, lastname) values (56,'Stu56','Student56');
insert into student(id, firstname, lastname) values (57,'Stu57','Student57');
insert into student(id, firstname, lastname) values (58,'Stu58','Student58');
insert into student(id, firstname, lastname) values (59,'Stu59','Student59');
insert into student(id, firstname, lastname) values (60,'Stu60','Student60');
insert into student(id, firstname, lastname) values (61,'Stu61','Student61');
insert into student(id, firstname, lastname) values (62,'Stu62','Student62');
insert into student(id, firstname, lastname) values (63,'Stu63','Student63');
insert into student(id, firstname, lastname) values (64,'Stu64','Student64');
insert into student(id, firstname, lastname) values (65,'Stu65','Student65');
insert into student(id, firstname, lastname) values (66,'Stu66','Student66');
insert into student(id, firstname, lastname) values (67,'Stu67','Student67');
insert into student(id, firstname, lastname) values (68,'Stu68','Student68');
insert into student(id, firstname, lastname) values (69,'Stu69','Student69');
insert into student(id, firstname, lastname) values (70,'Stu70','Student70');
insert into student(id, firstname, lastname) values (71,'Stu71','Student71');
insert into student(id, firstname, lastname) values (72,'Stu72','Student72');
insert into student(id, firstname, lastname) values (73,'Stu73','Student73');
insert into student(id, firstname, lastname) values (74,'Stu74','Student74');
insert into student(id, firstname, lastname) values (75,'Stu75','Student75');
insert into student(id, firstname, lastname) values (76,'Stu76','Student76');
insert into student(id, firstname, lastname) values (77,'Stu77','Student77');
insert into student(id, firstname, lastname) values (78,'Stu78','Student78');
insert into student(id, firstname, lastname) values (79,'Stu79','Student79');
insert into student(id, firstname, lastname) values (80,'Stu80','Student80');
insert into student(id, firstname, lastname) values (81,'Stu81','Student81');
insert into student(id, firstname, lastname) values (82,'Stu82','Student82');
insert into student(id, firstname, lastname) values (83,'Stu83','Student83');
insert into student(id, firstname, lastname) values (84,'Stu84','Student84');
insert into student(id, firstname, lastname) values (85,'Stu85','Student85');
insert into student(id, firstname, lastname) values (86,'Stu86','Student86');
insert into student(id, firstname, lastname) values (87,'Stu87','Student87');
insert into student(id, firstname, lastname) values (88,'Stu88','Student88');
insert into student(id, firstname, lastname) values (89,'Stu89','Student89');
insert into student(id, firstname, lastname) values (90,'Stu90','Student90');
insert into student(id, firstname, lastname) values (91,'Stu91','Student91');
insert into student(id, firstname, lastname) values (92,'Stu92','Student92');
insert into student(id, firstname, lastname) values (93,'Stu93','Student93');
insert into student(id, firstname, lastname) values (94,'Stu94','Student94');
insert into student(id, firstname, lastname) values (95,'Stu95','Student95');
insert into student(id, firstname, lastname) values (96,'Stu96','Student96');
insert into student(id, firstname, lastname) values (97,'Stu97','Student97');
insert into student(id, firstname, lastname) values (98,'Stu98','Student98');
insert into student(id, firstname, lastname) values (99,'Stu99','Student99');
insert into student(id, firstname, lastname) values (100,'Stu100','Student100');
insert into student(id, firstname, lastname) values (101,'Stu101','Student101');
insert into student(id, firstname, lastname) values (102,'Stu102','Student102');
insert into student(id, firstname, lastname) values (103,'Stu103','Student103');
insert into student(id, firstname, lastname) values (104,'Stu104','Student104');
insert into student(id, firstname, lastname) values (105,'Stu105','Student105');
insert into student(id, firstname, lastname) values (106,'Stu106','Student106');
insert into student(id, firstname, lastname) values (107,'Stu107','Student107');
insert into student(id, firstname, lastname) values (108,'Stu108','Student108');
insert into student(id, firstname, lastname) values (109,'Stu109','Student109');
insert into student(id, firstname, lastname) values (110,'Stu110','Student110');
insert into student(id, firstname, lastname) values (111,'Stu111','Student111');
insert into student(id, firstname, lastname) values (112,'Stu112','Student112');
insert into student(id, firstname, lastname) values (113,'Stu113','Student113');
insert into student(id, firstname, lastname) values (114,'Stu114','Student114');
insert into student(id, firstname, lastname) values (115,'Stu115','Student115');
insert into student(id, firstname, lastname) values (116,'Stu116','Student116');
insert into student(id, firstname, lastname) values (117,'Stu117','Student117');
insert into student(id, firstname, lastname) values (118,'Stu118','Student118');
insert into student(id, firstname, lastname) values (119,'Stu119','Student119');
insert into student(id, firstname, lastname) values (120,'Stu120','Student120');
insert into student(id, firstname, lastname) values (121,'Stu121','Student121');
insert into student(id, firstname, lastname) values (122,'Stu122','Student122');
insert into student(id, firstname, lastname) values (123,'Stu123','Student123');
insert into student(id, firstname, lastname) values (124,'Stu124','Student124');
insert into student(id, firstname, lastname) values (125,'Stu125','Student125');
insert into student(id, firstname, lastname) values (126,'Stu126','Student126');
insert into student(id, firstname, lastname) values (127,'Stu127','Student127');
insert into student(id, firstname, lastname) values (128,'Stu128','Student128');
insert into student(id, firstname, lastname) values (129,'Stu129','Student129');
insert into student(id, firstname, lastname) values (130,'Stu130','Student130');
insert into student(id, firstname, lastname) values (131,'Stu131','Student131');
insert into student(id, firstname, lastname) values (132,'Stu132','Student132');
insert into student(id, firstname, lastname) values (133,'Stu133','Student133');
insert into student(id, firstname, lastname) values (134,'Stu134','Student134');
insert into student(id, firstname, lastname) values (135,'Stu135','Student135');
insert into student(id, firstname, lastname) values (136,'Stu136','Student136');
insert into student(id, firstname, lastname) values (137,'Stu137','Student137');
insert into student(id, firstname, lastname) values (138,'Stu138','Student138');
insert into student(id, firstname, lastname) values (139,'Stu139','Student139');
insert into student(id, firstname, lastname) values (140,'Stu140','Student140');
insert into student(id, firstname, lastname) values (141,'Stu141','Student141');
insert into student(id, firstname, lastname) values (142,'Stu142','Student142');
insert into student(id, firstname, lastname) values (143,'Stu143','Student143');
insert into student(id, firstname, lastname) values (144,'Stu144','Student144');
insert into student(id, firstname, lastname) values (145,'Stu145','Student145');
insert into student(id, firstname, lastname) values (146,'Stu146','Student146');
insert into student(id, firstname, lastname) values (147,'Stu147','Student147');
insert into student(id, firstname, lastname) values (148,'Stu148','Student148');
insert into student(id, firstname, lastname) values (149,'Stu149','Student149');
insert into student(id, firstname, lastname) values (150,'Stu150','Student150');
-- select *from student;

INSERT INTO department (id, name, collegeID) VALUES ('AES', 'Agricultural and Environmental Sciences', 'COSAE');
INSERT INTO department (id, name, collegeID) VALUES ('ART', 'Art and Design', 'COAHS');
INSERT INTO department (id, name, collegeID) VALUES ('BIO', 'Biology', 'COSAE');
INSERT INTO department (id, name, collegeID) VALUES ('CHEM', 'Chemistry and Biochemistry', 'COSAE');
INSERT INTO department (id, name, collegeID) VALUES ('COMS', 'Communication and Sociology', 'COAHS');
INSERT INTO department (id, name, collegeID) VALUES ('ENGP', 'Engineering and Physics', 'COSAE');
INSERT INTO department (id, name, collegeID) VALUES ('HGS', 'History and Global Studies', 'COAHS');
INSERT INTO department (id, name, collegeID) VALUES ('JMC', 'Journalism and Mass Communication', 'COAHS');
INSERT INTO department (id, name, collegeID) VALUES ('LL', 'Language and Literature', 'COAHS');
INSERT INTO department (id, name, collegeID) VALUES ('LA', 'Liberal Arts', 'COAHS');
INSERT INTO department (id, name, collegeID) VALUES ('MATH', 'Mathematics', 'COSAE');
INSERT INTO department (id, name, collegeID) VALUES ('MUS', 'Music', 'COAHS');
INSERT INTO department (id, name, collegeID) VALUES ('PSCJ', 'Political Science and Criminal Justice', 'COAHS');
INSERT INTO department (id, name, collegeID) VALUES ('PSY', 'Psychology', 'COHABS');
INSERT INTO department (id, name, collegeID) VALUES ('THEA', 'Theatre', 'COAHS');
INSERT INTO department (id, name, collegeID) VALUES ('BMM', 'Bible, Missions and Ministry', 'COBS');
INSERT INTO department (id, name, collegeID) VALUES ('MFS', 'Marriage and Family Studies', 'COBS');
INSERT INTO department (id, name, collegeID) VALUES ('GST', 'Graduate School of Theology', 'COBS');
INSERT INTO department (id, name, collegeID) VALUES ('ACF', 'Accounting and Finance', 'COBA');
INSERT INTO department (id, name, collegeID) VALUES ('MGS', 'Management Sciences', 'COBA');
INSERT INTO department (id, name, collegeID) VALUES ('SITC', 'School of Information Technology and Computing', 'COBA');
INSERT INTO department (id, name, collegeID) VALUES ('CSD', 'Communication Sciences and Disorders', 'COHABS');
INSERT INTO department (id, name, collegeID) VALUES ('KIN', 'Kinesiology and Nutrition', 'COHABS');
INSERT INTO department (id, name, collegeID) VALUES ('OT', 'Occupational Therapy', 'COHABS');
INSERT INTO department (id, name, collegeID) VALUES ('SSW', 'School of Social Work', 'COHABS');
INSERT INTO department (id, name, collegeID) VALUES ('TED', 'Teacher Education', 'COHAHS');
INSERT INTO department (id, name, collegeID) VALUES ('SEL', 'School of Educational Leadership', 'COLAPS');
INSERT INTO department (id, name, collegeID) VALUES ('SHHS', 'School of Health and Human Services', 'COHAHS');
INSERT INTO department (id, name, collegeID) VALUES ('SPS', 'School of Professional Studies', 'COLAPS');
INSERT INTO department (id, name, collegeID) VALUES ('NUR', 'School of Nursing', 'CON');
INSERT INTO department (id, name, collegeID) VALUES ('IDM', 'Interdisciplinary Degrees and Majors', 'IDK');
INSERT INTO department (id, name, collegeID) VALUES ('HON', 'Honors College', 'COH');


insert into course (id, department, title, num, hrs) values ('ACCT210','ACCT','Financial Accounting', 210,3);
insert into course (id, department, title, num, hrs) values ('ACCT302','ACCT','Cost Accounting 1', 302,3);
insert into course (id, department, title, num, hrs) values ('ACCT304','ACCT','Income Tax 1', 304,3);
insert into course (id, department, title, num, hrs) values ('ACCT310','ACCT','Intermediate Accounting 1', 310,3);
insert into course (id, department, title, num, hrs) values ('ACCT311','ACCT','Intermediate Accounting 2', 311,3);
insert into course (id, department, title, num, hrs) values ('ACCT324','ACCT','Accounting Information Systems', 324,3);
insert into course (id, department, title, num, hrs) values ('ACCT405','ACCT','Fundamentals of Auditing', 405,3);
insert into course (id, department, title, num, hrs) values ('ACCT410','ACCT','Advanced Accounting 1', 410,3);
insert into course (id, department, title, num, hrs) values ('ACCT499','ACCT','Accounting Internship', 499,3);
insert into course (id, department, title, num, hrs) values ('ART105','ART','Two-Dimensional Design', 105,3);
insert into course (id, department, title, num, hrs) values ('ART106','ART','Three-Dimensional Design', 106,3);
insert into course (id, department, title, num, hrs) values ('ART111','ART','Basic Drawing', 111,3);
insert into course (id, department, title, num, hrs) values ('ART112','ART','Figure Drawing I', 112,3);
insert into course (id, department, title, num, hrs) values ('ART222','ART','Art History: General Survey II', 222,3);
insert into course (id, department, title, num, hrs) values ('ART317','ART','Introduction to Illustration', 317,3);
insert into course (id, department, title, num, hrs) values ('ART318','ART','Digital Illustration', 318,3);
insert into course (id, department, title, num, hrs) values ('ART351','ART','Typography I', 351,3);
insert into course (id, department, title, num, hrs) values ('BGRK221','BGRK','New Testament Greek for Beginners I', 221,3);
insert into course (id, department, title, num, hrs) values ('BGRK222','BGRK','New Testament Greek for Beginners II', 222,3);
insert into course (id, department, title, num, hrs) values ('BGRK331','BGRK','Elementary Greek Readings I', 331,3);
insert into course (id, department, title, num, hrs) values ('BGRK332','BGRK','Elementary Greek Readings II', 332,3);
insert into course (id, department, title, num, hrs) values ('BGRK441','BGRK','Exegetical Greek Seminar I', 441,3);
insert into course (id, department, title, num, hrs) values ('BGRK442','BGRK','Exegetical Greek Seminar II', 442,3);
insert into course (id, department, title, num, hrs) values ('BHEB472','BHEB','Introduction to Hebrew II', 472,3);
insert into course (id, department, title, num, hrs) values ('BIBH383','BIBH','Restoration History', 383,3);
insert into course (id, department, title, num, hrs) values ('BIBL320','BIBL','Introduction to Biblical Interpretation', 320,3);
insert into course (id, department, title, num, hrs) values ('BIBL365','BIBL','General Epistles', 365,3);
insert into course (id, department, title, num, hrs) values ('BIBL367','BIBL','The Book of Acts', 367,3);
insert into course (id, department, title, num, hrs) values ('BIBL451','BIBL','The Pentateuch', 451,3);
insert into course (id, department, title, num, hrs) values ('BIBL452','BIBL','Historical Books of the Old Testament', 452,3);
insert into course (id, department, title, num, hrs) values ('BIBL453','BIBL','The Devotional and Wisdom Literature of the Old Testament', 453,3);
insert into course (id, department, title, num, hrs) values ('BIBL454','BIBL','The Prophetic Literature of the Old Testament', 454,3);
insert into course (id, department, title, num, hrs) values ('BIBL458','BIBL','The Synoptic Gospels', 458,3);
insert into course (id, department, title, num, hrs) values ('BIBL460','BIBL','Galatians and Romans', 460,3);
insert into course (id, department, title, num, hrs) values ('BIBL461','BIBL','The Corinthian Letters', 461,3);
insert into course (id, department, title, num, hrs) values ('BIBL466','BIBL','Book of Revelation', 466,3);
insert into course (id, department, title, num, hrs) values ('BIBM391','BIBM','Ministry in Context', 391,3);
insert into course (id, department, title, num, hrs) values ('BIBM429','BIBM','Field Education', 429,2);
insert into course (id, department, title, num, hrs) values ('BIBM491','BIBM','Senior Capstone Experience', 491,1);
insert into course (id, department, title, num, hrs) values ('BIBM493','BIBM','Preaching', 493,3);
insert into course (id, department, title, num, hrs) values ('BIBP380','BIBP','Introduction to Philosophy', 380,3);
insert into course (id, department, title, num, hrs) values ('BIBP478','BIBP','Philosophy of Religion', 478,3);
insert into course (id, department, title, num, hrs) values ('BIBP486','BIBP','Ethics', 486,3);
insert into course (id, department, title, num, hrs) values ('BIBP487','BIBP','History of Ancient and Medieval Philosophy', 487,3);
insert into course (id, department, title, num, hrs) values ('BIBP489','BIBP','History of Modern Philosophy', 489,3);
insert into course (id, department, title, num, hrs) values ('BIBT332','BIBT','Religious Teachings of C.S. Lewis', 332,3);
insert into course (id, department, title, num, hrs) values ('BIBT342','BIBT','Christianity in Culture', 342,3);
insert into course (id, department, title, num, hrs) values ('BIBT370','BIBT','the church', 370,3);
insert into course (id, department, title, num, hrs) values ('BIBT379','BIBT','The Church', 379,3);
insert into course (id, department, title, num, hrs) values ('BIBT401','BIBT','christian leadership', 401,3);
insert into course (id, department, title, num, hrs) values ('BIBT403','BIBT','christian worship', 403,3);
insert into course (id, department, title, num, hrs) values ('BIBT439','BIBT','Teaching and Learning for Spiritual Formation', 439,3);
insert into course (id, department, title, num, hrs) values ('BIBT480','BIBT','arts and culture: a christian aesthetic', 480,3);
insert into course (id, department, title, num, hrs) values ('BIBT491','BIBT','Theology', 491,3);
insert into course (id, department, title, num, hrs) values ('BIOL101','BIOL','Biology - Human Perspective', 101,3);
insert into course (id, department, title, num, hrs) values ('BIOL121','BIOL','Introductory Biology I', 121,3);
insert into course (id, department, title, num, hrs) values ('BIOL122','BIOL','Introductory Biology I Laboratory', 122,1);
insert into course (id, department, title, num, hrs) values ('BIOL123','BIOL','Introductory Biology II', 123,3);
insert into course (id, department, title, num, hrs) values ('BIOL124','BIOL','Introductory Biology II Laboratory', 124,1);
insert into course (id, department, title, num, hrs) values ('BIOL312','BIOL','Cell Biology', 312,3);
insert into course (id, department, title, num, hrs) values ('BLAW363','BLAW','Introduction to Business Law and Ethics', 363,3);
insert into course (id, department, title, num, hrs) values ('BLAW365','BLAW','Law and Entrepreneurship', 365,3);
insert into course (id, department, title, num, hrs) values ('BLAW461','BLAW','Business Law II', 461,3);
insert into course (id, department, title, num, hrs) values ('BMIS270','BMIS','Living the Mission', 270,3);
insert into course (id, department, title, num, hrs) values ('BMIS345','BMIS','Understanding Culture for Global Service', 345,3);
insert into course (id, department, title, num, hrs) values ('BMIS371','BMIS','Religion in Global Contexts', 371,3);
insert into course (id, department, title, num, hrs) values ('BMIS420','BMIS','Gospel in a Multicultural World', 420,3);
insert into course (id, department, title, num, hrs) values ('BMIS421','BMIS','Mission as Spiritual Formation', 421,3);
insert into course (id, department, title, num, hrs) values ('BUBH380','BUBH','Survey of Church History', 380,3);
insert into course (id, department, title, num, hrs) values ('BUSA120','BUSA','Introduction to Business', 120,3);
insert into course (id, department, title, num, hrs) values ('BUSA419','BUSA','International Business', 419,3);
insert into course (id, department, title, num, hrs) values ('BUSA435','BUSA','Christian Business Leadership Perspectives', 435,3);
insert into course (id, department, title, num, hrs) values ('CHEM114','CHEM','Introductory Organic and Biological Chemistry', 114,3);
insert into course (id, department, title, num, hrs) values ('CHEM131','CHEM','General Chemistry Laboratory I', 131,1);
insert into course (id, department, title, num, hrs) values ('CHEM132','CHEM','General Chemistry Laboratory II', 132,1);
insert into course (id, department, title, num, hrs) values ('CHEM133','CHEM','General Chemistry I', 133,3);
insert into course (id, department, title, num, hrs) values ('CHEM134','CHEM','General Chemistry II', 134,3);
insert into course (id, department, title, num, hrs) values ('CHEM221','CHEM','Organic Chemistry Laboratory I', 221,1);
insert into course (id, department, title, num, hrs) values ('CHEM223','CHEM','Organic Chemistry I', 223,3);
insert into course (id, department, title, num, hrs) values ('CHEM322','CHEM','Organic Chemistry Laboratory II', 322,1);
insert into course (id, department, title, num, hrs) values ('CHEM324','CHEM','Organic Chemistry II', 324,3);
insert into course (id, department, title, num, hrs) values ('CHEM333','CHEM','Physical Chemistry I', 333,4);
insert into course (id, department, title, num, hrs) values ('CHEM334','CHEM','Physical Chemistry II', 334,4);
insert into course (id, department, title, num, hrs) values ('CHEM335','CHEM','Analytical Chemistry I', 335,4);
insert into course (id, department, title, num, hrs) values ('CHEM356','CHEM','Analytical Chemistry II', 356,4);
insert into course (id, department, title, num, hrs) values ('CHEM423','CHEM','Chemistry and Biochemistry Seminar', 423,3);
insert into course (id, department, title, num, hrs) values ('CHEM443','CHEM','Inorganic Chemistry', 443,3);
insert into course (id, department, title, num, hrs) values ('CHEM453','CHEM','Biochemistry I: Foundations of Biochemistry', 453,3);
insert into course (id, department, title, num, hrs) values ('CHEM454','CHEM','Biochemistry II: Gene Expression', 454,3);
insert into course (id, department, title, num, hrs) values ('CHEM456','CHEM','Biochemistry III: Metabolism', 456,2);
insert into course (id, department, title, num, hrs) values ('CHEM463','CHEM','Biochemistry Laboratory I', 463,1);
insert into course (id, department, title, num, hrs) values ('CRIM205','CRIM','Introduction to Criminal Justice', 205,3);
insert into course (id, department, title, num, hrs) values ('CRIM250','CRIM','Police Systems and Practices', 250,3);
insert into course (id, department, title, num, hrs) values ('CRIM320','CRIM','Criminal Law', 320,3);
insert into course (id, department, title, num, hrs) values ('CRIM330','CRIM','Domestic Violence', 330,3);
insert into course (id, department, title, num, hrs) values ('CRIM350','CRIM','Corrections: Prison, Probation, and Parole', 350,3);
insert into course (id, department, title, num, hrs) values ('CRIM365','CRIM','Search and Seizure', 365,3);
insert into course (id, department, title, num, hrs) values ('CRIM370','CRIM','Forensic Evidence', 370,3);
insert into course (id, department, title, num, hrs) values ('CRIM420','CRIM','Law Enforcement Leadership', 420,3);
insert into course (id, department, title, num, hrs) values ('CRIM430','CRIM','Evidence and Procedure', 430,3);
insert into course (id, department, title, num, hrs) values ('CRIM455','CRIM','Professionalism and Ethics in Criminal Justice', 455,3);
insert into course (id, department, title, num, hrs) values ('CRIM499','CRIM','Criminal Justice Intership', 499,3);
insert into course (id, department, title, num, hrs) values ('CS115','CS','Introduction to Programming Using Scripting', 115,3);
insert into course (id, department, title, num, hrs) values ('CS116','CS','Scripting for Analytics', 116,3);
insert into course (id, department, title, num, hrs) values ('CS120','CS','Programing I', 120,3);
insert into course (id, department, title, num, hrs) values ('CS130','CS','Programing II', 130,3);
insert into course (id, department, title, num, hrs) values ('CS230','CS','Object-Oriented Programing', 230,3);
insert into course (id, department, title, num, hrs) values ('CS315','CS','Mobile Application Development', 315,3);
insert into course (id, department, title, num, hrs) values ('CS316','CS','Mobile Game Development', 316,3);
insert into course (id, department, title, num, hrs) values ('CS330','CS','Human-Computer Inter', 330,3);
insert into course (id, department, title, num, hrs) values ('CS332','CS','Design and Analysis', 332,3);
insert into course (id, department, title, num, hrs) values ('CS352','CS','Programing Languages', 352,3);
insert into course (id, department, title, num, hrs) values ('CS356','CS','Operating Systems', 356,3);
insert into course (id, department, title, num, hrs) values ('CS374','CS','Software Engineering', 374,3);
insert into course (id, department, title, num, hrs) values ('CS375','CS','Software Engineering II', 375,3);
insert into course (id, department, title, num, hrs) values ('CS467','CS','Introduction to Artificial Intelligence', 467,3);
insert into course (id, department, title, num, hrs) values ('DET210','DET','Introduction to Digital Entertainment', 210,3);
insert into course (id, department, title, num, hrs) values ('DET220','DET','Introduction to 3D Modeling', 220,3);
insert into course (id, department, title, num, hrs) values ('DET230','DET','Introduction to Animation: Keyframes & Pixels', 230,3);
insert into course (id, department, title, num, hrs) values ('DET255','DET','Game Textures', 255,3);
insert into course (id, department, title, num, hrs) values ('DET260','DET','Game Engines', 260,3);
insert into course (id, department, title, num, hrs) values ('DET310','DET','Digital Entertainment Technology II', 310,3);
insert into course (id, department, title, num, hrs) values ('DET315','DET','Game Materials', 315,3);
insert into course (id, department, title, num, hrs) values ('DET320','DET','Advanced 3D Modeling', 320,3);
insert into course (id, department, title, num, hrs) values ('DET330','DET','3D Animation: Keyframes and Pixels', 330,3);
insert into course (id, department, title, num, hrs) values ('DET350','DET','Digital Entertainment Development', 350,3);
insert into course (id, department, title, num, hrs) values ('DET360','DET','AR/VR Development', 360,3);
insert into course (id, department, title, num, hrs) values ('DET365','DET','Virtual Production', 365,3);
insert into course (id, department, title, num, hrs) values ('DET370','DET','Serious Games', 370,3);
insert into course (id, department, title, num, hrs) values ('DET410','DET','Digital Entertainment Technology III', 410,3);
insert into course (id, department, title, num, hrs) values ('DSGN102','DSGN','Introduction to Interior Design', 102,3);
insert into course (id, department, title, num, hrs) values ('DSGN111','DSGN','Design Drawing I', 111,3);
insert into course (id, department, title, num, hrs) values ('DSGN201','DSGN','Fundamental Design I', 201,3);
insert into course (id, department, title, num, hrs) values ('DSGN202','DSGN','Fundamental Design II', 202,3);
insert into course (id, department, title, num, hrs) values ('DSGN211','DSGN','Design Drawing II', 211,3);
insert into course (id, department, title, num, hrs) values ('DSGN221','DSGN','History of Architecture and Design I', 221,3);
insert into course (id, department, title, num, hrs) values ('DSGN222','DSGN','History of Architecture and Design II', 222,3);
insert into course (id, department, title, num, hrs) values ('DSGN232','DSGN','Digital Design Communication', 232,3);
insert into course (id, department, title, num, hrs) values ('DSGN301','DSGN','Intermediate Interior Design I', 301,3);
insert into course (id, department, title, num, hrs) values ('DSGN302','DSGN','Intermediate Interior Design II', 302,3);
insert into course (id, department, title, num, hrs) values ('DSGN351','DSGN','Interior Components', 351,3);
insert into course (id, department, title, num, hrs) values ('DSGN352','DSGN','Building Systems', 352,3);
insert into course (id, department, title, num, hrs) values ('DSGN401','DSGN','Advanced Interior Design', 401,3);
insert into course (id, department, title, num, hrs) values ('DSGN402','DSGN','Design, Construction and Details for Interiors', 402,3);
insert into course (id, department, title, num, hrs) values ('DSGN461','DSGN','Professional Principles and Practices (for Design Practitioners)', 461,3);
insert into course (id, department, title, num, hrs) values ('DSGN463','DSGN','Field Experience', 463,3);
insert into course (id, department, title, num, hrs) values ('ECON260','ECON','Principles of Macroeconomics', 260,3);
insert into course (id, department, title, num, hrs) values ('ECON261','ECON','Principles of Microeconomics', 261,3);
insert into course (id, department, title, num, hrs) values ('ECON312','ECON','Game Theory', 312,3);
insert into course (id, department, title, num, hrs) values ('ECON438','ECON','International Poverty and Development', 438,3);
insert into course (id, department, title, num, hrs) values ('ECON463','ECON','Managerial Economics', 463,3);
insert into course (id, department, title, num, hrs) values ('ENGL301','ENGL','Introduction to English Studies', 301,3);
insert into course (id, department, title, num, hrs) values ('ENGL311','ENGL','Literary Theory and Criticism', 311,3);
insert into course (id, department, title, num, hrs) values ('ENGL320','ENGL','Creative Nonfiction Workshop', 320,3);
insert into course (id, department, title, num, hrs) values ('ENGL321','ENGL','Screenwriting', 321,3);
insert into course (id, department, title, num, hrs) values ('ENGL322','ENGL','Fiction Workshop', 322,3);
insert into course (id, department, title, num, hrs) values ('ENGL323','ENGL','Poetry Workshop', 323,3);
insert into course (id, department, title, num, hrs) values ('ENGL324','ENGL','Play Writing Workshop', 324,3);
insert into course (id, department, title, num, hrs) values ('ENGL325','ENGL','Advanced Composition', 325,3);
insert into course (id, department, title, num, hrs) values ('ENGL326','ENGL','Business and Professional Writing', 326,3);
insert into course (id, department, title, num, hrs) values ('ENGL327','ENGL','Scientific and Technical Writing', 327,3);
insert into course (id, department, title, num, hrs) values ('ENGL328','ENGL','Social Justice: A Rhetoric', 328,3);
insert into course (id, department, title, num, hrs) values ('ENGL329','ENGL','Rhetoric as Written Discourse', 329,3);
insert into course (id, department, title, num, hrs) values ('ENGL330','ENGL','Advanced English Grammar', 330,3);
insert into course (id, department, title, num, hrs) values ('ENGL331','ENGL','Narrative for Film and New Media', 331,3);
insert into course (id, department, title, num, hrs) values ('ENGL332','ENGL','Introduction to Film Studies', 332,3);
insert into course (id, department, title, num, hrs) values ('ENGL333','ENGL','Studies in World Cinema', 333,3);
insert into course (id, department, title, num, hrs) values ('ENGL351','ENGL','Literature for Young Adults', 351,3);
insert into course (id, department, title, num, hrs) values ('ENGL362','ENGL','American Literature Before 1860', 362,3);
insert into course (id, department, title, num, hrs) values ('ENGL363','ENGL','American Literature After 1860', 363,3);
insert into course (id, department, title, num, hrs) values ('ENGL376','ENGL','Fiction', 376,3);
insert into course (id, department, title, num, hrs) values ('ENGL377','ENGL','Drama', 377,3);
insert into course (id, department, title, num, hrs) values ('ENGL378','ENGL','Poetry', 378,3);
insert into course (id, department, title, num, hrs) values ('ENGL380','ENGL','Interactive Narratives', 380,3);
insert into course (id, department, title, num, hrs) values ('ENGL410','ENGL','Language and Literature Internship', 410,3);
insert into course (id, department, title, num, hrs) values ('ENGL432','ENGL','Introduction to Linguistics', 432,3);
insert into course (id, department, title, num, hrs) values ('ENGL441','ENGL','Topics in Literary Criticism and Bibliography', 441,3);
insert into course (id, department, title, num, hrs) values ('ENGL443','ENGL','Topics in the English Language', 443,3);
insert into course (id, department, title, num, hrs) values ('ENGL446','ENGL','Topics in American Literature', 446,3);
insert into course (id, department, title, num, hrs) values ('ENGL447','ENGL','Topics in General Literature', 447,3);
insert into course (id, department, title, num, hrs) values ('ENGL448','ENGL','Topics in British Literature Before 1700', 448,3);
insert into course (id, department, title, num, hrs) values ('ENGL449','ENGL','Topics in British Literature After 1700', 449,3);
insert into course (id, department, title, num, hrs) values ('ENGL459','ENGL','English for Secondary Teachers', 459,3);
insert into course (id, department, title, num, hrs) values ('ENGL464','ENGL','American Novel', 464,3);
insert into course (id, department, title, num, hrs) values ('ENGL470','ENGL','Multicultural Literature', 470,3);
insert into course (id, department, title, num, hrs) values ('ENGL471','ENGL','Literature and Belief', 471,3);
insert into course (id, department, title, num, hrs) values ('ENGL472','ENGL','Film and Belief', 472,3);
insert into course (id, department, title, num, hrs) values ('ENGL473','ENGL','Rhetoric and Belief', 473,3);
insert into course (id, department, title, num, hrs) values ('ENGL481','ENGL','Medieval British Literature', 481,3);
insert into course (id, department, title, num, hrs) values ('ENGL483','ENGL','Shakespeare', 483,3);
insert into course (id, department, title, num, hrs) values ('ENGL484','ENGL','Seventeenth-Century British Literature', 484,3);
insert into course (id, department, title, num, hrs) values ('ENGL495','ENGL','Eighteenth-Century British Literature', 495,3);
insert into course (id, department, title, num, hrs) values ('ENGL496','ENGL','Nineteenth-Century British Literature', 496,3);
insert into course (id, department, title, num, hrs) values ('ENGL497','ENGL','Twentieth-Century British Literature', 497,3);
insert into course (id, department, title, num, hrs) values ('ENGL499','ENGL','Studies in World Literature', 499,3);
insert into course (id, department, title, num, hrs) values ('ENGR115','ENGR','Introduction to Engineering and Physics', 115,1);
insert into course (id, department, title, num, hrs) values ('ENGR116','ENGR','Introduction to Engineering and Physics Laboratory', 116,1);
insert into course (id, department, title, num, hrs) values ('ENGR117','ENGR','Computational Tools for Engineering and Physics', 117,1);
insert into course (id, department, title, num, hrs) values ('ENGR131','ENGR','Computer Aided Design and Modeling', 131,1);
insert into course (id, department, title, num, hrs) values ('ENGR135','ENGR','Introduction to Electric Circuits', 135,3);
insert into course (id, department, title, num, hrs) values ('ENGR136','ENGR','Introduction to Electric Circuits Laboratory', 136,1);
insert into course (id, department, title, num, hrs) values ('ENGR210','ENGR','Digital Logic', 210,3);
insert into course (id, department, title, num, hrs) values ('ENGR217','ENGR','Engineering Career Skills', 217,1);
insert into course (id, department, title, num, hrs) values ('ENGR221','ENGR','Statics and Dynamics', 221,4);
insert into course (id, department, title, num, hrs) values ('ENGR281','ENGR','Engineering Thermodynamics', 281,3);
insert into course (id, department, title, num, hrs) values ('ENGR306','ENGR','Engineering Ethics', 306,1);
insert into course (id, department, title, num, hrs) values ('ENGR317','ENGR','Engineering Project Management', 317,1);
insert into course (id, department, title, num, hrs) values ('ENGR333','ENGR','Fluid Mechanics', 333,3);
insert into course (id, department, title, num, hrs) values ('ENGR350','ENGR','Engineering Economics', 350,3);
insert into course (id, department, title, num, hrs) values ('ENGR355','ENGR','Electronic Devices', 355,3);
insert into course (id, department, title, num, hrs) values ('ENGR356','ENGR','Electronic Devices Laboratory', 356,1);
insert into course (id, department, title, num, hrs) values ('ENGR360','ENGR','Electricity and Magnetism', 360,3);
insert into course (id, department, title, num, hrs) values ('ENGR377','ENGR','Statistics for Engineers', 377,3);
insert into course (id, department, title, num, hrs) values ('ENGR387','ENGR','Power Electronics and Electromechanics', 387,3);
insert into course (id, department, title, num, hrs) values ('ENGR388','ENGR','Network Analysis', 388,3);
insert into course (id, department, title, num, hrs) values ('ENGR390','ENGR','Junior Clinic', 390,3);
insert into course (id, department, title, num, hrs) values ('ENGR410','ENGR','Signal Processing', 410,3);
insert into course (id, department, title, num, hrs) values ('ENGR422','ENGR','Embedded Systems', 422,3);
insert into course (id, department, title, num, hrs) values ('ENGR423','ENGR','Embedded Systems Laboratory', 423,1);
insert into course (id, department, title, num, hrs) values ('ENGR430','ENGR','Senior Clinic I', 430,3);
insert into course (id, department, title, num, hrs) values ('ENGR432','ENGR','Senior Clinic II', 432,3);
insert into course (id, department, title, num, hrs) values ('ENTR120','ENTR','Foundations of Entrepreneurship', 120,3);
insert into course (id, department, title, num, hrs) values ('ENTR305','ENTR','Entrepreneurial Mindset', 305,3);
insert into course (id, department, title, num, hrs) values ('ENTR315','ENTR','Business Models', 315,3);
insert into course (id, department, title, num, hrs) values ('ENTR325','ENTR','Raising Capital', 325,3);
insert into course (id, department, title, num, hrs) values ('ENTR335','ENTR','Building Startup Teams', 335,3);
insert into course (id, department, title, num, hrs) values ('ENTR410','ENTR','Social Entrepreneurship', 410,3);
insert into course (id, department, title, num, hrs) values ('ENTR411','ENTR','Entrepreneurial Venture Management', 411,3);
insert into course (id, department, title, num, hrs) values ('ENTR412','ENTR','Launching the Venture', 412,3);
insert into course (id, department, title, num, hrs) values ('ENTR419','ENTR','Global Entrepreneur', 419,3);
insert into course (id, department, title, num, hrs) values ('ENTR420','ENTR','Entrepreneurial Journey', 420,3);
insert into course (id, department, title, num, hrs) values ('ENTR430','ENTR','Topics in Entrepreneurship', 430,3);
insert into course (id, department, title, num, hrs) values ('FIN310','FIN','Financial Managment', 310,3);
insert into course (id, department, title, num, hrs) values ('FIN499','FIN','Finance Internship', 499,3);
insert into course (id, department, title, num, hrs) values ('FLLA221','FLLA','Intermediate Latin I', 221,3);
insert into course (id, department, title, num, hrs) values ('FLLA222','FLLA','Intermediate Latin II', 222,3);
insert into course (id, department, title, num, hrs) values ('FREN221','FREN','Intermediate French I', 221,3);
insert into course (id, department, title, num, hrs) values ('FREN222','FREN','Intermediate French II', 222,3);
insert into course (id, department, title, num, hrs) values ('GER221','GER','Intermediate German I', 221,3);
insert into course (id, department, title, num, hrs) values ('GER222','GER','Intermediate German II', 222,3);
insert into course (id, department, title, num, hrs) values ('GOVT225','GOVT','National Government', 225,3);
insert into course (id, department, title, num, hrs) values ('GOVT315','GOVT','Government and Criminal Justice Research Methods', 315,3);
insert into course (id, department, title, num, hrs) values ('GOVT384','GOVT','American Judicial Process', 384,3);
insert into course (id, department, title, num, hrs) values ('GOVT432','GOVT','Constitutional Law: Civil Rights', 432,3);
insert into course (id, department, title, num, hrs) values ('GOVT487','GOVT','Terrorism Studies', 487,3);
insert into course (id, department, title, num, hrs) values ('IS222','IS','Analytics 1: Statistics', 222,3);
insert into course (id, department, title, num, hrs) values ('IS324','IS','Management Information Systems', 324,3);
insert into course (id, department, title, num, hrs) values ('IS330','IS','Business Geographic Information Systems', 330,3);
insert into course (id, department, title, num, hrs) values ('IS405','IS','Systems Analysis and Design', 405,3);
insert into course (id, department, title, num, hrs) values ('IS410','IS','Enterprise Resource Planning', 410,3);
insert into course (id, department, title, num, hrs) values ('IS415','IS','E-Commerce', 415,3);
insert into course (id, department, title, num, hrs) values ('IS430','IS','Management of Information and Technology Resources', 430,3);
insert into course (id, department, title, num, hrs) values ('IS432','IS','Analytics 3: Data Mining', 432,3);
insert into course (id, department, title, num, hrs) values ('IS442','IS','Analytics 4: Business Analytics Projects', 442,3);
insert into course (id, department, title, num, hrs) values ('IS499','IS','Information Systems Internship', 499,3);
insert into course (id, department, title, num, hrs) values ('IS524','IS','Management Information Systems', 524,3);
insert into course (id, department, title, num, hrs) values ('IS605','IS','Systems Analysis and Design', 605,3);
insert into course (id, department, title, num, hrs) values ('IT220','IT','Introduction to Databases and Database Management', 220,3);
insert into course (id, department, title, num, hrs) values ('IT221','IT','Fundamentals of Networking and Data Communications', 221,3);
insert into course (id, department, title, num, hrs) values ('IT263','IT','Analytics 2: Data Management and Visualization', 263,3);
insert into course (id, department, title, num, hrs) values ('IT310','IT','Introduction to Computer and Information Security', 310,3);
insert into course (id, department, title, num, hrs) values ('IT325','IT','Web Application Development', 325,3);
insert into course (id, department, title, num, hrs) values ('IT330','IT','Analytics 2: Data Managment and Visualization', 330,3);
insert into course (id, department, title, num, hrs) values ('ITC110','ITC','Introduction to Information, Technology, and Computing', 110,3);
insert into course (id, department, title, num, hrs) values ('ITC125','ITC','Introduction to Human-Computer Interaction', 125,3);
insert into course (id, department, title, num, hrs) values ('ITC399','ITC','ITC Research', 399,3);
insert into course (id, department, title, num, hrs) values ('ITC480','ITC','Reflections on Faith and Work Credit Hours', 480,3);
insert into course (id, department, title, num, hrs) values ('ITC499','ITC','Information, Technology, and Computing Internship', 499,3);
insert into course (id, department, title, num, hrs) values ('JMC165','JMC','Media Maker I', 165,3);
insert into course (id, department, title, num, hrs) values ('JMC166','JMC','Media Maker II', 166,3);
insert into course (id, department, title, num, hrs) values ('JMC224','JMC','Media writing', 224,3);
insert into course (id, department, title, num, hrs) values ('JMC233','JMC','Photography', 233,3);
insert into course (id, department, title, num, hrs) values ('JMC261','JMC','Television Production', 261,3);
insert into course (id, department, title, num, hrs) values ('JMC265','JMC','Film Production', 265,3);
insert into course (id, department, title, num, hrs) values ('JMC302','JMC','Introduction to Race and Media', 302,1);
insert into course (id, department, title, num, hrs) values ('JMC303','JMC','Colloquium in Race and Media', 303,1);
insert into course (id, department, title, num, hrs) values ('JMC321','JMC','Student Media Lab(One semester required)', 321,0);
insert into course (id, department, title, num, hrs) values ('JMC338','JMC','Broadcast News and Sport', 338,3);
insert into course (id, department, title, num, hrs) values ('JMC342','JMC','Communication Design', 342,3);
insert into course (id, department, title, num, hrs) values ('JMC351','JMC','Web Publishing', 351,3);
insert into course (id, department, title, num, hrs) values ('JMC352','JMC','Advanced Web Publishing', 352,3);
insert into course (id, department, title, num, hrs) values ('JMC355','JMC','Media Technology', 355,3);
insert into course (id, department, title, num, hrs) values ('JMC361','JMC','Advanced Media Production', 361,3);
insert into course (id, department, title, num, hrs) values ('JMC364','JMC','Media and Religion', 364,3);
insert into course (id, department, title, num, hrs) values ('JMC365','JMC','Film Practicum', 365,3);
insert into course (id, department, title, num, hrs) values ('JMC367','JMC','Social Media', 367,3);
insert into course (id, department, title, num, hrs) values ('JMC390','JMC','Advertising Creativity and Copy writing', 390,3);
insert into course (id, department, title, num, hrs) values ('JMC405','JMC','Visual Portfolio', 405,3);
insert into course (id, department, title, num, hrs) values ('JMC421','JMC','Promotional Video Practicum', 421,3);
insert into course (id, department, title, num, hrs) values ('JMC465','JMC','Documentary Practicum', 465,3);
insert into course (id, department, title, num, hrs) values ('JMC488','JMC','Communication Law', 488,3);
insert into course (id, department, title, num, hrs) values ('JMC495','JMC','JMC Internship (Capstone course)', 495,1);
insert into course (id, department, title, num, hrs) values ('MATH130','MATH','Finite Math for Applications', 130,3);
insert into course (id, department, title, num, hrs) values ('MATH131','MATH','Calculus for Application', 131,3);
insert into course (id, department, title, num, hrs) values ('MATH185','MATH','Calculus I', 185,3);
insert into course (id, department, title, num, hrs) values ('MATH186','MATH','Calculus II', 186,3);
insert into course (id, department, title, num, hrs) values ('MATH187','MATH','Calculus Computer Laboratory', 187,1);
insert into course (id, department, title, num, hrs) values ('MATH227','MATH','Discrete Mathematics', 227,3);
insert into course (id, department, title, num, hrs) values ('MATH286','MATH','Calculus III', 286,3);
insert into course (id, department, title, num, hrs) values ('MATH325','MATH','Linear Algebra', 325,3);
insert into course (id, department, title, num, hrs) values ('MATH334','MATH','Linear Programming', 334,3);
insert into course (id, department, title, num, hrs) values ('MATH341','MATH','Numerical Methods', 341,3);
insert into course (id, department, title, num, hrs) values ('MATH351','MATH','Abstract Algebra I', 351,3);
insert into course (id, department, title, num, hrs) values ('MATH361','MATH','Ordinary Differential Equations', 361,4);
insert into course (id, department, title, num, hrs) values ('MATH377','MATH','Statistical Methods I', 377,3);
insert into course (id, department, title, num, hrs) values ('MATH432','MATH','Introduction to Operations Research', 432,3);
insert into course (id, department, title, num, hrs) values ('MATH463','MATH','Partial Differential Equations', 463,3);
insert into course (id, department, title, num, hrs) values ('MGMT305','MGMT','Foundations of Entrepreneurship', 305,3);
insert into course (id, department, title, num, hrs) values ('MGMT312','MGMT','Game Theory', 312,3);
insert into course (id, department, title, num, hrs) values ('MGMT320','MGMT','Management and Organizational Behavior', 320,3);
insert into course (id, department, title, num, hrs) values ('MGMT322','MGMT','Business and Sustainability', 322,3);
insert into course (id, department, title, num, hrs) values ('MGMT330','MGMT','Management and Organizational Behavior', 330,3);
insert into course (id, department, title, num, hrs) values ('MGMT331','MGMT','Operations Management', 331,3);
insert into course (id, department, title, num, hrs) values ('MGMT332','MGMT','Human Resource Management', 332,3);
insert into course (id, department, title, num, hrs) values ('MGMT335','MGMT','Leadership in Organizations', 335,3);
insert into course (id, department, title, num, hrs) values ('MGMT337','MGMT','Safety, Health and Security', 337,3);
insert into course (id, department, title, num, hrs) values ('MGMT342','MGMT','Total Quality Management', 342,3);
insert into course (id, department, title, num, hrs) values ('MGMT345','MGMT','Introduction to Management Science', 345,3);
insert into course (id, department, title, num, hrs) values ('MGMT373','MGMT','Employee Planning, Recruitment and Selection', 373,3);
insert into course (id, department, title, num, hrs) values ('MGMT375','MGMT','Employee and Labor Relations', 375,3);
insert into course (id, department, title, num, hrs) values ('MGMT434','MGMT','Strategic Philanthropy', 434,3);
insert into course (id, department, title, num, hrs) values ('MGMT436','MGMT','Current Topics in Organizational Behavior', 436,3);
insert into course (id, department, title, num, hrs) values ('MGMT439','MGMT','Strategic Management', 439,3);
insert into course (id, department, title, num, hrs) values ('MGMT447','MGMT','Compensation and Benefits Management', 447,3);
insert into course (id, department, title, num, hrs) values ('MGMT450','MGMT','Career Management', 450,3);
insert into course (id, department, title, num, hrs) values ('MGMT452','MGMT','Logistics and Supply Chain Management', 452,3);
insert into course (id, department, title, num, hrs) values ('MGMT459','MGMT','Project Management', 459,3);
insert into course (id, department, title, num, hrs) values ('MGMT499','MGMT','Management Internship', 499,3);
insert into course (id, department, title, num, hrs) values ('MGMT532','MGMT','Human Resource Management', 532,3);
insert into course (id, department, title, num, hrs) values ('MGMT629','MGMT','Advanced Management Systems', 629,3);
insert into course (id, department, title, num, hrs) values ('MGMT635','MGMT','Organizational Design and Change', 635,3);
insert into course (id, department, title, num, hrs) values ('MGMT636','MGMT','Organizational Behavior', 636,3);
insert into course (id, department, title, num, hrs) values ('MKTG320','MKTG','Principles of Marketing', 320,3);
insert into course (id, department, title, num, hrs) values ('MKTG333','MKTG','Sports Administration', 333,3);
insert into course (id, department, title, num, hrs) values ('MKTG341','MKTG','Marketing Research', 341,3);
insert into course (id, department, title, num, hrs) values ('MKTG342','MKTG','Consumer Behavior', 342,3);
insert into course (id, department, title, num, hrs) values ('MKTG343','MKTG','Personal Selling', 343,3);
insert into course (id, department, title, num, hrs) values ('MKTG344','MKTG','Marketing Promotion', 344,3);
insert into course (id, department, title, num, hrs) values ('MKTG419','MKTG','International Marketing', 419,3);
insert into course (id, department, title, num, hrs) values ('MKTG432','MKTG','Analytics 3: Data Mining', 432,3);
insert into course (id, department, title, num, hrs) values ('MKTG495','MKTG','Marketing Strategy', 495,3);
insert into course (id, department, title, num, hrs) values ('MKTG499','MKTG','Marketing Internship', 499,3);
insert into course (id, department, title, num, hrs) values ('PHIL379','PHIL','Philosophy, Religion and Science', 379,3);
insert into course (id, department, title, num, hrs) values ('PHIL486','PHIL','Ethics', 486,3);
insert into course (id, department, title, num, hrs) values ('PHYS220','PHYS','Engineering Physics I', 220,3);
insert into course (id, department, title, num, hrs) values ('PHYS221','PHYS','Engineering Physics I Laboratory', 221,1);
insert into course (id, department, title, num, hrs) values ('PHYS222','PHYS','Engineering Physics II', 222,3);
insert into course (id, department, title, num, hrs) values ('PHYS223','PHYS','Engineering Physics II Laboratory', 223,1);
insert into course (id, department, title, num, hrs) values ('PHYS330','PHYS','Modern Physics', 330,3);
insert into course (id, department, title, num, hrs) values ('PHYS393','PHYS','Introduction to Research', 393,3);
insert into course (id, department, title, num, hrs) values ('PSYC120','PSYC','Introduction to Psychology', 120,3);
insert into course (id, department, title, num, hrs) values ('PSYC201','PSYC','Psychology Seminar', 201,1);
insert into course (id, department, title, num, hrs) values ('PSYC211','PSYC','Human Dev & Lead in Community', 211,3);
insert into course (id, department, title, num, hrs) values ('PSYC232','PSYC','Developmental Psychology', 232,3);
insert into course (id, department, title, num, hrs) values ('PSYC233','PSYC','Physiological Psychology', 233,3);
insert into course (id, department, title, num, hrs) values ('PSYC241','PSYC','Cognition and Learning', 241,3);
insert into course (id, department, title, num, hrs) values ('PSYC252','PSYC','Mental Health', 252,3);
insert into course (id, department, title, num, hrs) values ('PSYC278','PSYC','Stress and Its Management', 278,3);
insert into course (id, department, title, num, hrs) values ('PSYC301','PSYC','Psychology Seminar II', 301,1);
insert into course (id, department, title, num, hrs) values ('PSYC305','PSYC','Peacemaking', 305,3);
insert into course (id, department, title, num, hrs) values ('PSYC311','PSYC','Elementary Statistics', 311,3);
insert into course (id, department, title, num, hrs) values ('PSYC342','PSYC','Applied Sports Psychology', 342,3);
insert into course (id, department, title, num, hrs) values ('PSYC343','PSYC','Selection & Perf. Appraisal', 343,3);
insert into course (id, department, title, num, hrs) values ('PSYC345','PSYC','Sexual Minorities: Ident & Com', 345,3);
insert into course (id, department, title, num, hrs) values ('PSYC346','PSYC','Freud and Jung', 346,3);
insert into course (id, department, title, num, hrs) values ('PSYC348','PSYC','Psychology and Christianity', 348,3);
insert into course (id, department, title, num, hrs) values ('PSYC351','PSYC','Experimental Psychology', 351,4);
insert into course (id, department, title, num, hrs) values ('PSYC356','PSYC','Health Psychology', 356,3);
insert into course (id, department, title, num, hrs) values ('PSYC368','PSYC','Psychological Tests and Measurements', 368,3);
insert into course (id, department, title, num, hrs) values ('PSYC370','PSYC','Social Psychology', 370,3);
insert into course (id, department, title, num, hrs) values ('PSYC372','PSYC','Child Abuse: Recogn & Response', 372,3);
insert into course (id, department, title, num, hrs) values ('PSYC373','PSYC','Character/Needs Except Children', 373,3);
insert into course (id, department, title, num, hrs) values ('PSYC374','PSYC','Abnormal Child Psychology', 374,3);
insert into course (id, department, title, num, hrs) values ('PSYC375','PSYC','Industrial & Organization Psyc', 375,3);
insert into course (id, department, title, num, hrs) values ('PSYC376','PSYC','Psych. of Mental Retardation', 376,3);
insert into course (id, department, title, num, hrs) values ('PSYC382','PSYC','Abnormal Psychology', 382,3);
insert into course (id, department, title, num, hrs) values ('PSYC388','PSYC','Teams & Team Leadership', 388,3);
insert into course (id, department, title, num, hrs) values ('PSYC392','PSYC','Child Psychology', 392,3);
insert into course (id, department, title, num, hrs) values ('PSYC396','PSYC','Issues of Emerging Adulthood', 396,3);
insert into course (id, department, title, num, hrs) values ('PSYC401','PSYC','Career and Calling', 401,1);
insert into course (id, department, title, num, hrs) values ('PSYC451','PSYC','Statistics in Psyc. Research', 451,3);
insert into course (id, department, title, num, hrs) values ('PSYC471','PSYC','Behavior Modification', 471,3);
insert into course (id, department, title, num, hrs) values ('PSYC485','PSYC','Introduction to Counseling', 485,4);
insert into course (id, department, title, num, hrs) values ('PSYC493','PSYC','History of Theories in Psychology', 493,3);
insert into course (id, department, title, num, hrs) values ('SOCI111','SOCI','Introduction to Sociology', 111,3);
insert into course (id, department, title, num, hrs) values ('SOCI355','SOCI','Social Deviance', 355,3);
insert into course (id, department, title, num, hrs) values ('SOCI388','SOCI','Crime and Delinquency', 388,3);
insert into course (id, department, title, num, hrs) values ('SOCI415','SOCI','Social Research', 415,3);
insert into course (id, department, title, num, hrs) values ('SPAN221','SPAN','Intermediate I', 221,3);
insert into course (id, department, title, num, hrs) values ('SPAN222','SPAN','Intermediate II', 222,3);
insert into course (id, department, title, num, hrs) values ('SPEN221','SPEN','Intermediate Spanish I', 221,3);
insert into course (id, department, title, num, hrs) values ('SPEN222','SPEN','Intermediate Spanish II', 222,3);
insert into course (id, department, title, num, hrs) values ('THEA227','THEA','Introduction to Technical Theatre', 227,3);
-- select *from course;

insert into major (id, title, deptID, reqtext, hrs, gpa) values ('CS', 'Computer Science', 'SITC', 'Minimum grade of C in CS 120, CS 130, CS 230, IT 220, IT 221, MATH 227', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('ART', 'Interior Design', 'ART', 'Minimum grade of C in art and design courses', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('EE', 'Electrical Engineering','ENGR', 'Minimum grade for PHYS or ENGR courses, C', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('DET', 'Digital Entertainment Technology','SITC', 'All DET majors must perform two required portfolio reviews', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('BIBLE', 'Bible','BMM', 'Minimum grade of a C in all 300 or above Bible classes', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('PSYC', 'Psychology','PSY', 'Minimum GPA in major: 2.00', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('BIO', 'Biochemistry', 'BIO', 'Minimum GPA in major: 2.00', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('CJ', 'Criminal Justice', 'PSCJ', 'Min grade per major course: C', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('BBA', 'Accounting','ACF', 'Minimum grade in each business course: C', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('IS', 'Information Systems','SITC', 'Minimum grade in each business course: C', 128, 2.00);
insert into major (id, title, deptID, reqtext, hrs, gpa) values ('BM', 'Business Managment','MGS', 'Minimum grade for PHYS or ENGR courses: C', 128, 2.00);
-- -- select *from major;

INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (1, 'Brian', 'Burton', 'SITC', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (2, 'Brent', 'Reeves', 'SITC', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (3, 'James', 'Prather', 'SITC', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (4, 'John', 'Homer', 'SITC', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (5, 'Arisoa', 'Randrianasolo', 'SITC', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (6, 'Karen', 'St. John', 'SITC', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (7, 'Rich', 'Tanner', 'SITC', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (8, 'Geoff', 'Broderick', 'ART', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (9, 'Ryan', 'Feerer', 'ART', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (10, 'Kenneth', 'Jones', 'ART', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (11, 'Kelly', 'Mann', 'ART', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (12, 'Dan', 'McGregor', 'ART', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (13, 'Ronnie', 'Rama', 'ART', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (14, 'Nil', 'Santana', 'ART', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (15, 'Trey', 'Shirley', 'ART', 0);
INSERT INTO teachers (id, firstname, lastname, departmentID, adjunct) VALUES (16, 'Mike', 'Wiggins', 'ART', 0);


insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10101, 'CS120', 'Spring 2025', '2025-01-15', '2025-05-10', 'MWF', 30, 'MBB101');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10202, 'CS130', 'Spring 2025', '2025-01-16', '2025-05-11', 'TR', 40, 'MBB202');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10303, 'CS220', 'Summer 2025', '2025-06-01', '2025-08-10', 'MW', 25, 'MBB303');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10404, 'CRIM205', 'Summer 2025', '2025-06-05', '2025-08-15', 'MW', 30, 'MBB110');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10505, 'CRIM250', 'Fall 2025', '2025-08-20', '2025-12-10', 'TTh', 35, 'MBB120');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10606, 'CRIM320', 'Fall 2025', '2025-08-22', '2025-12-12', 'MWF', 40, 'MBB130');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10707, 'CRIM330', 'Fall 2025', '2025-12-15', '2026-01-30', 'MW', 25, 'MBB140');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10808, 'CRIM365', 'Fall 2025', '2025-12-20', '2026-02-10', 'TR', 30, 'MBB150');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10909, 'CS230', 'Spring 2025', '2025-01-15', '2025-05-10', 'MWF', 35, 'MBB201');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11001, 'CS352', 'Spring 2025', '2025-01-15', '2025-05-10', 'TR', 25, 'MBB105');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11002, 'CS374', 'Spring 2025', '2025-01-15', '2025-05-10', 'MWF', 30, 'MBB215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11003, 'IT220', 'Spring 2025', '2025-01-15', '2025-05-10', 'TR', 35, 'MBB118');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11004, 'IT221', 'Spring 2025', '2025-01-15', '2025-05-10', 'MW', 35, 'MBB120');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11005, 'MATH227', 'Spring 2025', '2025-01-15', '2025-05-10', 'MWF', 40, 'MBB125');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11006, 'DET210', 'Spring 2025', '2025-01-15', '2025-05-10', 'TR', 25, 'MBB115');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11007, 'DET220', 'Spring 2025', '2025-01-15', '2025-05-10', 'MWF', 20, 'MBB116');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11008, 'BIOL121', 'Spring 2025', '2025-01-15', '2025-05-10', 'TR', 50, 'FOS110');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11009, 'BIOL122', 'Spring 2025', '2025-01-15', '2025-05-10', 'M', 25, 'FOS111');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11010, 'ACCT210', 'Spring 2025', '2025-01-15', '2025-05-10', 'MWF', 40, 'COBA201');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11011, 'CS467', 'Summer 2025', '2025-06-01', '2025-08-10', 'MTWR', 25, 'MBB205');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11012, 'CS315', 'Summer 2025', '2025-06-01', '2025-08-10', 'MTWR', 30, 'MBB206');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11013, 'MATH185', 'Summer 2025', '2025-06-01', '2025-08-10', 'MTWR', 35, 'MBB127');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11014, 'MATH186', 'Summer 2025', '2025-06-01', '2025-08-10', 'MTWR', 35, 'MBB128');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11015, 'CHEM133', 'Summer 2025', '2025-06-01', '2025-08-10', 'MTWR', 40, 'FOS120');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11016, 'CHEM131', 'Summer 2025', '2025-06-01', '2025-08-10', 'TR', 20, 'FOS121');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11017, 'MGMT320', 'Summer 2025', '2025-06-01', '2025-08-10', 'MTWR', 40, 'COBA202');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11018, 'MKTG320', 'Summer 2025', '2025-06-01', '2025-08-10', 'MTWR', 40, 'COBA205');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11019, 'PSYC120', 'Summer 2025', '2025-06-01', '2025-08-10', 'MTWR', 45, 'HSC101');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11020, 'CS120', 'Fall 2025', '2025-08-20', '2025-12-10', 'MWF', 35, 'MBB101');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11021, 'CS130', 'Fall 2025', '2025-08-20', '2025-12-10', 'TR', 30, 'MBB102');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11022, 'CS230', 'Fall 2025', '2025-08-20', '2025-12-10', 'MWF', 25, 'MBB201');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11023, 'CS330', 'Fall 2025', '2025-08-20', '2025-12-10', 'TR', 20, 'MBB207');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11024, 'IT220', 'Fall 2025', '2025-08-20', '2025-12-10', 'MWF', 35, 'MBB118');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11025, 'IT221', 'Fall 2025', '2025-08-20', '2025-12-10', 'TR', 35, 'MBB120');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11026, 'MATH227', 'Fall 2025', '2025-08-20', '2025-12-10', 'MWF', 40, 'MBB125');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11027, 'MATH185', 'Fall 2025', '2025-08-20', '2025-12-10', 'MWF', 45, 'MBB127');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11028, 'BIOL121', 'Fall 2025', '2025-08-20', '2025-12-10', 'TR', 50, 'FOS110');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11029, 'BIOL122', 'Fall 2025', '2025-08-20', '2025-12-10', 'W', 25, 'FOS111');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11030, 'CHEM133', 'Fall 2025', '2025-08-20', '2025-12-10', 'MWF', 45, 'FOS120');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11031, 'CHEM131', 'Fall 2025', '2025-08-20', '2025-12-10', 'T', 22, 'FOS121');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11032, 'ACCT210', 'Fall 2025', '2025-08-20', '2025-12-10', 'MWF', 45, 'COBA201');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11033, 'MGMT320', 'Fall 2025', '2025-08-20', '2025-12-10', 'TR', 40, 'COBA202');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11034, 'PSYC120', 'Fall 2025', '2025-08-20', '2025-12-10', 'MWF', 50, 'HSC101');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11035, 'DET210', 'Fall 2025', '2025-08-20', '2025-12-10', 'TR', 25, 'MBB115');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11036, 'DET220', 'Fall 2025', '2025-08-20', '2025-12-10', 'MWF', 22, 'MBB116');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11037, 'CS115', 'Fall 2025', '2025-12-15', '2026-01-30', 'MTWRF', 30, 'MBB101');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11038, 'MATH130', 'Fall 2025', '2025-12-15', '2026-01-30', 'MTWRF', 35, 'MBB125');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11039, 'SOCI111', 'Fall 2025', '2025-12-15', '2026-01-30', 'MTWRF', 40, 'HSC105');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (11040, 'BIBL320', 'Fall 2025', '2025-12-15', '2026-01-30', 'MTWRF', 35, 'BSB201');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10001, 12, 'A100', 'ART105', 'Spring 2025', '2025-01-14', '2025-05-10', 'MWF');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10002, 15, 'A120', 'ART106', 'Spring 2025', '2025-01-14', '2025-05-10', 'MWF');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10003, 25, 'A200', 'ART222', 'Spring 2025', '2025-01-14', '2025-05-10', 'TR');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10004, 15, 'A220', 'DSGN102', 'Spring 2025', '2025-01-14', '2025-05-10', 'TR');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10005, 10, 'A300', 'DSGN111', 'Spring 2025', '2025-01-14', '2025-05-10', 'TR');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10006, 8, 'A330', 'DSGN201', 'Spring 2025', '2025-01-14', '2025-05-10', 'MTWRF');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10007, 30, 'A221', 'DSGN202', 'Spring 2025', '2025-01-14', '2025-05-10', 'MWF');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10008, 26, 'A223', 'DSGN211', 'Spring 2025', '2025-01-14', '2025-05-10', 'TR');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10009, 23, 'A113', 'DSGN221', 'Spring 2025', '2025-01-14', '2025-05-10', 'MWF');
insert into section (crn, max, room, courseID, term, startdate, enddate, days) values ( 10010, 10, 'A118', 'DSGN222', 'Spring 2025', '2025-01-14', '2025-05-10', 'MTWRF');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10040, 'CHEM133', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10041, 'CHEM131', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10042, 'CHEM132', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10043, 'CHEM134', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10044, 'CHEM221', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10045, 'CHEM223', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10046, 'CHEM322', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10047, 'CHEM324', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10048, 'CHEM423', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section (crn, courseID, term, startdate, enddate, days, max, room) values (10049, 'CHEM453', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10050, 'PSYC120', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10051, 'PSYC232', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10052, 'PSYC233', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10053, 'PSYC241', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10054, 'PSYC351', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10055, 'PSYC368', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10056, 'PSYC370', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10057, 'PSYC382', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10058, 'PSYC451', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
INSERT INTO section (crn, courseID, term, startdate, enddate, days, max, room) VALUES (10059, 'PSYC485', 'Fall 2025', '2025-12-15', '2026-01-30', 'MWF', 40, 'OSC215');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10060, 30, 'MBB110', 'CRIM205', 'Spring 2025', '2025-01-13', '2025-05-23', 'MW');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10061, 35, 'MBB120', 'CRIM250', 'Spring 2025', '2025-01-13', '2025-05-23', 'TR');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10062, 40, 'MBB130', 'CRIM320', 'Spring 2025', '2025-01-13', '2025-05-23', 'MWF');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10063, 25, 'MBB140', 'CRIM330', 'Spring 2025', '2025-01-13', '2025-05-23', 'MW');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10064, 30, 'MBB150', 'CRIM365', 'Spring 2025', '2025-01-13', '2025-05-23', 'TR');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10065, 30, 'MBB160', 'CRIM375', 'Spring 2025', '2025-01-13', '2025-05-23', 'MWF');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10066, 25, 'MBB170', 'CRIM410', 'Spring 2025', '2025-01-13', '2025-05-23', 'TR');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10067, 40, 'MBB180', 'GOVT225', 'Spring 2025', '2025-01-13', '2025-05-23', 'MW');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10068, 35, 'MBB190', 'GOVT315', 'Spring 2025', '2025-01-13', '2025-05-23', 'TR');
insert into section(crn, max, room, courseID, term, startdate, enddate, days) VALUES (10069, 30, 'MBB200', 'GOVT384', 'Spring 2025', '2025-01-13', '2025-05-23', 'MWF');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12001,30,'MBB102','CS120','Spring 2025','2025-01-14','2025-05-10','MWF');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12002,35,'MBB103','CS130','Spring 2025','2025-01-14','2025-05-10','TR');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12003,25,'MBB201','CS230','Spring 2025','2025-01-14','2025-05-10','MWF');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12004,25,'MBB204','CS315','Spring 2025','2025-01-14','2025-05-10','TR');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12005,30,'MBB205','CS374','Spring 2025','2025-01-14','2025-05-10','MWF');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12006,25,'MBB102','CS467','Spring 2025','2025-01-14','2025-05-10','TR');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12007,25,'MBB103','CS330','Spring 2025','2025-01-14','2025-05-10','MWF');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12008,20,'MBB204','CS352','Spring 2025','2025-01-14','2025-05-10','TR');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12009,25,'MBB205','CS332','Spring 2025','2025-01-14','2025-05-10','MWF');
INSERT INTO section (crn,room,max,courseID,term,startdate,enddate,days) VALUES (12010,25,'MBB206','CS375','Spring 2025','2025-01-14','2025-05-10','TR');

-- CS student
INSERT INTO student_section (studentID,sectionID,grade) VALUES (90, 12001, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (90, 12014, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (91, 12001, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (91, 12016, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (92, 12002, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (92, 12014, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (93, 12001, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (93, 12017, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (94, 12002, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (94, 12016, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (95, 12003, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (95, 12014, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (96, 12001, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (96, 12017, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (97, 12002, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (97, 12015, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (98, 12003, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (98, 12016, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (99, 12001, NULL);
INSERT INTO student_section (studentID,sectionID,grade) VALUES (99, 12014, NULL);
-- student 1-10
-- Interior Architecture (student 1)
INSERT INTO student_section (studentID, sectionID, grade) VALUES (1, 10001, NULL);  -- Graphic Design
INSERT INTO student_section (studentID, sectionID, grade) VALUES (1, 10002, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (2, 10001, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (2, 10002, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (2, 10003, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (3, 10001, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (3, 10005, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (3, 10004, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (4, 10006, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (4, 10007, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (4, 10008, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (5, 10009, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (5, 10010, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (6, 10002, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (6, 10005, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (6, 10008, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (7, 10001, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (7, 10004, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (7, 10009, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (8, 10003, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (8, 10006, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (8, 10010, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (9, 10001, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (9, 10007, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (9, 10005, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (10, 10002, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (10, 10004, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (10, 10006, NULL);
-- EE
-- Student 2
INSERT INTO student_section (studentID, sectionID, grade) VALUES (12, 10011, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (12, 10012, NULL);
-- Student 3
INSERT INTO student_section (studentID, sectionID, grade) VALUES (13, 10013, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (13, 10014, NULL);
-- Student 4
INSERT INTO student_section (studentID, sectionID, grade) VALUES (14, 10015, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (14, 10016, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (14, 10017, NULL);
-- Student 5
INSERT INTO student_section (studentID, sectionID, grade) VALUES (15, 10018, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (15, 10019, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (15, 10020, NULL);
-- Student 6
INSERT INTO student_section (studentID, sectionID, grade) VALUES (16, 10015, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (16, 10016, NULL);
-- Student 7
INSERT INTO student_section (studentID, sectionID, grade) VALUES (17, 10017, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (17, 10018, NULL);
-- Student 8
INSERT INTO student_section (studentID, sectionID, grade) VALUES (18, 10011, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (18, 10019, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (18, 10013, NULL);
-- Student 9
INSERT INTO student_section (studentID, sectionID, grade) VALUES (19, 10012, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (19, 10015, NULL);
-- Student 10
INSERT INTO student_section (studentID, sectionID, grade) VALUES (20, 10013, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (20, 10015, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (20, 10019, NULL);
INSERT INTO student_section (studentID, sectionID, grade) VALUES (20, 10020, NULL);
--Terrence
insert into student_section(studentID, sectionID, grade) values (60, 10060, NULL);
insert into student_section(studentID, sectionID, grade) values (61, 10061, NULL);
insert into student_section(studentID, sectionID, grade) values (61, 10062, NULL);
insert into student_section(studentID, sectionID, grade) values (62, 10063, NULL);
insert into student_section(studentID, sectionID, grade) values (62, 10064, NULL);
insert into student_section(studentID, sectionID, grade) values (63, 10065, NULL);
insert into student_section(studentID, sectionID, grade) values (63, 10066, NULL);
insert into student_section(studentID, sectionID, grade) values (63, 10067, NULL);
insert into student_section(studentID, sectionID, grade) values (64, 10068, NULL);
insert into student_section(studentID, sectionID, grade) values (64, 10069, NULL);
insert into student_section(studentID, sectionID, grade) values (64, 10060, NULL);
insert into student_section(studentID, sectionID, grade) values (65, 10061, NULL);
insert into student_section(studentID, sectionID, grade) values (65, 10062, NULL);
insert into student_section(studentID, sectionID, grade) values (65, 10063, NULL);

-- Core Computer Science courses (common to all concentrations)
insert into major_class(majorID, classID) values('CS','CS120');
insert into major_class(majorID, classID) values('CS','CS130');
insert into major_class(majorID, classID) values('CS','CS230');
insert into major_class(majorID, classID) values('CS','CS332');
insert into major_class(majorID, classID) values('CS','CS374');
insert into major_class(majorID, classID) values('CS','ENGR210');
insert into major_class(majorID, classID) values('CS','IT220');
insert into major_class(majorID, classID) values('CS','IT221');
insert into major_class(majorID, classID) values('CS','IT310');
insert into major_class(majorID, classID) values('CS','ITC110');
insert into major_class(majorID, classID) values('CS','ITC125');
insert into major_class(majorID, classID) values('CS','ITC480');
insert into major_class(majorID, classID) values('CS','MATH185');
insert into major_class(majorID, classID) values('CS','MATH227');
insert into major_class(majorID, classID) values('CS','MATH377');

-- Software Engineering (SE) concentration courses
insert into major_class(majorID, classID) values('CS','CS330');
insert into major_class(majorID, classID) values('CS','CS352');
insert into major_class(majorID, classID) values('CS','CS375');

-- Game Development (GDP) concentration courses
insert into major_class(majorID, classID) values('CS','CS375');
insert into major_class(majorID, classID) values('CS','DET210');
insert into major_class(majorID, classID) values('CS','DET260');

-- Computing Theory (CT) concentration courses
insert into major_class(majorID, classID) values('CS','CS341');
insert into major_class(majorID, classID) values('CS','CS352');
insert into major_class(majorID, classID) values('CS','CS356');
insert into major_class(majorID, classID) values('CS','CS365');
insert into major_class(majorID, classID) values('CS','CS467');
insert into major_class(majorID, classID) values('CS','MATH186');
insert into major_class(majorID, classID) values('CS','MATH187');



insert into major_class(majorID, classID) values('ITC','ITC320');
insert into major_class(majorID, classID) values('ART', 'ART287');
insert into major_class(majorID, classID) values('ART', 'ART292');
insert into major_class(majorID, classID) values('ART', 'ART314');
insert into major_class(majorID, classID) values('ART', 'ART315');
insert into major_class(majorID, classID) values('ART', 'ART317');
insert into major_class(majorID, classID) values('ART', 'ART318');
insert into major_class(majorID, classID) values('ART', 'ART324');
insert into major_class(majorID, classID) values('ART', 'ART325');
insert into major_class(majorID, classID) values('ART', 'ART331');
insert into major_class(majorID, classID) values('ART', 'ART332');
insert into major_class(majorID, classID) values('ART', 'ART341');
insert into major_class(majorID, classID) values('ART', 'ART342');
insert into major_class(majorID, classID) values('ART', 'ART347');
insert into major_class(majorID, classID) values('ART', 'ART351');
insert into major_class(majorID, classID) values('ART', 'ART352');
insert into major_class(majorID, classID) values('ART', 'ART353');
insert into major_class(majorID, classID) values('ART', 'ART358');
insert into major_class(majorID, classID) values('ART', 'ART361');
insert into major_class(majorID, classID) values('ART', 'ART362');
insert into major_class(majorID, classID) values('ART', 'ART371');
insert into major_class(majorID, classID) values('ART', 'ART372');
insert into major_class(majorID, classID) values('ART', 'ART423');
insert into major_class(majorID, classID) values('ART', 'ART425');
insert into major_class(majorID, classID) values('ART', 'ART433');
insert into major_class(majorID, classID) values('ART', 'ART434');
insert into major_class(majorID, classID) values('ART', 'ART443');
insert into major_class(majorID, classID) values('ART', 'ART444');
insert into major_class(majorID, classID) values('ART', 'ART453');
insert into major_class(majorID, classID) values('ART', 'ART454');
insert into major_class(majorID, classID) values('ART', 'ART455');
insert into major_class(majorID, classID) values('ART', 'ART456');
insert into major_class(majorID, classID) values('ART', 'ART458');
insert into major_class(majorID, classID) values('ART', 'ART463');
insert into major_class(majorID, classID) values('ART', 'ART464');
insert into major_class(majorID, classID) values('ART', 'ART473');
insert into major_class(majorID, classID) values('ART', 'ART474');
insert into major_class(majorID, classID) values('ART', 'ART490');
insert into major_class(majorID, classID) values('ART', 'ART494');
insert into major_class(majorID, classID) values('ART', 'ART495');
insert into major_class(majorID, classID) values('ART', 'ART496');
insert into major_class(majorID, classID) values('ART', 'DSGN251');
insert into major_class(majorID, classID) values('ART', 'DSGN102');
insert into major_class(majorID, classID) values('ART', 'DSGN111');
insert into major_class(majorID, classID) values('ART', 'DSGN201');
insert into major_class(majorID, classID) values('ART', 'DSGN202');
insert into major_class(majorID, classID) values('ART', 'DSGN211');
insert into major_class(majorID, classID) values('ART', 'DSGN221');
insert into major_class(majorID, classID) values('ART', 'DSGN222');
insert into major_class(majorID, classID) values('ART', 'DSGN232');
insert into major_class(majorID, classID) values('ART', 'DSGN251');
insert into major_class(majorID, classID) values('ART', 'DSGN301');
insert into major_class(majorID, classID) values('ART', 'DSGN301');
insert into major_class(majorID, classID) values('ART', 'DSGN351');
insert into major_class(majorID, classID) values('ART', 'DSGN352');
insert into major_class(majorID, classID) values('ART', 'DSGN401');
insert into major_class(majorID, classID) values('ART', 'DSGN402');
insert into major_class(majorID, classID) values('ART', 'DSGN461');
insert into major_class(majorID, classID) values('ART', 'DSGN463');

insert into major_class(majorID, classID) values('EE', 'CHEM133');
insert into major_class(majorID, classID) values('EE', 'CHEM131');
insert into major_class(majorID, classID) values('EE', 'ENGR115');
insert into major_class(majorID, classID) values('EE', 'ENGR116');
insert into major_class(majorID, classID) values('EE', 'ENGR117');
insert into major_class(majorID, classID) values('EE', 'ENGR131');
insert into major_class(majorID, classID) values('EE', 'ENGR135');
insert into major_class(majorID, classID) values('EE', 'ENGR136');
insert into major_class(majorID, classID) values('EE', 'ENGR217');
insert into major_class(majorID, classID) values('EE', 'ENGR221');
insert into major_class(majorID, classID) values('EE', 'ENGR281');
insert into major_class(majorID, classID) values('EE', 'ENGR306');
insert into major_class(majorID, classID) values('EE', 'ENGR317');
insert into major_class(majorID, classID) values('EE', 'ENGR333');
insert into major_class(majorID, classID) values('EE', 'ENGR350');
insert into major_class(majorID, classID) values('EE', 'ENGR377');
insert into major_class(majorID, classID) values('EE', 'ENGR390');
insert into major_class(majorID, classID) values('EE', 'ENGR430');
insert into major_class(majorID, classID) values('EE', 'ENGR432');
insert into major_class(majorID, classID) values('EE', 'MATH185');
insert into major_class(majorID, classID) values('EE', 'MATH186');
insert into major_class(majorID, classID) values('EE', 'MATH286');
insert into major_class(majorID, classID) values('EE', 'MATH361');
insert into major_class(majorID, classID) values('EE', 'MATH187');
insert into major_class(majorID, classID) values('EE', 'MATH341');
insert into major_class(majorID, classID) values('EE', 'MATH325');
insert into major_class(majorID, classID) values('EE', 'MATH463');
insert into major_class(majorID, classID) values('EE', 'BIOL121');
insert into major_class(majorID, classID) values('EE', 'CHEM114');
insert into major_class(majorID, classID) values('EE', 'PHYS330');
insert into major_class(majorID, classID) values('EE', 'PHIL379');
insert into major_class(majorID, classID) values('EE', 'PHYS220');
insert into major_class(majorID, classID) values('EE', 'PHYS221');
insert into major_class(majorID, classID) values('EE', 'PHYS222');
insert into major_class(majorID, classID) values('EE', 'PHYS223');
insert into major_class(majorID, classID) values('EE', 'ENGR210');
insert into major_class(majorID, classID) values('EE', 'ENGR355');
insert into major_class(majorID, classID) values('EE', 'ENGR356');
insert into major_class(majorID, classID) values('EE', 'ENGR360');
insert into major_class(majorID, classID) values('EE', 'ENGR387');
insert into major_class(majorID, classID) values('EE', 'ENGR388');
insert into major_class(majorID, classID) values('EE', 'ENGR410');
insert into major_class(majorID, classID) values('EE', 'ENGR422');
insert into major_class(majorID, classID) values('EE', 'ENGR423');
insert into major_class(majorID, classID) values('BIBLE', 'BIBP380');
insert into major_class(majorID, classID) values('BIBLE', 'BIBP478');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBP487');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBP489');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBT332');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBT342');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBT439');
insert into major_class(majorID, classID) values ('BIBLE', 'BGRK221');
insert into major_class(majorID, classID) values ('BIBLE', 'BGRK222');
insert into major_class(majorID, classID) values ('BIBLE', 'BGRK331');
insert into major_class(majorID, classID) values ('BIBLE', 'BGRK332');
insert into major_class(majorID, classID) values ('BIBLE', 'FREN221');
insert into major_class(majorID, classID) values ('BIBLE', 'FREN222');
insert into major_class(majorID, classID) values ('BIBLE', 'GER221');
insert into major_class(majorID, classID) values ('BIBLE', 'GER222');
insert into major_class(majorID, classID) values ('BIBLE', 'SPEN221');
insert into major_class(majorID, classID) values ('BIBLE', 'SPEN222');
insert into major_class(majorID, classID) values ('BIBLE', 'BMIS420');
insert into major_class(majorID, classID) values ('BIBLE', 'BMIS371');
insert into major_class(majorID, classID) values ('BIBLE', 'BUBH380');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBH383');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBH432');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBM493');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBT379');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBT491');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL320');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL365');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL367');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL451');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL452');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL453');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL454');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL458');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL460');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL461');
insert into major_class(majorID, classID) values ('BIBLE', 'BGRK441');
insert into major_class(majorID, classID) values ('BIBLE', 'BGRK442');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBL466');
insert into major_class(majorID, classID) values ('BIBLE', 'BHEB472');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBM391');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBM429');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBM491');
insert into major_class(majorID, classID) values ('BIBLE', 'BMIS270');
insert into major_class(majorID, classID) values ('BIBLE', 'BMIS345');
insert into major_class(majorID, classID) values ('BIBLE', 'BMIS421');
insert into major_class(majorID, classID) values ('BIBLE', 'BIBP486');
-- Core Computer Science courses (common to all concentrations)
insert into major_class(majorID, classID) values('CS','CS120');
insert into major_class(majorID, classID) values('CS','CS130');
insert into major_class(majorID, classID) values('CS','CS230');
insert into major_class(majorID, classID) values('CS','CS332');
insert into major_class(majorID, classID) values('CS','CS374');
insert into major_class(majorID, classID) values('CS','ENGR210');
insert into major_class(majorID, classID) values('CS','IT220');
insert into major_class(majorID, classID) values('CS','IT221');
insert into major_class(majorID, classID) values('CS','IT310');
insert into major_class(majorID, classID) values('CS','ITC110');
insert into major_class(majorID, classID) values('CS','ITC125');
insert into major_class(majorID, classID) values('CS','ITC480');
insert into major_class(majorID, classID) values('CS','MATH185');
insert into major_class(majorID, classID) values('CS','MATH227');
insert into major_class(majorID, classID) values('CS','MATH377');
-- Software Engineering (SE) concentration courses
insert into major_class(majorID, classID) values('CS','CS330');
insert into major_class(majorID, classID) values('CS','CS352');
insert into major_class(majorID, classID) values('CS','CS375');
insert into major_class(majorID, classID) values('DET','ART105');
insert into major_class(majorID, classID) values('DET','CS115');
insert into major_class(majorID, classID) values('DET','DET210');
insert into major_class(majorID, classID) values('DET','DET310');
insert into major_class(majorID, classID) values('DET','DET350');
insert into major_class(majorID, classID) values('DET','DET410');
insert into major_class(majorID, classID) values('DET','ENGL331');
insert into major_class(majorID, classID) values('DET','ENGL332');
insert into major_class(majorID, classID) values('DET','ENGL380');
insert into major_class(majorID, classID) values('DET','ENGL472');
insert into major_class(majorID, classID) values('DET','ITC110');
insert into major_class(majorID, classID) values('DET','ITC480');
insert into major_class(majorID, classID) values('DET','JMC488');
insert into major_class(majorID, classID) values('DET','BLAW363');
insert into major_class(majorID, classID) values('DET','PHIL486');
-- English
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL301');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL311');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL320');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL321');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL322');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL323');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL324');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL325');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL326');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL327');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL328');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL329');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL330');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL331');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL332');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL333');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL351');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL362');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL363');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL376');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL377');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL378');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL380');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL410');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL432');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL441');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL443');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL446');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL447');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL448');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL449');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL459');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL464');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL470');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL471');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL472');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL473');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL481');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL483');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL484');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL495');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL496');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL497');
INSERT INTO major_class(majorID, classID) VALUES ('ENGL', 'ENGL499');
-- Criminal Justice
insert into major_class(majorID, classID) values('CJ', 'CRIM205');
insert into major_class(majorID, classID) values('CJ', 'CRIM250');
insert into major_class(majorID, classID) values('CJ', 'CRIM320');
-- Accounting
insert into major_class(majorID, classID) values('ACCT','ACCT210');
insert into major_class(majorID, classID) values('ACCT', 'BLAW363');
insert into major_class(majorID, classID) values('ACCT','BUSA120');
insert into major_class(majorID, classID) values('ACCT','ENTR120');
insert into major_class(majorID, classID) values('ACCT','ECON260');
insert into major_class(majorID, classID) values('ACCT','ECON261');
insert into major_class(majorID, classID) values('ACCT','FIN310');
insert into major_class(majorID, classID) values('ACCT','IS222');
insert into major_class(majorID, classID) values('ACCT','IT263');
insert into major_class(majorID, classID) values('ACCT','MGMT330');
insert into major_class(majorID, classID) values('ACCT','MKTG320');
insert into major_class(majorID, classID) values('ACCT','BUSA419');
insert into major_class(majorID, classID) values('ACCT','MATH130');
insert into major_class(majorID, classID) values('ACCT','ACCT304');
insert into major_class(majorID, classID) values('ACCT','ACCT302');
insert into major_class(majorID, classID) values('ACCT','ACCT310');
insert into major_class(majorID, classID) values('ACCT','ACCT311');
insert into major_class(majorID, classID) values('ACCT','ACCT324');
insert into major_class(majorID, classID) values('ACCT','ACCT405');
insert into major_class(majorID, classID) values('ACCT','ACCT410');
insert into major_class(majorID, classID) values('ACCT','BLAW461');
insert into major_class(majorID, classID) values('ACCT','MGMT439');
insert into major_class(majorID, classID) values('ACCT','CS115');
insert into major_class(majorID, classID) values('ACCT','CS116');
insert into major_class(majorID, classID) values('ACCT','ACCT499');
-- Multimedia
insert into major_class(majorID, classID) values('JMC','JMC302');
insert into major_class(majorID, classID) values('JMC','JMC303');
insert into major_class(majorID, classID) values('JMC','JMC488');
insert into major_class(majorID, classID) values('JMC','JMC165');
insert into major_class(majorID, classID) values('JMC','JMC166');
insert into major_class(majorID, classID) values('JMC','JMC342');
insert into major_class(majorID, classID) values('JMC','JMC351');
insert into major_class(majorID, classID) values('JMC','JMC224');
insert into major_class(majorID, classID) values('JMC','JMC233');
insert into major_class(majorID, classID) values('JMC','JMC261');
insert into major_class(majorID, classID) values('JMC','JMC265');
insert into major_class(majorID, classID) values('JMC','JMC321');
insert into major_class(majorID, classID) values('JMC','JMC361');
insert into major_class(majorID, classID) values('JMC','JMC421');
insert into major_class(majorID, classID) values('JMC','JMC495');
insert into major_class(majorID, classID) values('JMC','JMC338');
insert into major_class(majorID, classID) values('JMC','JMC352');
insert into major_class(majorID, classID) values('JMC','JMC355');
insert into major_class(majorID, classID) values('JMC','JMC364');
insert into major_class(majorID, classID) values('JMC','JMC365');
insert into major_class(majorID, classID) values('JMC','JMC367');
insert into major_class(majorID, classID) values('JMC','JMC390');
insert into major_class(majorID, classID) values('JMC','JMC405');
insert into major_class(majorID, classID) values('JMC','JMC465');
insert into major_class(majorID, classID) values('PSYC','PSYC120');
insert into major_class(majorID, classID) values('SOCI','SOCI111');


insert into major_class(majorID, classID) values('BIOL','BIOL312');
insert into major_class(majorID, classID) values('CHEM','CHEM333');
insert into major_class(majorID, classID) values('CHEM','CHEM334');
insert into major_class(majorID, classID) values('CHEM','CHEM355');
insert into major_class(majorID, classID) values('CHEM','CHEM356');
insert into major_class(majorID, classID) values('CHEM','CHEM443');
insert into major_class(majorID, classID) values('MATH','MATH185');
insert into major_class(majorID, classID) values('MATH','MATH186');
insert into major_class(majorID, classID) values('MATH','MATH286');
insert into major_class(majorID, classID) values('PHYS','PHYS220');
insert into major_class(majorID, classID) values('PHYS','PHYS221');
insert into major_class(majorID, classID) values('PHYS','PHYS222');
insert into major_class(majorID, classID) values('PHYS','PHYS223');

insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM205');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM250');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM320');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM330');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM365');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM420');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM430');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM455');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM499');
insert into major_class (majorID, classID) VALUES ('CJ', 'SPAN221');
insert into major_class (majorID, classID) VALUES ('CJ', 'SPAN222');
insert into major_class (majorID, classID) VALUES ('CJ', 'GOVT225');
insert into major_class (majorID, classID) VALUES ('CJ', 'GOVT384');
insert into major_class (majorID, classID) VALUES ('CJ', 'GOVT432');
insert into major_class (majorID, classID) VALUES ('CJ', 'GOVT487');
insert into major_class (majorID, classID) VALUES ('CJ', 'SOCI388');
insert into major_class (majorID, classID) VALUES ('CJ', 'SOCI415');
insert into major_class (majorID, classID) VALUES ('CJ', 'GOVT315');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM350');
insert into major_class (majorID, classID) VALUES ('CJ', 'CRIM370');
insert into major_class (majorID, classID) VALUES ('CJ', 'SOCI355');




INSERT INTO and_prereq (course, prereq) VALUES ('CS332','CS130');
INSERT INTO and_prereq (course, prereq) VALUES ('CS332','MATH185');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 133','MATH 124');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 131','MATH 124');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 132','CHEM 133');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 134','CHEM 133');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 221','CHEM 134');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 223','CHEM 134');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 322','CHEM 223');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 324','CHEM 223');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 453','CHEM 324');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 454','CHEM 453');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 456','CHEM 453');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 463','CHEM 453');
INSERT INTO and_prereq (course, prereq) VALUES ('BIOL 123','BIOL 121');
INSERT INTO and_prereq (course, prereq) VALUES ('BIOL 124','BIOL 122');
INSERT INTO and_prereq (course, prereq) VALUES ('BIOL 312','BIOL 123');
INSERT INTO and_prereq (course, prereq) VALUES ('BIOL 312','BIOL 121');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 333','CHEM 324');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 334','CHEM 333');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 335','CHEM 322');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 356','CHEM 332');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 443','CHEM 324');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH 185','MATH 124');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH 186','MATH 185');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM 286','MATH 186');
INSERT INTO and_prereq (course, prereq) VALUES ('PHYS 220','MATH 185');
INSERT INTO and_prereq (course, prereq) VALUES ('PHYS 221','PHYS 220');
INSERT INTO and_prereq (course, prereq) VALUES ('PHYS 222','PHYS 220');
INSERT INTO and_prereq (course, prereq) VALUES ('PHYS 223','PHYS 222');
INSERT INTO and_prereq (course, prereq) VALUES ('FIN310','ACCT210');
INSERT INTO and_prereq (course, prereq) VALUES ('FIN310','MATH130');
INSERT INTO and_prereq (course, prereq) VALUES ('IS222','MATH130');
INSERT INTO and_prereq (course, prereq) VALUES ('IT263','IS222');
INSERT INTO and_prereq (course, prereq) VALUES ('MKTG419','MKTG320');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH185','MATH124');
INSERT INTO and_prereq (course, prereq) VALUES ('ACCT302','ACCT210');
INSERT INTO and_prereq (course, prereq) VALUES ('ACCT304','ACCT210');
INSERT INTO and_prereq (course, prereq) VALUES ('ACCT310','ACCT210');
INSERT INTO and_prereq (course, prereq) VALUES ('ACCT311','ACCT310');
INSERT INTO and_prereq (course, prereq) VALUES ('ACCT324','ACCT210');
INSERT INTO and_prereq (course, prereq) VALUES ('ACCT324','BUSA120');
INSERT INTO and_prereq (course, prereq) VALUES ('ACCT405','ACCT311');
INSERT INTO and_prereq (course, prereq) VALUES ('ACCT410','ACCT311');
INSERT INTO and_prereq (course, prereq) VALUES ('BLAW461','ACCT310');
INSERT INTO and_prereq (course, prereq) VALUES ('DSGN201','DSGN111');
INSERT INTO and_prereq (course, prereq) VALUES ('DSGN202','DSGN201');
INSERT INTO and_prereq (course, prereq) VALUES ('DSGN211','DSGN111');
INSERT INTO and_prereq (course, prereq) VALUES ('DSGN211','ART105');
INSERT INTO and_prereq (course, prereq) VALUES ('DSGN301','DSGN202');
INSERT INTO and_prereq (course, prereq) VALUES ('DSGN302','DSGN301');
INSERT INTO and_prereq (course, prereq) VALUES ('DSGN401','DSGN302');
INSERT INTO and_prereq (course, prereq) VALUES ('DSGN401','DSGN351');
INSERT INTO and_prereq (course, prereq) VALUES ('DSGN402','DSGN401');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM133','CHEM131');
INSERT INTO and_prereq (course, prereq) VALUES ('CHEM133','MATH109');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR115','MATH124');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR116','MATH124');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR135','MATH185');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR220','PHYS220');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR220','PHYS221');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR220','MATH186');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR222','ENGR220');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR222','MATH286');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR281','PHYS222');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR281','MATH186');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR306','ENGL112');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR333','ENGR220');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR350','MATH131');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR390','ENGR342');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR430','ENGR390');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR432','ENGR430');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH185','MATH124');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH186','MATh185');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH286','MATH186');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH361','MATH186');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH187','MATH131');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH341','MATH186');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH341','CS120');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH325','MATH186');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH463','MATH286');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH463','MATH361');
INSERT INTO and_prereq (course, prereq) VALUES ('PSYC351','PSYC368');
INSERT INTO and_prereq (course, prereq) VALUES ('PSYC451','PSYC351');
INSERT INTO and_prereq (course, prereq) VALUES ('PSYC485','PSYC382');
INSERT INTO and_prereq (course, prereq) VALUES ('PSYC305','ENGL111');
INSERT INTO and_prereq (course, prereq) VALUES ('PSYC343','PSYC368');
INSERT INTO and_prereq (course, prereq) VALUES ('PSYC451','PSYC351');
INSERT INTO and_prereq (course, prereq) VALUES ('PSYC471','PSYC241');
INSERT INTO and_prereq (course, prereq) VALUES ('PSYC485','PSYC382');
INSERT INTO and_prereq (course, prereq) VALUES ('CRIM250','CRIM205');
INSERT INTO and_prereq (course, prereq) VALUES ('CRIM320','CRIM205');
INSERT INTO and_prereq (course, prereq) VALUES ('CRIM330','CRIM205');
INSERT INTO and_prereq (course, prereq) VALUES ('CRIM365','CRIM205');
INSERT INTO and_prereq (course, prereq) VALUES ('CRIM420','CRIM205');
INSERT INTO and_prereq (course, prereq) VALUES ('CRIM430','CRIM205');
INSERT INTO and_prereq (course, prereq) VALUES ('CRIM455','CRIM205');
INSERT INTO and_prereq (course, prereq) VALUES ('SPAN221','SPAN112');
INSERT INTO and_prereq (course, prereq) VALUES ('SPAN222','SPAN221');
INSERT INTO and_prereq (course, prereq) VALUES ('GOVT487','GOVT227');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT332','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT342','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT439','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BGRK222','BGRK221');
INSERT INTO and_prereq (course, prereq) VALUES ('BGRK331','BGRK222');
INSERT INTO and_prereq (course, prereq) VALUES ('BGRK332','BGRK331');
INSERT INTO and_prereq (course, prereq) VALUES ('FREN221','FREN112');
INSERT INTO and_prereq (course, prereq) VALUES ('FREN222','FREN221 ');
INSERT INTO and_prereq (course, prereq) VALUES ('GER221','GER112 ');
INSERT INTO and_prereq (course, prereq) VALUES ('GER222','GER221');
INSERT INTO and_prereq (course, prereq) VALUES ('SPAN221','SPAN112');
INSERT INTO and_prereq (course, prereq) VALUES ('SPAN222','SPAN221');
INSERT INTO and_prereq (course, prereq) VALUES ('BMIS420','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BMIS371','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBH380','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBH383','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBH432','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM493','BIBL320');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT379','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT491','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL320','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL365','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL367','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL451','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL452','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL453','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL454','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL458','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL460','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL461','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BGRK441','BGRK 332');
INSERT INTO and_prereq (course, prereq) VALUES ('BGRK442','BGRK 441');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBL466','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BHEB472','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM391','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM429','BIBM391');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM491','BIBM429');
INSERT INTO and_prereq (course, prereq) VALUES ('BMIS345','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BMIS241','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BMIS371','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('SMIS420','BIBM211');
INSERT INTO and_prereq (course, prereq) VALUES ('CS120','MATH109');
INSERT INTO and_prereq (course, prereq) VALUES ('CS130','CS120');
INSERT INTO and_prereq (course, prereq) VALUES ('CS332','CS130');
INSERT INTO and_prereq (course, prereq) VALUES ('CS332','MATH185');
INSERT INTO and_prereq (course, prereq) VALUES ('CS374','CS230');
INSERT INTO and_prereq (course, prereq) VALUES ('IT310','IT221');
INSERT INTO and_prereq (course, prereq) VALUES ('CS341','MATH186');
INSERT INTO and_prereq (course, prereq) VALUES ('CS341','CS120');
INSERT INTO and_prereq (course, prereq) VALUES ('CS352','CS230');
INSERT INTO and_prereq (course, prereq) VALUES ('CS356','CS220');
INSERT INTO and_prereq (course, prereq) VALUES ('CS356','ENGR210');
INSERT INTO and_prereq (course, prereq) VALUES ('CS365','CS332');
INSERT INTO and_prereq (course, prereq) VALUES ('CS365','MATH227');
INSERT INTO and_prereq (course, prereq) VALUES ('CS467','CS332');
INSERT INTO and_prereq (course, prereq) VALUES ('CS467','MATH227');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH186','MATh185');
INSERT INTO and_prereq (course, prereq) VALUES ('MATH185','MATH124');
INSERT INTO and_prereq (course, prereq) VALUES ('CS375','CS374');
INSERT INTO and_prereq (course, prereq) VALUES ('DET260','CS116');
INSERT INTO and_prereq (course, prereq) VALUES ('DET260','CS118');
INSERT INTO and_prereq (course, prereq) VALUES ('DET260','CS130');
INSERT INTO and_prereq (course, prereq) VALUES ('DET260','DET220');
INSERT INTO and_prereq (course, prereq) VALUES ('CS330','ITC125');
INSERT INTO and_prereq (course, prereq) VALUES ('IT325','CS116');
INSERT INTO and_prereq (course, prereq) VALUES ('IS432','IS222');
INSERT INTO and_prereq (course, prereq) VALUES ('CS315','IT220');
INSERT INTO and_prereq (course, prereq) VALUES ('CS136','DET260');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGR442','CS120');
INSERT INTO and_prereq (course, prereq) VALUES ('IS222','MATH130');
INSERT INTO and_prereq (course, prereq) VALUES ('IS324','ISO324');
INSERT INTO and_prereq (course, prereq) VALUES ('IS330','IS222');
INSERT INTO and_prereq (course, prereq) VALUES ('IS410','IS324');
INSERT INTO and_prereq (course, prereq) VALUES ('IS442','CS115');
INSERT INTO and_prereq (course, prereq) VALUES ('IS442','IS222');
INSERT INTO and_prereq (course, prereq) VALUES ('IS442','IS432');
INSERT INTO and_prereq (course, prereq) VALUES ('DET255','DET220');
INSERT INTO and_prereq (course, prereq) VALUES ('DET260','DET220');
INSERT INTO and_prereq (course, prereq) VALUES ('DET315','DET255');
INSERT INTO and_prereq (course, prereq) VALUES ('DET320','DET220');
INSERT INTO and_prereq (course, prereq) VALUES ('DET330','DET220');
INSERT INTO and_prereq (course, prereq) VALUES ('DET350','DET210');
INSERT INTO and_prereq (course, prereq) VALUES ('DET360','DET260');
INSERT INTO and_prereq (course, prereq) VALUES ('DET365','DET260');
INSERT INTO and_prereq (course, prereq) VALUES ('DET370','DET210');
INSERT INTO and_prereq (course, prereq) VALUES ('ART317','ART105');
INSERT INTO and_prereq (course, prereq) VALUES ('ART317','ART112');
INSERT INTO and_prereq (course, prereq) VALUES ('ART112','ART111');
INSERT INTO and_prereq (course, prereq) VALUES ('ART318','ART105');
INSERT INTO and_prereq (course, prereq) VALUES ('ART318','ART317');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGL107','ENGL106');
INSERT INTO and_prereq (course, prereq) VALUES ('ENGL107','ENGL006');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC166','JMC165');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC342','JMC166');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC351','JMC342');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC488','JMC224');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC224','JMC100');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC233','JMC166');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC261','JMC166');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC265','JMC166');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC321','JMC224');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC361','JMC265');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC421','JMC261');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC421','JMC266');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT342','BIBL101');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT342','BIBL102');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT342','BIBL103');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT379','BIBL101');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT379','BIBL102');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBT379','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM401','BIBL101');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM401','BIBL102');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM401','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM403','BIBL101');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM403','BIBL102');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM403','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM480','BIBL101');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM480','BIBL102');
INSERT INTO and_prereq (course, prereq) VALUES ('BIBM480','BIBL211');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC338','JMC166');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC338','JMC224');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC352','JMC351');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC365','JMC265');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC390','JMC342');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC390','JMC348');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC405','JMC351');
INSERT INTO and_prereq (course, prereq) VALUES ('JMC405','JMC361');
INSERT INTO or_prereq (course, prereq) VALUES ('CS230','CS118');
INSERT INTO or_prereq (course, prereq) VALUES ('CS230','CS130');
INSERT INTO or_prereq (course, prereq) VALUES ('PSYC 370','PSYC 120');
INSERT INTO or_prereq (course, prereq) VALUES ('PSYC 370','SOCI 111');
INSERT INTO or_prereq (course, prereq) VALUES ('PSYC 374','SPED 371');
INSERT INTO or_prereq (course, prereq) VALUES ('PSYC 374','PSYC 232');
INSERT INTO or_prereq (course, prereq) VALUES ('FIN310','ECON260');
INSERT INTO or_prereq (course, prereq) VALUES ('FIN310','ECON261');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH130','MATH109');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH130','MATH120');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH130','MATH123');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH131','MATH109');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH131','MATW109');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH131','MATH130');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBP380','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBP380','BIBL103');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBP478','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBP486','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBP486','BIBL103');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBP487','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBP487','BIBL103');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBP489','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBP489','BIBL103');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBL365','BGRK 221');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBL365','BGRK 222');
INSERT INTO or_prereq (course, prereq) VALUES ('CS120','MATW109');
INSERT INTO or_prereq (course, prereq) VALUES ('CS120','MATH124');
INSERT INTO or_prereq (course, prereq) VALUES ('CS120','MATH185');
INSERT INTO or_prereq (course, prereq) VALUES ('CS120','CS115');
INSERT INTO or_prereq (course, prereq) VALUES ('CS230','CS118');
INSERT INTO or_prereq (course, prereq) VALUES ('CS230','CS130');
INSERT INTO or_prereq (course, prereq) VALUES ('IT220','CS115');
INSERT INTO or_prereq (course, prereq) VALUES ('IT220','CS117');
INSERT INTO or_prereq (course, prereq) VALUES ('IT220','CS120');
INSERT INTO or_prereq (course, prereq) VALUES ('IT221','CS115');
INSERT INTO or_prereq (course, prereq) VALUES ('IT117','CS117');
INSERT INTO or_prereq (course, prereq) VALUES ('IT221','CS120');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH187','MATH131');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH187','MATH185');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH227','CS120');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH227','MATH185');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH337','MATH131');
INSERT INTO or_prereq (course, prereq) VALUES ('MATH337','MATH185');
INSERT INTO or_prereq (course, prereq) VALUES ('DET260','CS116');
INSERT INTO or_prereq (course, prereq) VALUES ('DET260','CS118');
INSERT INTO or_prereq (course, prereq) VALUES ('DET260','CS130');
INSERT INTO or_prereq (course, prereq) VALUES ('DET260','DET220');
INSERT INTO or_prereq (course, prereq) VALUES ('CS330','MKTG320');
INSERT INTO or_prereq (course, prereq) VALUES ('CS330','ART351');
INSERT INTO or_prereq (course, prereq) VALUES ('IT325','CS116');
INSERT INTO or_prereq (course, prereq) VALUES ('IT325','CS118');
INSERT INTO or_prereq (course, prereq) VALUES ('IT325','CS130');
INSERT INTO or_prereq (course, prereq) VALUES ('IS432','IS337');
INSERT INTO or_prereq (course, prereq) VALUES ('IS432','PSYC311');
INSERT INTO or_prereq (course, prereq) VALUES ('IS432','SOCI416');
INSERT INTO or_prereq (course, prereq) VALUES ('IS432','MKTG432');
INSERT INTO or_prereq (course, prereq) VALUES ('CS315','CS116');
INSERT INTO or_prereq (course, prereq) VALUES ('CS315','CS118');
INSERT INTO or_prereq (course, prereq) VALUES ('CS315','CS130');
INSERT INTO or_prereq (course, prereq) VALUES ('IS405','IS324');
INSERT INTO or_prereq (course, prereq) VALUES ('IT225','CS116');
INSERT INTO or_prereq (course, prereq) VALUES ('IT225','CS120');
INSERT INTO or_prereq (course, prereq) VALUES ('DET260','CS116');
INSERT INTO or_prereq (course, prereq) VALUES ('DET260','CS118');
INSERT INTO or_prereq (course, prereq) VALUES ('DET260','CS130');
INSERT INTO or_prereq (course, prereq) VALUES ('DET410','DET350');
INSERT INTO or_prereq (course, prereq) VALUES ('DET410','ITC499');
INSERT INTO or_prereq (course, prereq) VALUES ('JMC495','JMC347');
INSERT INTO or_prereq (course, prereq) VALUES ('JMC495','JMC348');
INSERT INTO or_prereq (course, prereq) VALUES ('JMC495','JMC324');
INSERT INTO or_prereq (course, prereq) VALUES ('JMC495','JMC265');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBL342','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBL342','BIBL103');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBL379','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBL379','BIBL103');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBM401','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBM401','BIBL103');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBM403','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBM403','BIBL103');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBM480','BIBL102');
INSERT INTO or_prereq (course, prereq) VALUES ('BIBM480','BIBL103');
INSERT INTO or_prereq (course, prereq) VALUES ('JMC355','JMC261');
INSERT INTO or_prereq (course, prereq) VALUES ('JMC355','JMC265');
INSERT INTO or_prereq (course, prereq) VALUES ('JMC465','JMC261');
INSERT INTO or_prereq (course, prereq) VALUES ('JMC465','JMC338');
INSERT INTO coreq(course, prereq) VALUES ('ENGR442','ENGR423');





insert into student_major(studentID, major) values (90,'CS');
insert into student_major(studentID, major) values (2,'IS');
insert into student_major(studentID, major) values (3,'DET');
insert into student_major(studentID, major) values (4,'BIBLE');
insert into student_major(studentID, major) values (81, 'ART');
insert into student_major(studentID, major) values (82, 'BBA');
insert into student_major(studentID, major) values (83, 'CJ');
insert into student_major(studentID, major) values (84, 'BM');
insert into student_major(studentID, major) values (85, 'EE');
insert into student_major(studentID, major) values (86, 'PSYC');
insert into student_major(studentID, major) values (87, 'BIO');
insert into student_major(studentID, major) values (88, 'PSYC');
-- select *from student_major;
insert into student_major(studentID, major) values (1, 'ART');
insert into student_major(studentID, major) values (2, 'ART');
insert into student_major(studentID, major) values (3, 'ART');
insert into student_major(studentID, major) values (4, 'ART');
insert into student_major(studentID, major) values (5, 'ART');
insert into student_major(studentID, major) values (6, 'ART');
insert into student_major(studentID, major) values (7, 'ART');
insert into student_major(studentID, major) values (8, 'ART');
insert into student_major(studentID, major) values (9, 'ART');
insert into student_major(studentID, major) values (10, 'ART');
insert into student_major(studentID, major) values (11, 'EE');
insert into student_major(studentID, major) values (12, 'EE');
insert into student_major(studentID, major) values (13, 'EE');
insert into student_major(studentID, major) values (14, 'EE');
insert into student_major(studentID, major) values (15, 'EE');
insert into student_major(studentID, major) values (16, 'EE');
insert into student_major(studentID, major) values (17, 'EE');
insert into student_major(studentID, major) values (18, 'EE');
insert into student_major(studentID, major) values (19, 'EE');
insert into student_major(studentID, major) values (20, 'EE');

INSERT INTO concentration(id, major, title, reqtext) VALUES ('SE','CS','Software Engineering','Minimum grade of C in CS 120, CS 130, CS 230; IT 220, IT 221; MATH 227');
INSERT INTO concentration(id, major, title, reqtext) VALUES ('CT','CS','Computing Theory','Minimum grade of C in CS 120, CS 130, CS 230; IT 220, IT 221; MATH 227');
INSERT INTO concentration(id, major, title, reqtext) VALUES ('GDP','CS','Game Development','Minimum grade of C in CS 120, CS 130, CS 230; IT 220, IT 221; MATH 227');
INSERT INTO concentration(id, major, title, reqtext) VALUES ('ANRP', 'ACCT', 'Analytics and Reporting', 'Minimum grade of C in ACCT 210, ACCT 220, ACCT 230, ACCT 240, ACCT 250');
INSERT INTO concentration(id, major, title, reqtext) VALUES ('ACCG', 'ACCT', 'General Accounting', 'Minimum grade of C in ACCT 210, ACCT 220, ACCT 230, ACCT 240, ACCT 250');
INSERT INTO concentration(id, major, title, reqtext) VALUES ('BLAN', 'BBMN', 'Biblical Languages', 'Minimum grade of C in all 300-level or above Bible classes.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BIBL', 'BBMN', 'Biblical Text','Minimum grade of C in all 300-level or above Bible classes.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BIBM', 'BBMN', 'Christian Ministry', 'Minimum grade of C in all 300-level or above Bible classes.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BMIS', 'BBMN', 'Missions', 'Minimum grade of C in all 300-level or above Bible classes.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BANL', 'MGMT', 'Analytics', 'Minimum of C in each business and emphases course.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BABL', 'MGMT','Business Leadership', 'Minimum of C in each business and emphases course.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('EN', 'MGMT','Entrepreneurship', 'Minimum of C in each business and emphases course.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('HR', 'MGMT','Human Resources Management', 'Minimum of C in each business and emphases course.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BIND', 'MGMT','Interdisciplinary', 'Minimum of C in each business and emphases course.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BOPR', 'MGMT','Operations', 'Minimum of C in each business and emphases course.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BCHC','BCH','ACS','Minimum GPA of 2.0');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BCBS','BCH','Biomedical Science','Minimum GPA of 2.0');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('BCHV','BCH','Pre-Vet','Minimum GPA of 2.0');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('VP', 'DET', 'Virtual Production', 'Minimum grade of C in CS117, DET210, DET260, and DET410. Two portfolio reviews.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('GD', 'DET', 'Game Development', 'Minimum grade of C in CS117, DET210, DET260, and DET410. Two portfolio reviews.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('IART', 'INAD', 'Art and Design', 'Minimum grade of C in art and design courses.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('IBUS', 'INAD', 'Business', 'Minimum grade of C in art and design courses.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('FLM', 'JMM', 'Film', 'Minimum GPA for graduation of 2.25.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('MM', 'JMM', 'Media Ministry', 'Minimum GPA for graduation of 2.25.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('ISAS', 'IS', 'Accounting Systems', 'Minimum grade of C in each business course.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('ISAN', 'IS', 'Analytics', 'Minimum grade of C in each business course.');
INSERT INTO concentration(id, major, title, reqtext)  VALUES ('ISAD', 'IS', 'Application Development', 'Minimum grade of C in each business course.');

-- 1.  Minimum passing grade for each course (default 'C')
DROP VIEW IF EXISTS course_min_grade;
CREATE VIEW course_min_grade AS
SELECT
    id          AS course_id,
    title       AS course_name,
    'C'         AS minimum_required_grade     -- default assumption
FROM course;

-- 2.  Concentrations available for every major
DROP VIEW IF EXISTS major_concentrations;
CREATE VIEW major_concentrations AS
SELECT
    m.id            AS major_id,
    m.title         AS major_name,
    c.title         AS concentration_name
FROM concentration  c
JOIN major          m ON m.id = c.major;

-- 3.  Credit‑hour progress toward a student’s active major
DROP VIEW IF EXISTS major_completion;
CREATE VIEW major_completion AS
WITH passed AS (
    SELECT
        ss.studentID,
        sec.courseID
    FROM student_section ss
    JOIN section       sec ON sec.crn = ss.sectionID
    WHERE ss.grade IS NOT NULL            -- treat any recorded grade as “passed”
)
SELECT
    s.id                                 AS student_id,
    m.id                                 AS major_id,
    m.title                              AS major_name,
    SUM(co.hrs)                          AS hours_completed,
    m.hrs                                AS hours_required,
    (m.hrs - COALESCE(SUM(co.hrs),0))    AS hours_remaining
FROM student          s
JOIN student_major    sm  ON sm.studentID = s.id
JOIN major            m   ON m.id        = sm.major
LEFT JOIN passed           p   ON p.studentID = s.id
LEFT JOIN course           co  ON co.id       = p.courseID
GROUP BY s.id, m.id, m.title, m.hrs;

-- 4.  All classes a student is enrolled in (past or present)
DROP VIEW IF EXISTS student_classes;
CREATE VIEW student_classes AS
SELECT
    s.id              AS student_id,
    sec.crn           AS section_crn,
    c.id              AS course_id,
    c.title           AS course_name,
    sec.term,
    sec.days,
    sec.room,
    ss.grade
FROM student_section ss
JOIN section         sec ON sec.crn   = ss.sectionID
JOIN course           c  ON c.id      = sec.courseID
JOIN student          s  ON s.id      = ss.studentID;

-- 5.  Current semester credit‑hour load
DROP VIEW IF EXISTS current_hours;
CREATE VIEW current_hours AS
SELECT
    s.id                AS student_id,
    SUM(c.hrs)          AS current_hours
FROM student_section ss
JOIN section       sec ON sec.crn = ss.sectionID
JOIN course         c  ON c.id   = sec.courseID
JOIN student        s  ON s.id   = ss.studentID
-- Treat the TERM that matches today’s calendar year/semester as “current”
WHERE (strftime('%Y', 'now') = substr(sec.term, -4))
GROUP BY s.id;

-- 6.  The department a student’s primary major is housed in
DROP VIEW IF EXISTS student_department;
CREATE VIEW student_department AS
SELECT
    s.id          AS student_id,
    d.id          AS department_id,
    d.name        AS department_name
FROM student        s
JOIN student_major  sm ON sm.studentID = s.id
JOIN major          m  ON m.id        = sm.major
JOIN department     d  ON d.id        = m.deptID;

-- 7.  Professors historically teaching or affiliated with a course (joined by department)
DROP VIEW IF EXISTS course_professors;
CREATE VIEW course_professors AS
SELECT DISTINCT
    c.id          AS course_id,
    c.title       AS course_name,
    t.id          AS professor_id,
    t.firstname,
    t.lastname
FROM course     c
JOIN teachers   t ON t.departmentID = c.department;

-- 8.  All majors a student has declared
DROP VIEW IF EXISTS student_majors;
CREATE VIEW student_majors AS
SELECT
    s.id        AS student_id,
    m.id        AS major_id,
    m.title     AS major_name
FROM student            s
JOIN student_major      sm ON sm.studentID = s.id
JOIN major              m  ON m.id        = sm.major;

-- 9.  Required courses for a student’s major that they still need
DROP VIEW IF EXISTS remaining_major_courses;
CREATE VIEW remaining_major_courses AS
WITH taken AS (
    SELECT DISTINCT
        ss.studentID,
        sec.courseID
    FROM student_section ss
    JOIN section sec ON sec.crn = ss.sectionID
)
SELECT
    s.id        AS student_id,
    m.id        AS major_id,
    c.id        AS course_id,
    c.title     AS course_name
FROM student          s
JOIN student_major    sm  ON sm.studentID = s.id
JOIN major            m   ON m.id        = sm.major
JOIN major_class      mc  ON mc.majorID  = m.id
JOIN course           c   ON c.id        = mc.classID
LEFT JOIN taken       t   ON t.studentID = s.id AND t.courseID = c.id
WHERE t.courseID IS NULL;

-- 10.  Enrollment head‑count by teaching department (any term)
DROP VIEW IF EXISTS department_enrollment_count;
CREATE VIEW department_enrollment_count AS
SELECT
    d.id                          AS department_id,
    d.name                        AS department_name,
    COUNT(DISTINCT ss.studentID)  AS enrolled_students
FROM department     d
JOIN course         c  ON c.department = d.id
JOIN section        sec ON sec.courseID = c.id
JOIN student_section ss  ON ss.sectionID = sec.crn
GROUP BY d.id, d.name;

-- 11.  All professors in a department
DROP VIEW IF EXISTS department_professors;
CREATE VIEW department_professors AS
SELECT
    d.id          AS department_id,
    d.name        AS department_name,
    t.id          AS professor_id,
    t.firstname,
    t.lastname,
    t.adjunct
FROM department d
JOIN teachers   t ON t.departmentID = d.id;

-- 12.  Courses tied to a major (un‑sequenced “semester plan”)
DROP VIEW IF EXISTS major_semester_courses;
CREATE VIEW major_semester_courses AS
SELECT
    m.id      AS major_id,
    c.id      AS course_id,
    c.title   AS course_name,
    c.hrs
FROM major_class mc
JOIN major       m ON m.id = mc.majorID
JOIN course      c ON c.id = mc.classID;

-- 13.  Historical & upcoming offerings of every course
DROP VIEW IF EXISTS course_offerings;
CREATE VIEW course_offerings AS
SELECT
    c.id      AS course_id,
    c.title   AS course_name,
    sec.crn   AS section_crn,
    sec.term,
    sec.days,
    sec.room,
    sec.startdate,
    sec.enddate
FROM course   c
JOIN section  sec ON sec.courseID = c.id;

-- 14.  Count of required courses for each major
DROP VIEW IF EXISTS major_required_courses_count;
CREATE VIEW major_required_courses_count AS
SELECT
    m.id                AS major_id,
    m.title             AS major_name,
    COUNT(mc.classID)   AS required_course_count,
    m.hrs               AS required_hours
FROM major m
LEFT JOIN major_class mc ON mc.majorID = m.id
GROUP BY m.id, m.title, m.hrs;

-- 15.  Courses a student has that also satisfy some other major (for “what transfers?” questions)
DROP VIEW IF EXISTS transferable_courses;
CREATE VIEW transferable_courses AS
WITH student_courses AS (
    SELECT DISTINCT
        s.id        AS student_id,
        sec.courseID
    FROM student_section ss
    JOIN section sec ON sec.crn = ss.sectionID
    JOIN student s   ON s.id   = ss.studentID
)
SELECT
    sc.student_id,
    m.id          AS potential_major,
    c.id          AS course_id,
    c.title       AS course_name
FROM student_courses sc
JOIN major_class   mc ON mc.classID = sc.courseID
JOIN major         m  ON m.id       = mc.majorID
JOIN course        c  ON c.id       = sc.courseID
ORDER BY sc.student_id, m.id, c.id;

-- 16.  Room assignment for each student’s classes
DROP VIEW IF EXISTS student_class_rooms;
CREATE VIEW student_class_rooms AS
SELECT
    s.id        AS student_id,
    c.id        AS course_id,
    c.title     AS course_name,
    sec.room
FROM student_section ss
JOIN section sec ON sec.crn = ss.sectionID
JOIN course  c   ON c.id    = sec.courseID
JOIN student s   ON s.id    = ss.studentID;

-- 17.  Professors associated with a student’s major
DROP VIEW IF EXISTS major_professors;
CREATE VIEW major_professors AS
SELECT DISTINCT
    m.id          AS major_id,
    t.id          AS professor_id,
    t.firstname,
    t.lastname
FROM major       m
JOIN department  d ON d.id = m.deptID
JOIN teachers    t ON t.departmentID = d.id;

-- 18.  Simple GPA requirement evaluator (assume 4.0 scale & major.gpa column is required GPA)
DROP VIEW IF EXISTS required_gpa_calc;
CREATE VIEW required_gpa_calc AS
SELECT
    s.id            AS student_id,
    m.id            AS major_id,
    m.gpa           AS required_major_gpa
FROM student            s
JOIN student_major      sm ON sm.studentID = s.id
JOIN major              m  ON m.id        = sm.major;

-- 19.  Human‑readable schedule block for student’s current classes
DROP VIEW IF EXISTS student_current_class_schedule;
CREATE VIEW student_current_class_schedule AS
SELECT
    s.id            AS student_id,
    c.id            AS course_id,
    c.title         AS course_name,
    sec.days,
    sec.room,
    sec.term,
    sec.startdate,
    sec.enddate
FROM student_section ss
JOIN section sec ON sec.crn = ss.sectionID
JOIN course  c   ON c.id    = sec.courseID
JOIN student s   ON s.id    = ss.studentID
WHERE (strftime('%Y', 'now') = substr(sec.term, -4));
