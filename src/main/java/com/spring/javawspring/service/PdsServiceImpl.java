package com.spring.javawspring.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javawspring.common.JavawspringProvide;
import com.spring.javawspring.dao.PdsDAO;
import com.spring.javawspring.vo.PdsVO;

@Service
public class PdsServiceImpl implements PdsService {
	
	@Autowired
	PdsDAO pdsDAO;

	@Override
	public int getSearchTotRecCnt(String part, String search, String searchString) {
		return pdsDAO.getSearchTotRecCnt(part, search, searchString);
	}

	@Override
	public ArrayList<PdsVO> getPdsList(int startIndexNo, int pageSize, String part, String search, String searchString) {
		
		return pdsDAO.getPdsList(startIndexNo, pageSize, part, search, searchString);
	}

	@Override
	public void setPdsInput(MultipartHttpServletRequest mFile, PdsVO vo) {
		
		try {
			List<MultipartFile> fileList=mFile.getFiles("file");
			
			String oFileNames="";
			String sFileNames="";
			int fileSizes=0;
			
			for(MultipartFile file : fileList) {
				
				String oFileName=file.getOriginalFilename();
				String sFileName=saveFileName(oFileName);
				
//				파일 업로드 메소드 호출
				
				writeFile(file, sFileName);
				
				oFileNames+=oFileName+"/";
				sFileNames+=sFileName+"/";
				fileSizes+=file.getSize();
				
			}
			
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			vo.setFSize(fileSizes);
			
			pdsDAO.setPdsInput(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
//	실제 서버에 저장되는 파일명 중복 방지를 위한 파일명 설정

	private String saveFileName(String oFileName) {
		
		String fileName="";
		
		Calendar cal=Calendar.getInstance();
		
		fileName+=cal.get(Calendar.YEAR);
		fileName+=cal.get(Calendar.MONTH);
		fileName+=cal.get(Calendar.DATE);
		fileName+=cal.get(Calendar.HOUR);
		fileName+=cal.get(Calendar.MINUTE);
		fileName+=cal.get(Calendar.SECOND);
		fileName+=cal.get(Calendar.MILLISECOND);
		fileName+="_"+oFileName;
		
		return fileName;
	}
	
//	실제로 파일을 서버에 저장한다.
	
	private void writeFile(MultipartFile file, String sFileName) throws IOException {
		
		byte[] data=file.getBytes();
		
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String realPath=request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		FileOutputStream fos=new FileOutputStream(realPath+sFileName);
		
		fos.write(data);
		fos.close();
	}

	@Override
	public void setPdsDownNum(int idx) {
		pdsDAO.setPdsDownNum(idx);
	}

	@Override
	public PdsVO getPdsContent(int idx) {
		
		return pdsDAO.getPdsContent(idx);
	}

	@Override
	public void setPdsDelete(PdsVO vo) {
		
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String realPath=request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		String[] fSNames=vo.getFSName().split("/");
		
//		서버에 존재하는 파일들을 삭제 처리한다.
		
		for(int i=0; i<fSNames.length; i++) {
			File file = new File(realPath+fSNames[i]);
			if(file.exists()) file.delete();			
		}
		
//		DB에 pds 게시글 내역 삭제 처리
		
		pdsDAO.setPdsDelete(vo.getIdx());
		
		
	}

	
}
