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
	
	public int getCount(int productNo);	
	public List<ReviewDTO> reviewPage(@Param("productNo")int productNo,
			@Param("s") int start, @Param("e") int end);
	public void delete(int reviewNo);
	public ReviewDTO contentView(int reviewNo);
	public int modify(ReviewDTO dto );
	public void productCount(@Param("productNo")int productNo,
			@Param("reviewStar") int reviewStar);
	public void productmodify(@Param("modifyProductNo")int modifyProductNo,
			@Param("modifyStar") int modifyStar);
	
}
