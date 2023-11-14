package kr.co.gudi.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.gudi.admin.dao.ReportDAO;
import kr.co.gudi.admin.dto.InquiryDTO;
import kr.co.gudi.admin.dto.ReportDTO;

@Service
public class ReportService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReportDAO reportDao;
	
	public Map<String, Object> reportListCall(String ad_id, String page, String stateOption, String typeOption) {
		int p = Integer.parseInt(page);
		int offset = (p - 1) * 10;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ReportDTO> list = new ArrayList<ReportDTO>();
		
		list = reportDao.reportListCall(offset);
		
		int stOption = 0;
		if(stateOption.equals("complete")) {
			stOption=2;
		}else if(stateOption.equals("inProcess")) {
			stOption=1;
		}
		
		int tpOption = 0;
		if(typeOption.equals("review")){
			tpOption=1;
		}else if(typeOption.equals("comment")){
			tpOption=2;
		}else if(typeOption.equals("reserve")){
			tpOption=3;
		}
		
		if(stateOption.equals("all")) {
			if(typeOption.equals("all")) {
				list = reportDao.reportListCall(offset);
			}else {
				list = reportDao.typeListCall(offset, tpOption);
			}
		}else {
			list = reportDao.optionListCall(offset, stOption);				
		}
		
		
		
		map.put("list", list);
		int pages = reportDao.totalPage();
		map.put("pages", pages);
		if (p > pages) {
			p = pages;
		}
		map.put("currPage", p);
		return map;
	}

	public void reportDetail(String report_num, String ad_id, Model model) {
		// 상세보기 데이터 조회
		ReportDTO reportDetail = reportDao.reportDetail(report_num);
		
		// '처리중' 상태 업데이트
		int state = reportDetail.getReport_state();
		if(state==0) {
			reportDao.updateState(report_num);
		}
		
		// 히스토리 테이블에 데이터 저장
		reportDao.insertHistory(report_num,ad_id);
		
		reportDetail =  reportDao.reportDetail(report_num);
		model.addAttribute("reportDetail", reportDetail);
	}

	public ReportDTO callDetail(String report_num) {
		return reportDao.reportDetail(report_num);
	}

	public void repAnswerSend(String content, String report_num) {
		// 히스토리 테이블 업데이트 - 내용, 날짜 추가 
		reportDao.updateRepHistory(content, report_num);
		
		// 신고 답장 쪽지로 보내기
		reportDao.sendNote(content, report_num);
		
		// 신고 리스트 상태 '2' 로 업데이트 
		reportDao.updateRepState(report_num);
		
		logger.info("신고 문의 답장 성공!");
	}

	public Map<String, Object> reportDatePickSend(String selectedDate, String page) {
		// parameter 값은 String으로 받아와서 int로 변환한다.
		int p = Integer.parseInt(page);
		// offset 구하기
		int offset = (p - 1) * 5;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ReportDTO> list = reportDao.reportDatePickSend(selectedDate,offset);
		
		map.put("list", list);
		// 만들 수 있는 총 페이지 수 / 페이지 당 게시글 수
		// select COUNT(idx)/ppn from bbs;
		int pages = reportDao.totalPage();
		//logger.info("만들 수 있는 총 페이지 수 : " + pages);
		map.put("pages", pages);
		// 만약 현재 보고있는 페이지가 총 페이지 수보다 크면 현재 페이지를 총 페이지 수로 변경한다.
		if (p > pages) {
			p = pages;
		}
		map.put("currPage", p);
		logger.info("list : "+ list);
		return map;
	}

	public Map<String, Object> reportDatePickHandle(String selectedDate, String page) {
		// parameter 값은 String으로 받아와서 int로 변환한다.
		int p = Integer.parseInt(page);
		// offset 구하기
		int offset = (p - 1) * 5;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ReportDTO> list = reportDao.reportDatePickHandle(selectedDate,offset);
		
		map.put("list", list);
		// 만들 수 있는 총 페이지 수 / 페이지 당 게시글 수
		// select COUNT(idx)/ppn from bbs;
		int pages = reportDao.totalPage();
		//logger.info("만들 수 있는 총 페이지 수 : " + pages);
		map.put("pages", pages);
		// 만약 현재 보고있는 페이지가 총 페이지 수보다 크면 현재 페이지를 총 페이지 수로 변경한다.
		if (p > pages) {
			p = pages;
		}
		map.put("currPage", p);
		logger.info("list : "+ list);
		return map;
	}
}
