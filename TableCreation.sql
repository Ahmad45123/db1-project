-- PostGradUser (id, email, password)
-- Admin(id) _ _
-- Where Admin.id references PostGradUser
-- GucianStudent( id,firstName, lastName, type, faculty, address, GPA, undergradID) _ _
-- Where GucianStudent.id references PostGradUser
-- NonGucianStudent( id,firstName, lastName, type,faculty,address,GPA ) _ _
-- Where NonGucianStudent.id references PostGradUser
-- GUCStudentPhoneNumber ( id,phone) _ _
-- Where GUCStudentPhoneNumber.id references GucianStudent
-- NonGUCStudentPhoneNumber ( id,phone) _ _
-- Where NonGUCStudentPhoneNumber.id references NonGucianStudent
-- Course (id, fees,creditHours, code)
-- Supervisor (id, name, faculty) _ _
-- Where Supervisor.id references PostGradUser
-- Thesis (serialNumber, field, type, title, startDate, endDate, defenseDate, years, grade,
-- payment_id, noExtension) _ _ _ _ _ _
-- Where thesis.years = endDate - startDate ,
-- payment_id references Payment
-- Publication (id, title, date, place, accepted, host)
-- Payment (id, amount, no_Installments, fundPercentage)
-- Examiner (id, name, fieldOfWork, isNational ) _ _
-- Where Examiner.id references PostGradUser
-- Defense (serialNumber, date, location, grade) _ _ _ _ _ _ _
-- Where Defense.serial_no references Thesis
-- GUCianProgressReport (sid, no, date, eval, state, thesisSerialNumber, supid) _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
-- Where ProgressReport.sid references GucianStudent
-- , thesisSerialNumber references Thesis,
-- ProgressReport.supid references Supervisor
-- NonGUCianProgressReport (sid, no, date, eval, state, thesisSerialNumber, supid) _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
-- Where ProgressReport.sid references NonGucianStudent
-- , thesisSerialNumber references Thesis,
-- ProgressReport.supid references Supervisor
-- Installment (date, paymentId, amount, done) _ _ _ _ _ _
-- Where paymentId references Payment
-- NonGucianStudentPayForCourse(sid, paymentNo, cid) _ _ _ _ _ _ _ _ _ _
-- Where NonGucianStudentPayForCourse.sid references NonGucianStudent
-- , NonGucianStudentPayForCourse.paymentNo references Payment
-- , NonGucianStudentPayForCourse.cid references Course
-- NonGucianStudentTakeCourse (sid, cid, grade) _ _ _ _
-- Where NonGucianStudentTakeCourse .sid references NonGucianStudent
-- , NonGucianStudentTakeCourse .cid references Course
-- GUCianStudentRegisterThesis (sid, supid, serial_no) _ _ _ _ _ _ _ _ _
-- Where sid references GucianStudent,
-- supid references Supervisor
-- , serialNo references Thesis
-- NonGUCianStudentRegisterThesis (sid, supid, serial_no) _ _ _ _ _ _ _ _ _
-- Where sid references NonGucianStudent,
-- supid references Supervisor
-- , serialNo references Thesis
-- ExaminerEvaluateDefense(date, serialNo, examinerId, comment) _ _ _ _ _ _ _ _ _ _ _ _ _
-- Where date and serialNo references Defense
-- , examinerId references Examiner
-- ThesisHasPublication(serialNo,pubid)
-- _ _ _ _ _ _ _ _
-- Where ThesisHasPublication.serialNo references Thesis,
-- ThesisHasPublication.pubid references Publication

CREATE TABLE PostGradUser (
    id INT PRIMARY KEY IDENTITY,
    email TEXT NOT NULL,
    password TEXT NOT NULL
); 

CREATE TABLE Admin(
    id INT PRIMARY KEY REFERENCES PostGradUser(id)
);

CREATE TABLE GucianStudent (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    type TEXT NOT NULL,
    faculty TEXT NOT NULL,
    address TEXT NOT NULL,
    GPA DECIMAL(3,2) NOT NULL,
    undergradID VARCHAR(10) NOT NULL,
);

CREATE TABLE NonGucianStudent (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    type TEXT NOT NULL,
    faculty TEXT NOT NULL,
    address TEXT NOT NULL,
    GPA DECIMAL(3,2) NOT NULL
);

CREATE TABLE GUCStudentPhoneNumber (
    id INT REFERENCES GucianStudent(id),
    phone TEXT NOT NULL,
    PRIMARY KEY(id, phone)
);

CREATE TABLE NonGUCStudentPhoneNumber (
    id INT REFERENCES NonGucianStudent(id),
    phone TEXT NOT NULL,
    PRIMARY KEY(id, phone)
);

CREATE TABLE Course (
    id INT PRIMARY KEY IDENTITY,
    fees DECIMAL(5,2) NOT NULL,
    creditHours INT NOT NULL,
    code TEXT NOT NULL
);

CREATE TABLE Supervisor (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    name TEXT NOT NULL,
    faculty TEXT NOT NULL
);

CREATE TABLE Thesis (
    serialNumber INT PRIMARY KEY IDENTITY,
    field TEXT NOT NULL,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    defenseDate Datetime NOT NULL,
    years AS year(endDate) - year(startDate),
    grade DECIMAL(3,2) NOT NULL,
    payment_id INT REFERENCES Payment(id),
    noExtension INT NOT NULL
);

CREATE Table Publication(
    id INT PRIMARY KEY IDENTITY,
    title TEXT NOT NULL,
    date DATE NOT NULL,
    place TEXT NOT NULL,
    accepted BOOLEAN NOT NULL,
    host TEXT NOT NULL
);

CREATE TABLE Payment (
    id INT PRIMARY KEY IDENTITY,
    amount DECIMAL(5,2) NOT NULL,
    no_Installments INT NOT NULL,
    fundPercentage DECIMAL(3,2) NOT NULL
);

CREATE TABLE Examiner (
    id INT PRIMARY KEY REFERENCES PostGradUser(id),
    name TEXT NOT NULL,
    fieldOfWork TEXT NOT NULL,
    isNational TEXT NOT NULL
);

CREATE TABLE Defense (
    serialNumber INT REFERENCES Thesis(serialNumber),
    date Datetime NOT NULL,
    location varchar(15) NOT NULL,
    grade DECIMAL(3,2),
    PRIMARY KEY(serialNumber, date)
);

CREATE TABLE GUCianProgressReport (
    sid INT REFERENCES GucianStudent(id),
    no INT NOT NULL,
    date DATE NOT NULL,
    eval TEXT NOT NULL,
    state TEXT NOT NULL,
    thesisSerialNumber INT REFERENCES Thesis(serialNumber),
    supid INT REFERENCES Supervisor(id),
    PRIMARY KEY (sid, no)
);

CREATE TABLE NonGUCianProgressReport (
    sid INT REFERENCES NonGucianStudent(id),
    no INT NOT NULL,
    date DATE NOT NULL,
    eval TEXT NOT NULL,
    state TEXT NOT NULL,
    thesisSerialNumber INT REFERENCES Thesis(serialNumber),
    supid INT REFERENCES Supervisor(id),
    PRIMARY KEY (sid, no)
);

CREATE TABLE Installment (
    date DATE NOT NULL,
    paymentId INT REFERENCES Payment(id),
    amount DECIMAL(5,2) NOT NULL,
    done INT NOT NULL,
    PRIMARY KEY (date, paymentId)
);

CREATE TABLE NonGucianStudentPayForCourse (
    sid INT REFERENCES NonGucianStudent(id),
    paymentNo INT NOT NULL,
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
    comment varchar(300),
    PRIMARY KEY (date, serialNo, examinerId)
);

CREATE TABLE ThesisHasPublication (
    serialNo INT REFERENCES Thesis(serialNumber),
    pubid INT REFERENCES Publication(id),
    PRIMARY KEY (serialNo, pubid)
);