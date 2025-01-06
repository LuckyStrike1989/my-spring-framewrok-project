-- study.tb_up_tempfile definition

CREATE TABLE `TB_UP_TEMPFILE` (
  `SEQ` int NOT NULL AUTO_INCREMENT COMMENT '업로드 임시 파일 시퀀스',
  `FILE_ID` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '업로드 파일 ID',
  `FILE_PATH` varchar(256) COLLATE utf8mb4_general_ci NOT NULL COMMENT '업로드 임시 파일 경로',
  `FILE_CATE` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '카테고리',
  `ORGIN_FILE_NM` varchar(256) COLLATE utf8mb4_general_ci NOT NULL COMMENT '원본 파일명',
  `ORGIN_FILE_SIZE` bigint NOT NULL DEFAULT '0' COMMENT '원본 파일 크기',
  `CHUNK_SIZE` int NOT NULL DEFAULT '0' COMMENT '청크 크기',
  `CHUNK_COUNT` int NOT NULL DEFAULT '0' COMMENT '청크 수',
  `CHUNK_POS` int NOT NULL DEFAULT '0' COMMENT '청크 위치',
  `RSA_PUBLIC_KEY` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'RSA 공개키',
  `RSA_PRIVATE_KEY` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'RSA 개인키',
  `USE_CRYPTO` tinyint DEFAULT '0' COMMENT '전송 암호화 사용 여부',
  `REG_ID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '등록자',
  `REG_DTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `MOD_DTM` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`SEQ`),
  UNIQUE KEY `TB_UP_TEMPFILE_unique` (`FILE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- study.tb_up_file definition

CREATE TABLE `TB_UP_FILE` (
  `SEQ` int NOT NULL AUTO_INCREMENT COMMENT '업로드 파일 시퀀스',
  `FILE_ID` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '업로드 파일 ID',
  `FILE_PATH` varchar(256) COLLATE utf8mb4_general_ci NOT NULL COMMENT '업로드 파일 경로',
  `FILE_CATE` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '카테고리',
  `ORGIN_FILE_NM` varchar(256) COLLATE utf8mb4_general_ci NOT NULL COMMENT '원본 파일명',
  `ORGIN_FILE_SIZE` bigint NOT NULL DEFAULT '0' COMMENT '파일 크기',
  `REG_ID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '등록자',
  `REG_DTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`SEQ`),
  UNIQUE KEY `TB_UP_FILE_unique` (`FILE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- study.tb_down_tempfile definition

CREATE TABLE `TB_DOWN_TEMPFILE` (
  `SEQ` int NOT NULL AUTO_INCREMENT COMMENT '다운로드 임시 파일 시퀀스',
  `FILE_ID` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '다운로드 파일 ID',
  `FILE_PATH` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '다운로드 임시 파일 경로',
  `ORGIN_FILE_NM` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '원본 파일명',
  `ORGIN_FILE_SIZE` bigint NOT NULL DEFAULT '0' COMMENT '원본 파일 크기',
  `CHUNK_SIZE` int NOT NULL DEFAULT '0' COMMENT '청크 크기',
  `CHUNK_COUNT` int NOT NULL DEFAULT '0' COMMENT '청크 수',
  `CHUNK_POS` int NOT NULL DEFAULT '0' COMMENT '청크 위치',
  `REG_ID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '등록자',
  `REG_DTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`SEQ`),
  UNIQUE KEY `TB_DOWN_TEMPFILE_unique` (`FILE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- study.tb_category definition

CREATE TABLE `TB_CATEGORY` (
  `SEQ` int NOT NULL AUTO_INCREMENT COMMENT '카테고리 시퀀스',
  `CATE_ID` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '카테고리 ID',
  `CATE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '카테고리',
  `UP_TEMP_FILE_PATH` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '업로드 임시 파일 경로',
  `UP_FILE_PATH` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '업로드 파일 경로',
  `UP_CHUNK_SIZE` int NOT NULL DEFAULT '0' COMMENT '업로드 청크 크기',
  `UP_USE_CRYPTO` tinyint DEFAULT '0' COMMENT '업로드 전송 암호화 사용 여부',
  `DOWN_TEMP_FILE_PATH` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '다운로드 임시 파일 경로',
  `DOWN_CHUNK_SIZE` int NOT NULL DEFAULT '0' COMMENT '다운로드 청크 크기',
  `DOWN_USE_CRYPTO` tinyint DEFAULT '0' COMMENT '다운로드 전송 암호화 사용 여부',
  `REG_ID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '등록자',
  `REG_DTM` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `MOD_DTM` datetime DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`SEQ`),
  UNIQUE KEY `TB_CATEGORY_unique` (`CATE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

