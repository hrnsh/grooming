package kr.co.gudi.location.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.gudi.location.dto.LocationDTO;
import kr.co.gudi.review.dto.ReviewDTO;

public interface LocationDAO{

	List<LocationDTO> getNearbyCompanies(HashMap<String, Double> params);

	List<LocationDTO> searchCompany(String keyword);

	List<LocationDTO> getCompanyDetail(String companyName);

	//List<LocationDTO> getTicketPrice(String companyName);

	List<ReviewDTO> getReviews(String companyName);

	void sendNoteToCom(String subject, String content, String receiver, String sender);
	
}
