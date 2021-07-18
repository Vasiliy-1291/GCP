CREATE TABLE USERS (
    ID int,
    Name varchar(255),
    Email varchar(255),
    Position varchar(255),
    Department_ID int
);
CREATE TABLE DEPARTMENTS (
    ID int,
    Department_Name varchar(255)
);
INSERT INTO USERS VALUES (1,'Vasil','Vasil@epam.com','DevOps',1);
INSERT INTO USERS VALUES (2,'Irina','Irina@epam.com','HR',2);
INSERT INTO USERS VALUES (3,'Max','Max@emap.com','developer',3);
INSERT INTO USERS VALUES (4,'Petr','petr@emap.com','support',4);
INSERT INTO USERS VALUES (5,'Ivan','Ivan@emap.com','manager',5);
INSERT INTO DEPARTMENTS VALUES (1,'DevOps');
INSERT INTO DEPARTMENTS VALUES (2,'HR');
INSERT INTO DEPARTMENTS VALUES (3,'developers');
INSERT INTO DEPARTMENTS VALUES (4,'Support');
INSERT INTO DEPARTMENTS VALUES (5,'manager');