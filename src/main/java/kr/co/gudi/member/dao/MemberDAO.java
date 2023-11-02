package kr.co.gudi.member.dao;

import java.util.HashMap;

public interface MemberDAO {

	int overlay(String id);

	int join(HashMap<String, String> params);

	HashMap<String, Object> login(HashMap<String, String> params);

	String logingo(String id, String pw);

	Object dofindId(String id, String email);
;
}
