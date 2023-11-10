package kr.co.gudi.profile.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.profile.dao.ProfileDAO;
import kr.co.gudi.profile.dto.ProfileDTO;

@Service
public class ProfileService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired ProfileDAO dao;

	public ProfileDTO profile(String user_id) {
		return dao.profile(user_id);
	}

	public ArrayList<ProfileDTO> list(String user_id) {
		return dao.list(user_id);
	}

	public int profileupdate(HashMap<String, String> params) {
		return dao.profileupdate(params);
	}

	public ArrayList<ProfileDTO> updatelist(String user_id) {
		return dao.updatelist(user_id);
	}

	public int animalprofiledelete(ArrayList<String> animaldeleteList) {
		int delete_count = 0;
		for(String a_num : animaldeleteList) {
			delete_count += dao.animalprofiledelete(a_num);
			}
		return delete_count;
	}

	public void animalregister(HashMap<String, String> params) {
		int row = dao.animalregister(params);
		logger.info("동물 등록 count : " + row);
	}

	public int comregister(HashMap<String, String> params) {
		int row = 0;
		
		row = dao.comregister(params);
		logger.info("업체 등록 count : " + row);
		
		if(row>0) {
			row = dao.userstateupdater(params.get("user_id"), "1");
		}
		return row;
	}

	public ProfileDTO userstatechecker(String user_id) {
		return dao.userstatechecker(user_id);
	}
	

	public ArrayList<ProfileDTO> comlist(String user_id) {
		return dao.comlist(user_id);
	}
	
	public int userstatedeleter(HashMap<String, String> params) {
		logger.info("회원 탈퇴 : " + params.get("user_id"));
		int row = dao.userstatedeleter(params.get("user_id"),"4");
		return row;
	}

	public int writepickupinfo(HashMap<String, String> params) {
		int row = 0;
		
		logger.info("픽업 정보 등록 : " + params);
		
		row = dao.writepickupinfo(params.get("com_num"),params.get("p_distance"),params.get("p_section"),params.get("p_price"));
		
		logger.info("픽업 정보 등록 2 : " + row);
		
		return row;
	}

	public ArrayList<ProfileDTO> pickuplist(String com_num) {
		return dao.pickuplist(com_num);
	}

	public int writeticketprice(ArrayList<String> ticketList) {
		int row = 0;
		for(String t_type : ticketList) {
			row += dao.writeticketprice(t_type);
		}
		return row;
	}
	

}
