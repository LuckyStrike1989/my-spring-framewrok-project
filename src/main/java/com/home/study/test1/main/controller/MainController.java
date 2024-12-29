package com.home.study.test1.main.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.home.study.test1.board.model.BoardSearchVO;
import com.home.study.test1.board.model.BoardVO;
import com.home.study.test1.board.service.IBoardService;

@Controller
public class MainController {
	@Autowired
	private IBoardService boardService;
	
	@RequestMapping("/index")
	public String mainIndex(@ModelAttribute("boardSearchVO") BoardSearchVO boardSearchVO, ModelMap model) {
		String searchType = boardSearchVO.getSearchType();
		if (searchType.isEmpty()) {
			searchType = "subject";
		}
		
		String searchCondition = boardSearchVO.getSearchCondition();
		if (searchCondition.isEmpty()) {
			searchCondition = "equal";
		}
		
		String searchKeyword = boardSearchVO.getSearchKeyword();
		searchKeyword = searchKeyword.trim();
		
		List<BoardVO> boardList = boardService.selectBoardList(boardSearchVO);
		model.addAttribute("boardList", boardList);
		
		return "main/main";
	}
	
	@RequestMapping("/default")
	public String defaultIndex(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		List<String> memberIDList = new ArrayList<>();
		memberIDList.add("testid1");
		memberIDList.add("testid2");
		memberIDList.add("testid3");
		memberIDList.add("testid4");
		memberIDList.add("testid5");
		model.addAttribute("memberList", memberIDList);
		
		return "main/main";
	}
}
