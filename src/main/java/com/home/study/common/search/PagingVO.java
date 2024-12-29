package com.home.study.common.search;

import java.io.Serializable;

public class PagingVO implements Serializable{
	private static final long serialVersionUID = -8320352229077385027L;
	
	/**
	 * 전체 레코드 수
	 */
	private int recordTotalCount = 0;

	/**
	 * 페이지 레코드 수(기본값 : 10)
	 */
	private int recordCountPerPage = 10;

	/**
	 * 페이지 번호
	 */
	private int pageNo = 1;

	/**
	 * 페이지의 레코드 시작 번호
	 */
	private int pageStartRecordNo = 0;

	/**
	 * 페이지의 레코드 종료 번호
	 */
	private int pageEndRecordNo = 0;

	/**
	 * 페이지 마지막 번호
	 */
	private int pageLastNo = 0;

	public int getRecordTotalCount() {
		return recordTotalCount;
	}

	public void setRecordTotalCount(int recordTotalCount) {
		this.recordTotalCount = recordTotalCount;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageStartRecordNo() {
		return pageStartRecordNo;
	}

	public void setPageStartRecordNo(int pageStartRecordNo) {
		this.pageStartRecordNo = pageStartRecordNo;
	}

	public int getPageEndRecordNo() {
		return pageEndRecordNo;
	}

	public void setPageEndRecordNo(int pageEndRecordNo) {
		this.pageEndRecordNo = pageEndRecordNo;
	}

	public int getPageLastNo() {
		return pageLastNo;
	}

	public void setPageLastNo(int pageLastNo) {
		this.pageLastNo = pageLastNo;
	}
	
	/**
	 * one 베이스(oracle)로 페이징을 처리합니다.
	 */
	public void processOne() {
		process(false);
	}

	/**
	 * zero 베이스(mariaDB, mySQL)로 페이징을 처리합니다.
	 */
	public void processZero() {
		process(true);
	}
	
	/**
	 * 페이징을 처리합니다.
	 * @param zero 제로 베이스 여부 (true : mariaDB, mySQL은 zero 베이스, false : oracle은 1 베이스)
	 */
	public void process(boolean zero) {
		// 레코드 번호
		int startBase = 1;
		int endBase = 0;
		// 제로 베이스 
		if (zero) {
			startBase = 0;
			endBase = -1;
		}
		
		// 페이지 마지막 번호 설정
		// 나머지가 있으면 페이지 마지막 번호를 증가 시킴
		pageLastNo = (recordTotalCount / recordCountPerPage) + (recordTotalCount % recordCountPerPage == 0 ? 0 : 1);
		if (pageLastNo > 0) {
			if (pageNo <= pageLastNo) {
				// 페이지의 레코드 시작 번호 설정
				pageStartRecordNo = ((pageNo - 1) * recordCountPerPage) + startBase;
				// 페이지의 레코드 종료 번호 설정
				pageEndRecordNo = pageNo * recordCountPerPage + endBase;
				// 페이지의 레코드 종료 번호가 전체 레코드 수보다 크면 전체 레코드 수로 변경
				if (pageEndRecordNo > (recordTotalCount + endBase)) {
					pageEndRecordNo = recordTotalCount + endBase;
				}
			} else {
				pageStartRecordNo = 0;
				pageEndRecordNo = 0;
			}
		} else {
			pageStartRecordNo = 0;
			pageEndRecordNo = 0;
			pageLastNo = 0;
		}
	}
}
