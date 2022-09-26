package com.kg.seeot.board.service;

import org.springframework.web.multipart.MultipartFile;

import com.kg.seeot.board.dto.FileDTO;

public interface BoardFileService {
	public String IMAGE_REPO = "c:/spring/image_repo";
	public String getMessage(String msg, String url);
	public FileDTO saveFile(MultipartFile file);
	public void deleteImage(String fName);
}
