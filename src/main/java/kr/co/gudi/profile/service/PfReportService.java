package kr.co.gudi.profile.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.admin.dto.ReportDTO;
import kr.co.gudi.profile.dao.PfReportDAO;

@Service
public class PfReportService {
	@Autowired PfReportDAO pfReportDAO;

	public Map<String, Object> pfReportListCall(String page, String stateOption, String typeOption, String user_id) {
		int p = Integer.parseInt(page);
		int offset = (p - 1) * 10;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ReportDTO> list = new ArrayList<ReportDTO>();
		
		list = pfReportDAO.reportListCall(offset, user_id);
		
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
				list = pfReportDAO.reportListCall(offset, user_id);
			}else {
				list = pfReportDAO.typeListCall(offset, tpOption, user_id);
			}
		}else {
			list = pfReportDAO.optionListCall(offset, stOption, user_id);	
		}
		
		map.put("list", list);
		int pages = pfReportDAO.totalPage();
		map.put("pages", pages);
		if (p > pages) {
			p = pages;
		}
		map.put("currPage", p);
		
		return map;
	}


	public ReportDTO reportDetail(String report_num, String user_id) {
		return pfReportDAO.reportDetail(report_num, user_id);
	}
}
