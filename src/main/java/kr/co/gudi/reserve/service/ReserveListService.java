package kr.co.gudi.reserve.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public ArrayList<ReserveDTO> reserveComList(String loginId) {
		
		return dao.reserveComList(loginId);
	}

	public ArrayList<ReserveDTO> section(String formattedDate1, String formattedDate2) {
		
		return dao.section(formattedDate1,formattedDate2);
	}

	public ArrayList<ReserveDTO> all(String loginId, String stateFilter) {

		return dao.all(loginId,stateFilter);
	}

	public ArrayList<ReserveDTO> state(String loginId, String stateFilter) {

		return dao.state(loginId,stateFilter);
	}

	public ArrayList<ReserveDTO> detail(String loginId, int idx) {
		
		return dao.detail(loginId,idx);
	}

	public void change(int r_num, String selState) {
		dao.change(r_num,selState);
		
	}

	public void saveReview(HashMap<String, Object> params) {
		dao.saveReview(params);
		
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




}
