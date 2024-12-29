package com.home.study.test1.board.dao;

import java.util.List;

import com.home.study.test1.board.model.BoardSearchVO;
import com.home.study.test1.board.model.BoardVO;

public interface IBoardDao {
	int selectBoardListCount(BoardSearchVO boardSearchVO);
	
	List<BoardVO> selectBoardList(BoardSearchVO boardSearchVO);
}
