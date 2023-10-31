package kr.co.gudi.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	
	@RequestMapping(value = "/")
	public String home() {
		logger.info("home");
		
		return "home";
	}
}
