package kr.co.gudi.reserve.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.gudi.reserve.dto.ReserveDTO;
import kr.co.gudi.reserve.service.ReserveListService;

@Controller
public class ReserveListController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReserveListService service;
	@RequestMapping(value="/booking")
	public String booking(Model model, HttpSession session){
		
		ArrayList<ReserveDTO> reserveList = service.reserveList();
		model.addAttribute("reserveList", reserveList);
		String loginId=(String) session.getAttribute("loginId");
		int checkId=service.checkId(loginId);
		logger.info("로그인ID :"+checkId);
		
		return "reserve/reserveList";
	}
}