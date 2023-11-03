package kr.co.gudi.main.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.main.dao.MainDAO;
import kr.co.gudi.main.dto.MainDTO;

@Service
public class MainService {
	
	@Autowired MainDAO dao;

	public ArrayList<MainDTO> rank() {
		return dao.rank();
	}
	
}
