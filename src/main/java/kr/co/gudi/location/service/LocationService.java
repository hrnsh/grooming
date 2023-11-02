/**
 * 
 */
package kr.co.gudi.location.service;

import java.util.List;

import kr.co.gudi.location.dto.LocationDTO;

public interface LocationService {

	List<LocationDTO> getNearbyPlaces(double lat, double lng);

}
