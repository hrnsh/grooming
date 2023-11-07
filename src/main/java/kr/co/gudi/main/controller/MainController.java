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
	public String main(Model model) {
		ArrayList<MainDTO> rank = service.rank();
		model.addAttribute("rank", rank);
		return "main";
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginId");
		return "redirect:/main";
	}
}
