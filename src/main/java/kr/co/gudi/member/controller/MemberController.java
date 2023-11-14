package kr.co.gudi.member.controller;

import java.util.HashMap;
import java.util.Objects;

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
			@RequestParam String user_id, @RequestParam String pw) {
		String page = "/login";
		logger.info(user_id+"/"+pw);
		if(user_id!="" && pw!="") {
			boolean success = service.logingo(user_id,pw)!= null ? true : false;
			logger.info("login success : "+success);
			
			if(success) {
				session.setAttribute("loginId", user_id);
				page = "redirect:/";
			}else {
				model.addAttribute("msg", "아이디 또는 비밀번호를 확인해 주세요.");
			}
		}else {
			model.addAttribute("msg", "아이디 또는 비밀번호를 입력해 주세요.");
		}
		return page;
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginId");
		return "redirect:/";
	}
	

	@RequestMapping(value = {"/findID"})
	public String findID() {
		return "findID";
	}
	
	@RequestMapping(value="/dofindID", method=RequestMethod.POST)
	public String dofindID(@RequestParam String name, @RequestParam String email, Model model) {
		String page = "/findID";
		if(name!="" && email!="") {
			String user_Id = service.dofindID(name,email);
			if(user_Id != null) {
				model.addAttribute("msg", "회원님의 아이디는 '"+user_Id+"' 입니다.");
				page="login";
			}else {
				model.addAttribute("msg", "아이디를 찾을 수 없습니다. 이름 또는 이메일을 확인해 주세요.");
			}
		}else {
			model.addAttribute("msg", "이름 또는 이메일을 입력해 주세요.");
		}
		return page;
	}
	
	@RequestMapping(value = {"/findPW"})
	public String findPW() {
		return "findPW";
	}
	
	@RequestMapping(value="/dofindPW", method=RequestMethod.POST)
	public String dofindPW(@RequestParam String name, @RequestParam String user_id, 
			@RequestParam String email, Model model) {
		logger.info("name,user_id,email " + name,user_id,email);
		String page = "findPW";
		
		if(name!="" && user_id!="" && email!="") {
			String pw = service.dofindPW(name, user_id, email);
			if(pw != null) {
				model.addAttribute("msg", "회원님의 비밀 번호는 '"+pw+"' 입니다.");
				page="login";
			}else {
				model.addAttribute("msg", "비밀번호를 찾을 수 없습니다. 이름, 아이디, 또는 이메일을 확인해 주세요.");
			}
		}else {
			model.addAttribute("msg", "이름, 아이디, 또는 이메일을 입력해 주세요.");
		}
		return page;
	}
	
	
	
	@RequestMapping(value = {"/joinForm"})
	public String joinForm() {
		return "joinForm";
	}
	
	@RequestMapping(value="/overlayId")
	@ResponseBody
	public HashMap<String, Object> overlayId(@RequestParam String user_id) {
		logger.info("user"+user_id);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(user_id!="") {
			boolean use = service.overlayId(user_id);
			logger.info("사용 가능 여부 : "+use);
			map.put("use", use);
		}
		return map;
	}
	
	@RequestMapping(value="/overlayEmail")
	@ResponseBody
	public HashMap<String, Object> overlayEmail(@RequestParam String email) {
		logger.info("email"+email);
		boolean use = service.overlayEmail(email);
		logger.info("사용 가능 여부 : "+use);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("use", use);
		return map;
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(Model model, @RequestParam HashMap<String, String> params) {
		logger.info("params : "+params);
		String msg = service.join(params);
		model.addAttribute("msg", msg);
		return "login";
	}
	
	
}
