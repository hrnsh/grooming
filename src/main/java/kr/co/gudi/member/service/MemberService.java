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

	public boolean overlay(String id) {
		
		boolean use = false;
		int cnt = dao.overlay(id);
		if(cnt==0) {
			use = true;
		}
		return use;
	}

	public int join(HashMap<String, String> params) {
		int row = 0;
		row = dao.join(params);
		if(row>0 && params.get("id")!=null) {
			row = dao.join(params);
		}
		return row;
	}


	public String logingo(String id, String pw) {
		boolean success = false;
		return dao.logingo(id,pw);
	}

	public Object dofindID(String id, String email) {
		boolean success = false;
		return dao.dofindId(id,email);
	}





	
}
