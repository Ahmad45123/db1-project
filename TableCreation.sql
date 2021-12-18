CREATE TABLE PostGradUser (
    id INT PRIMARY KEY IDENTITY,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(20) NOT NULL
); 

CREATE TABLE Admin(
    id INT PRIMARY KEY REFERENCES PostGradUser(id)
);

CREATE TABLE GucianStudent (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    type VARCHAR(10) NOT NULL,
    faculty VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
    GPA DECIMAL(10,2) NOT NULL,
    undergradID VARCHAR(10) NOT NULL,
);

CREATE TABLE NonGucianStudent (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    type VARCHAR(10) NOT NULL,
    faculty VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
    GPA DECIMAL(10,2) NOT NULL
);

CREATE TABLE GUCStudentPhoneNumber (
    id INT REFERENCES GucianStudent(id),
    phone VARCHAR(20) NOT NULL,
    PRIMARY KEY(id, phone)
);

CREATE TABLE NonGUCStudentPhoneNumber (
    id INT REFERENCES NonGucianStudent(id),
    phone VARCHAR(20) NOT NULL,
    PRIMARY KEY(id, phone)
);

CREATE TABLE Course (
    id INT PRIMARY KEY IDENTITY,
    fees DECIMAL(10,2) NOT NULL,
    creditHours INT NOT NULL,
    code VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE Supervisor (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    name VARCHAR(50) NOT NULL,
    faculty VARCHAR(20) NOT NULL
);

CREATE TABLE Payment (
    id INT PRIMARY KEY IDENTITY,
    amount DECIMAL(10,2) NOT NULL,
    no_Installments INT NOT NULL,
    fundPercentage DECIMAL(10,2) NOT NULL
);

CREATE TABLE Installment (
    date DATE NOT NULL,
    paymentId INT REFERENCES Payment(id),
    amount DECIMAL(10,2) NOT NULL,
    done INT NOT NULL,
    PRIMARY KEY (date, paymentId)
);

CREATE TABLE Thesis (
    serialNumber INT PRIMARY KEY IDENTITY,
    field VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    defenseDate Datetime NOT NULL,
    years AS DATEDIFF(YEAR, endDate, startDate),
    grade DECIMAL(10,2) NOT NULL,
    payment_id INT REFERENCES Payment(id),
    noExtension INT NOT NULL
);

CREATE Table Publication(
    id INT PRIMARY KEY IDENTITY,
    title VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    place VARCHAR(50) NOT NULL,
    accepted BIT NOT NULL,
    host VARCHAR(50) NOT NULL
);

CREATE TABLE Examiner (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    name VARCHAR(50) NOT NULL,
    fieldOfWork VARCHAR(50) NOT NULL,
    isNational BIT NOT NULL
);

CREATE TABLE Defense (
    serialNumber INT REFERENCES Thesis(serialNumber),
    date Datetime NOT NULL,
    location varchar(15) NOT NULL,
    grade DECIMAL(10,2),
    PRIMARY KEY(serialNumber, date)
);

CREATE TABLE GUCianProgressReport (
    sid INT REFERENCES GucianStudent(id),
    no INT NOT NULL,
    date DATE NOT NULL,
    eval INT NULL,
    state VARCHAR(50) NULL,
    thesisSerialNumber INT REFERENCES Thesis(serialNumber),
    supid INT REFERENCES Supervisor(id),
    PRIMARY KEY (sid, no)
);

CREATE TABLE NonGUCianProgressReport (
    sid INT REFERENCES NonGucianStudent(id),
    no INT NOT NULL,
    date DATE NOT NULL,
    eval INT NOT NULL,
    state VARCHAR(50) NOT NULL,
    thesisSerialNumber INT REFERENCES Thesis(serialNumber),
    supid INT REFERENCES Supervisor(id),
    PRIMARY KEY (sid, no)
);

CREATE TABLE NonGucianStudentPayForCourse (
    sid INT REFERENCES NonGucianStudent(id),
    paymentNo INT REFERENCES Payment(id),
    cid INT REFERENCES Course(id),
    PRIMARY KEY (sid, paymentNo, cid)
);

CREATE TABLE NonGUCianStudentTakeCourse (
    sid INT REFERENCES NonGucianStudent(id),
    cid INT REFERENCES Course(id),
    grade DECIMAL(10,2),
    PRIMARY KEY (sid, cid)
);

CREATE TABLE GUCStudentRegisterThesis (
    sid INT REFERENCES GucianStudent(id),
    supid INT REFERENCES Supervisor(id),
    serial_no INT REFERENCES Thesis(serialNumber),
    PRIMARY KEY (sid, supid, serial_no)
);

CREATE TABLE NonGUCStudentRegisterThesis (
    sid INT REFERENCES NonGucianStudent(id),
    supid INT REFERENCES Supervisor(id),
    serial_no INT REFERENCES Thesis(serialNumber),
    PRIMARY KEY (sid, supid, serial_no)
);

CREATE TABLE ExaminerEvaluateDefense (
    date DATE NOT NULL,
    serialNo INT REFERENCES Thesis(serialNumber),
    examinerId INT REFERENCES Examiner(id),
    comment varchar(300),
    PRIMARY KEY (date, serialNo, examinerId)
);

CREATE TABLE ThesisHasPublication (
    serialNo INT REFERENCES Thesis(serialNumber),
    pubid INT REFERENCES Publication(id),
    PRIMARY KEY (serialNo, pubid)
);