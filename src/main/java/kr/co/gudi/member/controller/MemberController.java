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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.member.service.MemberService;

@Controller
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberService service;
	
	@RequestMapping(value = "/login")
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
	
	@RequestMapping(value="/overlay")
	@ResponseBody // ajax 에서 반환하는 값을 response 에 그려주는 역할을 한다.
	public HashMap<String, Object> overlay(@RequestParam String id) {
		boolean use = service.overlay(id);
		logger.info("사용 가능 여부 : "+use);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("use", use);
		// No converter found for return value of type: class java.util.HashMap
		// 자바가 아닌 타입으로 들어가기 때문에 어떻게 해석을 해야할지 모르겠다는 의미이다.
		// response 는 출력(페이지그리기)이 되는 객체이므로 값을 기존 페이지위에 값을 그리고 출력한다.
		
		return map;
	}
	
	
	
	
	@RequestMapping(value = "/join")
	public String join(Model model, @RequestParam HashMap<String, String> params) {
		logger.info("params", params);
		String msg = service.join(params);
		model.addAttribute("msg",msg);
		return "login";
	}
	
	
}
