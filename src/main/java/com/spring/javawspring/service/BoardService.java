package com.spring.javawspring.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javawspring.vo.BoardReplyVO;
import com.spring.javawspring.vo.BoardVO;
import com.spring.javawspring.vo.GoodVO;

public interface BoardService {

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize, String search, String searchString);

	public int setBoardInput(BoardVO vo);

	public BoardVO getBoardContent(int idx);

	public void setReadNumPlus(int idx);

	public void setClickLike(int idx);

	public ArrayList<BoardVO> getPrevNext(int idx);

	public void imgCheck(String content);

	public void setBoardDeleteOk(int idx);

	public void imgDelete(String content);

	public void imgCheckUpdate(String content);

	public void setBoardUpdateOk(BoardVO vo);

	public GoodVO getBoardGoodCheck(int partIdx, String part, String mid);

	public void setBoardGoodInfor(int partIdx, String part, String mid);

	public void setDbLike(int partIdx, String mid, String part);

	public void setDbLikeDelete(int partIdx, String mid, String part);

	public void setUnClickLike(int idx);

	public int setBoardReplyInput(BoardReplyVO replyVO);

	public List<BoardReplyVO> getBoardReply(int idx);

	public int setBoardReplyDeleteOk(int idx);

	public String getMaxLevelOrder(int boardIdx);

	public void setLevelOrderPlusUpdate(BoardReplyVO replyVO);

	public void setBoardReplyInput2(BoardReplyVO replyVO);

	public int getSearchTotRecCnt(String search, String searchString);

	public ArrayList<BoardVO> getNewBoardList();

	public void setBoardReplyUpdate(BoardReplyVO vo);

}
