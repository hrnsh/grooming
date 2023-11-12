package kr.co.gudi.reserve.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.gudi.reserve.dto.ReserveDTO;

public interface ReserveListDAO {

	int checkId(String loginId);

	
	

	ArrayList<ReserveDTO> reserveComList(String loginId);



	ArrayList<ReserveDTO> section(String formattedDate1, String formattedDate2);


	ArrayList<ReserveDTO> all(String loginId, String stateFilter);


	ArrayList<ReserveDTO> state(String loginId, String stateFilter);



	ArrayList<ReserveDTO> detail(String loginId, int idx);



	void change(int r_num, String selState);



	void saveReview(HashMap<String, Object> params);



	ArrayList<ReserveDTO> rivDetail(int idx);



	void revCancel(int r_num);



	void saveRevCancel(int r_num, String loginId, String c_reason);



	ArrayList<ReserveDTO> cancelReason(int idx);



	void saveReply(int rev_num, String rrep_content);



	ArrayList<ReserveDTO> replyDetail(int idx);




	ArrayList<ReserveDTO> reserveList(String loginId);






}
