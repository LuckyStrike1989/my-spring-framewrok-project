package com.home.study.test1.transmission.model;

import java.io.Serializable;
import java.util.List;

import com.home.study.common.search.SearchVO;

import lombok.Data;

@Data
public class UploadFileSearchVO extends SearchVO implements Serializable{
	private static final long serialVersionUID = 231734544578347694L;
	
	/**
     * 카테고리
     */
    private String category = "";

    /**
     * 업로드 파일 ID
     */
    private String fileID = "";

    /**
     * 등록자 ID registrationID
     */
    private String regID= "";

    /**
     * 검색 결과 - 업로드된 파일 리스트
     */
    private List<UploadFileVO> resultList = null;
}
