CREATE DATABASE study;

CREATE TABLE study.INT_BOARD_TB (
	BRD_SEQ BIGINT AUTO_INCREMENT NOT NULL COMMENT '게시판 시퀀스',
	BRD_SUBJECT VARCHAR(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '게시판 제목',
	BRD_CONTENT TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '게시판 내용',
	REG_ID varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '등록자 아이디',
	REG_DTM DATETIME DEFAULT NOW() NOT NULL COMMENT '등록 일자',
	MOD_ID varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '변경자 아이디',
	MOD_DTM DATETIME NULL COMMENT '변경 일자',
	CONSTRAINT INT_BOARD_TB_PK PRIMARY KEY (BRD_SEQ)
)
ENGINE=INNODB
DEFAULT CHARSET=UTF8
COLLATE=UTF8_GENERAL_CI
COMMENT='board';

INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 1", "테스트 내용 1", "testid1");
INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 2", "테스트 내용 2", "testid2");
INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 3", "테스트 내용 3", "testid1");
INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 4", "테스트 내용 4", "testid3");
INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 5", "테스트 내용 5", "testid2");
INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 6", "테스트 내용 6", "testid2");
INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 7", "테스트 내용 7", "testid3");
INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 8", "테스트 내용 8", "testid1");
INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 9", "테스트 내용 9", "testid3");
INSERT INTO study.INT_BOARD_TB (BRD_SUBJECT, BRD_CONTENT, REG_ID) VALUES ("테스트 제목 10", "테스트 내용 10", "testid1");

SELECT * FROM INT_BOARD_TB;