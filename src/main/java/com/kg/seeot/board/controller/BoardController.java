package com.kg.seeot.board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.service.BoardService;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired BoardService bs;

	
@GetMapping("test")
public String test() {
	return "board/test";
}

@GetMapping("boardList")
public String boardList(Model model) {
bs.boardList(model);
	return "board/boardList";
}

@GetMapping("boardContentView")
public String boardContentView(String memberId, Model model) {
	bs.boardContentView(memberId, model);
	return "board/boardContentView";
}
@GetMapping("boardWrite")
public String boardWrite() {
	
	return "board/boardWrite";
}
@GetMapping("boardReply")
public String boardReply(String memberId, Model model) {
	bs.boardContentView(memberId, model);
	return "board/boardReply";
}
@GetMapping("boardModifyForm")
public String boardModifyForm(String memberId, Model model) {
	bs.boardModifyForm(memberId, model);
	return "board/boardModifyForm";
}

@GetMapping("delete")
public void delete(String memberId, String boardFile,
					HttpServletResponse response,
					HttpServletRequest request) throws IOException {
	String msg = 
			bs.delete(memberId, boardFile,request);
	response.setContentType("text/html; charset=utf-8");
	PrintWriter out = response.getWriter();
	out.print( msg );
}

@PostMapping("boardReplySave")
public void boardReplySave(String memberId, Model model,MultipartHttpServletRequest mul,
			HttpServletResponse response,HttpServletRequest request) throws IOException {
	String message = bs.writeSave(mul, request);
	
	response.setContentType("text/html;charset=utf-8");
	PrintWriter out = response.getWriter();
	out.print( message );
}

@PostMapping("writeSave")
public void writeSave(MultipartHttpServletRequest mul,
		HttpServletResponse response,
		HttpServletRequest request) throws Exception {
	String message = bs.writeSave(mul, request);
	
	response.setContentType("text/html;charset=utf-8");
	PrintWriter out = response.getWriter();
	out.print( message );
}


}
