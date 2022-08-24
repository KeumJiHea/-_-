package com.kg.seeot.board.service;

import org.springframework.web.multipart.MultipartFile;

public interface BoardFileService {
	public String IMAGE_REPO = "c:/spring/image_repo";
	public String getMessage(String msg, String url);
	public String saveFile(MultipartFile file);
}
