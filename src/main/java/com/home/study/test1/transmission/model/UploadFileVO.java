package com.home.study.test1.transmission.model;

import java.io.Serializable;

import com.home.study.common.model.BaseEntity;

import lombok.Data;

@Data
public class UploadFileVO extends BaseEntity implements Serializable{
	private static final long serialVersionUID = 4554034127359711939L;
	
	/**
     * 업로드 파일 시퀀스
     */
    private int seq = 0;

    /**
     * 업로드 파일 ID
     */
    private String fileID = "";

    /**
     * 업로드 파일 경로
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
    private long orginFileSize = 0;
}
