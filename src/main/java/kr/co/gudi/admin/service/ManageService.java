package kr.co.gudi.admin.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.admin.dao.ManageDAO;
import kr.co.gudi.admin.dto.ManageDTO;

@Service
public class ManageService {

	@Autowired ManageDAO dao;
	public ArrayList<ManageDTO> adList() {
		
		return dao.adList();
	}

}
