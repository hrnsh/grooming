package kr.co.gudi.location.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.location.dto.LocationDTO;
import kr.co.gudi.location.service.LocationService;

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
            @RequestParam double lat,
            @RequestParam double lon) {
        List<LocationDTO> nearbyCompanies = locationService.getNearbyCompanies(lat, lon);
        return nearbyCompanies;
    }

}
