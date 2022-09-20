package com.kg.seeot.mybatis.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kg.seeot.board.dto.ReviewDTO;

public interface ReviewMapper {
	
	public int addReview(ReviewDTO dto);
	public List<ReviewDTO> getRepList(int productNo);
	public void saveData(ReviewDTO dto );
	
	public void addReply(Map<String, String> map);
	public List<ReviewDTO> reviewList();
	
	
	
	
	
}
