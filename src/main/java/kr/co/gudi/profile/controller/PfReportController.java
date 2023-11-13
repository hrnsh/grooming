package kr.co.gudi.profile.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.profile.service.PfReportService;

@Controller
public class PfReportController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PfReportService pfReportService;
	
	@RequestMapping(value="/pfReportList")
	public String pfReportList() {
		return "/user/pfReportList";
	}
	
	@RequestMapping(value="/pfReportListCall")
	@ResponseBody
	public Map<String, Object> pfReportListCall(@RequestParam String page,
			@RequestParam String stateOption, @RequestParam String typeOption,HttpSession session){
		logger.info("신고 내역 호출 성공!");
		String user_id = (String) session.getAttribute("loginId");
		return pfReportService.pfReportListCall(page,stateOption,typeOption, user_id); 
	}
}
