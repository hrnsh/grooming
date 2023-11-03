package kr.co.gudi.member.dao;

import java.util.HashMap;

public interface MemberDAO {

	int overlayId(String user_id);

	int join(HashMap<String, String> params);

	HashMap<String, Object> login(HashMap<String, String> params);

	String logingo(String user_id, String pw);

	int overlayEmail(String email);

	String dofindID(String name, String email);

	String dofindPW(String name, String user_id, String email);


}
