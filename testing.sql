-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema enrollment_project
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `enrollment_project` ;

-- -----------------------------------------------------
-- Schema enrollment_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `enrollment_project` DEFAULT CHARACTER SET utf8 ;
USE `enrollment_project` ;

-- -----------------------------------------------------
-- Table `enrollment_project`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`college` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`),
  UNIQUE INDEX `college_id_UNIQUE` (`college_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enrollment_project`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`department` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(45) NOT NULL,
  `department_code` VARCHAR(45) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE INDEX `department_id_UNIQUE` (`department_id` ASC) VISIBLE,
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `enrollment_project`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enrollment_project`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`courses` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_num` INT NOT NULL,
  `course_title` VARCHAR(45) NOT NULL,
  `course_credits` INT NOT NULL,
  `department_id` INT NOT NULL,
  `course_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE INDEX `course_id_UNIQUE` (`course_id` ASC) VISIBLE,
  INDEX `fk_courses_department_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `enrollment_project`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enrollment_project`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`term` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `term` VARCHAR(45) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`term_id`),
  UNIQUE INDEX `term_id_UNIQUE` (`term_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enrollment_project`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`faculty` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(45) NOT NULL,
  `faculty_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`faculty_id`),
  UNIQUE INDEX `faculity_id_UNIQUE` (`faculty_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enrollment_project`.`sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`sections` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`sections` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `section_number` INT NOT NULL,
  `section_capacity` INT NOT NULL,
  `course_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  UNIQUE INDEX `sections_id_UNIQUE` (`section_id` ASC) VISIBLE,
  INDEX `fk_sections_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_sections_courses1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_sections_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `fk_sections_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `enrollment_project`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `enrollment_project`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `enrollment_project`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enrollment_project`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`student` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `f_name` VARCHAR(45) NOT NULL,
  `l_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `student_dob` DATE NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enrollment_project`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enrollment_project`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `enrollment_project`.`enrollment` (
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `student_id`),
  INDEX `fk_sections_student_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_sections_student_sections1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_sections_student_sections1`
    FOREIGN KEY (`section_id`)
    REFERENCES `enrollment_project`.`sections` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_student_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `enrollment_project`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE enrollment_project;

INSERT INTO student (student_id, f_name, l_name, gender, city, state, student_dob)
VALUES (1001, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22')
,	(1002, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22')
,	(1003, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22')
,	(1004, 'Devon', 'Merril', 'M', 'Messa', 'AZ', '2000-07-22')
,	(1005, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22')
,	(1006, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22')
,	(1007, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22')
,	(1008, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22')
,	(1009, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22')
,	(1010, 'Susan', 'Sorensen', 'F', 'Messa', 'AZ', '1998-08-09');

INSERT INTO term (term_id, term, year)
Values('1001', 'Fall', 2019)
,	('1002', 'Winter', 2018);

-- still need to create inserts for sections

INSERT INTO college (college_id, college_name)
VALUES(1001,'College of Physical Science and Engineering')
,	(1002, 'College of Business and Communication')
,	(1003, 'College of Language and Letters');

INSERT INTO department (department_id, department_name, department_code, college_id)
VALUES(1001, 'Computer Information Technology', 'CIT', 1001)
,	(1002, 'Economics', 'ECON', 1002)
,	(1003, 'Humanities and Philosophy', 'HUM', 1003);

INSERT INTO courses (course_id, course_num, course_title, course_credits, department_id)
VALUES('1001', 111, 'Intro to Databases', 3, 1001)
,	('1002', 388, 'Econometrics', 4,, 1002)
,	('1003', 150, 'Micro Economics', 3, 1002)
,	('1004', 376, 'Classical Heritage', 2, 1003);

INSERT INTO faculty (faculty_id, faculty_fname, faculty_lname)
VALUES(1001, 'Marty', 'Morring')
,	(1002, 'Nate', 'Norris')
,	(1003, 'Ben', 'Barrus')
,	(1004, 'John', 'Jensen')
,	(1005, 'Bill', 'Barney');

INSERT INTO sections(section_id, section_number, section_capacity, course_id, term_id, faculty_id)
VALUES(1001, 1, 30, 1001, 1001, 1001)
,	(1002, 1, 50, 1003, 1001, 1002)
,	(1003, 2, 50, 1003, 1001, 1002)
,	(1004, 1, 35, 1002, 1001, 1003)
,	(1005, 1, 30, 1004, 1001, 1004)
,	(1006, 2, 30, 1001, 1002, 1001)
,	(1007, 3, 35, 1001, 1002, 1005)
,	(1008, 1, 50, 1003, 1002, 1002)
,	(1009, 2, 50, 1003, 1002, 1002)
,	(1010, 1, 30, 1004, 1002, 1004);

INSERT INTO enrollment(student_id, section_id)
VALUES(1006, 1007)
,	(1007, 1006)
,	(1007, 1008)
,	(1007, 1010)
,	(1004, 1005)
,	(1009, 1009)
,	(1002, 1004)
,	(1003, 1004)
,	(1005, 1004)
,	(1005, 1005)
,	(1001, 1001)
,	(1001, 1003)
,	(1008, 1009)
,	(1010, 1006);

-- select * from student;
-- select * from faculty;
-- select * from college;
-- select * from courses;
-- select * from department;
-- select * from enrollment;
-- select * from sections;
-- select * from term;

-- catalog view


SELECT college.college_name, department.department_name, department.department_code, courses.course_num, courses.course_title, courses.course_credits
FROM courses
JOIN department ON courses.department_id = department.department_id
JOIN college ON department.college_id = college.college_id;


-- section view


 SELECT term.year, 
		term.term,
       courses.course_name, 
       sections.section_number,
       faculty.faculty_fname,
       faculty.faculty_lname,
       sections.section_capacity
FROM term
JOIN sections ON term.term_id = sections.term_id
JOIN faculty ON faculty.faculty_id = sections.faculty_id
JOIN courses On sections.course_id = courses.course_id;


-- Student view

SELECT * FROM student; 

-- Enrollment view

SELECT concat(f_name, ' enrolling in ',
       courses.course_name, ' ', 
       term.term, ' ',
       term.year, ' Section ',
       sections.section_number) AS enrollment
FROM student
JOIN enrollment ON student.student_id = enrollment.student_id
JOIN sections ON sections.section_id = enrollment.section_id
JOIN courses ON courses.course_id = sections.course_id
JOIN term ON term.term_id = sections.term_id
ORDER BY f_name; 


