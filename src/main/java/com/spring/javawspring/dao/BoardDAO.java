package com.spring.javawspring.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawspring.vo.BoardReplyVO;
import com.spring.javawspring.vo.BoardVO;
import com.spring.javawspring.vo.GoodVO;

public interface BoardDAO {

	public List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize,@Param("search") String search, @Param("searchString") String searchString);

	public int setBoardInput(@Param("vo") BoardVO vo);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public void setReadNumPlus(@Param("idx") int idx);

	public void setClickLike(@Param("idx") int idx);

	public ArrayList<BoardVO> getPrevNext(@Param("idx") int idx);

	public void setBoardDeleteOk(@Param("idx") int idx);

	public void setBoardUpdateOk(@Param("vo") BoardVO vo);

	public GoodVO getBoardGoodCheck(@Param("partIdx") int partIdx, @Param("part") String part, @Param("mid") String mid);

	public void setBoardGoodInfor(@Param("partIdx") int partIdx, @Param("part") String part, @Param("mid") String mid);

	public void setDbLike(@Param("partIdx") int partIdx, @Param("mid") String mid, @Param("part") String part);

	public void setDbLikeDelete(@Param("partIdx") int partIdx, @Param("mid") String mid, @Param("part") String part);

	public void setUnClickLike(@Param("idx") int idx);

	public int setBoardReplyInput(@Param("replyVO") BoardReplyVO replyVO);

	public List<BoardReplyVO> getBoardReply(@Param("idx") int idx);

	public int setBoardReplyDeleteOk(@Param("idx") int idx);

	public String getMaxLevelOrder( @Param("boardIdx") int boardIdx);

	public void setLevelOrderPlusUpdate(@Param("replyVO") BoardReplyVO replyVO);

	public void setBoardReplyInput2(@Param("replyVO") BoardReplyVO replyVO);

	public int getSearchTotRecCnt(@Param("search") String search, @Param("searchString") String searchString);

	public ArrayList<BoardVO> getNewBoardList();

	public void setBoardReplyUpdate(@Param("vo") BoardReplyVO vo);
	
}
