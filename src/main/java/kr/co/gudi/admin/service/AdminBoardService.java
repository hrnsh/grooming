package kr.co.gudi.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.gudi.admin.dao.AdminBoardDAO;
import kr.co.gudi.admin.dto.AdBoardDTO;
import kr.co.gudi.board.dto.BoardDTO;
import kr.co.gudi.photo.dto.photoDTO;

@Service
public class AdminBoardService {
	@Autowired AdminBoardDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	public Map<String, Object> admyBoardList(String page, String loginId, String date) {
		
		// pagePerNum 과 page 를 가지고 offset 을 계산해 내자

				int offset = 0;
				int p =Integer.parseInt(page);
				offset = 5*(p-1);
				ArrayList<AdBoardDTO> list = new ArrayList<AdBoardDTO>();
				logger.info("date : "+date);
				if(date.equals("0")) {
				list = dao.admyBoardList(loginId,offset);
				}else {
				list = dao.adbdatefilter(loginId,date,offset);
				}
				//만들수 있는 총 페이지수
				logger.info("filter : "+loginId);
				int max = dao.adbmaxpage(loginId);
				logger.info("만들 수 있는 총 페이지수 : "+max);
				
				Map<String, Object> map = new HashMap<String, Object>();
				
				// 만약 현재 보고있는 페이지가, 총 페이지수 보다 크면 현재페이지를 총 페이지수로 변경한다.
				if(p>max) {
					
					p = max;
				}
				
				map.put("currPage", p);
				
				map.put("pages", max/5+1);
				logger.info("list : "+list);
				map.put("list", list);
				

				
				
				return map;
				}//분기

	public void adbdata(String idx, Model model) {
		
		adbhit(idx);
		AdBoardDTO bbs = dao.adbdata(idx);
		
		logger.info("bbs date : "+bbs.getAdb_date());
		
		ArrayList<photoDTO> photos = dao.adbgetPhoto(idx);
		
		logger.info("bbs : "+bbs);
		logger.info("photos : "+photos);
		
		
		model.addAttribute("list",bbs);
		model.addAttribute("photos", photos);
	}
	
	public void adbhit(String idx) {
		
		
		dao.adbhit(idx);
		
		
	}



	public int relist(ArrayList<String> adbDelList) {
		// TODO Auto-generated method stub
		
		int cnt = 0;
		
		for(String b_num : adbDelList) {
			
			cnt += dao.adbDelList(Integer.parseInt(b_num));
			
		}
		
		
		return cnt;
	}


		
	public AdBoardDTO re(String bnum) {
		// TODO Auto-generated method stub
		logger.info("re 값 : " + dao.re(bnum));
		return dao.re(bnum);
	}



	public void boardUpdate(String subject, String editorTxt, String bnum) {
		dao.boardUpdate(subject,editorTxt,bnum);
		
	}

	public Map<String, Object> adboardList() {
		
		ArrayList<AdBoardDTO> result = dao.adboardList();
		
		Map<String, Object> list = new HashMap<String, Object>();
		
		list.put("list", result);
		
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	

}
