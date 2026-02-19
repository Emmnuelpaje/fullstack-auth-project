

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- CREATE DATABASE
CREATE DATABASE hr_db;
USE hr_db;

-- DEPARTMENT

CREATE TABLE Department (
  Department_ID INT NOT NULL AUTO_INCREMENT,
  Department_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (Department_ID),
  UNIQUE (Department_name)
) ENGINE=InnoDB;

-- EMPLOYEE

CREATE TABLE Employee (
  Employee_id INT NOT NULL AUTO_INCREMENT,
  Employee_Fname VARCHAR(50) NOT NULL,
  Employee_MName VARCHAR(25),
  Employee_LName VARCHAR(50) NOT NULL,
  Employee_PhoneNumber VARCHAR(15) NOT NULL,
  Employee_House_Street VARCHAR(100) NOT NULL,
  Employee_Barangay VARCHAR(50) NOT NULL,
  Employee_City_Municipality VARCHAR(50) NOT NULL,
  Employee_Position VARCHAR(50) NOT NULL,
  Employee_HireDate DATE NOT NULL,
  Employee_Assigned_Ward VARCHAR(50) NOT NULL,
  Employee_DutyDate DATETIME NOT NULL,
  Employee_Shift_Type ENUM('Morning','Afternoon','Night','Reliever') NOT NULL,
  Employee_PhilHealth_No VARCHAR(14) NOT NULL,
  Employee_Pagibig_No VARCHAR(14) NOT NULL,
  Employee_SSS_No VARCHAR(12) NOT NULL,
  Employee_status ENUM('Active','Inactive','On_Leave') NOT NULL DEFAULT 'Active',
  Department_Department_ID INT NOT NULL,
  PRIMARY KEY (Employee_id, Department_Department_ID),
  UNIQUE (Employee_id),
  FOREIGN KEY (Department_Department_ID)
    REFERENCES Department(Department_ID)
) ENGINE=InnoDB;

-- PATIENT
CREATE TABLE Patient (
  Pat_ID INT NOT NULL,
  Pat_Type ENUM('Inpatient','Outpatient','Walk-in') NOT NULL,
  Pat_Fname VARCHAR(50) NOT NULL,
  Pat_MName VARCHAR(50),
  Pat_LName VARCHAR(50) NOT NULL,
  Pat_Date_Of_Birth DATE NOT NULL,
  Pat_Age INT NOT NULL,
  Pat_Gender ENUM('Male','Female') NOT NULL,
  Pat_Civil_Status ENUM('Single','Married','Widowed','Separated','Anulled') NOT NULL,
  Pat_Contact_Number VARCHAR(15) NOT NULL,
  Pat_Email_Address VARCHAR(100) NOT NULL,
  Pat_Status ENUM('Active','Inactive','Deceased','Transferred') NOT NULL,
  Pat_Home_Street VARCHAR(100),
  Pat_Barangay VARCHAR(50) NOT NULL,
  Pat_City_Municipality VARCHAR(50) NOT NULL,
  Pat_Region VARCHAR(50) NOT NULL,
  Pat_Blood_Type VARCHAR(5),
  Pat_Allergies TEXT,
  Pat_Existing_Conditions TEXT,
  Pat_Medical_History TEXT,
  Pat_Emergency_Contact_Name VARCHAR(100) NOT NULL,
  Pat_Emergency_Contact_Number VARCHAR(15) NOT NULL,
  Pat_Date_Registered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Pat_Registered_Type ENUM('Appointment','Walk-In') NOT NULL,
  PRIMARY KEY (Pat_ID)
) ENGINE=InnoDB;

-- BED
CREATE TABLE Bed (
  Bed_ID INT NOT NULL AUTO_INCREMENT,
  Bed_Room_No VARCHAR(10) NOT NULL,
  Bed_Status ENUM('Available','Occupied','Cleaning') DEFAULT 'Available',
  Bed_Ward VARCHAR(30),
  PRIMARY KEY (Bed_ID)
) ENGINE=InnoDB;

-- ADMISSION
CREATE TABLE Admission (
  Admission_ID INT NOT NULL AUTO_INCREMENT,
  Admission_Date DATETIME NOT NULL,
  Admission_Discharge DATETIME,
  Bed_Bed_ID INT NOT NULL,
  Patient_Pat_ID INT NOT NULL,
  PRIMARY KEY (Admission_ID, Bed_Bed_ID, Patient_Pat_ID),
  FOREIGN KEY (Bed_Bed_ID) REFERENCES Bed(Bed_ID),
  FOREIGN KEY (Patient_Pat_ID) REFERENCES Patient(Pat_ID)
) ENGINE=InnoDB;


-- DOCTOR

CREATE TABLE Doctor (
  Doctor_ID INT NOT NULL AUTO_INCREMENT,
  Doctor_Specialization VARCHAR(50) NOT NULL,
  Doctor_License_no VARCHAR(20) NOT NULL,
  Employee_Employee_id INT NOT NULL,
  Admission_Admission_ID INT NOT NULL,
  Admission_Bed_Bed_ID INT NOT NULL,
  Admission_Patient_Pat_ID INT NOT NULL,
  PRIMARY KEY (Doctor_ID, Employee_Employee_id, Admission_Admission_ID, Admission_Bed_Bed_ID, Admission_Patient_Pat_ID),
  UNIQUE (Doctor_License_no),
  FOREIGN KEY (Employee_Employee_id) REFERENCES Employee(Employee_id),
  FOREIGN KEY (Admission_Admission_ID, Admission_Bed_Bed_ID, Admission_Patient_Pat_ID)
    REFERENCES Admission(Admission_ID, Bed_Bed_ID, Patient_Pat_ID)
) ENGINE=InnoDB;


-- APPOINTMENT

CREATE TABLE Appointment (
  Appt_ID INT NOT NULL AUTO_INCREMENT,
  Appt_Date DATETIME NOT NULL,
  Appt_Status ENUM('Scheduled','Completed','Cancelled','Reschedule') DEFAULT 'Scheduled',
  Patient_Pat_ID INT NOT NULL,
  Doctor_Doctor_ID INT NOT NULL,
  Doctor_Employee_Employee_id INT NOT NULL,
  PRIMARY KEY (Appt_ID, Doctor_Doctor_ID, Doctor_Employee_Employee_id),
  FOREIGN KEY (Patient_Pat_ID) REFERENCES Patient(Pat_ID),
  FOREIGN KEY (Doctor_Doctor_ID, Doctor_Employee_Employee_id)
    REFERENCES Doctor(Doctor_ID, Employee_Employee_id)
) ENGINE=InnoDB;


-- MEDICAL RECORD

CREATE TABLE Medical_Record (
  MedRecord_ID INT NOT NULL AUTO_INCREMENT,
  MedRecord_Diagnosis TEXT,
  MedRecord_Treatment TEXT,
  MedRecord_Date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  Doctor_Doctor_ID INT NOT NULL,
  Doctor_Employee_Employee_id INT NOT NULL,
  Patient_Pat_ID INT NOT NULL,
  PRIMARY KEY (MedRecord_ID, Doctor_Doctor_ID, Doctor_Employee_Employee_id, Patient_Pat_ID),
  FOREIGN KEY (Doctor_Doctor_ID, Doctor_Employee_Employee_id)
    REFERENCES Doctor(Doctor_ID, Employee_Employee_id),
  FOREIGN KEY (Patient_Pat_ID) REFERENCES Patient(Pat_ID)
) ENGINE=InnoDB;

-- BILLING
CREATE TABLE Billing (
  Bill_ID INT NOT NULL AUTO_INCREMENT,
  Bill_Amount DECIMAL(10,2) NOT NULL,
  Bill_Status ENUM('Pending','Paid','Partial') DEFAULT 'Pending',
  Patient_Pat_ID INT NOT NULL,
  PRIMARY KEY (Bill_ID, Patient_Pat_ID),
  FOREIGN KEY (Patient_Pat_ID) REFERENCES Patient(Pat_ID)
) ENGINE=InnoDB;

-- RESTORE SETTINGS
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
