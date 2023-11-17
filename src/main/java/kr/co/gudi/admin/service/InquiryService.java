package kr.co.gudi.admin.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gudi.admin.dao.InquiryDAO;
import kr.co.gudi.admin.dto.InquiryDTO;
import kr.co.gudi.admin.dto.InquiryHistoryDTO;
import kr.co.gudi.admin.dto.photoDTO;
import kr.co.gudi.profile.dto.NoteDTO;

@Service
public class InquiryService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired InquiryDAO inquiryDao;
	
	private String root = "C:/upload/";
	
	// 일반 문의 보내기 & 테이블에 저장 
	public void saveInquiry(MultipartFile photo, String subject, 
			String content, String loginId) throws Exception {
		// dto 로 데이터 저장 후 inquiry 테이블에 insert 한다. f
		InquiryDTO dto = new InquiryDTO();
		dto.setInq_subject(subject);
		dto.setInq_content(content);
		dto.setUser_id(loginId);
		inquiryDao.saveInquiry(dto);
		
		// inquiry 테이블에서 방금 저장한 inq_num, inq_code 를 가져온다.
		// photo 테이블의 photo_n, photo_code에 insert 한다. 
		int num = dto.getInq_num();
		String code = "inq";
		//logger.info("num / code = " + num);
		
		 if(num>0) {
	         savePhoto(num, code, photo);
	      }
	}

	// 첨부된 사진 저장 
	private void savePhoto(int num, String code, MultipartFile photo) throws Exception {
		// 1. oriFileName 추출 (image.jpg)
			String oriFileName = photo.getOriginalFilename();
			//logger.info("oriFileName : "+oriFileName);
			if(!oriFileName.equals("")) {
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				// 2. 파일명 변경해서 newFileName로 저장 (1234567981234.jpg)
				String newFileName = System.currentTimeMillis() + ext; 
				//logger.info("newFileName : "+newFileName);
				// 3. 파일 저장
				// 3-1. 객체로 부터 바이트 추출
				byte[] arr = photo.getBytes();
				// 3-2. 저장할 경로와 파일명 지정
				Path path = Paths.get(root + newFileName);
				// 3-3. 파일 저장
				Files.write(path, arr);
				inquiryDao.savePhoto(code, num, oriFileName, newFileName);
				logger.info("사진 저장 성공!");
			}
	}

	// 일반 문의 리스트 호출 
	public Map<String, Object> inquiryListCall(String page, String ad_id, String stateOption, int option) {
		int p = Integer.parseInt(page);
		int offset = (p - 1) * 10;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<InquiryDTO> list = new ArrayList<InquiryDTO>();
		list = inquiryDao.inquiryListCall(offset);

		if(!stateOption.equals("all")) {
			int stOption = 0;
			if(stateOption.equals("complete")) {
				stOption=2;
			}else if(stateOption.equals("inProcess")) {
				stOption=1;
			}
			list = inquiryDao.optionListCall(offset, stOption);
		}else {
			list = inquiryDao.inquiryListCall(offset);
		}
		
		
		map.put("list", list);
		int pages = inquiryDao.totalPage();
		map.put("pages", pages);
		if (p > pages) {
			p = pages;
		}
		map.put("currPage", p);
		return map;
	}

	// 일반 신규 문의 상세보기 
	public void newIqDetail(String inq_num, String ad_id, Model model) {
		// 상세보기 데이터 조회 
		InquiryDTO newIqDetail = inquiryDao.newIqDetail(inq_num);	
		
		// '처리중' 상태 업데이트 
		int state = newIqDetail.getInq_state();
		if(state==0) {
			inquiryDao.updateState(inq_num); 
		}
		
		// 히스토리 테이블에 데이터 삽입 
		inquiryDao.insertIqHistory(inq_num,ad_id);
		
		// 사진 조회 
		String inq_code = newIqDetail.getInq_code();
		photoDTO photo = inquiryDao.getPhoto(inq_num, inq_code);
		if (photo != null) {
	        model.addAttribute("photo", photo);
	    }
		
		// 상태 '1' 로 업데이트 된 데이터 조회하기 
		newIqDetail = inquiryDao.newIqDetail(inq_num);	
		model.addAttribute("newIqDetail", newIqDetail);
	}

	
	public InquiryDTO callDetail(String inq_num) {
		return inquiryDao.newIqDetail(inq_num);
	}

	// 답장 보내기 기능 
	public void inqAnswerSend(String subject, String content, String inq_num) {
		inquiryDao.updateIqHis(subject, content, inq_num);
		logger.info("히스토리 업데이트 성공!");
		
		inquiryDao.sendNote(subject, content, inq_num);
		logger.info("문의 답장 쪽지로 보내기 성공!");
		
		inquiryDao.updateInqState(inq_num);
		logger.info("문의 리스트 상태 2로 업데이트 성공!");
	}

	public Map<String, Object> inquiryDatePickSend(String selectedDate, String page) {
		// parameter 값은 String으로 받아와서 int로 변환한다.
		int p = Integer.parseInt(page);
		// offset 구하기
		int offset = (p - 1) * 5;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<InquiryDTO> list = inquiryDao.inquiryDatePickSend(selectedDate,offset);
		
		map.put("list", list);
		// 만들 수 있는 총 페이지 수 / 페이지 당 게시글 수
		// select COUNT(idx)/ppn from bbs;
		int pages = inquiryDao.totalPage();
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

	public Map<String, Object> inquiryDatePickHandle(String selectedDate, String page) {
		// parameter 값은 String으로 받아와서 int로 변환한다.
		int p = Integer.parseInt(page);
		// offset 구하기
		int offset = (p - 1) * 5;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<InquiryDTO> list = inquiryDao.inquiryDatePickHandle(selectedDate,offset);
		
		map.put("list", list);
		// 만들 수 있는 총 페이지 수 / 페이지 당 게시글 수
		// select COUNT(idx)/ppn from bbs;
		int pages = inquiryDao.totalPage();
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
