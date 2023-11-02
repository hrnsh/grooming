package kr.co.gudi.location.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;

import kr.co.gudi.location.dto.LocationDTO;

public class LocationDAOImpl implements LocationDAO {

	// 데이터베이스 연결 정보
	private static final String URL = "jdbc:mariadb://localhost:3306/gdj70";
	private static final String USERNAME = "web_user";
    private static final String PASSWORD = "pass";
	
    @Override
    public List<LocationDTO> getNearbyPlaces(double lat, double lng) {
        List<LocationDTO> places = new ArrayList<>();
        
        try(Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD)){
        	String query = "SELECT * FROM company WHERE ";
        } catch{
        	
        }

        return places;
	}

}
