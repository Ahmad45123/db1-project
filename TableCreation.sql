USE Master;
DROP DATABASE PostGradOffice;
CREATE DATABASE PostGradOffice;
USE PostGradOffice;
CREATE TABLE PostGradUser (
    id INT PRIMARY KEY IDENTITY,
    email VARCHAR(50)  ,
    password VARCHAR(20)  
); 

CREATE TABLE Admin(
    id INT PRIMARY KEY REFERENCES PostGradUser(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE GucianStudent (
    id INT PRIMARY KEY REFERENCES PostGradUser(id) ON DELETE CASCADE ON UPDATE CASCADE,
    firstName VARCHAR(20)  ,
    lastName VARCHAR(20)  ,
    type VARCHAR(10)  ,
    faculty VARCHAR(20)  ,
    address VARCHAR(50)  ,
    GPA DECIMAL(10,2)  ,
    undergradID VARCHAR(10)  ,
);

CREATE TABLE NonGucianStudent (
    id INT PRIMARY KEY REFERENCES PostGradUser(id) ON DELETE CASCADE ON UPDATE CASCADE,
    firstName VARCHAR(20)  ,
    lastName VARCHAR(20)  ,
    type VARCHAR(10)  ,
    faculty VARCHAR(20)  ,
    address VARCHAR(50)  ,
    GPA DECIMAL(10,2)  
);

CREATE TABLE GUCStudentPhoneNumber (
    id INT REFERENCES GucianStudent(id) ON DELETE CASCADE ON UPDATE CASCADE,
    phone VARCHAR(20)  ,
    PRIMARY KEY(id, phone)
);

CREATE TABLE NonGUCStudentPhoneNumber (
    id INT REFERENCES NonGucianStudent(id) ON DELETE CASCADE ON UPDATE CASCADE,
    phone VARCHAR(20)  ,
    PRIMARY KEY(id, phone)
);

CREATE TABLE Course (
    id INT PRIMARY KEY IDENTITY,
    fees DECIMAL(10,2)  ,
    creditHours INT  ,
    code VARCHAR(10)   UNIQUE
);

CREATE TABLE Supervisor (
    id INT PRIMARY KEY REFERENCES PostGradUser(id) ON DELETE CASCADE ON UPDATE CASCADE,
    name VARCHAR(50)  ,
    faculty VARCHAR(20)  
);

CREATE TABLE Payment (
    id INT PRIMARY KEY IDENTITY,
    amount DECIMAL(10,2)  ,
    no_Installments INT  ,
    fundPercentage DECIMAL(10,2)  
);

CREATE TABLE Installment (
    date DATE  ,
    paymentId INT REFERENCES Payment(id) ON DELETE CASCADE ON UPDATE CASCADE,
    amount DECIMAL(10,2)  ,
    done INT  ,
    PRIMARY KEY (date, paymentId)
);

CREATE TABLE Thesis (
    serialNumber INT PRIMARY KEY IDENTITY,
    field VARCHAR(50),
    type VARCHAR(50),
    title VARCHAR(50),
    startDate DATE,
    endDate DATE,
    defenseDate Datetime,
    years AS DATEDIFF(YEAR, startDate, endDate),
    grade DECIMAL(10,2),
    payment_id INT REFERENCES Payment(id) ON DELETE CASCADE ON UPDATE CASCADE,
    noExtension INT  
);

CREATE Table Publication(
    id INT PRIMARY KEY IDENTITY,
    title VARCHAR(50)  ,
    date DATE  ,
    place VARCHAR(50)  ,
    accepted BIT  ,
    host VARCHAR(50)  
);

CREATE TABLE Examiner (
    id INT PRIMARY KEY REFERENCES PostGradUser(id) ON DELETE CASCADE ON UPDATE CASCADE,
    name VARCHAR(50)  ,
    fieldOfWork VARCHAR(50)  ,
    isNational BIT  
);

CREATE TABLE Defense (
    serialNumber INT REFERENCES Thesis(serialNumber) ON DELETE CASCADE ON UPDATE CASCADE,
    date Datetime  ,
    location varchar(15)  ,
    grade DECIMAL(10,2),
    PRIMARY KEY(serialNumber, date)
);

CREATE TABLE GUCianProgressReport (
    sid INT REFERENCES GucianStudent(id) ON DELETE CASCADE ON UPDATE CASCADE,
    no INT  ,
    date DATE  ,
    eval INT NULL,
    state VARCHAR(50) NULL,
    thesisSerialNumber INT REFERENCES Thesis(serialNumber) ON DELETE CASCADE ON UPDATE CASCADE,
    supid INT REFERENCES Supervisor(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (sid, no)
);

CREATE TABLE NonGUCianProgressReport (
    sid INT REFERENCES NonGucianStudent(id) ON DELETE CASCADE ON UPDATE CASCADE,
    no INT  ,
    date DATE  ,
    eval INT  ,
    state VARCHAR(50)  ,
    thesisSerialNumber INT REFERENCES Thesis(serialNumber) ON DELETE CASCADE ON UPDATE CASCADE,
    supid INT REFERENCES Supervisor(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (sid, no)
);

CREATE TABLE NonGucianStudentPayForCourse (
    sid INT REFERENCES NonGucianStudent(id) ON DELETE CASCADE ON UPDATE CASCADE,
    paymentNo INT REFERENCES Payment(id) ON DELETE CASCADE ON UPDATE CASCADE,
    cid INT REFERENCES Course(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (sid, paymentNo, cid)
);

CREATE TABLE NonGUCianStudentTakeCourse (
    sid INT REFERENCES NonGucianStudent(id) ON DELETE CASCADE ON UPDATE CASCADE,
    cid INT REFERENCES Course(id) ON DELETE CASCADE ON UPDATE CASCADE,
    grade DECIMAL(10,2),
    PRIMARY KEY (sid, cid)
);

CREATE TABLE GUCStudentRegisterThesis (
    sid INT REFERENCES GucianStudent(id) ON DELETE CASCADE ON UPDATE CASCADE,
    supid INT REFERENCES Supervisor(id) ON DELETE CASCADE ON UPDATE CASCADE,
    serial_no INT REFERENCES Thesis(serialNumber) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (sid, supid, serial_no)
);

CREATE TABLE NonGUCStudentRegisterThesis (
    sid INT REFERENCES NonGucianStudent(id) ON DELETE CASCADE ON UPDATE CASCADE,
    supid INT REFERENCES Supervisor(id) ON DELETE CASCADE ON UPDATE CASCADE,
    serial_no INT REFERENCES Thesis(serialNumber) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (sid, supid, serial_no)
);

CREATE TABLE ExaminerEvaluateDefense (
    date Datetime,
    serialNo INT REFERENCES Thesis(serialNumber) ON DELETE CASCADE ON UPDATE CASCADE,
    examinerId INT REFERENCES Examiner(id) ON DELETE CASCADE ON UPDATE CASCADE,
    comment varchar(300),
    PRIMARY KEY (date, serialNo, examinerId)
);

CREATE TABLE ThesisHasPublication (
    serialNo INT REFERENCES Thesis(serialNumber) ON DELETE CASCADE ON UPDATE CASCADE,
    pubid INT REFERENCES Publication(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (serialNo, pubid)
);