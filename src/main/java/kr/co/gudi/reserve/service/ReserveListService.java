package kr.co.gudi.reserve.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.reserve.dao.ReserveDAO;
import kr.co.gudi.reserve.dao.ReserveListDAO;
import kr.co.gudi.reserve.dto.ReserveDTO;

@Service
public class ReserveListService {
	
	@Autowired ReserveListDAO dao;
	public ArrayList<ReserveDTO> reserveList() {
		
		return dao.reserveList();
	}
	public int checkId(String loginId) {

		return dao.checkId(loginId);
	}

}
