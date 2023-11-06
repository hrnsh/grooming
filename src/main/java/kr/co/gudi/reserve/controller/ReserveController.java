package kr.co.gudi.reserve.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.events.Event;

import kr.co.gudi.reserve.dto.ReserveDTO;
import kr.co.gudi.reserve.service.ReserveService;


@Controller
public class ReserveController {
		Logger logger = LoggerFactory.getLogger(getClass());
		@Autowired ReserveService service;
		
		@RequestMapping(value="/reserve")
		public String reserve(Model model) {
			return "reserve/reserve";
		}
		
		@ResponseBody
		@RequestMapping(value="/events",method =RequestMethod.GET )
		public List<ReserveDTO> getEvent(Model model){
			List<ReserveDTO> animal = service.animal();
			model.addAttribute("animal",animal);
			logger.info("동물정보 :"+animal);
			return animal;
		}


}

