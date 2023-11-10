package kr.co.gudi.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.admin.dao.ManageDAO;
import kr.co.gudi.admin.dto.ManageDTO;

@Service
public class ManageService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ManageDAO dao;
	public HashMap<String, Object> adList(String user_state, String page) {
		int p = Integer.parseInt(page);		

		int offset = (p-1)*10;		
		ArrayList<ManageDTO> list = new ArrayList<ManageDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(user_state.equals("전체")) {
			list =dao.adList(offset);
		}else {
			list = dao.adStateList(user_state,offset);
		}		
		map.put("list",list);
		
		int pages = dao.totalPage();
		//logger.info("만들 수 있는 총 페이지 수 : " +pages);
		map.put("pages", pages);
		// 만약 현재 보고있는 페이지가 총 페이지 수보다 크면 현재 페이지를 총 페이지 수로 변경한다.
		if(p>pages) {
			p=pages;
		}
		map.put("currPage", p);
		return map;
	}
	public ArrayList<ManageDTO> manageDetail(String user_id) {
	
		return dao.manageDetail(user_id);
	}
	public void saveManage(HashMap<String, Object> params) {
		dao.saveManage(params);
		
		
	}

}
