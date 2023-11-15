package kr.co.gudi.reserve.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.gudi.reserve.dto.ReserveDTO;

public interface ReserveListDAO {

	int checkId(String loginId);

	
	

	ArrayList<ReserveDTO> reserveComList(String loginId, int offset);



	ArrayList<ReserveDTO> all(String loginId, String stateFilter, String page);


	ArrayList<ReserveDTO> state(String loginId, String stateFilter, int offset);



	ArrayList<ReserveDTO> detail(String loginId, int idx);



	void change(int r_num, String selState);



	void saveReview(HashMap<String, Object> params);



	ArrayList<ReserveDTO> rivDetail(int idx);



	void revCancel(int r_num);



	void saveRevCancel(int r_num, String loginId, String c_reason);



	ArrayList<ReserveDTO> cancelReason(int idx);



	void saveReply(int rev_num, String rrep_content);



	ArrayList<ReserveDTO> replyDetail(int idx);




	ArrayList<ReserveDTO> reserveList(String loginId, int offset);




	int totalPage();




	ArrayList<ReserveDTO> all(String loginId, String stateFilter, int offset);




	ArrayList<ReserveDTO> section(String loginId, String formattedDate1, String formattedDate2, int offset);




	String findAni(String loginId, String ani);



	void saveReserve(HashMap<String, Object> params);




	String chkDetail(String loginId, int idx);




	void plus(String loginId);




	int auto(String loginId);




	void reviewDel(int rev_num);




	void rrepDel(int rrep_num);




	void saveStar(HashMap<String, Object> params);




	ArrayList<ReserveDTO> userAll(String loginId, String stateFilter, int offset);




	ArrayList<ReserveDTO> userState(String loginId, String stateFilter, int offset);






}
