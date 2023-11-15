package kr.co.gudi.reserve.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.admin.dto.ManageDTO;
import kr.co.gudi.reserve.dao.ReserveDAO;
import kr.co.gudi.reserve.dao.ReserveListDAO;
import kr.co.gudi.reserve.dto.ReserveDTO;


@Service
public class ReserveListService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReserveListDAO dao;
	public int checkId(String loginId) {
		int checkId=dao.checkId(loginId);
		logger.info("로그인ID :"+checkId);
		return checkId;
	}

	public HashMap<String, Object> reserveComList(String loginId, String page) {
		int p = Integer.parseInt(page);		

		int offset = (p-1)*10;		
		ArrayList<ReserveDTO> list = new ArrayList<ReserveDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		list =dao.reserveComList(loginId,offset);
		map.put("revComList",list);
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



	public HashMap<String, Object> all(String loginId, String stateFilter,String page, int checkId) {
		int p = Integer.parseInt(page);		

		int offset = (p-1)*10;		
		ArrayList<ReserveDTO> list = new ArrayList<ReserveDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(checkId==0) {		
				list = dao.userAll(loginId,stateFilter,offset);
				map.put("revComList",list);
			}else {
				list = dao.all(loginId,stateFilter,offset);
				map.put("revComList",list);	
			}
			
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

	public HashMap<String, Object> state(String loginId, String stateFilter,String page, int checkId) {
		int p = Integer.parseInt(page);		

		int offset = (p-1)*10;		
		ArrayList<ReserveDTO> list = new ArrayList<ReserveDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(checkId==0) {		
			list = dao.userState(loginId,stateFilter,offset);
			map.put("revComList",list);
		}else {
			list = dao.state(loginId,stateFilter,offset);
			map.put("revComList",list);
		}
		logger.info("상태리스트 :"+list);
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


	public ArrayList<ReserveDTO> detail(String loginId, int idx) {
		String chk=dao.chkDetail(loginId,idx);
		logger.info("픽업여부: "+chk);
		ArrayList<ReserveDTO>dto=new ArrayList<ReserveDTO>();
		dto=dao.detail(loginId,idx);
		return dto;
	}

	public void change(int r_num, String selState, String loginId) {
		if(selState.equals("이용완료")) {
			dao.change(r_num,selState);
			dao.plus(loginId);
		}else {
		dao.change(r_num,selState);
		}
	}

	public void saveReview(HashMap<String, Object> params) {
		dao.saveReview(params);
		dao.saveStar(params);
	
	}

	public ArrayList<ReserveDTO> rivDetail(int idx) {
	
		return dao.rivDetail(idx);
	}

	public void revCancel(int r_num) {
		dao.revCancel(r_num);
		
	}

	public void saveRevCancel(int r_num, String loginId, String c_reason) {
		dao.saveRevCancel(r_num,loginId,c_reason);
		
	}

	public ArrayList<ReserveDTO> cancelReason(int idx) {
		
		return dao.cancelReason(idx);
	}

	public void saveReply(int rev_num, String rrep_content) {
		dao.saveReply(rev_num,rrep_content);
		
	}

	public ArrayList<ReserveDTO> replyDetail(int idx) {
		
		return dao.replyDetail(idx);
	}

	public HashMap<String, Object> reserveList(String loginId, String page) {
		
		int p = Integer.parseInt(page);		

		int offset = (p-1)*10;		
		ArrayList<ReserveDTO> list = new ArrayList<ReserveDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		list = dao.reserveList(loginId,offset);
			
		map.put("revComList",list);
		
		int pages = dao.totalPage();
		logger.info("페이징수:"+pages);
		//logger.info("만들 수 있는 총 페이지 수 : " +pages);
		map.put("pages", pages);
		// 만약 현재 보고있는 페이지가 총 페이지 수보다 크면 현재 페이지를 총 페이지 수로 변경한다.
		if(p>pages) {
			p=pages;
		}
		map.put("currPage", p);
		return map;
	}

	public HashMap<String, Object> section(String loginId, String formattedDate1, String formattedDate2, String page) {
		int p = Integer.parseInt(page);	
		int offset = (p-1)*10;		
		ArrayList<ReserveDTO> list = new ArrayList<ReserveDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		list = dao.section(loginId,formattedDate1,formattedDate2,offset);
		logger.info("시작: "+formattedDate1);
		logger.info("끝: "+formattedDate2);
		map.put("revComList",list);
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

	public String findAni(String loginId, String ani) {
		
		return dao.findAni(loginId,ani);
	}

	public void saveReserve(HashMap<String, Object> params) {
		dao.saveReserve(params);
		
	}

	public int auto(String loginId) {
		
		return dao.auto(loginId);
	}

	public void reviewDel(int rev_num) {
		dao.reviewDel(rev_num);
		
	}

	public void rrepDel(int rrep_num) {
		dao.rrepDel(rrep_num);
		
	}






}
