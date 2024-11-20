drop database if exists MySchool;
create database MySchool;
use MySchool;

create table Persons
(
	person_id int not null primary key auto_increment,
    first_name varchar(50),
    last_name varchar(50)
);

INSERT INTO Persons (first_name, last_name)
VALUES 
('John', 'Doe'),
('Jane', 'Smith'),
('Michael', 'Johnson'),
('Emily', 'Davis'),
('Christopher', 'Brown'),
('Amanda', 'Wilson'),
('David', 'Jones'),
('Jessica', 'Garcia'),
('Matthew', 'Martinez'),
('Laura', 'Hernandez'),
('James', 'Lopez'),
('Megan', 'Clark'),
('Andrew', 'Lewis'),
('Hannah', 'Walker'),
('Ryan', 'Young'),
('Sarah', 'Allen'),
('Joshua', 'Hall'),
('Sophia', 'King'),
('Justin', 'Wright'),
('Olivia', 'Scott'),
('Daniel', 'Torres'),
('Emma', 'Nguyen'),
('Nathan', 'Baker'),
('Isabella', 'Rivera'),
('Ethan', 'Adams'),
('Mia', 'Gonzalez'),
('Aaron', 'Carter'),
('Ava', 'Mitchell'),
('Tyler', 'Perez'),
('Chloe', 'Roberts'),
('Alexander', 'Turner'),
('Lily', 'Phillips'),
('Zachary', 'Campbell'),
('Grace', 'Parker'),
('Jacob', 'Evans'),
('Victoria', 'Edwards'),
('Anthony', 'Collins'),
('Abigail', 'Stewart'),
('Brandon', 'Sanchez'),
('Ella', 'Morris'),
('Samuel', 'Rogers'),
('Layla', 'Reed'),
('Nicholas', 'Cook'),
('Zoey', 'Morgan'),
('Benjamin', 'Bell'),
('Avery', 'Murphy'),
('Jack', 'Bailey'),
('Ellie', 'Cooper'),
('Logan', 'Richardson'),
('Harper', 'Ward');

create table Teachers
(
	teacher_id int not null primary key auto_increment,
    person_id int not null,
    FOREIGN KEY (person_id) REFERENCES Persons(person_id),
    UNIQUE(person_id)
);

insert into Teachers (person_id)
values
(1),
(7),
(42),
(37),
(14);

create table Students
(
	student_id int not null primary key auto_increment,
    person_id int not null,
    FOREIGN KEY (person_id) REFERENCES Persons(person_id),
    UNIQUE(person_id)
);

insert into Students (person_id)
values
(2),
(3),
(4),
(5),
(6),
(8),
(9),
(10),
(11),
(12),
(13),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23);


create table Courses
(
	course_id int not null primary key auto_increment,
    teacher_id int not null,
    name varchar(60),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

INSERT INTO Courses (teacher_id, name)
VALUES 
(1, 'Introduction to Computer Science'),
(2, 'Calculus I'),
(5, 'Principles of Marketing'),
(3, 'Introduction to Psychology'),
(1, 'World History 101'),
(4, 'Organic Chemistry'),
(5, 'Microeconomics'),
(1, 'Fundamentals of Physics'),
(3, 'Art and Design Basics'),
(1, 'Data Structures and Algorithms');

create table Enrollment
(
	student_id int not null,
    course_id int not null,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Enroll students in courses
-- Enroll students in courses
INSERT INTO Enrollment (student_id, course_id)
VALUES
    (1, 1),  -- Student 1 (Jane Smith) in Introduction to Computer Science
    (2, 1),  -- Student 2 (Michael Johnson) in Introduction to Computer Science
    (3, 2),  -- Student 3 (Emily Davis) in Calculus I
    (4, 2),  -- Student 4 (Christopher Brown) in Calculus I
    (5, 3),  -- Student 5 (Amanda Wilson) in Principles of Marketing
    (6, 3),  -- Student 6 (David Jones) in Principles of Marketing
    (7, 4),  -- Student 7 (Jessica Garcia) in Introduction to Psychology
    (8, 4),  -- Student 8 (Matthew Martinez) in Introduction to Psychology
    (9, 5),  -- Student 9 (Laura Hernandez) in World History 101
    (10, 5), -- Student 10 (James Lopez) in World History 101
    (11, 6), -- Student 11 (Megan Clark) in Organic Chemistry
    (12, 6), -- Student 12 (Andrew Lewis) in Organic Chemistry
    (13, 7), -- Student 13 (Hannah Walker) in Microeconomics
    (14, 7), -- Student 14 (Ryan Young) in Microeconomics
    (15, 8), -- Student 15 (Sarah Allen) in Fundamentals of Physics
    (16, 8), -- Student 16 (Joshua Hall) in Fundamentals of Physics
    (17, 9), -- Student 17 (Sophia King) in Art and Design Basics
    (18, 9), -- Student 18 (Justin Wright) in Art and Design Basics
    (19, 10),-- Student 19 (Olivia Scott) in Data Structures and Algorithms
    (20, 10);-- Student 20 (Emma Nguyen) in Data Structures and Algorithms


    
