﻿CREATE TABLE PERSON
(
  PId INT NOT NULL,
  PName VARCHAR(20) NOT NULL,
  PRIMARY KEY (PId)
);

CREATE TABLE MODEL
(
  MCC INT,
  MVIN VARCHAR(30) NOT NULL,
  MFuel VARCHAR(1),
  MEngine VARCHAR(20),
  MHP INT,
  MWeight INT,
  PRIMARY KEY (MVIN)
);

CREATE TABLE OBD_PARAMETER
(
  OBDHexCode INT NOT NULL,
  OBDLabel VARCHAR(20) NOT NULL,
  PRIMARY KEY (OBDHexCode)
);

CREATE TABLE GPS_DATA
(
  GPSTs INT NOT NULL,
  GPSLatitude INT NOT NULL,
  GPSLongitude INT NOT NULL,
  PRIMARY KEY (GPSTs)
);

CREATE TABLE VEHICLE
(
  VVIN VARCHAR(30) NOT NULL,
  MVIN VARCHAR(30) NOT NULL,
  PRIMARY KEY (VVIN),
  FOREIGN KEY (MVIN) REFERENCES MODEL(MVIN)
);

CREATE TABLE TRACK
(
  TId INT NOT NULL,
  TInitDate DATE NOT NULL,
  TInitHour TIME NOT NULL,
  TDistance INT NOT NULL,
  TArea GIS,
  TPolyLine GIS,
  TInitSec INT NOT NULL,
  PId INT NOT NULL,
  VVIN VARCHAR(30) NOT NULL,
  PRIMARY KEY (TId),
  FOREIGN KEY (PId) REFERENCES PERSON(PId),
  FOREIGN KEY (VVIN) REFERENCES VEHICLE(VVIN)
);

CREATE TABLE Drives
(
  PId INT NOT NULL,
  VVIN VARCHAR(30) NOT NULL,
  PRIMARY KEY (PId, VVIN),
  FOREIGN KEY (PId) REFERENCES PERSON(PId),
  FOREIGN KEY (VVIN) REFERENCES VEHICLE(VVIN)
);

CREATE TABLE SAMPLE
(
  SName VARCHAR(20) NOT NULL,
  STs INT NOT NULL,
  SFloatValue FLOAT,
  SIntValue INT,
  OBDHexCode INT NOT NULL,
  TId INT NOT NULL,
  GPSTs INT NOT NULL,
  PRIMARY KEY (STs, OBDHexCode),
  FOREIGN KEY (OBDHexCode) REFERENCES OBD_PARAMETER(OBDHexCode),
  FOREIGN KEY (TId) REFERENCES TRACK(TId),
  FOREIGN KEY (GPSTs) REFERENCES GPS_DATA(GPSTs),
  UNIQUE (SName)
);