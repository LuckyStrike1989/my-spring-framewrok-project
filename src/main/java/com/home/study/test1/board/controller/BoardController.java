package com.home.study.test1.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.home.study.test1.board.model.BoardVO;
import com.home.study.test1.board.service.IBoardService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private IBoardService boardService;
	
	@RequestMapping(value = "/addform", method = RequestMethod.GET)
	public String addBoardForm(
		HttpServletRequest request
		, HttpServletResponse response
		, @ModelAttribute("board") BoardVO board
		, ModelMap model
	) {
		return "board/boardform";
	}
	
	@RequestMapping(value="/addboard", method=RequestMethod.POST)
	public String addBoard(HttpServletRequest request, HttpServletResponse response,
			@Valid @ModelAttribute("board") BoardVO boardVO, ModelMap model) {
		
		String registrationId = boardVO.getRegistrationId();
		
		if( registrationId.isEmpty() ) {
			model.addAttribute("errorInputId","registrationId");
			model.addAttribute("errorMessage", "작성자 입력란에 아이디가 입력되지 않았습니다.\\n아이디를 입력하세요.");
			return "board/boardform";
		} else if (registrationId.length() < 2 || registrationId.length() > 20) {
			model.addAttribute("errorInputId","registrationId");
			model.addAttribute("errorMessage", "작성자 입력란에 아이디는 최소 2자이상 최대 20자 이내로 입력하세요.");
			return "board/boardform";
		}
		
		String subject = boardVO.getSubject();
		if ( subject.isEmpty() ) {
			model.addAttribute("errorInputId","subject");
			model.addAttribute("errorMessage", "제목 입력란에 제목이 입력되지 않았습니다.\\n제목을 입력하세요.");
			return "board/boardform";
		}
		
		if (!boardService.insertBoardItem(boardVO)) {
			return "board/boardform";
		}
		
		return "redirect:/index.do";
	}
}
