-- PRAGMA foreign_keys = ON;

ALTER TABLE Albums DROP CONSTRAINT cover_photo;

DROP TABLE Tags;
DROP TABLE Photos;
DROP TABLE Albums;
DROP TABLE Participants;
DROP TABLE User_Events;
DROP TABLE Education;
DROP TABLE Programs;
DROP TABLE Messages;
DROP TABLE User_Hometown_Cities;
DROP TABLE User_Current_Cities;
DROP TABLE Cities;
DROP TABLE Friends;
DROP TABLE Users;

DROP SEQUENCE CITIES_ID;
DROP SEQUENCE PROGRAMS_ID;