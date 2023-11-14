package kr.co.gudi.location.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.location.dto.LocationDTO;
import kr.co.gudi.location.service.LocationService;
import kr.co.gudi.review.dto.ReviewDTO;

@Controller
public class LocationController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
    private LocationService locationService;

    @RequestMapping(value =  "/locationSearch")
    public String locationSearch() {
        return "locationSearch";
    }
    
    @RequestMapping(value = "/getNearbyCompanies", method = RequestMethod.POST)
    @ResponseBody
    public List<LocationDTO> getNearbyCompanies(
    		@RequestParam HashMap<String, Double> params) {
        return locationService.getNearbyCompanies(params);
    }
    
    @RequestMapping(value = "/searchCompany", method = RequestMethod.POST)
    @ResponseBody
    public List<LocationDTO> searchCompany(@RequestParam String keyword) {
    	return locationService.searchCompany(keyword);
    }
    
    @RequestMapping(value = "/getCompanyDetail", method = RequestMethod.POST)
    @ResponseBody
    public List<LocationDTO> getCompanyDetail(@RequestParam String companyName) {
    	List<LocationDTO> companyDetail = locationService.getCompanyDetail(companyName);
    	logger.info(companyName);
    	logger.info("업체 정보 : {}", companyDetail);
    	
    	return companyDetail;
    }
    
    /*
    @RequestMapping(value = "/getTicketPrice", method = RequestMethod.POST)
    @ResponseBody
    public List<LocationDTO> getTicketPrice(@RequestParam String companyName) {
    	return locationService.getTicketPrice(companyName);
    }
    */
    
    @RequestMapping(value = "/getReviews", method = RequestMethod.POST)
    @ResponseBody
    public List<ReviewDTO> getReviews(@RequestParam String companyName){
    	List<ReviewDTO> reviews = locationService.getReviews(companyName);
    	
    	logger.info("업체 이름: "+companyName);
    	logger.info("리뷰 리스트: "+ reviews);
    	return reviews;
    }
    
    @RequestMapping(value = "/locationNote")
    public String locationNote(@RequestParam String companyName,
    		Model model) {
    	model.addAttribute("companyName", companyName);
    	return "locationNote";
    }
    
    @RequestMapping(value="/sendNoteToCom", method=RequestMethod.POST)
    public String sendNoteToCom(@RequestParam String subject, @RequestParam String content, 
			@RequestParam String receiver, HttpSession session) {
    	logger.info("제목: "+subject+", 내용: "+content+", 수신자: "+receiver);
    	String sender = (String) session.getAttribute("loginId");
    	
    	locationService.sendNoteToCom(subject, content, receiver, sender);
    	return "redirect:/locationSearch";
    }
    
    @RequestMapping(value = "/AverageReviews", method = RequestMethod.POST)
    @ResponseBody
    public List<ReviewDTO> AverageReviews(@RequestParam String companyName) {
    	logger.info("업체 이름: "+companyName);
    	List<ReviewDTO> reviewList = locationService.AverageReviews(companyName);
    	
    	logger.info("reviewList: "+reviewList);
    	return reviewList;
    }
}
