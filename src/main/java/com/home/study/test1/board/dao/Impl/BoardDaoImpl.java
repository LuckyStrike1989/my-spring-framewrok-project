package com.home.study.test1.board.dao.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.home.study.test1.board.dao.IBoardDao;
import com.home.study.test1.board.model.BoardSearchVO;
import com.home.study.test1.board.model.BoardVO;

@Repository("BoardDaoImpl")
public class BoardDaoImpl implements IBoardDao{
	protected static final String SQL_FILE_PATH = "com.home.study.test1.board.mapper.mariadb.BoardMapper.";
	
	@Autowired
	@Qualifier("sqlSessionMariaDB")
	private SqlSession sqlSession;
	
	@Override
	public int selectBoardListCount(BoardSearchVO boardSearchVO) {
		return ((Integer)sqlSession.selectOne(SQL_FILE_PATH + "selectBoardListCount", boardSearchVO)).intValue();
		// return sqlSession.selectOne(SQL_FILE_PATH + "selectBoardListCount", boardSearchVO);
	}
	
	@Override
	public List<BoardVO> selectBoardList(BoardSearchVO boardSearchVO) {
		return sqlSession.selectList(SQL_FILE_PATH + "selectBoardList", boardSearchVO);
	}
}
