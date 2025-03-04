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
			@ModelAttribute("board") BoardVO boardVO, ModelMap model) {
		if (!boardService.insertBoardItem(boardVO)) {
			return "board/boardform";
		}
		
		return "redirect:/index.do";
	}
}
