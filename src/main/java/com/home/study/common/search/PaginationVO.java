package com.home.study.common.search;

import java.io.Serializable;

public class PaginationVO extends PagingVO implements Serializable{
	private static final long serialVersionUID = -8322117144582942029L;
	
	/**
	 * 페이지 사이즈(기본값 10)
	 */
	private int pageSize = 10;

	/**
	 * 페이지 시작 번호
	 */
	private int pageStartNo = 1;

	/**
	 * 페이지 종료 번호
	 */
	private int pageEndNo = 1;
	
	/**
	 * 이전 페이지 사이즈 번호
	 */
	private int prevPageSizeNo = 1;

	/**
	 * 다음 페이지 사이즈 번호
	 */
	private int nextPageSizeNo = 1;

	/**
	 * 이전 페이지 사이즈 번호 활성화 여부
	 */
	private boolean enablePrevPageSizeNo = false;

	/**
	 * 다음 페이지 사이즈 번호 활성화 여부
	 */
	private boolean enableNextPageSizeNo = false;

	/**
	 * 전체 페이지 앞 번호 활성화 여부
	 */
	private boolean enablePageFirstNo = false;

	/**
	 * 전체 페이지 마지막 번호 활성화 여부
	 */
	private boolean enablePageLastNo = false;

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageStartNo() {
		return pageStartNo;
	}

	public void setPageStartNo(int pageStartNo) {
		this.pageStartNo = pageStartNo;
	}

	public int getPageEndNo() {
		return pageEndNo;
	}

	public void setPageEndNo(int pageEndNo) {
		this.pageEndNo = pageEndNo;
	}
	
	public int getPrevPageSizeNo() {
		return prevPageSizeNo;
	}

	public void setPrevPageSizeNo(int prevPageSizeNo) {
		this.prevPageSizeNo = prevPageSizeNo;
	}

	public int getNextPageSizeNo() {
		return nextPageSizeNo;
	}

	public void setNextPageSizeNo(int nextPageSizeNo) {
		this.nextPageSizeNo = nextPageSizeNo;
	}

	public boolean isEnablePrevPageSizeNo() {
		return enablePrevPageSizeNo;
	}

	public void setEnablePrevPageSizeNo(boolean enablePrevPageSizeNo) {
		this.enablePrevPageSizeNo = enablePrevPageSizeNo;
	}

	public boolean isEnableNextPageSizeNo() {
		return enableNextPageSizeNo;
	}

	public void setEnableNextPageSizeNo(boolean enableNextPageSizeNo) {
		this.enableNextPageSizeNo = enableNextPageSizeNo;
	}

	public boolean isEnablePageFirstNo() {
		return enablePageFirstNo;
	}

	public void setEnablePageFirstNo(boolean enablePageFirstNo) {
		this.enablePageFirstNo = enablePageFirstNo;
	}

	public boolean isEnablePageLastNo() {
		return enablePageLastNo;
	}

	public void setEnablePageLastNo(boolean enablePageLastNo) {
		this.enablePageLastNo = enablePageLastNo;
	}

	@Override
	protected void process(boolean zero) {
		super.process(zero);
		
		// 페이지 시작 번호 설정
		// 몫만큼 페이지 시작 번호 변경한다.
		int start = pageNo / pageSize;
		if (start >= 1) {
			// 나머지가 없으면 페이지 번호가 페이지 마지막 번호와 같아 몫을 감소 시킨다.
			if (pageNo % pageSize == 0){
				start--;
			}
			pageStartNo = (start * pageSize) + 1;
		}
		
		if (pageLastNo > 0) {
			// 페이지 종료 번호 설정
			pageEndNo = (pageStartNo - 1) + pageSize;
			// 페이지 종료 번호가 페이지 마지막 번호보다 크면 페이지 마지막 번호로 변경
			if (pageEndNo > pageLastNo) {
				pageEndNo = pageLastNo;
			}
			
			// 이전 페이지 사이즈 번호
			prevPageSizeNo = pageStartNo - 1;
			// 이전 페이지 사이즈 번호 활성화 여부
			if (prevPageSizeNo > 0) {
				enablePrevPageSizeNo = true;
			}
			
			// 다음 페이지 사이즈 번호
			nextPageSizeNo = pageEndNo + 1;
			// 다음 페이지 사이즈 번호 활성화 여부
			if (nextPageSizeNo <= pageLastNo) {
				enableNextPageSizeNo = true;
			}
			
			// 전체 페이지 앞 번호 활성화 여부
			if (pageNo > 1) {
				enablePageFirstNo = true;
			}
			
			// 전체 페이지 마지막 번호 활성화 여부
			if (pageNo < pageLastNo) {
				enablePageLastNo = true;
			}
		}
	}
}
