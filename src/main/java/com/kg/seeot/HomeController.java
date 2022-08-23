package com.kg.seeot;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home.page";
	}
	
    /**
     * Tiles를 사용하지 않은 일반적인 형태
     */    
    @RequestMapping("/test")
    public String test() {
        return "test";
    }    
    
    /**
     * Tiles를 사용(header, footer 포함)
     */        
    @RequestMapping("/testPage")
    public String testPage() {
        return "test.page";
    }
    
    /**
     * Tiles를 사용(header, footer 제외)
     */    
    @RequestMapping("/testPart")
    public String testPart() {
        return "test.part";
    } 
	
}
