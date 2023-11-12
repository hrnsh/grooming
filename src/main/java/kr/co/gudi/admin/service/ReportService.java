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
	
	public Map<String, Object> reportListCall(String ad_id, String page, String stateOption, int typeOption) {
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
		
		if(stateOption.equals("all")) {
			if(typeOption>=0) {
				list = reportDao.typeListCall(offset, typeOption);
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
}
