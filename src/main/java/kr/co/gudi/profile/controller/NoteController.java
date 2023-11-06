package kr.co.gudi.profile.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.admin.dto.InquiryDTO;
import kr.co.gudi.admin.service.InquiryService;
import kr.co.gudi.profile.dto.NoteDTO;
import kr.co.gudi.profile.service.NoteService;

@Controller
public class NoteController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired NoteService noteService;
	
	@RequestMapping(value="/pfNoteList")
	public String pfNoteList() {
		return "/note/pfNoteList";
	}
	
	@RequestMapping(value="/sentList")
	@ResponseBody
	public Map<String, Object> sentList(@RequestParam String page, 
			@RequestParam String loginId, @RequestParam String readOptionSent){
		logger.info("내가 쓴 쪽지 리스트 호출 성공");
		return noteService.sentList(page, loginId,readOptionSent);
	}
	
	@RequestMapping(value="/receiveList")
	@ResponseBody
	public Map<String, Object> receiveList(@RequestParam String page,
			@RequestParam String loginId, @RequestParam String readOptionReceive){
		logger.info("받은 쪽지 리스트 호출 성공");
		return noteService.receiveList(page, loginId, readOptionReceive);
	}
	
	@RequestMapping(value="/pfNoteSend")
	public String pfNoteSend(Model model, @RequestParam String idx) {
		logger.info("내가 쓴 쪽지 상세보기 호출 성공");
		NoteDTO sentDetail = noteService.callDetail(idx);
		model.addAttribute("sentDetail", sentDetail);
		return "/note/pfNoteSend";
	}
	
	@RequestMapping(value="/pfNoteReceive")
	public String pfNoteReceive(Model model, @RequestParam String idx) {
		NoteDTO receiveDetail = noteService.receiveDetail(idx);
		model.addAttribute("receiveDetail", receiveDetail);
		return "/note/pfNoteReceive";
	}
	
	@RequestMapping(value="/pfNoteReply")
	public String pfNoteReply(@RequestParam String idx, Model model) {
		NoteDTO noteReply = noteService.callDetail(idx);
		model.addAttribute("noteReply", noteReply);
		return "/note/pfNoteReply";
	}
	
	@RequestMapping(value="/sendNote", method=RequestMethod.POST)
	public String sendNote(@RequestParam String subject, @RequestParam String content, 
			@RequestParam String receiver, HttpSession session) {
		String sender = (String) session.getAttribute("loginId");
		if(sender!=null) {
			noteService.sendNote(subject,content,receiver, sender);
		}
		return "redirect:/pfNoteList";
	}
	
	@RequestMapping(value="/delSent")
	@ResponseBody
	public HashMap<String, Object> delSent(){
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		return result;
	}
	
}
