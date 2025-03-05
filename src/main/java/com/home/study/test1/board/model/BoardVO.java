package com.home.study.test1.board.model;

import java.io.Serializable;

import com.home.study.common.model.BaseEntity;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class BoardVO extends BaseEntity implements Serializable{
	private static final long serialVersionUID = 4190411165367743068L;
	/**
	 * 게시판 시퀀스
	 */
	private int sequence = 0;
	
	/**
	 * 게시판 제목
	 */
	@NotNull(message="게시판 제목을 입력하세요.")
	@NotEmpty(message="게시판 제목을 입력하세요.")
	private String subject = "";
	
	/**
	 * 게시판 내용
	 */
	private String content = "";
}
