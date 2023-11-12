package kr.co.gudi.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.admin.dao.AdminDAO;
import kr.co.gudi.admin.dto.AdminDTO;

@Service
public class AdminService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminDAO dao;

	public AdminDTO adminProfile(String ad_id) {
		return dao.adminProfile(ad_id);
	}

	public ArrayList<AdminDTO> adminlist() {
		return dao.adminlist();
	}

	public boolean logingo(String ad_id, String ad_pw) {
		boolean success = false;
		String log=dao.logingo(ad_id,ad_pw);
		if(log!=null) {
			success=true;
		}
		return success;
	}
	
	public int adminprofileupdate(HashMap<String, String> params) {
		return dao.adminprofileupdate(params);
	}
}

