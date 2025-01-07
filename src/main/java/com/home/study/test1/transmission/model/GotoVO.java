package com.home.study.test1.transmission.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class GotoVO implements Serializable{
	private static final long serialVersionUID = 3928423356896572366L;
	
	/**
     * 검색 타입
     */
    private String searchType = "";

    /**
     * 검색 조건
     */
    private String searchCondition = "";

    /**
     * 검색 키워드
     */
    private String searchKeyword = "";

    /**
     * 페이지 번호
     */
    private int pageNo = 1;

    /**
     * 페이지 레코드 수(기본값 : 10)
     */
    protected int recordCountPerPage = 10;
}
