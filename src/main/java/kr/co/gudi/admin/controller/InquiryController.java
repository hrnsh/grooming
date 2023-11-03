package kr.co.gudi.admin.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.admin.dto.InquiryDTO;
import kr.co.gudi.admin.service.InquiryService;

@Controller
public class InquiryController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired InquiryService inquiryService;
	
	@RequestMapping(value="/pfNoteList")
	public String pfNoteList() {
		return "pfNoteList";
	}
	
	@RequestMapping(value="/sentList")
	@ResponseBody
	public Map<String, Object> sentList(@RequestParam String page){
		logger.info("내가 쓴 쪽지 리스트 호출 성공");
		logger.info("보여줄 페이지 : " +page);
		return inquiryService.sentList(page);
	}
	
	@RequestMapping(value="/receiveList")
	@ResponseBody
	public Map<String, Object> receiveList(@RequestParam String page){
		logger.info("받은 쪽지 리스트 호출 성공");
		return inquiryService.receiveList(page);
	}
	
	
	@RequestMapping(value="/pfNoteSend")
	public String pfNoteSend(Model model, @RequestParam String idx) {
		InquiryDTO sentDetail = inquiryService.sentDetail(idx);
		model.addAttribute("sentDetail", sentDetail);
		return "pfNoteSend";
	}
	
	@RequestMapping(value="/pfNoteReceive")
	public String pfNoteReceive() {
		return "pfNoteReceive";
	}
	
}
