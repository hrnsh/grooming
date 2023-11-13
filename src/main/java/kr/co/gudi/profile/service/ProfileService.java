package kr.co.gudi.profile.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gudi.admin.dao.AdminDAO;
import kr.co.gudi.profile.dao.ProfileDAO;
import kr.co.gudi.profile.dto.ProfileDTO;

@Service
public class ProfileService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired ProfileDAO dao;

	private String root = "/Users/amy/yurini/img/";
	
	public ProfileDTO profile(String user_id) {
		return dao.profile(user_id);
	}

	public ArrayList<ProfileDTO> list(String user_id) {
		return dao.list(user_id);
	}

	public int profileupdate(HashMap<String, String> params) {
		return dao.profileupdate(params);
	}

	public ArrayList<ProfileDTO> updatelist(String user_id) {
		return dao.updatelist(user_id);
	}

	public int animalprofiledelete(ArrayList<String> animaldeleteList) {
		int delete_count = 0;
		for(String a_num : animaldeleteList) {
			delete_count += dao.animalprofiledelete(a_num);
			}
		return delete_count;
	}

	public void animalregister(HashMap<String, String> params) {
		int row = dao.animalregister(params);
		logger.info("동물 등록 count : " + row);
	}

	public int comregister(HashMap<String, String> params) {
		int row = 0;
		
		row = dao.comregister(params);
		logger.info("업체 등록 count : " + row);
		
		if(row>0) {
			row = dao.userstateupdater(params.get("user_id"), "1");
		}
		return row;
	}

	public ProfileDTO userstatechecker(String user_id) {
		return dao.userstatechecker(user_id);
	}
	
	
//	public String comregister(Map<String, String> params, MultipartFile photos) {
//		// bbs 테이블에 insert한 글의 idx(auto_increment) 값을 가져오기
//		// 조건 1. 파라메터는 DTO 형태로 넣어야 한다
//		ProfileDTO dto = new ProfileDTO();
//		dto.setUser_id(params.get("user_id"));
//		dto.setCom_name(params.get("Com_name"));
//		dto.setCom_time(params.get("com_time"));
//		dto.setAccept(params.get("accept"));
//		dto.setPickup(params.get("pickup"));
//		dto.setAddress(params.get("address"));
//		dto.setAddress(params.get("address"));
//		dao.comregister(dto);
//		// 생성된 pk가져오기
//		int user_id = dto.getIdx();
//		logger.info("idx  = " + idx);
//		String page = "redirect:/list";
//
//		if (idx > 0) {
//			try {
//				saveFile(idx, photos);
//				page = "redirect:/detail?idx=" + idx;
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		return page;
//	}

	public ArrayList<ProfileDTO> comlist(String user_id) {
		return dao.comlist(user_id);
	}
	
	public int userstatedeleter(HashMap<String, String> params) {
		logger.info("회원 탈퇴 : " + params.get("user_id"));
		int row = dao.userstatedeleter(params.get("user_id"),"4");
		return row;
	}

	public int writepickupinfo(HashMap<String, String> params) {
		int row = 0;
		logger.info("픽업 정보 등록 : " + params);
		row = dao.writepickupinfo(params.get("com_num"),params.get("p_distance"),params.get("p_section"),params.get("p_price"));
		logger.info("픽업 정보 등록 2 : " + row);
		
		return row;
	}

	public ArrayList<ProfileDTO> pickuplist(String com_num) {
		return dao.pickuplist(com_num);
	}

	public int writeticketprice(HashMap<String, String> params) {
		int row = 0;
		logger.info("예약권 정보 입력 : " + params);
		row = dao.writeticketprice(params.get("com_num"),params.get("t_price"),params.get("t_type"));
		
		return row;
	}

	public int pickuppricedelete(ArrayList<String> pickuppricedeleteList) {
		int pickuppricedelete_count = 0;
		for(String p_num : pickuppricedeleteList) {
			pickuppricedelete_count += dao.pickuppricedelete(p_num);
		}
		return pickuppricedelete_count;
	}

	public ArrayList<ProfileDTO> ticketlist(String com_num) {
		return dao.ticketlist(com_num);
	}
	
	public int ticketpricedelete(ArrayList<String> ticketpricedeleteList) {
		int ticketpricedelete_count = 0;
		for(String t_num : ticketpricedeleteList) {
			ticketpricedelete_count += dao.ticketpricedelete(t_num);
		}
		return ticketpricedelete_count;
	}

	public void savecompic(MultipartFile photo, String loginId) throws Exception {
		ProfileDTO dto = new ProfileDTO();
		dto.setUser_id(loginId);
		ProfileDAO.savecompic(dto);
		
		int num = dto.getCom_num();
		String code = "COMPIC";
		
		if(num>0) {
			savePhoto(num,code,photo);
		}
	}
	
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
				ProfileDAO.savePhoto(code, num, oriFileName, newFileName);
				logger.info("사진 저장 성공!");
			}
	}
	
}
