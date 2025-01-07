package com.home.study.test1.transmission.model;

import java.io.Serializable;

import com.home.study.common.model.BaseEntity;

import lombok.Data;

@Data
public class TempDownloadFileVO extends BaseEntity implements Serializable {
	
	private static final long serialVersionUID = -6839554404754676663L;
	
	/**
     * 다운로드 임시 파일 시퀀스
     */
    private int seq = 0;

    /**
     * 다운로드 파일 ID
     */
    private String fileID = "";

    /**
     * 다운로드 임시 파일 경로
     */
    private String filePath = "";

    /**
     * 원본 파일명
     */
    private String orginFileName = "";

    /**
     * 원본 파일 크기
     */
    private long orginFileSize = 0;

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
}
