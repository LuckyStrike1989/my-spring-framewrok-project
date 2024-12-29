package com.home.study.test1.board.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.home.study.test1.board.dao.IBoardDao;
import com.home.study.test1.board.model.BoardSearchVO;
import com.home.study.test1.board.model.BoardVO;
import com.home.study.test1.board.service.IBoardService;

@Service
public class BoardServiceImpl implements IBoardService {

	@Autowired
	private IBoardDao boardDao;
	
	@Override
	public List<BoardVO> selectBoardList(BoardSearchVO boardSearchVO) {
		List<BoardVO> boardList = null;
		int count = boardDao.selectBoardListCount(boardSearchVO);
		
		if( count > 0 ) {
			boardList = boardDao.selectBoardList(boardSearchVO);
		}
		
		return boardList;
	}

}
