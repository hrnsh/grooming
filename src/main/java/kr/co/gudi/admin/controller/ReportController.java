package kr.co.gudi.admin.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.admin.service.ReportService;

@Controller
public class ReportController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReportService reportService;
	
	@RequestMapping(value="/adReport")
	public String adReport() {
		return "/admin/adReport";
	}
	
	// 신고 문의 리스트 호출 ajax 
	@RequestMapping(value="/reportListCall")
	@ResponseBody
	public Map<String, Object> reportListCall(@RequestParam String ad_id, @RequestParam String page){
		logger.info("신고 문의 리스트 호출 성공!");
		return reportService.reportListCall(ad_id,page);
	}
	
	@RequestMapping(value="/adReportDetail")
	public String adReportDetail(@RequestParam String report_num,
			HttpSession session, Model model) {
		String ad_id = (String) session.getAttribute("ad_id");
		reportService.reportDetail(report_num, ad_id, model);
		return "/admin/adReportDetail";
	}
}
