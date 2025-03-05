package com.home.study.common.model;

import java.io.Serializable;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class BaseEntity implements Serializable{
	private static final long serialVersionUID = 1480597842437005956L;
	
	/**
	 * 등록아이디
	 */
	@NotNull(message="작성자 아이디를 입력하세요.")
	@NotEmpty(message="작성자 아이디를 입력하세요.")
	@Size(min = 2, max = 20, message="작성자 아이디는 최소 2자, 최대 20자 이내로 입력하세요.")
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
