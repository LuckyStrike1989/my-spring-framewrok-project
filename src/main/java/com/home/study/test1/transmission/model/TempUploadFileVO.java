package com.home.study.test1.transmission.model;

import java.io.Serializable;

import com.home.study.common.model.BaseEntity;

import lombok.Data;

@Data
public class TempUploadFileVO extends BaseEntity implements Serializable{
	private static final long serialVersionUID = -4241594681473191360L;
	
	/**
     * 업로드 임시 파일 시퀀스
     */
    private int seq = 0;

    /**
     * 업로드 파일 ID
     */
    private String fileID = "";

    /**
     * 업로드 임시 파일 경로
     */
    private String filePath = "";

    /**
     * 카테고리
     */
    private String category = "";

    /**
     * 원본 파일명
     */
    private String orginFileName = "";

    /**
     * 원본 파일 크기
     */
    private long fileSize = 0;

    /**
     * 청크 크기
     */
    private int chunkSize = 0;

    /**
     * 청크 수
     */
    private int chunkCount = 0;

    /**
     * 청크 위치
     */
    private int chunkPos = 0;

    /**
     * RSA 공개키
     */
    private String publicKey = "";

    /**
     * RSA 개인키
     */
    private String privateKey = "";

    /**
     * 전송 암호화 사용 여부
     */
    private int useCrypto = 0;
}
