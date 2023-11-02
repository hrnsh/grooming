package kr.co.gudi.location.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.gudi.location.dao.LocationDAO;
import kr.co.gudi.location.dto.LocationDTO;

public class LocationServiceImpl implements LocationService {
	@Autowired
    private LocationDAO locationDao;

    @Override
    public List<LocationDTO> getNearbyPlaces(double lat, double lng) {
    	
    	
        return locationDao.getNearbyPlaces(lat, lng);
    }
}
