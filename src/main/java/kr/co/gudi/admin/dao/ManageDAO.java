package kr.co.gudi.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.gudi.admin.dto.ManageDTO;

public interface ManageDAO {

	ArrayList<ManageDTO> adList(int offset);

	int totalPage();

	ArrayList<ManageDTO> adStateList(String user_state, int offset);

	ArrayList<ManageDTO> manageDetail(String user_id);

	void saveManage(HashMap<String, Object> params);

}
