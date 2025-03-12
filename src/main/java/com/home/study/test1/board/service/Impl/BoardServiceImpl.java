package com.home.study.test1.board.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.home.study.common.search.PaginationVO;
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
		if (boardSearchVO.getPaginationVO() == null) {
			boardSearchVO.setPaginationVO(new PaginationVO());
		}
		
		int count = boardDao.selectBoardListCount(boardSearchVO);
		boardSearchVO.getPaginationVO().setRecordTotalCount(count);
		
		List<BoardVO> boardList = null;
		if (count > 0) {
			boardSearchVO.getPaginationVO().processZero();
			boardList = boardDao.selectBoardList(boardSearchVO);
		}
		
		return boardList;
	}

	@Override
	public boolean insertBoardItem(BoardVO boardVO) {
		return (boardDao.insertBoardItem(boardVO) == 1) ? true : false;
	}

	@Override
	public BoardVO selectBoardItem(BoardVO boardVO) {
		return boardDao.selectBoardItem(boardVO);
	}

}
