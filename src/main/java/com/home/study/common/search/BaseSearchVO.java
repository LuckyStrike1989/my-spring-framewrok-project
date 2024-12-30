package com.home.study.common.search;

import java.io.Serializable;

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

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getUseYesNo() {
		return useYesNo;
	}

	public void setUseYesNo(String useYesNo) {
		this.useYesNo = useYesNo;
	}
}
