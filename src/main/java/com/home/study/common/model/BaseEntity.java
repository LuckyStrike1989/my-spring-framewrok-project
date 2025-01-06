package com.home.study.common.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class BaseEntity implements Serializable{
	private static final long serialVersionUID = 1480597842437005956L;
	
	/**
	 * 등록아이디
	 */
	private String registrationId = "";
	
	/**
	 * 등록일시
	 */
	private String registrationDateTime = "";
	
	/**
	 * 수정아이디
	 */
	private String modificationId = "";
	
	/**
	 * 수정일시
	 */
	private String modificationDateTime = "";
}
