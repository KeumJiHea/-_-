package com.kg.seeot.board.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface BoardService {
	public void boardList(Model model);
	public void boardContentView(String memberId, Model model);
	public String writeSave(MultipartHttpServletRequest mul,HttpServletRequest request);
}
