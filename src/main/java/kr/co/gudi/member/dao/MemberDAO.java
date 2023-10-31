package kr.co.gudi.member.dao;

import java.util.HashMap;

public interface MemberDAO {

	String login(String id, String pw);

	int join(HashMap<String, String> params);

}
