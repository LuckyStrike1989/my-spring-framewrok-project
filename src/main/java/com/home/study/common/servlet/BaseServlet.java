package com.home.study.common.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.home.study.common.model.BaseResult;

public class BaseServlet extends HttpServlet{
	private static final long serialVersionUID = 1711180163115987456L;
	
	/**
	 * JSON으로 응답
	 * @param response HTTP 응답
	 * @param statusCode HTTP 상태 코드
	 * @param baseResult 결과 객체
	 * @throws IOException 오류
	 */
	protected void responseJSON(HttpServletResponse response, int statusCode, BaseResult baseResult) throws IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.setStatus(statusCode);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String resultJson = objectMapper.writeValueAsString(baseResult);
		response.getWriter().write(resultJson);
	}
	
	/**
     * JSON으로 응답
     * @param response HTTP 응답
     * @param statusCode HTTP 상태 코드
     * @param code 응답 코드
     * @param message 응답 메시지
     */
	protected void responseJSON(HttpServletResponse response, int statusCode, int code, String message) throws IOException {
		BaseResult baseResult = new BaseResult();
		baseResult.setCode(code);
		baseResult.setMessage(message);
		
		if( statusCode != HttpServletResponse.SC_OK ) {
			baseResult.setResult("failure");
		}
		
		responseJSON(response, statusCode, baseResult);
	}
	
	/**
	 * JSON으로 응답
	 * @param response HTTP 응답
	 * @param statusCode HTTP 상태 코드
	 * @param resultMap 결과 맵
	 * @throws IOException 오류
	 */
	protected void responseJSON(HttpServletResponse response, int statusCode, Map<String, Object> resultMap) throws IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.setStatus(statusCode);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String resultJson = objectMapper.writeValueAsString(resultMap);
		response.getWriter().write(resultJson);
	}
}
