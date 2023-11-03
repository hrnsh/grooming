package kr.co.gudi.location.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.location.dao.LocationDAO;
import kr.co.gudi.location.dto.LocationDTO;

@Service
public class LocationService{
	@Autowired
    private LocationDAO locationDao;
	
    public String processLocation(double lat, double lon) {
        
        List<LocationDTO> nearbyLocations = locationDao.getNearbyLocations(lat, lon);
        // 결과를 가공하여 문자열로 반환
        String result = processResult(nearbyLocations);
        
        return result;
    }
	
    private String processResult(List<LocationDTO> locations) {
		StringBuilder result = new StringBuilder();
		
		for (LocationDTO location : locations) {
			String com_name = location.getCom_name();
			int avg_star = location.getAvg_star();
			int user_total = location.getUser_total();
			
			result.append(com_name)
				.append("\n")
				.append(avg_star)
				.append("\n")
				.append("누적 이용자 수: ")
				.append(user_total);
		}
		return result.toString();
	}

}
