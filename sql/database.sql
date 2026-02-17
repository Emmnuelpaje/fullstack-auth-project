-- Create Database
CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;


-- DEPARTMENT
CREATE TABLE Department (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    head_id INT
);

DESCRIBE Department;
SELECT * FROM Department;


-- EMPLOYEE

CREATE TABLE Employee (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('male','female','other'),
    birth_date DATE,
    contact_no VARCHAR(20),
    address VARCHAR(100),
    position VARCHAR(50) NOT NULL,
    department_id INT,
    hire_date DATE,
    status ENUM('active','inactive','on_leave') DEFAULT 'active',
    shift_schedule VARCHAR(50),
    FOREIGN KEY (department_id) REFERENCES Department(dept_id)
);

DESCRIBE Employee;
SELECT * FROM Employee;


-- DOCTOR

CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('male','female','other'),
    specialty VARCHAR(50) NOT NULL,
    license_no VARCHAR(20) UNIQUE NOT NULL,
    contact_no VARCHAR(20)
);

DESCRIBE Doctor;
SELECT * FROM Doctor;


-- PATIENT

CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('male','female','other'),
    birth_date DATE,
    contact_no VARCHAR(20),
    address VARCHAR(100),
    blood_type VARCHAR(5) DEFAULT 'Unknown',
    patient_type ENUM('inpatient','outpatient','walkin') NOT NULL,
    registration_type ENUM('appointment','walkin') NOT NULL
);

DESCRIBE Patient;
SELECT * FROM Patient;


-- BED

CREATE TABLE Bed (
    bed_id INT AUTO_INCREMENT PRIMARY KEY,
    room_no VARCHAR(10) NOT NULL,
    status ENUM('available','occupied','cleaning') DEFAULT 'available',
    ward VARCHAR(30)
);

DESCRIBE Bed;
SELECT * FROM Bed;



-- APPOINTMENT

CREATE TABLE Appointment (
    appt_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    date_time DATETIME NOT NULL,
    status ENUM('scheduled','completed','cancelled') DEFAULT 'scheduled',
    priority ENUM('normal','walkin') DEFAULT 'normal',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

DESCRIBE Appointment;
SELECT * FROM Appointment;



-- ADMISSION

CREATE TABLE Admission (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    bed_id INT,
    doctor_id INT,
    admit_date DATETIME NOT NULL,
    discharge_date DATETIME,
    assigned_nurse_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (bed_id) REFERENCES Bed(bed_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (assigned_nurse_id) REFERENCES Employee(emp_id)
);

DESCRIBE Admission;
SELECT * FROM Admission;



-- MEDICAL RECORD

CREATE TABLE MedicalRecord (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT,
    treatment TEXT,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

DESCRIBE MedicalRecord;
SELECT * FROM MedicalRecord;



-- BILLING

CREATE TABLE Billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    admission_id INT,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending','paid','partial') DEFAULT 'pending',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (admission_id) REFERENCES Admission(admission_id)
);

DESCRIBE Billing;
SELECT * FROM Billing;
