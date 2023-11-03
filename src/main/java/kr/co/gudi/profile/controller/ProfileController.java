package kr.co.gudi.profile.controller;

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

import kr.co.gudi.profile.dto.ProfileDTO;
import kr.co.gudi.profile.service.ProfileService;

@Controller
public class ProfileController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired ProfileService service;
	
	@RequestMapping(value = "/profile")
	public String profile(@RequestParam String user_id, Model model) {
		ProfileDTO dto = service.profile(user_id);
		model.addAttribute("member", dto);
		logger.info("profile user_id : "+user_id);
		return "/user/pfNomal";
	}
	
	@RequestMapping(value="/listCall")
	@ResponseBody
	public HashMap<String, Object> listCall(HttpSession session, @RequestParam String user_id) {
		
		HashMap<String, Object>result = new HashMap<String, Object>();
		logger.info("aniamllist id : " + user_id);
		
		if(session.getAttribute("loginId") == null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			ArrayList<ProfileDTO> list = service.list(user_id);
			result.put("list", list);
		}
		return result;
	}

}
