CREATE TABLE PostGradUser (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE Admin (
    id INTEGER PRIMARY KEY REFERENCES PostGradUser(id)
);

CREATE TABLE GucianStudent (
    id INTEGER PRIMARY KEY REFERENCES PostGradUser(id),
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    type TEXT NOT NULL,
    faculty TEXT NOT NULL,
    address TEXT NOT NULL,
    GPA DECIMAL(3,2) NOT NULL,
    undergradID INTEGER NOT NULL
);

CREATE TABLE NonGucianStudent (
    id INTEGER PRIMARY KEY REFERENCES PostGradUser(id),
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    type TEXT NOT NULL,
    faculty TEXT NOT NULL,
    address TEXT NOT NULL,
    GPA DECIMAL(3,2) NOT NULL
);

CREATE TABLE GUCStudentPhoneNumber (
    id INTEGER PRIMARY KEY REFERENCES GucianStudent(id),
    phone TEXT NOT NULL
);

CREATE TABLE NonGUCStudentPhoneNumber (
    id INTEGER PRIMARY KEY REFERENCES NonGucianStudent(id),
    phone TEXT NOT NULL
);

CREATE TABLE Course (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fees DECIMAL(5,2) NOT NULL,
    creditHours INTEGER NOT NULL,
    code TEXT NOT NULL
);

CREATE TABLE Supervisor (
    id INTEGER PRIMARY KEY REFERENCES PostGradUser(id),
    name TEXT NOT NULL,
    faculty TEXT NOT NULL
);

CREATE TABLE Thesis (
    serialNumber INTEGER PRIMARY KEY AUTOINCREMENT,
    field TEXT NOT NULL,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    defenseDate DATE NOT NULL,
    years INTEGER NOT NULL,
    grade DECIMAL(3,2) NOT NULL,
    payment_id INTEGER REFERENCES Payment(id),
    noExtension INTEGER NOT NULL
);

CREATE TABLE Payment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    amount DECIMAL(5,2) NOT NULL,
    no_Installments INTEGER NOT NULL,
    fundPercentage DECIMAL(3,2) NOT NULL
);

CREATE TABLE Examiner (
    id INTEGER PRIMARY KEY REFERENCES PostGradUser(id),
    name TEXT NOT NULL,
    fieldOfWork TEXT NOT NULL,
    isNational TEXT NOT NULL
);

CREATE TABLE Defense (
    serialNumber INTEGER PRIMARY KEY REFERENCES Thesis(serialNumber),
    date DATE NOT NULL,
    location TEXT NOT NULL,
    grade DECIMAL(3,2) NOT NULL,
    thesisSerialNumber INTEGER REFERENCES Thesis(serialNumber),
    supid INTEGER REFERENCES Supervisor(id),
    examinerId INTEGER REFERENCES Examiner(id)
);

CREATE TABLE GUCianProgressReport (
    sid INTEGER REFERENCES GucianStudent(id),
    no INTEGER NOT NULL,
    date DATE NOT NULL,
    eval TEXT NOT NULL,
    state TEXT NOT NULL,
    thesisSerialNumber INTEGER REFERENCES Thesis(serialNumber),
    supid INTEGER REFERENCES Supervisor(id),
    PRIMARY KEY (sid, no, date)
);

CREATE TABLE NonGUCianProgressReport (
    sid INTEGER REFERENCES NonGucianStudent(id),
    no INTEGER NOT NULL,
    date DATE NOT NULL,
    eval TEXT NOT NULL,
    state TEXT NOT NULL,
    thesisSerialNumber INTEGER REFERENCES Thesis(serialNumber),
    supid INTEGER REFERENCES Supervisor(id),
    PRIMARY KEY (sid, no, date)
);

CREATE TABLE Installment (
    date DATE NOT NULL,
    paymentId INTEGER REFERENCES Payment(id),
    amount DECIMAL(5,2) NOT NULL,
    done INTEGER NOT NULL,
    PRIMARY KEY (date, paymentId)
);

CREATE TABLE NonGucianStudentPayForCourse (
    sid INTEGER REFERENCES NonGucianStudent(id),
    paymentNo INTEGER NOT NULL,
    cid INTEGER REFERENCES Course(id),
    PRIMARY KEY (sid, paymentNo, cid)
);

CREATE TABLE NonGUCianStudentTakeCourse (
    sid INTEGER REFERENCES NonGucianStudent(id),
    cid INTEGER REFERENCES Course(id),
    grade DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (sid, cid)
);

CREATE TABLE GUCStudentRegisterThesis (
    sid INTEGER REFERENCES GucianStudent(id),
    supid INTEGER REFERENCES Supervisor(id),
    serial_no INTEGER REFERENCES Thesis(serialNumber),
    PRIMARY KEY (sid, supid, serial_no)
);

CREATE TABLE NonGUCStudentRegisterThesis (
    sid INTEGER REFERENCES NonGucianStudent(id),
    supid INTEGER REFERENCES Supervisor(id),
    serial_no INTEGER REFERENCES Thesis(serialNumber),
    PRIMARY KEY (sid, supid, serial_no)
);

CREATE TABLE ExaminerEvaluateDefense (
    date DATE NOT NULL,
    serialNo INTEGER REFERENCES Thesis(serialNumber),
    examinerId INTEGER REFERENCES Examiner(id),
    comment TEXT NOT NULL,
    grade DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (date, serialNo, examinerId)
);

CREATE TABLE ThesisHasPublication (
    serialNo INTEGER REFERENCES Thesis(serialNumber),
    pubid INTEGER REFERENCES Publication(id),
    PRIMARY KEY (serialNo, pubid)
);