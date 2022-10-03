package com.kg.seeot.board.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kg.seeot.board.dto.ReplyDTO;

public interface BoardService {
	public void boardList(Model model, String nowPage, String cntPerPage);
	public void getBoard(int boardNo, Model model);
	public String boardWrite(MultipartHttpServletRequest mul, HttpServletRequest request);
	public String boardModify(MultipartHttpServletRequest mul, HttpServletRequest request);
	public String delete(int boardNo, HttpServletRequest request);
	public void addReply(Map<String, String> map);
	public ArrayList<ReplyDTO> getReplyList(int boardNo);
	public int deleteReply(int replyNo, int boardNo);
	public int modifyReply(int replyNo, String updateContent);
	public void upHit(int boardNo);
}
