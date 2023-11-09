package kr.co.gudi.location.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.location.dao.LocationDAO;
import kr.co.gudi.location.dto.LocationDTO;

@Service
public class LocationService{
	@Autowired
    private LocationDAO locationDao;

	public List<LocationDTO> getNearbyCompanies(HashMap<String, Double> params) {
		return locationDao.getNearbyCompanies(params);
	}

	public List<LocationDTO> searchCompany(String keyword) {
		return locationDao.searchCompany("%" + keyword + "%");
	}

	public List<LocationDTO> getCompanyDetail(String companyName) {
		return locationDao.getCompanyDetail(companyName);
	}

	public List<LocationDTO> getTicketPrice(String companyName) {
		return locationDao.getTicketPrice(companyName);
	}
}
