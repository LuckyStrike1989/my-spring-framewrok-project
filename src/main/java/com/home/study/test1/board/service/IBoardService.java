package com.home.study.test1.board.service;

import java.util.List;

import com.home.study.test1.board.model.BoardSearchVO;
import com.home.study.test1.board.model.BoardVO;

public interface IBoardService {
	List<BoardVO> selectBoardList(BoardSearchVO boardSearchVO);
	
	boolean insertBoardItem(BoardVO boardVO);
	
	BoardVO selectBoardItem(BoardVO boardVO);
}
