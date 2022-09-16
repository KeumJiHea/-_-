package com.kg.seeot.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ser.std.FileSerializer;
import com.kg.seeot.board.dto.FileDTO;
import com.kg.seeot.board.service.BoardFileService;
import com.kg.seeot.board.service.BoardService;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	BoardService bs;
	@Autowired
	BoardFileService bfs;

	@GetMapping("boardList")
	public String boardList(Model model) {
		bs.boardList(model);
		return "board/boardList.page";
	}

	@GetMapping("boardContentView")
	public String boardContentView(int boardNo, Model model) {
		bs.boardContentView(boardNo, model);
		return "board/boardContentView.page";
	}

	@GetMapping("boardWrite")
	public String boardWrite() {
		return "board/boardWrite.page";
	}
	
	@PostMapping("writeSave")
	@ResponseBody
	public void writeSave(MultipartHttpServletRequest mul, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		String message = bs.writeSave(mul, request);
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}
	
	@GetMapping("modifyForm")
	public String modifyForm(int boardNo, Model model) {
		bs.boardContentView(boardNo, model);
		return "board/boardModifyForm.page";
	}
	
	@PostMapping("boardModify")
	@ResponseBody
	public void boardModify(MultipartHttpServletRequest mul, HttpServletResponse response, HttpServletRequest request) throws Exception {
		String message = bs.boardModify(mul, request);
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}

	@GetMapping("boardReply")
	public String boardReply(int boardNo, Model model) {
		bs.boardContentView(boardNo, model);
		return "board/boardReply";
	}

	@GetMapping("delete")
	public void delete(String memberId, String boardFile, HttpServletResponse response, HttpServletRequest request)
			throws IOException {
		String msg = bs.delete(memberId, boardFile, request);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(msg);
	}

	@PostMapping("boardReplySave")
	public void boardReplySave(String memberId, Model model, MultipartHttpServletRequest mul,
			HttpServletResponse response, HttpServletRequest request) throws IOException {
		String message = bs.writeSave(mul, request);

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}

	@GetMapping("download")
	public void downloadFile(String file, HttpServletResponse response) throws Exception{
		response.addHeader("Content-disposition", "attachment; fileName=" + file);
		File f = new File(BoardFileService.IMAGE_REPO+"/"+file);
		FileInputStream in = new FileInputStream(f);
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
	}

}
