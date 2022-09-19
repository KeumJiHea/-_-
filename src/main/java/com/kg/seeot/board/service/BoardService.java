package com.kg.seeot.board.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface BoardService {
	public void boardList(Model model);
	public void getBoard(int boardNo, Model model);
	public String boardWrite(MultipartHttpServletRequest mul, HttpServletRequest request);
	public String boardModify(MultipartHttpServletRequest mul, HttpServletRequest request);
	public String delete(int boardNo, HttpServletRequest request);
}
