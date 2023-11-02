package kr.co.gudi.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@RequestMapping(value="/listCall")
	@ResponseBody
	public HashMap<String, Object> listCall(){
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("리스트 호출 성공");
		ArrayList<InquiryDTO> list = inquiryService.list();
		result.put("sentList", list);
		return result;
	}
	
	
}
