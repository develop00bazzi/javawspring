package com.spring.javawspring;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javawspring.common.SecurityUtil;
import com.spring.javawspring.pagination.PageProcess;
import com.spring.javawspring.pagination.PageVO;
import com.spring.javawspring.service.PdsService;
import com.spring.javawspring.vo.PdsVO;

@Controller
@RequestMapping("/pds")

public class PdsController {
	
	@Autowired
	PdsService pdsService;
	
	@Autowired
	PageProcess pageProcess;
	
//	자료실 리스트 이동
	
	@RequestMapping(value = "/pdsList", method = RequestMethod.GET)
	public String pdsListGet(Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name = "search", defaultValue = "", required = false) String search,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part
			) {	
		
		int totRecCnt=pdsService.getSearchTotRecCnt(part, search, searchString);
		
		PageVO pageVO=pageProcess.pageNation(pag, pageSize, totRecCnt);
		
		ArrayList<PdsVO> vos=pdsService.getPdsList(pageVO.getStartIndexNo(), pageVO.getPageSize(), part, search, searchString);
		
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVO);
		
		return "pds/pdsList";
	}
	
//	자료실 글쓰기 페이지 이동
	
	@RequestMapping(value = "/pdsInput", method = RequestMethod.GET)
	public String pdsInputGet() {
		return "pds/pdsInput";
	}
	
//	자료실 글쓰기 처리
	
//	multifile 자료 처리시에는 MultipartHttpServletRequest 객체 사용
	
	@RequestMapping(value = "/pdsInput", method = RequestMethod.POST)
	public String pdsInputPost(PdsVO vo, MultipartHttpServletRequest file) {
		
		String pwd=vo.getPwd();
		
		pwd=SecurityUtil.encryptSHA256(pwd);
		
		vo.setPwd(pwd);
		
//		멀티 파일을 서버에 저장시키고 정보를 DB에 저장
		
		pdsService.setPdsInput(file, vo);
		
		return "redirect:/msg/pdsInputOk";
	}
	
//	자료실 파일 다운로드 횟수 증가 처리
	
	@ResponseBody
	@RequestMapping(value = "/pdsDownNum", method = RequestMethod.POST)
	public String pdsDownNumPost(int idx) {
		
		pdsService.setPdsDownNum(idx);
		
		return "";
	}
	
//	자료실 파일 삭제 처리
	
//	삭제 처리 전 비밀번호를 체크한 후 맞으면 삭제 처리한다.
	
	@ResponseBody
	@RequestMapping(value = "/pdsDelete", method = RequestMethod.POST)
	public String pdsDeletePost(int idx, String pwd) {
		
		pwd=SecurityUtil.encryptSHA256(pwd);
		
		PdsVO vo=pdsService.getPdsContent(idx);
		
		if(!pwd.equals(vo.getPwd())) return "0";
		
//		비밀번호가 일치하면 파일 삭제 후 DB의 내역을 삭제처리한다.
		
		pdsService.setPdsDelete(vo);
		
		return "1";
	}
	
//	자료실 파일 전체 다운로드 페이지 이동
	
	@RequestMapping(value = "/pdsTotalDown", method = RequestMethod.GET)
	public String pdsTotalDownGet(HttpServletRequest request, int idx) throws IOException {
		
//		파일 압축 다운로드 처리 전에 다운로드 수를 증가
		
		pdsService.setPdsDownNum(idx);
		
//		여러 개의 파일일 경우 모든 파일을 하나의 파일로 압축(?=통합) 처리하여 다운로드 처리
//		이때 압축파일명은 '제목'으로 처리
		
		String realPath=request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		PdsVO vo=pdsService.getPdsContent(idx);
		
		String[] fNames=vo.getFName().split("/");
		String[] fSNames=vo.getFSName().split("/");
		
		String zipPath=realPath+"temp/";
		String zipName=vo.getTitle()+".zip";
		
		FileInputStream fis=null;
		FileOutputStream fos=null;
		
		ZipOutputStream zos=new ZipOutputStream(new FileOutputStream(zipPath+zipName));
		
		byte[] buffer=new byte[2048];
		
		for(int i=0; i<fSNames.length; i++) {
			
			fis=new FileInputStream(realPath+fSNames[i]);	
			fos=new FileOutputStream(zipPath+fNames[i]);	
			
			File moveAndRename=new File(zipPath+fNames[i]);
			
//			fos에 파일 쓰기 작업
			
			int data;
			
			while((data=fis.read(buffer,0,buffer.length))!=-1) {
				fos.write(buffer,0,data);
			}
			fos.flush();
			fos.close();
			fis.close();
			
//			zip 파일에 fos를 넣는 작업
			
			fis=new FileInputStream(moveAndRename);
			
			zos.putNextEntry(new ZipEntry(fNames[i]));
			
			while((data=fis.read(buffer,0,buffer.length))!=-1) {
				zos.write(buffer,0,data);
			}
			
			zos.flush();
			zos.closeEntry();
			fis.close();
		}
		
		zos.close();
		
		return "redirect:/pds/pdsDownAction?file="+java.net.URLEncoder.encode(zipName);
	}
	
	@RequestMapping(value = "/pdsDownAction", method = RequestMethod.GET)
	public void pdsDownActionGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String file=request.getParameter("file");
		
		String downPathFile=request.getSession().getServletContext().getRealPath("/resources/data/pds/temp/")+file;
		
		File downFile=new File(downPathFile);
		
		String downFileName=new String(file.getBytes("UTF-8"),"8859_1");
		
		response.setHeader("Content-Disposition", "attachment;filename="+downFileName);
		
		FileInputStream fis=new FileInputStream(downFile);
		
		ServletOutputStream sos=response.getOutputStream();
		
		byte[] buffer=new byte[2048];
		
		int data=0;
		
		while((data=fis.read(buffer,0,buffer.length))!=-1) {
			sos.write(buffer,0,data);
		}
		
		sos.flush();
		sos.close();
		fis.close();
		
//		다운로드 완료 후 temp 폴더의 파일들을 모두 삭제한다.
		
//		new File(downPathFile).delete();
		
		downFile.delete();
		
//		ZIP 파일을 제외한 나머지 원본 파일들은 관리자에서 확인 후 삭제처리할수 있도록 공부해보기
		
	}
	
	@RequestMapping(value = "/pdsContent", method = RequestMethod.GET)
	public String pdsContentGet(Model model, int idx, 
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name = "search", defaultValue = "", required = false) String search,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part
			) {
		
		PdsVO vo=pdsService.getPdsContent(idx);
		
		System.out.println("자료실 자료 보기 : "+vo);
		
		PageVO pageVO=new PageVO();
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pageVo",pageVO);
		
		return "pds/pdsContent";
	}
	

}
