package com.home.study.common.search;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.log4j.Log4j2;

@Data
public class PagingVO implements Serializable{
	private static final long serialVersionUID = -8320352229077385027L;
	
	/**
	 * 전체 레코드 수
	 */
	protected int recordTotalCount = 0;

	/**
	 * 페이지 레코드 수(기본값 : 10)
	 */
	protected int recordCountPerPage = 10;

	/**
	 * 페이지 번호
	 */
	protected int pageNo = 1;

	/**
	 * 페이지의 레코드 시작 번호
	 */
	protected int pageStartRecordNo = 0;

	/**
	 * 페이지의 레코드 종료 번호
	 */
	protected int pageEndRecordNo = 0;

	/**
	 * 페이지 마지막 번호
	 */
	protected int pageLastNo = 0;
	
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
	protected void process(boolean zero) {
		// 레코드 번호
		int startBase = 1;
		int endBase = 0;
		// 제로 베이스 
		if (zero) {
			startBase = 0;
			endBase = -1;
		}
		
		// 페이지 마지막 번호 설정
		// 나머지가 있으면 페이지 마지막 번호를 증가 시킨다.
		pageLastNo = (recordTotalCount / recordCountPerPage) + (recordTotalCount % recordCountPerPage == 0 ? 0 : 1);
		if (pageLastNo > 0) {
			// 현재 페이지 번호가 페이지 마지막 번호도 크면 페이지 마지막 번호로 변경
			// 현재 페이지 번호가 페이지 마지막 번호와 같을 때 삭제가 발생할 경우 전체 레코드 수가 줄어 들어 페이지 마지막 번호가 줄어 들 경우 페이지 마지막 번호로 변경
			if (pageNo > pageLastNo) {
				pageNo = pageLastNo;
			}
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
			pageLastNo = 0;
		}
	}
}
