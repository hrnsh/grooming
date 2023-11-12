package kr.co.gudi.admin.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gudi.admin.dto.InquiryDTO;
import kr.co.gudi.admin.service.InquiryService;

@Controller
public class InquiryController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired InquiryService inquiryService;
	
	@RequestMapping(value="/adInquiry")
	public String adInquiry() {
		return "/admin/adInquiry";
	}
	
	// 문의 보내기 페이지 이동 - FAQ 의  문의 보내기 버튼이랑 연결해야 함 
	@RequestMapping(value="/adInquirySend")
	public String adInquirySend() {
		return "/admin/adInquirySend";
	}
	
	// 문의 보내기  
	@RequestMapping(value="/sendInquiry", method=RequestMethod.POST)
	public String sendInquiry(MultipartFile photo, HttpSession session,
			@RequestParam String subject, @RequestParam String content) throws Exception {
		//logger.info("subject/content/photo : " +subject+"/"+content+"/"+photo);
		String loginId = (String) session.getAttribute("loginId");
		inquiryService.saveInquiry(photo, subject, content, loginId);
		return "redirect:/pfWrite";
	} 
	
	// 일반 문의 리스트 호출 ajax 
	@RequestMapping(value="/inquiryListCall")
	@ResponseBody
	public Map<String, Object> inquiryListCall(@RequestParam String page,
			@RequestParam String ad_id, @RequestParam String stateOption, @RequestParam String searchTxt,
			@RequestParam int option) {
		logger.info("일반 문의 리스트 호출 성공");
		return inquiryService.inquiryListCall(page, ad_id, stateOption, searchTxt,option);
	}
	
	// 일반 신규 문의 상세보기
	@RequestMapping(value="/adInquiryDetail")
	public String adInquiryDetail(@RequestParam String inq_num,
			HttpSession session, Model model) {
		String ad_id = (String) session.getAttribute("ad_id");
		inquiryService.newIqDetail(inq_num, ad_id, model);
		
		return "/admin/adInquiryDetail";
	}
	
	// 답장하기 페이지 이동 
	@RequestMapping(value="/adInquiryAnswer")
	public String adInqiuryAnswer(@RequestParam String inq_num, Model model) {
		InquiryDTO inquiryAnswer = inquiryService.callDetail(inq_num);
		model.addAttribute("inquiryAnswer",inquiryAnswer);
		return "/admin/adInquiryAnswer";
	}
	
	// 답장 보내기 기능 
	@RequestMapping(value="/inqAnswerSend")
	public String inqAnswerSend(@RequestParam String subject, 
			@RequestParam String content, @RequestParam String inq_num) {
		inquiryService.inqAnswerSend(subject, content, inq_num);
		return "redirect:/adInquiry";
	}
	
	
}
