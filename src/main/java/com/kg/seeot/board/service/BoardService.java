package com.kg.seeot.board.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface BoardService {
	public void boardList(Model model);
	public void boardContentView(int boardNo, Model model);
	public String writeSave(MultipartHttpServletRequest mul,HttpServletRequest request);
	public String delete(String memberId, String boardFile,
			HttpServletRequest request);
}
