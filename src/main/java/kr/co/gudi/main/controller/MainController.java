package kr.co.gudi.main.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.gudi.main.dto.MainDTO;
import kr.co.gudi.main.service.MainService;

@Controller
public class MainController {

	@Autowired MainService service;
	
	@RequestMapping(value={"/","/main"})
	public String main(Model model, HttpSession session) {
		ArrayList<MainDTO> rank = service.rank();
		model.addAttribute("rank", rank);
		
		// 관리자로 로그인 되어 있을 때, /로 이동하면 관리자 프로필로 이동
		String page = "main";
		String ad_id = (String) session.getAttribute("ad_id");
		if(ad_id!=null) {
			page = "/admin/adInquiry";
		}
		
		return page;
	}
	
	
}
