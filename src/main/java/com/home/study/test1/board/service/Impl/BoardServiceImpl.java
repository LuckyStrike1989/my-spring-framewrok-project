package com.home.study.test1.board.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.home.study.common.search.PagingVO;
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
		if (boardSearchVO.getPagingVO() == null) {
			boardSearchVO.setPagingVO(new PagingVO());
		}
		
		int count = boardDao.selectBoardListCount(boardSearchVO);
		boardSearchVO.getPagingVO().setRecordTotalCount(count);
		
		List<BoardVO> boardList = null;
		if (count > 0) {
			boardSearchVO.getPagingVO().processZero();
			boardList = boardDao.selectBoardList(boardSearchVO);
		}
		
		return boardList;
	}

}
