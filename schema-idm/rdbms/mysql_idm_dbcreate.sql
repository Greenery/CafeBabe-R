/* Creates the DB and initial user account and privleges */

CREATE database openiam DEFAULT CHARACTER SET utf8
CHARACTER SET = utf8;
USE openiam;

CREATE USER 'idmuser'@'localhost' IDENTIFIED BY 'idmuser';
GRANT ALL ON *.* TO 'idmuser'@'localhost'; 

/* enable remote access to the database */
GRANT ALL ON openiam.* TO idmuser@'*' IDENTIFIED BY 'idmuser';
