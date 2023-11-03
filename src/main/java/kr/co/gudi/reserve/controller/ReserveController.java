package kr.co.gudi.reserve.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.reserve.dto.ReserveDTO;
import kr.co.gudi.reserve.service.ReserveService;


@Controller
public class ReserveController {
		Logger logger = LoggerFactory.getLogger(getClass());
		@Autowired ReserveService service;
		
		@RequestMapping(value="/reserve")
		public String reserve(Model model) {
			ArrayList<ReserveDTO> animal =service.aniName();
			logger.info("동물이름:"+animal);
			model.addAttribute("animal",animal);
			
			return "reserve/reserve";
		}
		
		
		@RequestMapping(value="/events",method = RequestMethod.GET)
		public String events() {
			int amCnt =service.amCnt();
			logger.info("오전 이용자 수 :"+amCnt);
			int pmCnt =service.pmCnt();
			logger.info("오후 이용자 수 :"+pmCnt);
			int apmCnt=service.apmCnt();
			logger.info("종일 이용자 수 :"+apmCnt);
			
			return null;
		}		
}

