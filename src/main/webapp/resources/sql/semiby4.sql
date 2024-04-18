-- DROP TABLE BOARD_T CASCADE CONSTRAINTS;
-- DROP TABLE USER_T CASCADE CONSTRAINTS;

DROP SEQUENCE COMMENT_SEQ;
DROP SEQUENCE BOARD_SEQ;
DROP SEQUENCE ATTACH_SEQ;
DROP SEQUENCE USER_SEQ;

CREATE SEQUENCE USER_SEQ NOCACHE;
CREATE SEQUENCE BOARD_SEQ NOCACHE;
CREATE SEQUENCE ATTACH_SEQ NOCACHE;
CREATE SEQUENCE COMMENT_SEQ NOCACHE;

DROP TABLE COMMENT_T;
DROP TABLE ATTACH_T;
DROP TABLE BOARD_T;
DROP TABLE USER_T;

CREATE TABLE USER_T (
   USER_NO        NUMBER   NOT NULL,
   EMPLOYEE_ID    VARCHAR2(100 BYTE)  NOT NULL UNIQUE,
   PW            VARCHAR2(64 BYTE)  NOT NULL,
   EMAIL        VARCHAR2(100 BYTE)   NULL,
   NAME         VARCHAR2(100 BYTE) NULL,
   GENDER       VARCHAR2(5 BYTE)   NULL,
   MOBILE       VARCHAR2(20 BYTE)  NULL,
   PW_MODIFY_DT DATE               NULL,
   SIGNUP_DT    DATE               NULL,
    CONSTRAINT PK_USER_NO PRIMARY KEY(USER_NO)
);

CREATE TABLE BOARD_T (
   BOARD_NO    NUMBER               NOT NULL,
   USER_NO       NUMBER               NOT NULL,
   TITLE       VARCHAR2(1000 BYTE)   NOT NULL,
   CONTENTS    CLOB               NULL,
   HIT           NUMBER               DEFAULT 0,
   CREATE_DT   TIMESTAMP           NULL,
   MODIFY_DT   TIMESTAMP           NULL,
    CONSTRAINT PK_BOARD_NO      PRIMARY KEY (BOARD_NO),
    CONSTRAINT FK_BOARD_USER_NO FOREIGN KEY(USER_NO)
    REFERENCES USER_T(USER_NO) ON DELETE CASCADE
);

CREATE TABLE ATTACH_T (
   ATTACH_NO         NUMBER            NOT NULL,
   UPLOAD_PATH         VARCHAR2(500 BYTE) NULL,
   FILESYSTEM_NAME     VARCHAR2(500 BYTE) NULL,
   ORIGINAL_FILENAME VARCHAR2(500 BYTE) NULL,
   DOWNLOAD_COUNT     NUMBER            NULL,
   HAS_THUMBNAIL     NUMBER            NULL,
   BOARD_NO         NUMBER            NOT NULL,
    CONSTRAINT PK_ATTACH_NO PRIMARY KEY(ATTACH_NO),
    CONSTRAINT FK_ATTACH_BOARD_NO FOREIGN KEY(BOARD_NO)
    REFERENCES BOARD_T(BOARD_NO) ON DELETE CASCADE
);

CREATE TABLE COMMENT_T (
   COMMENT_NO NUMBER               NOT NULL,
   USER_NO    NUMBER               NOT NULL,
   CONTENTS   VARCHAR2(2000 BYTE)   NOT NULL,
   CREATE_DT  TIMESTAMP            NULL,
   STATE      NUMBER               NULL,
   DEPTH      NUMBER               NULL, --'원글0, 답글1',
   GROUP_NO   NUMBER               NULL,
   BOARD_NO   NUMBER               NOT NULL,
    CONSTRAINT PK_COMMENT_NO PRIMARY KEY (COMMENT_NO),
    CONSTRAINT FK_COMMENT_USER_NO FOREIGN KEY(USER_NO)
    REFERENCES USER_T(USER_NO) ON DELETE CASCADE
);



INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'admin', STANDARD_HASH('admin', 'SHA256'), 'admin@example.com', '관리자', 'man', '010-1111-1111', CURRENT_DATE, CURRENT_DATE);
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'tester1', STANDARD_HASH('1111', 'SHA256'), 'tester1@example.com', '테스터1', 'man', '010-1111-1111', CURRENT_DATE, CURRENT_DATE);
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'tester2', STANDARD_HASH('2222', 'SHA256'), 'tester2@example.com', '테스터2', 'man', '010-2222-2222', CURRENT_DATE, CURRENT_DATE);
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'tester3', STANDARD_HASH('3333', 'SHA256'), 'tester3@example.com', '테스터3', 'man', '010-3333-3333', CURRENT_DATE, CURRENT_DATE);
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'tester4', STANDARD_HASH('4444', 'SHA256'), 'tester4@example.com', '테스터4', 'man', '010-4444-4444', CURRENT_DATE, CURRENT_DATE);
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'tester5', STANDARD_HASH('5555', 'SHA256'), 'tester5@example.com', '테스터5', 'man', '010-5555-5555', CURRENT_DATE, CURRENT_DATE);
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'tester6', STANDARD_HASH('6666', 'SHA256'), 'tester6@example.com', '테스터6', 'man', '010-6666-6666', CURRENT_DATE, CURRENT_DATE);
COMMIT;
