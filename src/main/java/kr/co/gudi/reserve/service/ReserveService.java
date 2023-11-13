package kr.co.gudi.reserve.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.reserve.dao.ReserveDAO;
import kr.co.gudi.reserve.dto.ReserveDTO;


@Service
public class ReserveService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReserveDAO dao;
	public ArrayList<ReserveDTO> cnt() {
		
		return dao.cnt();
	}
	public List<ReserveDTO> myAni() {
		
		return dao.myAni();
	}
	public HashMap<String, Object> lat() {
		return dao.lat();
	}
	public double calDis(double latitude, double longitude, double comLat, double comLon) {
		double EARTH_RADIUS = 6371; // 지구 반지름 (단위: km)
		// 라디안으로 변환
        double radLat1 = Math.toRadians(latitude);
        double radLon1 = Math.toRadians(longitude);
        double radLat2 = Math.toRadians(comLat);
        double radLon2 = Math.toRadians(comLon);

        // 위도 차이, 경도 차이 계산
        double deltaLat = radLat2 - radLat1;
        double deltaLon = radLon2 - radLon1;

        // Haversine 공식 적용
        double a = Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2)
                + Math.cos(radLat1) * Math.cos(radLat2) * Math.sin(deltaLon / 2) * Math.sin(deltaLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distance = EARTH_RADIUS * c; // 거리 (단위: km)

        return distance;
    }
	public String tPrice() {
		return dao.tPrice();
	}
	public String tAmPrice() {
		
		return dao.tAmPrice();
	}
	public String tPmPrice() {
		
		return dao.tPmPrice();
	}
	public String p3Price() {

		return dao.p3Price();
	}
	public String p5Price() {
		
		return dao.p5Price();
	}
	public String p10Price() {
		
		return dao.p10Price();
	}
	public ArrayList<ReserveDTO> revInfo(String com_id) {

		return dao.revInfo(com_id);
	}

	public ArrayList<ReserveDTO> findReceiver(int r_num) {
		
		return dao.findReceiver(r_num);
	}
	public void writeNote(HashMap<String, Object> params) {
		dao.writeNote(params);	
	}

				

}