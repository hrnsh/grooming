package kr.co.gudi.admin.controller;

import java.util.ArrayList;
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

import kr.co.gudi.admin.dto.AdminDTO;
import kr.co.gudi.admin.service.AdminService;

@Controller
public class AdminController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminService service;
	
	@RequestMapping(value = "/adminProfile")
	public String adminProfile(@RequestParam String ad_id, Model model) {
		AdminDTO dto = service.adminProfile(ad_id);
		
		model.addAttribute("admin", dto);
		logger.info("admin id : " + ad_id);
		
		return "/admin/adProfile";
	}
	
	@RequestMapping(value = "/adminlistCall")
	@ResponseBody
	public HashMap<String, Object> adminlistCall(HttpSession session){
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		logger.info("list접근");
		if(session.getAttribute("loginId")==null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			ArrayList<AdminDTO> adminlist = service.adminlist();
			result.put("adminlist", adminlist);
		}
		logger.info("list put"+result);
		return result;
	}
}
