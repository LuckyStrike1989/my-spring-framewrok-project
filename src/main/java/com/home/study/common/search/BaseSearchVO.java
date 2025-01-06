package com.home.study.common.search;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.log4j.Log4j2;

@Data
public class BaseSearchVO implements Serializable{
	private static final long serialVersionUID = -8655251651235897931L;
	
	/**
	 * 검색 타입
	 */
	protected String searchType = "";

	/**
	 * 검색 조건
	 */
	protected String searchCondition = "";

	/**
	 * 검색 키워드
	 */
	protected String searchKeyword = "";

	/**
	 * 사용 여부
	 */
	protected String useYesNo = "";
}
