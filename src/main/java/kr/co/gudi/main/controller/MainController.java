package kr.co.gudi.main.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.gudi.main.dto.MainDTO;
import kr.co.gudi.main.service.MainService;

@Controller
public class MainController {

	@Autowired MainService service;
	
	@RequestMapping(value="/")
	public String main(Model model) {
		ArrayList<MainDTO> rank = service.rank();
		model.addAttribute("rank", rank);
		return "main";
	}
	
	@RequestMapping(value="/locationSearch")
	public String locationSearch() {
		return "locationSearch";
	}
	
	@RequestMapping(value="/reserve")
	public String reserve() {
		return "locationSearch";
	}
	
	@RequestMapping(value="/boardMain")
	public String boardMain() {
		return "boardMain";
	}
	
	@RequestMapping(value="/adFaqList")
	public String adFaqList() {
		return "adFaqList";
	}
	
	@RequestMapping(value="/login")
	public String login() {
		return "login";
	}
	
	@RequestMapping(value="/profile")
	public String profile() {
		return "profile";
	}
	
	@RequestMapping(value="/pfNoteList")
	public String pfNoteList() {
		return "pfNoteList";
	}
	
	@RequestMapping(value="/pfWrite")
	public String pfWrite() {
		return "pfWrite";
	}
	
}
