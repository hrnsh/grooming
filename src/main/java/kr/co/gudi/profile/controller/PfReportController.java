package kr.co.gudi.profile.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PfReportController {
	
	Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping(value="/pfReportList")
	public String pfReportList() {
		return "/user/pfReportList";
	}
	
//	@RequestMapping(value="/pfReportListCall")
//	@ResponseBody
//	public Map<String, Object> pfReportListCall(@RequestParam String page,
//			@RequestParam String stateOption, @RequestParam int typeOption){
//		logger.info("신고 내역 호출 성공!");
//		return ; 
//	}
}
