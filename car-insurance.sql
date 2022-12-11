CREATE TABLE car_owner
 (
SSN VARCHAR(9) NOT NULL PRIMARY KEY CHECK (LENGTH(SSN) = 9 AND SSN NOT LIKE '%[^0-9]%'), 
first_name VARCHAR(20) NOT NULL,
 middle_name VARCHAR(20), 
last_name VARCHAR(20) NOT NULL,
 gender VARCHAR(9) CHECK (gender IN ('Male','Female','Nonbinary')),
 date_of_birth DATE,
email VARCHAR(320) NOT NULL UNIQUE, 
phone VARCHAR(10) NOT NULL
)


INSERT INTO car_owner (SSN, first_name, middle_name, last_name, gender, date_of_birth, email, phone) VALUES
('493829382', 'James', '', 'Born', 'Male', '1975-03-12', 'jamesborn@gmail.com', '3859374394'),
('294857204', 'Abbey', '', 'Edward', 'Nonbinary', '1964-09-21', 'abbeyedward@gmail.com', '9348509340'),
('934857920', 'Agena', '', 'Keiko', 'Female', '1993-05-21', 'agenakeiko@gmail.com', '9435864130'),
('849348571', 'Alba', '', 'Jessica', 'Female', '1979-12-21', 'albajessica@gmail.com', '9483758202') ;



CREATE TABLE car
(
VIN VARCHAR(50) PRIMARY KEY NOT NULL,
year INTEGER NOT NULL, 
model VARCHAR(50) NOT NULL,
SSN VARCHAR(9) NOT NULL CHECK (LENGTH(SSN) = 9 AND SSN NOT LIKE
'%[^0-9]%'),
policy_name VARCHAR(255) NOT NULL,
body_style VARCHAR(30) NOT NULL,
FOREIGN KEY (SSN) REFERENCES car_owner ON DELETE CASCADE,
FOREIGN KEY (policy_name) REFERENCES policy ON DELETE SET NULL
)

INSERT INTO car VALUES                       
("KNAGM4A73E5459892", 2020, "Toyota Camry", "934857920", 'policy-2', "black"),
('JT2DB02T4V0027186', 2021, "Ford Explorer", "493829382", 'policy-2', "white" ),
('2HNYD18641H564733', 2015, "Mercedes C-Class", '849348571', 'policy-1', "red"),
('2XP5DB9X54M825433', 2018, "Toyota Rav4"  ,'493829382', 'policy-4', "gray"),
('2G1FK1EJ0A9270857', 2009,  " Lexus GS 350", '294857204', 'policy-2', "green"),
("1ZVHT80N795152147", 2015 , "Lexus RX 350", "849348571", "policy-1", "white"),
("1J8GL58K43W572871", 2019, "Tesla Model 3" , "493829382", "policy-4", "gray")

CREATE TABLE incident 
(
remark	TEXT NOT NULL DEFAULT ,
date	DATE NOT NULL,
damage_cost	DECIMAL(10, 2) NOT NULL CHECK("damage_cost" > 0),
VIN	VARCHAR(50) NOT NULL,
FOREIGN KEY("VIN") REFERENCES "car" ON DELETE CASCADE
)

INSERT INTO incident (remark, date, damage_cost, VIN) VALUES
('Crash into a tree', '2020-02-21', 2000.00, 'JT2DB02T4V0027186'),
('Crash into a lake', '2020-02-22' , 4050.00, '2XP5DB9X54M825433'),
('Flew off a bridge.', '2020-03-11', 10000.00, '2XP5DB9X54M825433'),
('Crash into a street light', '2020-02-23', 6000.00, '1J8GL58K43W572871'),
("Hit by a semi-truck", '2019-12-31', 4000.00, "1ZVHT80N795152147"),
("Scratch by a shopping cart", '2020-04-30', 4500.00, '1ZVHT80N795152147') ;

CREATE TABLE payment
(
SSN VARCHAR(9) NOT NULL,
VIN VARCHAR(50) NOT NULL,
confirmation_number VARCHAR(15) NOT NULL PRIMARY KEY,
payment_date DATE,
due_date DATE NOT NULL,
payment_amount DECIMAL(10, 2) NOT NULL CHECK (payment_amount > 0),
coverage_time_day INTEGER NOT NULL CHECK (coverage_time_day > 0),
policy_name VARCHAR(255) NOT NULL,
FOREIGN KEY (VIN) REFERENCES car ON DELETE CASCADE,
FOREIGN KEY (SSN) REFERENCES car_owner ON DELETE CASCADE,
FOREIGN KEY (policy_name) REFERENCES policy ON DELETE SET NULL
)

INSERT INTO payment ("SSN", "VIN", "confirmation_number", "payment_date", "due_date", "payment_amount", "coverage_time_day", "policy_name") VALUES 
('934857920', 'KNAGM4A73E5459892', 'Y32ADGWETW', '10-01-2019', '10-03-2019', 500.00, 30, 'policy-2'),
('493829382', 'JT2DB02T4V0027186', 'ERWAA2102EAD', '08-10-2021', '08-12-2021', 120, 30, 'policy-2'),
('849348571', '2HNYD18641H564733', 'AERQWDS123WE', '05-01-2019', '05-03-2019', 100.00, 30, 'policy-1');


CREATE TABLE policy
(
policy_name VARCHAR(255) NOT NULL PRIMARY KEY,
monthly_fee DECIMAL(10, 2) NOT NULL CHECK (monthly_fee > 0),
registered_date DATE NOT NULL DEFAULT 'now',
cover_percentage FLOAT NOT NULL CHECK (cover_percentage > 0 AND cover_percentage
<= 1),
deductible DECIMAL(10, 2) NOT NULL CHECK (deductible > 0)
)
INSERT INTO policy (policy_name, monthly_fee, registered_date, cover_percentage, deductible)
VALUES
('policy-1', 100.00, '2020-01-01', 0.8, 3000.00),
('policy-2', 120.00, '2020-01-01', 0.85, 4000.00),
('policy-3', 150.00, '2018-12-12', 0.90, 5000.00),
('policy-4', 175.00, '2019-03-22', 0.95, 7500.00) ;

