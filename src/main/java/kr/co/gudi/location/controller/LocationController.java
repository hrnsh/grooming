package kr.co.gudi.location.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LocationController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/locationSearch")
	public String locationSearch() {
		return "locationSearch";
	}
}
