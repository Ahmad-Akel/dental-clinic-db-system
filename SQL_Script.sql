--create address table
CREATE TABLE address(
    address_id number(4) NOT NULL ,
    country varchar2(100) NOT NULL ,
    city varchar2(100) NOT NULL ,
    zip_code varchar2(100) NOT NULL ,
    street_number varchar2(100) NOT NULL,
    CONSTRAINT address_pk PRIMARY KEY (address_id)
);



--Insert data to address table
INSERT INTO address(address_id, country, city, zip_code, street_number) VALUES (1,'Czechia','Pardubice',53002,202);
INSERT INTO address(address_id, country, city, zip_code, street_number) VALUES (2,'Czechia','Pardubice',53009,113);
INSERT INTO address(address_id, country, city, zip_code, street_number) VALUES (3,'Czechia','Prague',53258,78);
INSERT INTO address(address_id, country, city, zip_code, street_number) VALUES (4,'Czechia','Brno',45879,3);
INSERT INTO address(address_id, country, city, zip_code, street_number) VALUES (5,'Czechia','Olomouc',78564,44);


--retrieve data from address table
SELECT *
FROM  address
    WHERE country='Czechia'
    AND zip_code>=53002;


--update zip_code in address table
UPDATE
    address
SET
 zip_code=53008
WHERE
address_id=3;


--retrieve all the data from address table (D1)
SELECT *
FROM address
WHERE zip_code IN (53002,53009);



--create clinic table
CREATE TABLE clinic(
    clinic_id number(4) NOT NULL ,
    name varchar2(100) NOT NULL ,
    city varchar2(100) NOT NULL ,
    mail varchar2(150) NOT NULL ,
    phone_number varchar2(16) NOT NULL,
    address_id number(4) NOT NULL ,
    PRIMARY KEY (clinic_id),
    FOREIGN KEY (address_id) REFERENCES ADDRESS(address_id)
);


--delete city column
ALTER TABLE CLINIC
DROP (city);

select  * from patient;


--insert data into clinic table
INSERT ALL
INTO  clinic(clinic_id, name, city, mail, phone_number, address_id) VALUES (1,'DNT','dnt@gmail.com',722963852,1)
INTO  clinic(clinic_id, name, city, mail, phone_number, address_id) VALUES (2,'DMS','DMS@gmail.com',722852741,4)
INTO  clinic(clinic_id, name, city, mail, phone_number, address_id) VALUES (3,'DRK','DRK@gmail.com',756852963,5)
INTO  clinic(clinic_id, name, city, mail, phone_number, address_id) VALUES (4,'DFG','DFG@gmail.com',794963874,3)
INTO  clinic(clinic_id, name, city, mail, phone_number, address_id) VALUES (5,'DFV','DFV@gmail.com',789456123,2)
SELECT * FROM DUAL;



--create doctor table
CREATE TABLE doctor(
    doctor_id number(4) NOT NULL ,
    first_name varchar2(100) NOT NULL ,
    last_name varchar2(100) NOT NULL ,
    mail varchar2(150) NOT NULL ,
    phone_number varchar2(16) NOT NULL,
    address_id number(4) NOT NULL ,
    department_id number(4) NOT NULL,
    clinic_id number(4) NOT NULL ,
    PRIMARY KEY (doctor_id),
    FOREIGN KEY (address_id) REFERENCES ADDRESS(address_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (clinic_id) REFERENCES clinic(clinic_id)
);


--edit the doctor table to add patient_id column
ALTER TABLE doctor
ADD patient_id number(4)
ADD FOREIGN KEY (patient_id) REFERENCES patient(patient_id);


--inset data into doctor table
INSERT INTO doctor(doctor_id, first_name, last_name, mail, phone_number, address_id, department_id, clinic_id) VALUES (1,'Marek','Filip',722963852,'marek@gmail.com',1,1,1);
INSERT INTO doctor(doctor_id, first_name, last_name, mail, phone_number, address_id, department_id, clinic_id) VALUES (2,'Filip','Marek',722456123,'filip@gmail.com',2,2,2);
INSERT INTO doctor(doctor_id, first_name, last_name, mail, phone_number, address_id, department_id, clinic_id) VALUES (3,'Marek','Filip',722963852,'marek@gmail.com',5,2,3);
INSERT INTO doctor(doctor_id, first_name, last_name, mail, phone_number, address_id, department_id, clinic_id) VALUES (4,'Marek','Kopecky',722963852,'marek@gmail.com',1,2,1);


--select the doctor who has visited with the same patients who are visited doctor Filip Marek (D4)
SELECT *
FROM patient
    WHERE doctor_id IN (2,1) AND patient.doctor_id NOT IN (3);


--select the doctors and nurses names who have the same addresses (JOIN ON)
SELECT doctor.first_name,doctor.last_name,nurse.first_name,nurse.last_name
FROM doctor
    INNER JOIN NURSE
        ON doctor.address_id=nurse.ADDRESS_ID;


--(MINUS)
SELECT first_name,last_name
FROM doctor
    WHERE first_name='Marek'
MINUS
SELECT first_name,last_name
FROM nurse
    ORDER BY last_name;


--(INTERSECT)
SELECT address_id
FROM doctor
    INTERSECT
SELECT address_id
FROM NURSE
    ORDER BY address_id;


--create nurse table
CREATE TABLE nurse(
    nurse_id number(4) NOT NULL ,
    first_name varchar2(100) NOT NULL ,
    last_name varchar2(100) NOT NULL ,
    mail varchar2(150) NOT NULL ,
    phone_number varchar2(16) NOT NULL,
    address_id number(4) NOT NULL ,
    department_id number(4) NOT NULL,
    clinic_id number(4) NOT NULL ,
    PRIMARY KEY (nurse_id),
    FOREIGN KEY (address_id) REFERENCES ADDRESS(address_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (clinic_id) REFERENCES clinic(clinic_id)
);


--insert data to nurse table
INSERT INTO nurse(nurse_id, first_name, last_name, mail, phone_number, address_id, department_id, clinic_id) VALUES (1,'Rita','Karel','rita@gmail.com',722546981,1,1,1);
INSERT INTO nurse(nurse_id, first_name, last_name, mail, phone_number, address_id, department_id, clinic_id) VALUES (2,'Karla','Machova','karla@gmail.com',723546981,2,2,2);
INSERT INTO nurse(nurse_id, first_name, last_name, mail, phone_number, address_id, department_id, clinic_id) VALUES (3,'Petra','Hopova','rita@gmail.com',722746981,3,2,3);
INSERT INTO nurse(nurse_id, first_name, last_name, mail, phone_number, address_id, department_id, clinic_id) VALUES (4,'Sarka','Marek','Sarka@gmail.com',722756981,4,1,3);
INSERT INTO nurse(nurse_id, first_name, last_name, mail, phone_number, address_id, department_id, clinic_id) VALUES (5,'Tereza','Filip','Tereza@gmail.com',722646981,4,2,1);


--(RIGHT JOIN)
SELECT nurse.nurse_id Nurse_ID,nurse.first_name,nurse.last_name, doctor.doctor_id Doctor_ID,doctor.first_name,doctor.last_name
FROM nurse
    RIGHT JOIN doctor ON doctor.doctor_id=nurse.nurse_id;


--(LEFT JOIN)
SELECT nurse.nurse_id Nurse_ID,nurse.first_name,nurse.last_name, doctor.doctor_id Doctor_ID,doctor.first_name,doctor.last_name
FROM nurse
    LEFT JOIN doctor ON doctor.doctor_id=nurse.nurse_id;


--(UNION)
SELECT nurse_id,first_name,last_name
FROM nurse
    WHERE nurse_id >=2
UNION
SELECT doctor_id,first_name,last_name
FROM doctor
    WHERE first_name='Marek'
ORDER BY 2;


--create department table
CREATE TABLE department(
    department_id number(4) NOT NULL,
    name VARCHAR2(100) NOT NULL,
    clinic_id number(4) NOT NULL,
    address_id number(4) NOT NULL,
    PRIMARY KEY (department_id),
    FOREIGN KEY (address_id) REFERENCES ADDRESS(address_id),
    FOREIGN KEY (clinic_id) REFERENCES clinic(clinic_id)
);


--(NATURAL JOIN)
SELECT doctor.first_name,doctor.last_name,department.name
FROM doctor
    NATURAL JOIN department;


--select all the doctors first and last names and their departments where they belong
SELECT doctor.first_name,doctor.last_name,department.name Department_Name
FROM doctor
    CROSS JOIN department;


--insert data to department table
INSERT INTO department(department_id, name, clinic_id, address_id) VALUES (1,'Endodnotics',1,1);
INSERT INTO department(department_id, name, clinic_id, address_id) VALUES (2,'Prosthodontics',1,1);


--updating the name attribute on department table to be unique
ALTER TABLE department
ADD CONSTRAINT unique_name UNIQUE (name);



--create patient table
CREATE TABLE patient(
    patient_id number(4) NOT NULL ,
    first_name varchar2(100) NOT NULL ,
    last_name varchar2(100) NOT NULL ,
    mail varchar2(150) NOT NULL ,
    phone_number varchar2(16) NOT NULL,
    address_id number(4) NOT NULL ,
    insurance_id number(4) NOT NULL ,
    PRIMARY KEY (patient_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (insurance_id) REFERENCES insurance_company(insurance_id)
);


--edit the patient table to add doctor_id column
ALTER TABLE patient
ADD doctor_id number(4)
ADD FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id);


--insert data to patient table
INSERT INTO patient(patient_id, first_name, last_name, mail, phone_number, address_id, insurance_id) VALUES (1,'Ahmad','Akel','ahmad@gmail.com',722939931,1,1);
INSERT INTO patient(patient_id, first_name, last_name, mail, phone_number, address_id, insurance_id) VALUES (2,'Jan','Sam','jan@gmail.com',722939941,2,1);
INSERT INTO patient(patient_id, first_name, last_name, mail, phone_number, address_id, insurance_id) VALUES (3,'Filip','Sam','Filip@gmail.com',722546321,3,1);
INSERT INTO patient(patient_id, first_name, last_name, mail, phone_number, address_id, insurance_id) VALUES (4,'Karel','Sam','Karel@gmail.com',772578945,4,1);
INSERT INTO patient(patient_id, first_name, last_name, mail, phone_number, address_id, insurance_id) VALUES (5,'Honza','Sam','Honza@gmail.com',765987412,5,1);
INSERT INTO patient(patient_id, first_name, last_name, mail, phone_number, address_id, insurance_id) VALUES (6,'Martin','Kopecky','martin@gmail.com',765986412,5,1);


--delete repeated column from patient table
DELETE FROM patient
WHERE patient_id=5;


--retrieve data from patient table (D1)
SELECT *
FROM patient
    WHERE patient_id>1
    AND last_name ='Sam'
ORDER BY last_name ASC;


--retrieve data from patient table (D2)
SELECT *
FROM patient
    WHERE last_name='Sam'
    AND patient_id NOT IN (3,4);


--D4
SELECT first_name,last_name
FROM patient
    WHERE insurance_id NOT IN (1);


--select the patients first name and last name who visited doctor Marek Filip and not visited doctor Filip Marek (C)
SELECT first_name,last_name
FROM patient
    WHERE patient.doctor_id IN (1)
    AND patient.doctor_id NOT  IN (2);


--list all patients with their doctors (INNER USING)
SELECT patient.first_name,patient.last_name,doctor.first_name,doctor.last_name,doctor.patient_id
FROM patient
JOIN doctor
    USING (doctor_id);


--Using string function (LTRIM) to make a shortcut of the doctor's last name
SELECT last_name,
       LTRIM(last_name,'Kope') last_name_shortcut
FROM patient
    WHERE last_name LIKE '%Kope%'
ORDER BY last_name;


--return number of patients who are registered with the doctor with id (2) using (COUNT)
SELECT COUNT(patient_id) number_of_patients
FROM patient
WHERE doctor_id=2;

--patient VIEW
CREATE VIEW  patient_view AS
    SELECT
patient_id,
first_name || ' ' || last_name full_name
    FROM patient;


--create child subtype table
CREATE TABLE child(
  child_id number(4) NOT NULL UNIQUE,
  deciduous_teeth varchar2(120) NOT NULL,
  patient_id number(4) NOT NULL ,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);


--insert data to child table
INSERT INTO child(child_id, deciduous_teeth, patient_id) VALUES (2,'Good',2);



--create young subtype table
CREATE TABLE young(
  young_id number(4) NOT NULL UNIQUE,
  patient_id number(4) NOT NULL ,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);


--insert data to young table
INSERT INTO young(young_id, patient_id) VALUES (1,1);



--create insurance table
CREATE TABLE insurance_company(
  insurance_id number(4) NOT NULL,
  name varchar2(100) NOT NULL ,
  mail varchar2(150) NOT NULL ,
  insurance_number number(9) NOT NULL,
  insurance_type varchar2(10) NOT NULL,
  phone_number varchar2(16),
  PRIMARY KEY (insurance_id)
);

--rename insurance_id to insurance_company_id in insurance_company table
ALTER TABLE insurance_company
RENAME COLUMN insurance_id TO insurance_company_id;

--drop the insurance_number and insurance_type columns form insurance_company table
ALTER TABLE insurance_company
DROP (insurance_number,insurance_type);

--insert data to insurance_company table
INSERT INTO insurance_company(insurance_company_id, name, mail, phone_number) VALUES (1,'POI','poi@gmail.com',722546987);
INSERT INTO insurance_company(insurance_company_id, name, mail, phone_number) VALUES (2,'PON','pon@gmail.com',722566987);

--create insurance table
CREATE TABLE insurance(
      insurance_id number(4) NOT NULL ,
      insurance_type varchar2(50)NOT NULL ,
      insurance_number number(10) NOT NULL,
      insurance_company_id number(4) NOT NULL ,
      FOREIGN KEY (insurance_company_id) REFERENCES insurance_company(insurance_company_id)
);
--insert data to insurance table
INSERT INTO insurance(insurance_id, insurance_type, insurance_number, insurance_company_id) VALUES (1,'FULL',457865884,1);
INSERT INTO insurance(insurance_id, insurance_type, insurance_number, insurance_company_id) VALUES (2,'PART',457468684,1);

--create table appointment
CREATE TABLE appointment(
  appointment_id number(4),
  appointment_date date NOT NULL UNIQUE,
  doctor_id number(4) NOT NULL ,
  patient_id number(4) NOT NULL ,
  PRIMARY KEY (appointment_id),
  FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);


--insert data to appointment table
INSERT INTO appointment(appointment_id, appointment_date, doctor_id, patient_id) VALUES (1,'01-AUG-20',1,1);
INSERT INTO appointment(appointment_id, appointment_date, doctor_id, patient_id) VALUES (2,'02-SEP-21',1,2);
INSERT INTO appointment(appointment_id, appointment_date, doctor_id, patient_id) VALUES (3,'01-JAN-21',1,1);


--calculating how many months between two appointments dates using date function (MONTHS_BETWEEN)
SELECT MONTHS_BETWEEN('01-JAN-21','01-AUG-20') waiting_time
FROM DUAL;

SELECT
first_name,last_name,doctor_id
FROM patient p
WHERE
EXISTS(
    SELECT 1
    FROM appointment
    WHERE p.patient_id=appointment.patient_id
    );

--create table treatment
CREATE TABLE treatment(
    treatment_id number(4),
    fees number(4,3),
    medicine_list varchar2(300) NOT NULL,
    treatment_date date NOT NULL,
    PRIMARY KEY (treatment_id),
    doctor_id number(4) NOT NULL ,
    patient_id number(4) NOT NULL ,
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

ALTER TABLE treatment
RENAME COLUMN medicine_list TO medicine_name;

--insert data to treatment table
INSERT INTO treatment(treatment_id, fees, medicine_name, treatment_date, doctor_id, patient_id) VALUES (1,0.3,'Antigin,Orajel','05-SEP-20',1,1);
INSERT INTO treatment(treatment_id, fees, medicine_name, treatment_date, doctor_id, patient_id) VALUES (2,0.9,'Antigin,Topex','05-SEP-20',2,2);
INSERT INTO treatment(treatment_id, fees, medicine_name, treatment_date, doctor_id, patient_id) VALUES (3,NULL,'Some','06-AUG-21',3,3);


--create medicine table
CREATE TABLE medicine(
    medicine_id number(4) NOT NULL,
    name varchar2(100) NOT NULL,
    price number(4,3),
    treatment_id number(4),
    PRIMARY KEY (medicine_id),
    FOREIGN KEY (treatment_id) REFERENCES treatment(treatment_id)
);

--create a sequence
CREATE SEQUENCE medicine_info_seq;
INSERT INTO medicine(medicine_id, name, price, treatment_id)
VALUES (medicine_info_seq.nextval,'ARM',0.58,4);

--insert data for medicine table
INSERT INTO medicine(medicine_id, name, price, treatment_id) VALUES (1,'Antigin',0.25,1);
INSERT INTO medicine(medicine_id, name, price, treatment_id) VALUES (2,'benzocaine',0.75,2);
INSERT INTO medicine(medicine_id, name, price, treatment_id) VALUES (3,'Orajel',0.89,1);
INSERT INTO medicine(medicine_id, name, price, treatment_id) VALUES (4,'Topex',0.93,2);
INSERT INTO medicine(medicine_id, name, price, treatment_id) VALUES (5,'Some',NULL,3);

--list all treatments and their medicines where price is null (FULL OUTER JOIN)
SELECT *
FROM medicine
FULL OUTER JOIN treatment ON treatment.treatment_id=medicine.treatment_id
WHERE price IS NULL
      ORDER BY medicine.name;
select * from medicine;

--using * operator
SELECT medicine.medicine_id,name,price*25 price_in_USD
FROM medicine;

--select the price average using AVG numeric function
SELECT AVG(price) price_average
FROM medicine;


--counting the maximum price using (MAX) function
SELECT MAX(price) max_price
FROM medicine;


--counting the minimum price using (MIN) function
SELECT MIN(price) min_price
FROM medicine;


--counting the total price using (SUM) function
SELECT SUM(price) total_price
FROM medicine;

--return number of medicines which having total price bigger than 5 usd on each treatment using (GROUP BY,HAVING) clause and (COUNT)
SELECT treatment_id,COUNT(medicine_id) number_of_medicines
FROM medicine
GROUP BY treatment_id
HAVING SUM(price*10) >5
ORDER BY treatment_id;

