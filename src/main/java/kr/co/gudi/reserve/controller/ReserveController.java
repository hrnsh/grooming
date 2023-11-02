package kr.co.gudi.reserve.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ReserveController {

		@RequestMapping(value="/reserve")
		public String reserve() {
			return "reserve/reserve";
		}
		
		

}

