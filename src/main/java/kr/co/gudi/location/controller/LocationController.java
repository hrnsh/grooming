package kr.co.gudi.location.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.location.dto.LocationDTO;
import kr.co.gudi.location.service.LocationService;

@Controller
public class LocationController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
    private LocationService locationService;

    @RequestMapping("/locationSearch")
    public String locationSearch(Model model) {
        return "locationSearch";
    }

    @RequestMapping("/getNearbyPlaces")
    @ResponseBody
    public List<LocationDTO> getNearbyPlaces(@RequestParam double lat, @RequestParam double lng) {
        return locationService.getNearbyPlaces(lat, lng);
    }
    
    @RequestMapping("/getUserLocation")
    @ResponseBody
    public 
	
}
