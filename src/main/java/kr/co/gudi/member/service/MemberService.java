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

	public boolean overlayId(String user_id) {
		logger.info("user : "+user_id);
		boolean use = false;
		int cnt = dao.overlayId(user_id);
		logger.info("cnt"+cnt);
		if(cnt==0) {
			use = true;
		}
		return use;
	}

	public String join(HashMap<String, String> params) {
		String msg = "회원가입에 실패했습니다.";
		int row = dao.join(params);
		if(row>0) {
			msg = "회원가입에 성공했습니다.";
		}
		return msg;
	}


	public String logingo(String user_id, String pw) {
		boolean success = false;
		return dao.logingo(user_id,pw);
	}



	public boolean overlayEmail(String email) {
		logger.info("email : "+email);
		boolean use = false;
		int cnt = dao.overlayEmail(email);
		logger.info("cnt"+cnt);
		if(cnt==0) {
			use = true;
		}
		return use;
	}

	public String dofindID(String name, String email) {
		return dao.dofindID(name, email);
	}
	
	public String dofindPW(String name, String user_id, String email) {
		return dao.dofindPW(name, user_id, email);
	}





}
