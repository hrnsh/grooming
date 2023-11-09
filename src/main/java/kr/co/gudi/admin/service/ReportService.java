package kr.co.gudi.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.admin.dao.ReportDAO;
import kr.co.gudi.admin.dto.InquiryDTO;
import kr.co.gudi.admin.dto.ReportDTO;

@Service
public class ReportService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReportDAO reportDao;
	
	public Map<String, Object> reportListCall(String ad_id, String page) {
		int p = Integer.parseInt(page);
		int offset = (p - 1) * 10;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ReportDTO> list = new ArrayList<ReportDTO>();
		
		list = reportDao.reportListCall(offset);
		
		map.put("list", list);
		int pages = reportDao.totalPage();
		map.put("pages", pages);
		if (p > pages) {
			p = pages;
		}
		map.put("currPage", p);
		return map;
	}
}
