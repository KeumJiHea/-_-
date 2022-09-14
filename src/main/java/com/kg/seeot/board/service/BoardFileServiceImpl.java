package com.kg.seeot.board.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kg.seeot.board.dto.FileDTO;

@Service
public class BoardFileServiceImpl implements BoardFileService {
	public String getMessage(String msg, String url) {
		String message = "";
		message += "<script>alert('" + msg + "');";
		message += "location.href='" + url + "';</script>";
		return message;
	}

	public FileDTO saveFile(MultipartFile file) {
		FileDTO fdto = new FileDTO();

		SimpleDateFormat simpl = new SimpleDateFormat("yyyyMMddHHmmss-");
		Calendar calendar = Calendar.getInstance();
		
		String fileOriginName = file.getOriginalFilename();
		String fileSaveName = simpl.format(calendar.getTime()) + fileOriginName;
		File saveFile = new File(IMAGE_REPO + "/" + fileSaveName);
		
		try {
			file.transferTo(saveFile);// 해당 위치에 파일 저장
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(file.getSize() != 0) {
			fdto.setFileOriginName(fileOriginName);
			fdto.setFileSaveName(fileSaveName);
		}else {
			fdto.setFileOriginName("NaN");
			fdto.setFileSaveName("NaN");
		}
		return fdto;
	}

	public void deleteImage(String fName) {
		File dFile = new File(IMAGE_REPO + "/" + fName);
		dFile.delete();
	}
}
