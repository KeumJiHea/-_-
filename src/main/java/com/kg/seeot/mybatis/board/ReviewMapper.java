package com.kg.seeot.mybatis.board;

import java.util.List;
import java.util.Map;

import com.kg.seeot.board.dto.ReviewDTO;

public interface ReviewMapper {
public  List<ReviewDTO> reviewList();
public void addReply(Map<String, String>map);
}
