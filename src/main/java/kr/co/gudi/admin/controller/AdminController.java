package kr.co.gudi.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
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

import kr.co.gudi.admin.dto.AdminDTO;
import kr.co.gudi.admin.service.AdminService;

@Controller
public class AdminController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminService service;
	
	@RequestMapping(value = "/adProfile")
	public String adminProfile(@RequestParam String ad_id, Model model, HttpSession session) {
		AdminDTO dto = service.adminProfile(ad_id);
		model.addAttribute("admin",dto);
		logger.info("admin login",ad_id);
	
		return "/admin/adProfile";
	}
	
	@RequestMapping(value = "/adminlistCall")
	@ResponseBody
	public HashMap<String, Object> adminlistCall(HttpSession session){
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("list접근");
		if(session.getAttribute("ad_id")==null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			ArrayList<AdminDTO> adminlist = service.adminlist();
			result.put("adminlist", adminlist);
		}
		logger.info("list put"+result);
		return result;
	}
	
	@RequestMapping(value="/adLogin")
	public String adLoginTest() {
		return "/admin/adLogin";
	}
	
	@RequestMapping(value="/adLoginGo", method=RequestMethod.POST)
	public String adLoginGo(HttpSession session, @RequestParam String ad_id,
			@RequestParam String ad_pw, Model model) {
		logger.info(ad_id+"/"+ad_pw);
		boolean success = service.logingo(ad_id, ad_pw);
		logger.info("login success : "+success);
		String page = "/admin/adLogin";
		
		if(success) {
			session.setAttribute("ad_id", ad_id);
			session.setAttribute("admin", "admin");
			page = "/admin/adProfile";
		}else {
			model.addAttribute("msg", "관리자 아이디 또는 비밀번호를 확인해 주세요!");
		}
		return page;
	}

	@RequestMapping(value = "/adminprofileUpdateForm")
	public String adminprofileupdate(Model model, @RequestParam String ad_id) {
		model.addAttribute("adminProfile", service.adminProfile(ad_id));
		
		return "/admin/adUpdate";
	}
	
	@RequestMapping(value = "/adprofileupdate")
	public String adminupdate(Model model, @RequestParam HashMap<String, String> params) {
		logger.info("updateParams : " + params);
		String page = "redirect:/adminprofileUpdateForm?ad_id="+params.get("ad_id");
		
		if(service.adminprofileupdate(params)>0) {
			page="redirect:/adProfile?ad_id="+params.get("ad_id");
		}
		return page;
	}
	
	@RequestMapping(value = "/adpfdetail")
	public String detail(Model model, HttpSession session, @RequestParam String ad_id) {

		String page = "main";

		if (session.getAttribute("ad_id") == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다");

		} else {
			AdminDTO dto = service.adpfdetail(ad_id);
			model.addAttribute("admin", dto);
			page = "/admin/adProfileDetail";
			logger.info(ad_id);
		}
		return page;
	}
	
	@RequestMapping(value="/adLogout")
	public String adLogout(HttpSession session) {
		logger.info("세션 삭제 : " + session);
		session.removeAttribute("admin");
		session.removeAttribute("ad_id");
		return "redirect:/";
	}
	
	@RequestMapping(value = "/adminSearchList")
	@ResponseBody
	public HashMap<String, Object> adminSearchList(HttpSession session, @RequestParam String positionSearchOption){
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("ad_position!!! : " + positionSearchOption);
		if(session.getAttribute("ad_id") == null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			ArrayList<AdminDTO> adminSearchList = service.adminSearchList(positionSearchOption);
			result.put("adminSearchList", adminSearchList);
		}
		return result;
	}
	
	
	
}
