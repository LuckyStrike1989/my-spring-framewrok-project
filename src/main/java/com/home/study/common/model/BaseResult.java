package com.home.study.common.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class BaseResult implements Serializable{
	private static final long serialVersionUID = 8564316498574093938L;
	
	/**
	 * 결과 메시지 (success, failure)
	 */
	private String result = "success";
	
	/**
	 * 코드
	 */
	private int code = 0;
	
	/**
	 * 메시지
	 */
	private String message = "";
}
