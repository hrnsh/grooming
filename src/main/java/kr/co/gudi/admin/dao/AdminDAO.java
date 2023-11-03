package kr.co.gudi.admin.dao;

import java.util.ArrayList;

import kr.co.gudi.admin.dto.AdminDTO;

public interface AdminDAO {

	AdminDTO adminProfile(String ad_id);

	ArrayList<AdminDTO> adminlist();

}
