package kr.co.gudi.location.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.location.dao.LocationDAO;
import kr.co.gudi.location.dto.LocationDTO;
import kr.co.gudi.review.dto.ReviewDTO;

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

	public List<ReviewDTO> getReviews(String companyName) {
		return locationDao.getReviews(companyName);
	}

	public void sendNoteToCom(String subject, String content, String receiver, String sender) {
		locationDao.sendNoteToCom(subject, content, receiver, sender);
	}
}
