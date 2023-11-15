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

	ArrayList<ManageDTO> adResultList(int offset);

	ArrayList<ManageDTO> adStateResultList(String m_type, int offset);

	ArrayList<ManageDTO> dateFilter(String selectedDate, int offset);

	ArrayList<ManageDTO> idFilter(String ad_id, String user_id, int offset);

	ArrayList<ManageDTO> resultDetail(int m_num);

	ArrayList<ManageDTO> adFilter(String ad_id, int offset);

	void updateMember(HashMap<String, Object> params);

	void upState(String user_id, ArrayList<ManageDTO> dto);

}
