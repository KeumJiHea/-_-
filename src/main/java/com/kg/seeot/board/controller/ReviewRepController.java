package com.kg.seeot.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kg.seeot.board.dto.ReviewDTO;
import com.kg.seeot.board.service.ReviewService;

@RestController 
@RequestMapping("review")
public class ReviewRepController {
	@Autowired ReviewService rs;
	
	/*댓글가져오기용*/
	
	@GetMapping(value = "replyData", produces="application/json;charset=utf8")
	public List<ReviewDTO> replyData(@RequestParam("productNo") int productNo,
			Model model,@RequestParam(value="num", required=false, defaultValue="1") int num){
			
		System.out.println(productNo +","+ num);
		//System.out.println("beforestar : "+beforestar);
		

		return rs.getRepList(model,productNo ,num);

	}

	
	@GetMapping(value = "replyData1", produces="application/json;charset=utf8")
	public List<ReviewDTO> replyData(//@PathVariable int productNo
			){
		//System.out.println("reviewRepController");
		int productNo = 10002;
		
		return  rs.getRepList1(productNo );
	}

}

