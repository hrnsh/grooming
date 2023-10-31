package kr.co.gudi.member.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.member.dao.MemberDAO;

@Service
public class MemberService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberDAO dao;

	public String login(String id, String pw) {
		boolean success = false;
		return dao.login(id,pw);
	}

	public String join(HashMap<String, String> params) {
		String msg = "회원가입에 실패했습니다."; 
		int row = dao.join(params);
		if(row > 0) {
			msg = "회원가입에 성공했습니다.";
		}
		return msg;
	}

	

	
}
