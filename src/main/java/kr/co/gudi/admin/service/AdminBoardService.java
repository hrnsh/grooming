package kr.co.gudi.admin.service;

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
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gudi.admin.dao.AdminBoardDAO;
import kr.co.gudi.admin.dto.AdBoardDTO;
import kr.co.gudi.board.dto.BoardDTO;
import kr.co.gudi.photo.dto.photoDTO;

@Service
public class AdminBoardService {
	@Autowired AdminBoardDAO dao;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private String root = "C:/upload/";

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



	 public String adboardUpdate(Map<String, String> params, MultipartFile[] photos, String bnum, String uid) {

			// bbs 테이블에 insert 한 글의 idx(auto_increment) 값을 가져오기
			//조건 1. 파라메터는 DTO 형태로 넣어야 한다.
			String page = "redirect:/boardMain";
			
			
	
			AdBoardDTO dto = new AdBoardDTO();
			dto.setAdb_subject(params.get("subject"));
			dto.setAd_id(uid);
			dto.setB_num(Integer.parseInt(bnum));
			dto.setAdb_content(params.get("editorTxt"));
			logger.info(bnum);
			dto.setB_num(Integer.parseInt(bnum));
			logger.info("dto값" + dto.getAdb_subject());
			logger.info("dto값" + dto.getAd_id());
			logger.info("dto값" + dto.getAdb_content());
			logger.info("dto값" + dto.getAd_id());
			logger.info("dto값" + dto.getB_num());
			dao.adboardUpdate(dto);
			// 생성된 pk 가져오기
			// photo 테이블에도 insert
			int idx = dto.getB_num();
			logger.info("idx : "+idx);
			
			logger.info("dto.getB_num()의 값 : "+dto.getB_num());
			if (idx>0) {
				try {
					saveFile(idx, photos,uid);
					page = "redirect:/boardMain";
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			


			
			return page;
	 
	 
	 
	 }
	
	
		private void saveFile(int idx, MultipartFile[] photos, String admin) throws Exception {
			
			
			for (MultipartFile photo : photos) {
				String oriFileName = photo.getOriginalFilename();
				logger.info("oriFileName : "+oriFileName);
				logger.info("oriFileName : "+idx+oriFileName);
				if (!oriFileName.equals("")) {
					
					// 1. 파일이름 변경
					String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
					String newFileName = System.currentTimeMillis()+ext;
					
					// 2. 파일 저장
					byte[] arr = photo.getBytes();
					Path path = Paths.get(root+newFileName);
					Files.write(path, arr);
					
					//3. 파일명, 변경된파일명, idx를 photo 테이블에 추가
					
						
						logger.info("admin 사진저장 : "+admin);
						dao.adminboardwritePhoto(idx,oriFileName,newFileName);
					
					
				}
			}
			
			
			
			

			
		}
	
	
	
	
	

	public Map<String, Object> adboardList() {
		
		ArrayList<AdBoardDTO> result = dao.adboardList();
		
		Map<String, Object> list = new HashMap<String, Object>();
		
		list.put("list", result);
		
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	

}
