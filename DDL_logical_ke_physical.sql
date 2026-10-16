CREATE TABLE Branch (
    branchNo VARCHAR(5) PRIMARY KEY,
    mgrStaffNo VARCHAR(5) -- ini bakalan di-alter nanti karena hubungan circular constraint
);

CREATE TABLE Telephone (
    telNo VARCHAR(15) PRIMARY KEY,
    branchNo VARCHAR(5) NOT NULL,
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

CREATE TABLE Staff (
    staffNo VARCHAR(5) PRIMARY KEY,
    supervisorStaffNo VARCHAR(5),
    branchNo VARCHAR(5) NOT NULL,
    FOREIGN KEY (supervisorStaffNo) REFERENCES Staff(staffNo),
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

-- foreign key untuk manajer cabang
ALTER TABLE Branch ADD CONSTRAINT fk_branch_mgr FOREIGN KEY (mgrStaffNo) REFERENCES Staff(staffNo);

CREATE TABLE Manager (
    staffNo VARCHAR(5) PRIMARY KEY,
    FOREIGN KEY (staffNo) REFERENCES Staff(staffNo)
);

CREATE TABLE Client (
    clientNo VARCHAR(5) PRIMARY KEY
);

CREATE TABLE Registration (
    clientNo VARCHAR(5) PRIMARY KEY,
    branchNo VARCHAR(5) NOT NULL,
    staffNo VARCHAR(5) NOT NULL,
    FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo),
    FOREIGN KEY (staffNo) REFERENCES Staff(staffNo)
);

CREATE TABLE PrivateOwner (
    ownerNo VARCHAR(5) PRIMARY KEY
);

CREATE TABLE BusinessOwner (
    ownerNo VARCHAR(5) PRIMARY KEY
);

CREATE TABLE PropertyForRent (
    propertyNo VARCHAR(5) PRIMARY KEY,
    ownerNo VARCHAR(5) NOT NULL, 
    staffNo VARCHAR(5),
    branchNo VARCHAR(5) NOT NULL,
    FOREIGN KEY (staffNo) REFERENCES Staff(staffNo),
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

CREATE TABLE Viewing (
    clientNo VARCHAR(5),
    propertyNo VARCHAR(5),
    PRIMARY KEY (clientNo, propertyNo),
    FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
    FOREIGN KEY (propertyNo) REFERENCES PropertyForRent(propertyNo)
);

CREATE TABLE Lease (
    leaseNo VARCHAR(5) PRIMARY KEY,
    clientNo VARCHAR(5) NOT NULL,
    propertyNo VARCHAR(5) NOT NULL,
    FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
    FOREIGN KEY (propertyNo) REFERENCES PropertyForRent(propertyNo)
);

CREATE TABLE Newspaper (
    newspaperName VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Advert (
    propertyNo VARCHAR(5),
    newspaperName VARCHAR(50),
    dateAdvert DATE,
    PRIMARY KEY (propertyNo, newspaperName, dateAdvert),
    FOREIGN KEY (propertyNo) REFERENCES PropertyForRent(propertyNo),
    FOREIGN KEY (newspaperName) REFERENCES Newspaper(newspaperName)
);