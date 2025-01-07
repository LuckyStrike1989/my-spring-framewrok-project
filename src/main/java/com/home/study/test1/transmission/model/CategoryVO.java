package com.home.study.test1.transmission.model;

import java.io.Serializable;
import com.home.study.common.model.BaseEntity;

import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class CategoryVO extends BaseEntity implements Serializable {
	private static final long serialVersionUID = -651944560795227662L;
	
	/**
	 * 카테고리 시퀀스
	 */
	private int seq = 0;
	
	/**
	 * 카테고리 아이디
	 */
	private String categoryId = "";
	
	/**
	 * 카테고리
	 */
	@NotNull(message="카테고리 명을 입력하세요.")
	@NotEmpty(message="카테고리 명을 입력하세요.")
	@Size(min = 1, max = 50, message="카테고리 명은 최소 1자, 최대 50자 이내로 입력하세요.")
	private String category = "";
	
	/**
     * 업로드 임시 파일 경로
     */
    @NotNull(message="업로드 임시 파일 경로를 입력하세요.")
    @NotEmpty(message="업로드 임시 파일 경로를 입력하세요..")
    @Size(min = 1, max = 256, message="업로드 임시 파일 경로는 최소 1자, 최대 256자 이내로 입력하세요.")
    private String upTempFilePath = "";

    /**
     * 업로드 파일 경로
     */
    @NotNull(message="업로드 파일 경로를 입력하세요.")
    @NotEmpty(message="업로드 파일 경로를 입력하세요..")
    @Size(min = 1, max = 256, message="업로드 파일 경로는 최소 1자, 최대 256자 이내로 입력하세요.")
    private String upFilePath = "";

    /**
     * 업로드 청크 크기
     */
    //@Range(min = 1024, max = 1048576, message = "업로드 청크 크기는 최소 1024(1KB)이상 최대 1048576(1MB)이하이어야 합니다.")
    private int upChunkSize = 1024;

    /**
     * 업로드 전송 암호화 사용 여부
     */
    //@Range(min = 0, max = 2, message = "업로드 전송 암호화는 0:Blob 전송, 1:Base64 + 검증 + 압축 전송, 2:Base64 + 암호화 + 검증 전송만 지원합니다.")
    private int upUseCrypto = 0;

    /**
     * 다운로드 임시 파일 경로
     */
    @NotNull(message="다운로드 임시 파일 경로를 입력하세요.")
    @NotEmpty(message="다운로드 임시 파일 경로를 입력하세요..")
    @Size(min = 1, max = 256, message="다운로드 임시 파일 경로는 최소 1자, 최대 256자 이내로 입력하세요.")
    private String downTempFilePath = "";

    /**
     * 다운로드 청크 크기
     */
    //@Range(min = 1024, max = 1048576, message = "다운로드 청크 크기는 최소 1024(1KB)이상 최대 1048576(1MB)이하이어야 합니다.")
    private int downChunkSize = 1024;

    /**
     * 다운로드 전송 암호화 사용 여부
     */
    //@Range(min = 0, max = 0, message = "다운로드 전송 암호화는 0:Base64 전송만 지원합니다.")
    private int downUseCrypto = 0;
}
