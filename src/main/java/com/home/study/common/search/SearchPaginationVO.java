package com.home.study.common.search;

import java.io.Serializable;

import lombok.Data;

@Data
public class SearchPaginationVO extends BaseSearchVO implements Serializable{
	private static final long serialVersionUID = 4326046645692280592L;
	
	/**
	 * 페이지네이션 객체
	 */
	private PaginationVO paginationVO = null;
}
