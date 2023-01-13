package com.spring.javawspring.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javawspring.dao.BoardDAO;
import com.spring.javawspring.vo.BoardReplyVO;
import com.spring.javawspring.vo.BoardVO;
import com.spring.javawspring.vo.GoodVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize, String search, String searchString) {
		
		return boardDAO.getBoardList(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public int setBoardInput(BoardVO vo) {
		
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public void setReadNumPlus(int idx) {
		boardDAO.setReadNumPlus(idx);
	}

	@Override
	public void setClickLike(int idx) {
		boardDAO.setClickLike(idx);
	}

	@Override
	public ArrayList<BoardVO> getPrevNext(int idx) {
		
		return boardDAO.getPrevNext(idx);
	}

	@Override
	public void imgCheck(String content) {
		
//		        0         1         2         3         4         5        6          7         8         9         
//		        01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//		<p><img src="/javawspring/data/ckeditor/230111121332_2.png" style="height:210px; width:210px" /></p>
		
//		content 안에 그림 파일이 존재할때만 작업을 수행할 수 있도록 한다.
		
		if(content.indexOf("src=\"/")==-1) return;
		
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String uploadPath=request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		int position=32;
		
		String nextImg=content.substring(content.indexOf("src=\"/")+position);
		
		boolean sw=true;
		
		while(sw) {
			String imgFile=nextImg.substring(0, nextImg.indexOf("\""));
			
			String originalFilePath=uploadPath+imgFile;
			String copyFilePath=uploadPath+"board/"+imgFile;
			
			fileCopyCheck(originalFilePath, copyFilePath);	// board 폴더에 파일을 복사 처리
			
			if(nextImg.indexOf("src=\"/")==-1) {
				sw=false;
			}
			else {
				nextImg=nextImg.substring(nextImg.indexOf("src=\"/")+position);
			}
		}
		
	}
	
//	폴더에 파일 복사처리하는 메소드

	private void fileCopyCheck(String originalFilePath, String copyFilePath) {
		
		File originalFile=new File(originalFilePath);
		File copyFile=new File(copyFilePath);
		
		try {
			FileInputStream fis=new FileInputStream(originalFile);
			FileOutputStream fos=new FileOutputStream(copyFile);
			
			byte[] buffer=new byte[2048];
			
			int cnt=0;
			
			while((cnt=fis.read(buffer))!=-1) {
				fos.write(buffer, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void setBoardDeleteOk(int idx) {
		boardDAO.setBoardDeleteOk(idx);
	}
	
//	게시글 삭제할때 혹시 파일이 있다면 삭제 처리를 하기 위한 메소드

	@Override
	public void imgDelete(String content) {
		
//              0         1         2         3         4         5        6          7         8         9         
//              01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//		<p><img src="/javawspring/data/ckeditor/board/230111121332_2.png" style="height:210px; width:210px" /></p>

//		content 안에 그림 파일이 존재할때만 작업을 수행할 수 있도록 한다.		
		
		if(content.indexOf("src=\"/")==-1) return;
		
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String uploadPath=request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/board/");
		
		int position=38;
		
		String nextImg=content.substring(content.indexOf("src=\"/")+position);
		
		boolean sw=true;
		
		while(sw) {
			String imgFile=nextImg.substring(0, nextImg.indexOf("\""));	// 그림 파일명 꺼내오기
			
			String originalFilePath=uploadPath+imgFile;
			
			fileDelete(originalFilePath);	// board 폴더에 파일을 복사 처리
			
			if(nextImg.indexOf("src=\"/")==-1) {
				sw=false;
			}
			else {
				nextImg=nextImg.substring(nextImg.indexOf("src=\"/")+position);
			}
		}
		
		
	}
	
//	파일 삭제

	private void fileDelete(String originalFilePath) {
		
		File delfile=new File(originalFilePath);
		
		if(delfile.exists()) delfile.delete();
		
	}
	
//	게시글 수정 시 파일이 있다면 ckeditor로 복사 처리

	@Override
	public void imgCheckUpdate(String content) {

//       	    0         1         2         3         4         5        6          7         8         9         
//              01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//		<p><img src="/javawspring/data/ckeditor/230111121332_2.png" style="height:210px; width:210px" /></p>

//		content 안에 그림 파일이 존재할때만 작업을 수행할 수 있도록 한다.

		if(content.indexOf("src=\"/")==-1) return;
		
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String uploadPath=request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/board/");
		
		int position=38;
		
		String nextImg=content.substring(content.indexOf("src=\"/")+position);
		
		boolean sw=true;
		
		while(sw) {
			String imgFile=nextImg.substring(0, nextImg.indexOf("\""));
			
			String originalFilePath=uploadPath+imgFile;
			String copyFilePath=request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/"+imgFile);
			
			fileCopyCheck(originalFilePath, copyFilePath);	// board 폴더에 파일을 복사 처리
			
			if(nextImg.indexOf("src=\"/")==-1) {
				sw=false;
			}
			else {
				nextImg=nextImg.substring(nextImg.indexOf("src=\"/")+position);
			}
		}
		
	}

	@Override
	public void setBoardUpdateOk(BoardVO vo) {
		boardDAO.setBoardUpdateOk(vo);
	}

	@Override
	public GoodVO getBoardGoodCheck(int partIdx, String part, String mid) {
		
		return boardDAO.getBoardGoodCheck(partIdx, part, mid);
	}

	@Override
	public void setBoardGoodInfor(int partIdx, String part, String mid) {
		boardDAO.setBoardGoodInfor(partIdx, part, mid);
	}

	@Override
	public void setDbLike(int partIdx, String mid, String part) {
		boardDAO.setDbLike(partIdx, mid, part);
	}

	@Override
	public void setDbLikeDelete(int partIdx, String mid, String part) {
		boardDAO.setDbLikeDelete(partIdx, mid, part);
	}

	@Override
	public void setUnClickLike(int idx) {
		boardDAO.setUnClickLike(idx);
	}

	@Override
	public int setBoardReplyInput(BoardReplyVO replyVO) {
		
		return boardDAO.setBoardReplyInput(replyVO);
	}

	@Override
	public List<BoardReplyVO> getBoardReply(int idx) {
		
		return boardDAO.getBoardReply(idx);
	}

	@Override
	public int setBoardReplyDeleteOk(int idx) {
		
		return boardDAO.setBoardReplyDeleteOk(idx);
	}

	@Override
	public String getMaxLevelOrder(int boardIdx) {
		
		return boardDAO.getMaxLevelOrder(boardIdx);
	}

	@Override
	public void setLevelOrderPlusUpdate(BoardReplyVO replyVO) {
		System.out.println("서비스 구현 클래스"+replyVO.getIdx());
		boardDAO.setLevelOrderPlusUpdate(replyVO);
	}

	@Override
	public void setBoardReplyInput2(BoardReplyVO replyVO) {
		boardDAO.setBoardReplyInput2(replyVO);
	}

	@Override
	public int getSearchTotRecCnt(String search, String searchString) {
		
		return boardDAO.getSearchTotRecCnt(search, searchString);
	}

	@Override
	public ArrayList<BoardVO> getNewBoardList() {
		
		return boardDAO.getNewBoardList();
	}

	@Override
	public void setBoardReplyUpdate(BoardReplyVO vo) {
		boardDAO.setBoardReplyUpdate(vo);
	}

}
