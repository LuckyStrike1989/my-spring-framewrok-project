package com.home.study.common.search;

import java.io.Serializable;

public class SearchVO implements Serializable{
	private static final long serialVersionUID = -5674159496405556527L;
	
	/**
	 * 페이징 객체
	 */
	private PagingVO pagingVO = null;

	public PagingVO getPagingVO() {
		return pagingVO;
	}

	public void setPagingVO(PagingVO pagingVO) {
		this.pagingVO = pagingVO;
	}
}
