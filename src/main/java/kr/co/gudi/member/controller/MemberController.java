package kr.co.gudi.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
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

import kr.co.gudi.main.dto.MainDTO;
import kr.co.gudi.member.dto.MemberDTO;
import kr.co.gudi.member.service.MemberService;

@Controller
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberService service;
	
	@RequestMapping(value = {"/login"})
	public String login() {
		return "login";
	}
	
	@RequestMapping(value = "/logingo", method = RequestMethod.POST)
	public String logingo(Model model, HttpSession session,
			@RequestParam String id, @RequestParam String pw) {
		
		logger.info(id+"/"+pw);
		boolean success = service.logingo(id,pw)!= null ? true : false;
		logger.info("login success : "+success);
		String page = "redirect:/login";
		
		if(success) {
			session.setAttribute("loginId", id);
			page = "redirect:/";
		}else {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인하세요");
		}
		
		return page;
	}
	

	@RequestMapping(value = {"/findID"})
	public String findID() {
		return "findID";
	}
	
	@RequestMapping(value= {"/dofindID"})
	public String dofindID(@RequestParam String id, @RequestParam String email, Model model, HttpSession session) {
		logger.info(id+"/"+email);
		boolean success = service.dofindID(id,email)!= null ? true : false;
		logger.info("findID success : "+success);
		String page = "redirect:/findIDresult";
		
		if(success) {
			session.setAttribute("loginId", id);
			page = "redirect:/findIDresult";
		}else {
			model.addAttribute("msg", "아이디 또는 이메일을 확인하세요");
		}
		
		return page;
	}
	
	
	@RequestMapping(value = {"/findPW"})
	public String findPW() {
		return "findPW";
	}
	
	
	
	@RequestMapping(value = {"/joinForm"})
	public String joinForm() {
		return "joinForm";
	}
	
	@RequestMapping(value="/overlay")
	@ResponseBody
	public HashMap<String, Object> overlay(@RequestParam String id) {
		boolean use = service.overlay(id);
		logger.info("사용 가능 여부 : "+use);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("use", use);
		return map;
	}
	
	@RequestMapping(value="/join", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> join(@RequestParam HashMap<String, String> params){
		logger.info("params : "+params);
		HashMap<String, Object> result = new HashMap<String, Object>();
		int row = service.join(params);
		result.put("success", row);
		return result;
	}
	
	
}
