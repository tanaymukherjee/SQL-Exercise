CREATE TABLE `scheduling`.`course` (
  `department` INT NOT NULL,
  `course_number` VARCHAR(45) NOT NULL,
  `course_name` VARCHAR(45) NULL,
  PRIMARY KEY (`course_number`));

CREATE TABLE `scheduling`.`classroom` (
  `building` VARCHAR(45) NOT NULL,
  `room_number` VARCHAR(45) NOT NULL,
  `capacity` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`room_number`));

CREATE TABLE `scheduling`.`employment` (
  `instructor_name` VARCHAR(45) NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  `salary` VARCHAR(45) NULL,
  PRIMARY KEY (`department`, `instructor name`));

CREATE TABLE `scheduling`.`instructor` (
  `instructor_name` VARCHAR(45) NOT NULL,
  `building` VARCHAR(45) NOT NULL,
  `room_number` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`instructor name`, `room number`));

CREATE TABLE `scheduling`.`schedule` (
  `department` VARCHAR(45) NOT NULL,
  `course_number` VARCHAR(45) NOT NULL,
  `section` VARCHAR(45) NOT NULL,
  `building` VARCHAR(45) NOT NULL,
  `room_number` VARCHAR(45) NOT NULL,
  `instructor_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`course_number`, `instructor_name`));

INSERT INTO `scheduling`.`course` (`department`, `course_number`, `course_name`) VALUES ('CIS', '9340', 'DBMS');
INSERT INTO `scheduling`.`course` (`department`, `course_number`, `course_name`) VALUES ('STA', '9890', 'Data Mining');
INSERT INTO `scheduling`.`course` (`department`, `course_number`, `course_name`) VALUES ('STA', '9705', 'Multivariate');
INSERT INTO `scheduling`.`course` (`department`, `course_number`, `course_name`) VALUES ('CIS', '9760', 'Big Data');
INSERT INTO `scheduling`.`course` (`department`, `course_number`, `course_name`) VALUES ('STA', '9715', 'Probability');

INSERT INTO `scheduling`.`classroom` (`building`, `room_number`, `capacity`) VALUES ('VC', '4211', '30');
INSERT INTO `scheduling`.`classroom` (`building`, `room_number`, `capacity`) VALUES ('VC', '1050', '55');
INSERT INTO `scheduling`.`classroom` (`building`, `room_number`, `capacity`) VALUES ('NVC', '9999', '50');
INSERT INTO `scheduling`.`classroom` (`building`, `room_number`, `capacity`) VALUES ('NVC', '1111', '60');

INSERT INTO `scheduling`.`employment` (`instructor_name`, `department`, `salary`) VALUES ('Wang', 'CIS', '80000');
INSERT INTO `scheduling`.`employment` (`instructor_name`, `department`, `salary`) VALUES ('Yu', 'STA', '85000');
INSERT INTO `scheduling`.`employment` (`instructor_name`, `department`, `salary`) VALUES ('Rad', 'STA', '100000');
INSERT INTO `scheduling`.`employment` (`instructor_name`, `department`, `salary`) VALUES ('Ann', 'STA', '120000');
INSERT INTO `scheduling`.`employment` (`instructor_name`, `department`, `salary`) VALUES ('Tatum', 'CIS', '60000');
INSERT INTO `scheduling`.`employment` (`instructor_name`, `department`, `salary`) VALUES ('Oliver Twist', 'CIS', '50000');

INSERT INTO `scheduling`.`schedule` (`department`, `course_number`, `section`, `building`, `room_number`, `instructor_name`, `enrollment`) VALUES (CIS, '9340', 'CIS', 'VC', '4211', 'wang', '30');
INSERT INTO `scheduling`.`schedule` (`department`, `course_number`, `section`, `building`, `room_number`, `instructor_name`, `enrollment`) VALUES ('STA', '9705', 'STAT', 'NVC', '1111', 'Yu', '40');
INSERT INTO `scheduling`.`schedule` (`department`, `course_number`, `section`, `building`, `room_number`, `instructor_name`, `enrollment`) VALUES ('STA', '9715', 'STAT', 'NVC', '9999', 'Ann', '55');

## (a)
select e.instructor_name, i.phone_number, e.department from 
scheduling.employment as e join
scheduling.schedule as s on
e.instructor_name = s.instructor_name join
scheduling.instructor i on
s.instructor_name = i.instructor_name join
scheduling.classroom cr on
s.room_number = cr.room_number
where cr.room_number > 50;

## (b)
select e.instructor_name, e.salary from scheduling.employment as e
where e.salary > 
(select e.salary from scheduling.employment as e where e.instructor_name in ('Oliver Twist') and
e.department in ('CIS'));

## (c)
select max(e.salary), min(e.salary), avg(e.salary), count(s.instructor_name) from 
scheduling.employment as e join
scheduling.schedule as s on
e.instructor_name = s.instructor_name 
where s.enrollment > 50;

## (d)
select e.instructor_name, e.salary from 
scheduling.employment as e join
scheduling.schedule as s on
e.instructor_name = s.instructor_name where
e.salary > (select e.salary from scheduling.employment as e join
scheduling.schedule as s on
e.instructor_name = s.instructor_name where
s.room_number in ('4211'));

## Aliases:
scheduling.classroom as cr
scheduling.course as c
scheduling.employment as e
scheduling.instructor as i
scheduling.schedule as s
