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

	public List<LocationDTO> getNearbyCompanies(double lat, double lon) {
		return locationDao.getNearbyCompanies(lat, lon);
	}
	
    

}
