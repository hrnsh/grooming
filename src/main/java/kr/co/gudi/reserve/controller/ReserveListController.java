package kr.co.gudi.reserve.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.gudi.reserve.dto.ReserveDTO;
import kr.co.gudi.reserve.service.ReserveListService;

@Controller
public class ReserveListController {

	@Autowired ReserveListService service;
	@RequestMapping(value="/booking")
	public String booking(Model model, HttpSession session){
		
		ArrayList<ReserveDTO> reserveList = service.reserveList();
		model.addAttribute("reserveList", reserveList);
		
		return "reserve/reserveList";
	}
}
