package com.kg.seeot.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.dto.ReplyDTO;
import com.kg.seeot.board.service.BoardFileService;
import com.kg.seeot.board.service.BoardService;
import com.kg.seeot.common.SessionName;

@Controller
@RequestMapping("board")
public class BoardController{
	@Autowired
	BoardService bs;
	@Autowired
	BoardFileService bfs;

	@GetMapping("boardList")
	public String boardList(Model model, @RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
		bs.boardList(model, currentPage);
		return "board/boardList.page";
	}

	@GetMapping("board")
	public String getBoard(int boardNo, Model model) {
		bs.getBoard(boardNo, model);
		return "board/board.page";
	}

	@GetMapping("boardWrite")
	public String boardWrite() {
		return "board/boardWrite.page";
	}
	
	@PostMapping("boardWrite")
	@ResponseBody
	public void boardWrite(MultipartHttpServletRequest mul, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		String message = bs.boardWrite(mul, request);
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(message);
	}
	
	@GetMapping("modifyForm")
	public String modifyForm(int boardNo, Model model) {
		bs.getBoard(boardNo, model);
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

	@GetMapping("delete")
	public void delete(int boardNo, HttpServletResponse response, HttpServletRequest request)
			throws IOException {
		String msg = bs.delete(boardNo, request);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(msg);
	}
	
	@GetMapping("download")
	public void downloadFile(String file, HttpServletResponse response) throws Exception{
		response.addHeader("Content-disposition", "attachment; fileName=" + file);
		File f = new File(BoardFileService.IMAGE_REPO+"/"+file);
		FileInputStream in = new FileInputStream(f);
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
	}

	@PostMapping(value="reply", 
				produces = "application/json;charset=utf8")
	@ResponseBody
	public void reply(@RequestBody Map<String, String> map){
		System.out.println(map);
		bs.addReply(map);
	}
	
	@GetMapping(value="replyList/{boardNo}", produces = "application/json;charset=utf8")
	@ResponseBody
	public ArrayList<ReplyDTO> replyList(@PathVariable int boardNo){
		return bs.getReplyList(boardNo);
	}
	
	@PostMapping(value="deleteReply/{replyNo}", produces = "application/json;charset=utf8")
	@ResponseBody
	public int deleteReply(@PathVariable int replyNo) {
		int result = bs.deleteReply(replyNo);
		return result;
	}
	
	@PostMapping(value="modifyReply/{replyNo}/{updateContent}", produces = "application/json;charset=utf8")
	@ResponseBody
	public int modifyReply(@PathVariable int replyNo, @PathVariable String updateContent) {
		System.out.println(replyNo + updateContent);
		int result = bs.modifyReply(replyNo, updateContent);
		return result;
	}
}
