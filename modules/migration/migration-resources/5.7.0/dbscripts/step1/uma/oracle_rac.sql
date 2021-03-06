CREATE TABLE IDN_UMA_RESOURCE (
  ID                  INTEGER,
  RESOURCE_ID         VARCHAR2(255),
  RESOURCE_NAME       VARCHAR2(255),
  TIME_CREATED        TIMESTAMP              NOT NULL,
  RESOURCE_OWNER_NAME VARCHAR2(255),
  CLIENT_ID           VARCHAR2(255),
  TENANT_ID           INTEGER DEFAULT -1234,
  USER_DOMAIN         VARCHAR2(50),
  PRIMARY KEY (ID)
)
  /

CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 ORDER
  /

CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_TRIG
BEFORE INSERT
ON IDN_UMA_RESOURCE
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_RESOURCE_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID)
/

CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN)
/

CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
  ID                INTEGER,
  RESOURCE_IDENTITY INTEGER                NOT NULL,
  PROPERTY_KEY      VARCHAR2(40),
  PROPERTY_VALUE    VARCHAR2(255),
  PRIMARY KEY (ID),
  FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
)
  /

CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 ORDER
  /

CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_META_DATA_TRIG
BEFORE INSERT
ON IDN_UMA_RESOURCE_META_DATA
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_RESOURCE_META_DATA_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
  ID                INTEGER,
  RESOURCE_IDENTITY INTEGER                NOT NULL,
  SCOPE_NAME        VARCHAR2(255),
  PRIMARY KEY (ID),
  FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
)
  /

CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 ORDER
  /

CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_SCOPE_TRIG
BEFORE INSERT
ON IDN_UMA_RESOURCE_SCOPE
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_RESOURCE_SCOPE_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME)
/

CREATE TABLE IDN_UMA_PERMISSION_TICKET (
  ID              INTEGER,
  PT              VARCHAR2(255)           NOT NULL,
  TIME_CREATED    TIMESTAMP              NOT NULL,
  EXPIRY_TIME     TIMESTAMP              NOT NULL,
  TICKET_STATE    VARCHAR2(25) DEFAULT 'ACTIVE',
  TENANT_ID       INTEGER     DEFAULT -1234,
  PRIMARY KEY (ID)
)
  /

CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 ORDER
  /

CREATE OR REPLACE TRIGGER IDN_UMA_PERMISSION_TICKET_TRIG
BEFORE INSERT
ON IDN_UMA_PERMISSION_TICKET
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_PERMISSION_TICKET_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT)
/

CREATE TABLE IDN_UMA_PT_RESOURCE (
  ID             INTEGER,
  PT_RESOURCE_ID INTEGER                NOT NULL,
  PT_ID          INTEGER                NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
  FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
)
  /

CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 ORDER
  /

CREATE OR REPLACE TRIGGER IDN_UMA_PT_RESOURCE_TRIG
BEFORE INSERT
ON IDN_UMA_PT_RESOURCE
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_PT_RESOURCE_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
  ID             INTEGER,
  PT_RESOURCE_ID INTEGER                NOT NULL,
  PT_SCOPE_ID    INTEGER                NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
  FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
)
  /

CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 CACHE 20 ORDER
  /

CREATE OR REPLACE TRIGGER IDN_UMA_PT_RESOURCE_SCOPE_TRIG
BEFORE INSERT
ON IDN_UMA_PT_RESOURCE_SCOPE
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_PT_RESOURCE_SCOPE_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/
