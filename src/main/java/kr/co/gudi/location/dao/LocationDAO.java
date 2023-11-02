package kr.co.gudi.location.dao;

import java.util.List;

import kr.co.gudi.location.dto.LocationDTO;

public interface LocationDAO {

	List<LocationDTO> getNearbyPlaces(double lat, double lng);

}
