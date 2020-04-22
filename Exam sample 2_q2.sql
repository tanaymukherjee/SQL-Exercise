CREATE SCHEMA `university` ;

CREATE TABLE `university`.`student` (
  `name` VARCHAR(45) NOT NULL,
  `student_num` VARCHAR(45) NOT NULL,
  `class` VARCHAR(45) NULL,
  `major` VARCHAR(45) NULL,
  PRIMARY KEY (`student_num`, `name`));
  
  CREATE TABLE `university`.`course` (
  `course_name` VARCHAR(45) NOT NULL,
  `course_num` VARCHAR(45) NOT NULL,
  `credits` VARCHAR(45) NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`course_num`));
  
  CREATE TABLE `university`.`section` (
  `section_id` VARCHAR(45) NOT NULL,
  `course_num` VARCHAR(45) NOT NULL,
  `semester` VARCHAR(45) NOT NULL,
  `year` VARCHAR(45) NOT NULL,
  `instructor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`section_id`, `course_num`));
  
  CREATE TABLE `university`.`gradereport` (
  `student_num` VARCHAR(45) NOT NULL,
  `section_id` VARCHAR(45) NOT NULL,
  `grade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_num`, `section_id`));
  
INSERT INTO `university`.`student` (`name`, `student_num`, `class`, `major`) VALUES ('Tanay', '123', '2019', 'DS');
INSERT INTO `university`.`student` (`name`, `student_num`, `class`, `major`) VALUES ('Youran', '456', '2019', 'Stat');
INSERT INTO `university`.`student` (`name`, `student_num`, `class`, `major`) VALUES ('Chau', '789', '2019', 'BA');
INSERT INTO `university`.`student` (`name`, `student_num`, `class`, `major`) VALUES ('Jon', '124', '2018', 'CSE');
INSERT INTO `university`.`student` (`name`, `student_num`, `class`, `major`) VALUES ('Jorge', '287', '2019', 'Econ');

INSERT INTO `university`.`course` (`course_name`, `course_num`, `credits`, `department`) VALUES ('DBMS', 'CIS 9340', '9', 'CIS');
INSERT INTO `university`.`course` (`course_name`, `course_num`, `credits`, `department`) VALUES ('Big Data', 'STA 9760', '9', 'STA');
INSERT INTO `university`.`course` (`course_name`, `course_num`, `credits`, `department`) VALUES ('BA', 'CIS 9467', '9', 'CIS');
INSERT INTO `university`.`course` (`course_name`, `course_num`, `credits`, `department`) VALUES ('Multivariate', 'STA 9705', '9', 'STA');
INSERT INTO `university`.`course` (`course_name`, `course_num`, `credits`, `department`) VALUES ('Econometrics', 'FIN 100', '9', 'FIN');

INSERT INTO `university`.`section` (`section_id`, `course_num`, `semester`, `year`, `instructor`) VALUES ('11', 'CIS 9467', '2', '2020', 'Wang');
INSERT INTO `university`.`section` (`section_id`, `course_num`, `semester`, `year`, `instructor`) VALUES ('22', 'CIS 9340', '2', '2020', 'Ann');
INSERT INTO `university`.`section` (`section_id`, `course_num`, `semester`, `year`, `instructor`) VALUES ('33', 'STA 9705', '1', '2019', 'Yu');
INSERT INTO `university`.`section` (`section_id`, `course_num`, `semester`, `year`, `instructor`) VALUES ('44', 'STA 9760', '2', '2020', 'Taq');

INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('123', '11', '80');
INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('456', '11', '85');
INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('789', '11', '90');
INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('124', '11', '95');
INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('287', '11', '100');
INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('123', '22', '100');
INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('456', '22', '95');
INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('789', '22', '90');
INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('124', '22', '85');
INSERT INTO `university`.`gradereport` (`student_num`, `section_id`, `grade`) VALUES ('287', '22', '80');

## (a)
WITH total_credit as (
select st.name, c.credits from 
university.student as st join
university.gradereport as gr
on st.student_num = gr.student_num join
university.section as s on
s.section_id = gr.section_id join
university.course as c on
c.course_num = s.course_num
where st.name in (
Select st.name from 
university.student as st join
university.gradereport as gr
on st.student_num = gr.student_num join
university.section as s on
s.section_id = gr.section_id
where s.course_num LIKE '%CIS%'
)) select distinct name, sum(credits) from total_credit group by name, credits;

## (b)
select s.semester, s.year, st.name
from university.student as st join
university.gradereport as gr
on st.student_num = gr.student_num join
university.section as s on
s.section_id = gr.section_id join
university.course as c on
c.course_num = s.course_num where
s.course_num in ("CIS 9340", "CIS 9467")
group by st.name
having count(distinct s.year) = 1 AND count(distinct s.semester) = 1;

## Aliases:
university.student as st
university.section as s
university.gradereport as gr
university.course as c