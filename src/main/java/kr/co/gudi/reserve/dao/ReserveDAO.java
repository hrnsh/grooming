package kr.co.gudi.reserve.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.co.gudi.reserve.dto.ReserveDTO;

public interface ReserveDAO {

	
	ArrayList<ReserveDTO> cnt();

	List<ReserveDTO> myAni(String user_id);

	HashMap<String, Object> lat(String com_id);

	String tPrice();

	String tAmPrice();

	String tPmPrice();

	String p3Price();

	String p5Price();

	String p10Price();

	ArrayList<ReserveDTO> revInfo(String com_id);

	ArrayList<ReserveDTO> findReceiver(int r_num);

	void writeNote(HashMap<String, Object> params);

	String findCom_id(String companyName);


}


	


