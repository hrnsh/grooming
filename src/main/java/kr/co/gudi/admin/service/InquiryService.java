package kr.co.gudi.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.admin.dao.InquiryDAO;
import kr.co.gudi.admin.dto.InquiryDTO;
import kr.co.gudi.board.dto.BoardDTO;

@Service
public class InquiryService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired InquiryDAO inquiryDao;
	
	public Map<String, Object> sentList(String page) {
		// parameter 값은 String으로 받아와서 int로 변환한다.
		int p = Integer.parseInt(page);
		// offset 구하기 
		int offset = (p-1) * 5;
			
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<InquiryDTO> list = inquiryDao.sentList(offset);
		map.put("list", list);
		// 만들 수 있는 총 페이지 수 / 페이지 당 게시글 수
		// select COUNT(idx)/ppn from bbs;
		int pages = inquiryDao.totalPage();
		logger.info("만들 수 있는 총 페이지 수 : " +pages);
		map.put("pages", pages);
		// 만약 현재 보고있는 페이지가 총 페이지 수보다 크면 현재 페이지를 총 페이지 수로 변경한다.
		if(p>pages) {
			p=pages;
		}
		map.put("currPage", p);
		
		return map;
	}

	public Map<String, Object> receiveList(String page) {
		// parameter 값은 String으로 받아와서 int로 변환한다.
		int p = Integer.parseInt(page);
		// offset 구하기
		int offset = (p - 1) * 5;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<InquiryDTO> list = inquiryDao.receiveList(offset);
		map.put("list", list);
		// 만들 수 있는 총 페이지 수 / 페이지 당 게시글 수
		// select COUNT(idx)/ppn from bbs;
		int pages = inquiryDao.totalPage();
		logger.info("만들 수 있는 총 페이지 수 : " + pages);
		map.put("pages", pages);
		// 만약 현재 보고있는 페이지가 총 페이지 수보다 크면 현재 페이지를 총 페이지 수로 변경한다.
		if (p > pages) {
			p = pages;
		}
		map.put("currPage", p);

		return map;
	}
}
