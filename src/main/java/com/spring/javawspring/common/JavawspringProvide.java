package com.spring.javawspring.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

public class JavawspringProvide {
	
//	파일 업로드
	
	public int fileUpload(MultipartFile fName, String flag) {
		int res=0;
		
		try {
			UUID uid=UUID.randomUUID();
			
			String oFileName=fName.getOriginalFilename();
			String saveFileName=uid+"_"+oFileName;
			
			writeFile(fName, saveFileName, flag);
			
			res=1;
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}
	
//	파일 업로드 처리 메소드
	
	public void writeFile(MultipartFile fName, String saveFileName, String flag) throws IOException {
		
		byte[] data=fName.getBytes();
		
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String realPath=request.getSession().getServletContext().getRealPath("/resources/"+flag+"/");
		
		FileOutputStream fos=new FileOutputStream(realPath+saveFileName);
		
		fos.write(data);
		fos.close();
		
	}
	
//	파일 삭제 처리 메소드
	
	public void deleteFile(String fSName, String flag) {
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath=request.getSession().getServletContext().getRealPath("/resources/"+flag+"/");
		File file = new File(realPath + "/" +fSName);
		if(file.exists()) file.delete();
	}
	
}
