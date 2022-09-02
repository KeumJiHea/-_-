package com.kg.seeot.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kg.seeot.board.dto.ReviewDTO;
import com.kg.seeot.board.service.ReviewService;

@RestController //값만 받아온다
@RequestMapping("review")
public class ReviewRepController {
	@Autowired ReviewService rs;
	
	/*
	@PostMapping(value="addReview",produces="application/json;charset=utf8" )
	public void addReview(@RequestParam(value="memberId", required=false) String memberId,
			@RequestParam(value="reviewContent", required=false) String reviewContent, 
				@RequestParam(value="reviewStar", required=false) String reviewStar) {
		System.out.println("controller");
		System.out.println(memberId);
		System.out.println(reviewContent);
		System.out.println(reviewStar);
		//rs.addReview( memberId,reviewContent, reviewStar);
	}
	*/
	//map<key,value>
	@PostMapping(value="addReview",produces="application/json;charset=utf8" )
	public void addReview(@RequestBody Map<String, Object> map) {
		System.out.println("controller"); 
		
		  System.out.println((String)map.get("memberId"));
		  System.out.println((String)map.get("reviewContent"));
		  System.out.println((String)map.get("reviewFile"));
		  System.out.println(map.get("productNo"));
		  System.out.println(map.get("reviewStar")); 
		  System.out.println(map.get("rating")); 
		
		
		//int reviewStar = Integer.parseInt(String.valueOf(map.get("reviewStar")) );
	
		
	
		rs.addReview(map);
	}
	
	@PostMapping(value="addStar",produces="application/json;charset=utf8")
	public void addStar(int reviewStar) {
		rs.addStar(reviewStar);
	}
    /*
   
     * 게시물 댓글 불러오기(Ajax)
     * @param boardVO
     * @param request
     * @return
     * @throws Exception
  
    @RequestMapping(value="/board/commentList.do", produces="application/json; charset=utf8")
    @ResponseBody
    public ResponseEntity ajax_commentList(@ModelAttribute("boardVO") BoardVO boardVO, HttpServletRequest request) throws Exception{
        
        HttpHeaders responseHeaders = new HttpHeaders();
        ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
        
        // 해당 게시물 댓글
        List<BoardVO> commentVO = boardServiceImpl.selectBoardCommentByCode(boardVO);
        
        if(commentVO.size() > 0){
            for(int i=0; i<commentVO.size(); i++){
                HashMap hm = new HashMap();
                hm.put("c_code", commentVO.get(i).getC_code());
                hm.put("comment", commentVO.get(i).getComment());
                hm.put("writer", commentVO.get(i).getWriter());
                
                hmlist.add(hm);
            }
            
        }
        
        JSONArray json = new JSONArray(hmlist);        
        return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
        
    }
    */
}

