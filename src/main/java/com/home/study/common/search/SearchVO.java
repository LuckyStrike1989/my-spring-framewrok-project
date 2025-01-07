package com.home.study.common.search;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.log4j.Log4j2;

@Data
public class SearchVO extends BaseSearchVO implements Serializable{
	private static final long serialVersionUID = -5674159496405556527L;
	
	/**
	 * 페이지네이션 객체
	 */
	private PaginationVO pagination = null;
}
