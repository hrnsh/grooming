package kr.co.gudi.reserve.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.reserve.dao.ReserveDAO;
import kr.co.gudi.reserve.dto.ReserveDTO;

@Service
public class ReserveService {
	@Autowired ReserveDAO dao;

	public int amCnt() {
		
		return dao.amCnt();
	}

	public int pmCnt() {
		return dao.pmCnt();
	}

	public int apmCnt() {
		
		return dao.apmCnt();
	}

	public ArrayList<ReserveDTO> aniName() {
	
		return dao.aniName();
	}
	

	
}
