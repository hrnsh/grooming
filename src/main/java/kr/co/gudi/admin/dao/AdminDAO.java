package kr.co.gudi.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.gudi.admin.dto.AdminDTO;

public interface AdminDAO {

	AdminDTO adminProfile(String ad_id);

	ArrayList<AdminDTO> adminlist();

	String logingo(String ad_id, String ad_pw);
	
	int adminprofileupdate(HashMap<String, String> params);

	AdminDTO adpfdetail(String ad_id);

}
