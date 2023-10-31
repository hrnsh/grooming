package kr.co.gudi.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.gudi.member.service.MemberService;

@Controller
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberService service;
	
	@RequestMapping(value = "/")
	public String login() {
		logger.info("로그인 페이지로 이동");
		return "login";
	}
	
	@RequestMapping(value = "/login")
	public String main(@RequestParam String id, @RequestParam String pw, Model model, HttpSession session) {
		
		logger.info(id+"/"+pw);
		boolean success = service.login(id,pw)!= null ? true : false;
		logger.info("login success : "+success);
		String page = "redirect:/main";
		
		if(success) {
			session.setAttribute("loginId", id);
			page = "redirect:/main";
		}else {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인하세요");
		}
		
		return page;
	}
	
	
	
	@RequestMapping(value = "/joinForm")
	public String joinForm() {
		logger.info("회원가입 페이지로 이동");
		return "joinForm";
	}
	
	@RequestMapping(value = "/join")
	public String join(Model model, @RequestParam HashMap<String, String> params) {
		logger.info("params", params);
		String msg = service.join(params);
		model.addAttribute("msg",msg);
		return "login";
	}
	
	
}
