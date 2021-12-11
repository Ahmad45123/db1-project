CREATE TABLE PostGradUser (
    id INT PRIMARY KEY IDENTITY,
    email VARCHAR(10) NOT NULL,
    password VARCHAR(10) NOT NULL
); 

CREATE TABLE Admin(
    id INT PRIMARY KEY REFERENCES PostGradUser(id)
);

CREATE TABLE GucianStudent (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    firstName VARCHAR(10) NOT NULL,
    lastName VARCHAR(10) NOT NULL,
    type VARCHAR(10) NOT NULL,
    faculty VARCHAR(50) NOT NULL,
    address VARCHAR(10) NOT NULL,
    GPA DECIMAL(3,2) NOT NULL,
    undergradID VARCHAR(10) NOT NULL,
);

CREATE TABLE NonGucianStudent (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    firstName VARCHAR(10) NOT NULL,
    lastName VARCHAR(10) NOT NULL,
    type VARCHAR(10) NOT NULL,
    faculty VARCHAR(50) NOT NULL,
    address VARCHAR(10) NOT NULL,
    GPA DECIMAL(3,2) NOT NULL
);

CREATE TABLE GUCStudentPhoneNumber (
    id INT REFERENCES GucianStudent(id),
    phone VARCHAR(50) NOT NULL,
    PRIMARY KEY(id, phone)
);

CREATE TABLE NonGUCStudentPhoneNumber (
    id INT REFERENCES NonGucianStudent(id),
    phone VARCHAR(50) NOT NULL,
    PRIMARY KEY(id, phone)
);

CREATE TABLE Course (
    id INT PRIMARY KEY IDENTITY,
    fees DECIMAL(5,2) NOT NULL,
    creditHours INT NOT NULL,
    code VARCHAR(50) NOT NULL
);

CREATE TABLE Supervisor (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    name VARCHAR(50) NOT NULL,
    faculty VARCHAR(50) NOT NULL
);

CREATE TABLE Payment (
    id INT PRIMARY KEY IDENTITY,
    amount DECIMAL(5,2) NOT NULL,
    no_Installments INT NOT NULL,
    fundPercentage DECIMAL(3,2) NOT NULL
);

CREATE TABLE Installment (
    date DATE NOT NULL,
    paymentId INT REFERENCES Payment(id),
    amount DECIMAL(5,2) NOT NULL,
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
    defenseDate DATE NOT NULL,
    years AS year(endDate) - year(startDate),
    grade DECIMAL(3,2) NOT NULL,
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
    isNational VARCHAR(50) NOT NULL
);

CREATE TABLE Defense (
    serialNumber INT REFERENCES Thesis(serialNumber),
    date DATE NOT NULL,
    location VARCHAR(50) NOT NULL,
    grade DECIMAL(3,2) NOT NULL,
    PRIMARY KEY(serialNumber, date)
);

CREATE TABLE GUCianProgressReport (
    sid INT REFERENCES GucianStudent(id),
    no INT NOT NULL,
    date DATE NOT NULL,
    eval VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    thesisSerialNumber INT REFERENCES Thesis(serialNumber),
    supid INT REFERENCES Supervisor(id),
    PRIMARY KEY (sid, no)
);

CREATE TABLE NonGUCianProgressReport (
    sid INT REFERENCES NonGucianStudent(id),
    no INT NOT NULL,
    date DATE NOT NULL,
    eval VARCHAR(50) NOT NULL,
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
    grade DECIMAL(3,2) NOT NULL,
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
    comment VARCHAR(50) NOT NULL,
    PRIMARY KEY (date, serialNo, examinerId)
);

CREATE TABLE ThesisHasPublication (
    serialNo INT REFERENCES Thesis(serialNumber),
    pubid INT REFERENCES Publication(id),
    PRIMARY KEY (serialNo, pubid)
);