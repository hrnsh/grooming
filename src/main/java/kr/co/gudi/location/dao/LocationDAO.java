package kr.co.gudi.location.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.co.gudi.location.dto.LocationDTO;

public interface LocationDAO{

	List<LocationDTO> getNearbyCompanies(HashMap<String, Double> params);

	List<LocationDTO> searchCompany(String keyword);

	List<LocationDTO> getCompanyDetail(String companyName);

	List<LocationDTO> getTicketPrice(String companyName);
	
}
