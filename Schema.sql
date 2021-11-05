CREATE TABLE Academic(ID INT PRIMARY KEY IDENTITY, 
    FirstName VARCHAR(20), 
    LastName VARCHAR(20), 
    Email VARCHAR(50), 
    Faculty VARCHAR(20)
);

CREATE TABLE Student(
    Academic_ID INT PRIMARY KEY FOREIGN KEY REFERENCES Academic.ID,
    Type VARCHAR(6), 
    GPA DECIMAL(5, 4), 
    student_address VARCHAR(20), 
    PhoneNumber1 VARCHAR(20), 
    PhoneNumber2 VARCHAR(20)
);

CREATE TABLE Supervisor(
    academic_ID INT PRIMARY KEY FOREIGN KEY REFERENCES Academic.ID
);


CREATE TABLE GUCian(
    student_id INT PRIMARY KEY FOREIGN KEY REFERENCES Student.ID,
    undergrad_ID INT
);

CREATE TABLE non_GUCian(
    student_id INT PRIMARY KEY FOREIGN KEY REFERENCES Student.ID,
);

CREATE TABLE Publication(
    ID INT PRIMARY KEY,
    owner_ID INT FOREIGN KEY REFERENCES Student.ID,
    Payment_ID INT FOREIGN KEY REFERENCES Payment.ID,
    Accepted BIT,
    publication_date DATETIME,
    title VARCHAR(100),
    host VARCHAR(40),
    place VARCHAR(100)
);

CREATE TABLE PublishedOn(
    publication_ID INT PRIMARY KEY FOREIGN KEY REFERENCES Publication.ID,
    thesis_SN INT PRIMARY KEY FOREIGN KEY REFERENCES Thesis.SerialNumber,
);

CREATE TABLE Payment(
    ID INT PRIMARY KEY,
    no_installments INT,
    total_amount DECIMAL(10, 2),
    fund_percentage DECIMAL(4, 2)
);

CREATE TABLE Installment(
    ID INT PRIMARY KEY,
    payment_ID INT FOREIGN KEY REFERENCES Payment.ID,
    installment_date DATETIME,
    amount DECIMAL(10, 2),
    installment_status DECIMAL(10, 2)
);

CREATE TABLE Examiner(
    ID INT PRIMARY KEY,
    examiner_type VARCHAR(20),
    field_of_work VARCHAR(20),
    first_name VARCHAR(20),
    last_name VARCHAR(20)
);

CREATE TABLE Evaluates(
    examiner_ID INT FOREIGN KEY REFERENCES Examiner.ID,
    thesis_SN INT FOREIGN KEY REFERENCES Thesis.SerialNumber,
);

CREATE TABLE Defense(
    examiner_ID INT FOREIGN KEY REFERENCES Examiner.ID,
    thesis_SN INT FOREIGN KEY REFERENCES Thesis.SerialNumber,
    defense_date DATETIME,
    defense_location VARCHAR(100),
    defense_grade DECIMAL(4, 2)
);

CREATE TABLE Thesis(
    serialNumber INT PRIMARY KEY,
    paymentID INT FOREIGN KEY REFERENCES Payment.ID,
    title VARCHAR(100),
    thesisType VARCHAR(20),
    fieldOfWork VARCHAR(20),
    extensionsNeeded INT,
    startDate DATETIME,
    endDate DATETIME,
    seminarDate DATETIME,
    yearsSpent AS year(CURRENT_TIMESTAMP) - year(startDate),
);

CREATE TABLE ProgressReport(
    report_ID INT PRIMARY KEY,
    thesisSN INT FOREIGN KEY REFERENCES Thesis.serialNumber,
    thesisDescription VARCHAR(1000),
    thesisDate DATETIME,
    evaluation DECIMAL(4, 2),
    thesisState INT
);