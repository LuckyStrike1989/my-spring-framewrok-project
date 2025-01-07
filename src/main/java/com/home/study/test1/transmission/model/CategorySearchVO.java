package com.home.study.test1.transmission.model;

import java.io.Serializable;
import java.util.List;

import com.home.study.common.search.SearchVO;

import lombok.Data;

@Data
public class CategorySearchVO extends SearchVO implements Serializable{
	private static final long serialVersionUID = 3077786910124252002L;
	
	/**
     * 카테고리 ID
     */
    private String categoryID = "";

    /**
     * 검색 결과 - 카테고리 리스트
     */
    private List<CategoryVO> resultList = null;

}
