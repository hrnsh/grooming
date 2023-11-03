package kr.co.gudi.reserve.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.gudi.reserve.dto.ReserveDTO;
import kr.co.gudi.reserve.service.ReserveService;


@Controller
public class ReserveController {
		Logger logger = LoggerFactory.getLogger(getClass());
		@Autowired ReserveService service;
		
		@RequestMapping(value="/reserve")
		public String reserve(Model model) {
			ArrayList<ReserveDTO> animal = service.animal();
			model.addAttribute("animal",animal);
			return "reserve/reserve";
		}
		


}

