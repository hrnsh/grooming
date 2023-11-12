package kr.co.gudi.board.service;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gudi.board.dao.BoardDAO;
import kr.co.gudi.board.dto.BoardDTO;
import kr.co.gudi.board.dto.adminBoardDTO;
import kr.co.gudi.photo.dto.photoDTO;

@Service
public class BoardService {
	@Autowired BoardDAO dao;
	
	
	private String root = "C:/upload/";
	
	Logger logger = LoggerFactory.getLogger(getClass());

	/*
	 * public ArrayList<BoardDTO> boardList(String filter) {
	 * 
	 * 
	 * logger.info("필터값 : "+filter); logger.info("서비스 단 : "+dao.boardList(filter));
	 * return dao.boardList(filter);
	 * 
	 * }
	 */
/*
	public ArrayList<BoardDTO> dboardList() {
		// TODO Auto-generated method stub
		logger.info("서비스 단 : "+dao.dboardList());
		return dao.dboardList();
	}

	public ArrayList<BoardDTO> filterboardList() {
		// TODO Auto-generated method stub
		return null;
	}
*/

	public Map<String, Object> searchList(String searchtag, String searchindex ,String pagePerNum,String page) {

		logger.info("서비스 검색 : "+searchindex+searchtag);
		logger.info("pageper 와 page : "+pagePerNum+page);
		// pagePerNum 과 page 를 가지고 offset 을 계산해 내자
		int offset = 0;
		int p =Integer.parseInt(page);
		offset = (int) (Integer.parseInt(pagePerNum)*(p-1));
		ArrayList<BoardDTO> list = dao.searchList(searchtag,searchindex, Integer.parseInt(pagePerNum),offset);
		
		//만들수 있는 총 페이지수
		int max = dao.searchmaxpage(Integer.parseInt(pagePerNum),searchtag,searchindex);
		logger.info("만들 수 있는 총 페이지수 : "+max);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 만약 현재 보고있는 페이지가, 총 페이지수 보다 크면 현재페이지를 총 페이지수로 변경한다.
		if(p>max) {
			
			p = max;
		}
		
		map.put("currPage", p);
		
		map.put("pages", max+1);
		logger.info("list : "+list);
		map.put("list", list);		
		return map;
	}



	public Map<String, Object> boardList(String filter, String searchtag, String searchindex, String pagePerNum, String page) {
		// pagePerNum 과 page 를 가지고 offset 을 계산해 내자
		logger.info("searchtag 와 searchindex : "+searchtag+" / "+searchindex);
		if(Integer.parseInt(filter)==10) {
			return searchList(searchtag, searchindex ,pagePerNum,page);
		}else {
		int offset = 0;
		int p =Integer.parseInt(page);
		offset = (int) (Integer.parseInt(pagePerNum)*(p-1));
		ArrayList<BoardDTO> list = dao.boardList(filter, Integer.parseInt(pagePerNum),offset);
		
		//만들수 있는 총 페이지수
		logger.info("filter : "+Integer.parseInt(pagePerNum));
		logger.info("pagePerNum : "+Integer.parseInt(filter));
		int max = dao.maxpage(Integer.parseInt(pagePerNum),filter);
		logger.info("만들 수 있는 총 페이지수 : "+max);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 만약 현재 보고있는 페이지가, 총 페이지수 보다 크면 현재페이지를 총 페이지수로 변경한다.
		if(p>max) {
			
			p = max;
		}
		
		map.put("currPage", p);
		
		map.put("pages", max+1);
		logger.info("list : "+list);
		map.put("list", list);
		
		
		
		return map;
		}//분기
	}



	public void boardDetail(String b_num, Model model) {

		
		hit(b_num);
		BoardDTO bbs = dao.boardDetail(b_num);
		ArrayList<photoDTO> photos = dao.getPhoto(b_num);
		
		logger.info("bbs : "+bbs);
		logger.info("photos : "+photos);
		
		
		model.addAttribute("list",bbs);
		model.addAttribute("photos", photos);
		
	}



	private void hit(String b_num) {
		
		dao.hit(b_num);
		
	}



	public String boarduse(String b_num) {
		// TODO Auto-generated method stub
		return dao.boarduse(b_num);
	}



	public void boardDelete(int bnum) {
		dao.boardDelete(bnum);
		
	}






	public String boardWrite(Map<String, String> params, MultipartFile[] photos, String user_id, String admin) {
		// bbs 테이블에 insert 한 글의 idx(auto_increment) 값을 가져오기
		//조건 1. 파라메터는 DTO 형태로 넣어야 한다.
		String page = "redirect:/boardMain";
		if(admin!=null) {
		adminBoardDTO dto = new adminBoardDTO();
		dto.setAdb_subject(params.get("subject"));
		dto.setAd_id(params.get("user_id"));
		dto.setAdb_content(params.get("editorTxt"));
		dto.setAd_id(user_id);
		logger.info("admin 글저장 : "+admin);
		
		logger.info("admin 디티오 : "+dto);
		dao.adminwriteBoard(dto);
		// 생성된 pk 가져오기
		// photo 테이블에도 insert
		int idx = dto.getB_num();
		logger.info("idx : "+idx);
		
		logger.info("dto.getB_num()의 값 : "+dto.getB_num());
		if (idx>0) {
			try {
				saveFile(idx, photos,admin);
				page = "redirect:/boardMain";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		}else {
		BoardDTO dto = new BoardDTO();
		dto.setB_subject(params.get("subject"));
		dto.setUser_id(params.get("user_id"));
		dto.setB_content(params.get("editorTxt"));
		dto.setUser_id(user_id);
		dao.writeBoard(dto);
		// 생성된 pk 가져오기
		// photo 테이블에도 insert
		int idx = dto.getB_num();
		logger.info("idx : "+idx);
		
		logger.info("dto.getB_num()의 값 : "+dto.getB_num());
		if (idx>0) {
			try {
				saveFile(idx, photos,admin);
				page = "redirect:/boardMain";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
				if(admin=="admin") {
					
					logger.info("admin 사진저장 : "+admin);
					dao.adminboardwritePhoto(idx,oriFileName,newFileName);
				}else {
					logger.info("admin 사진저장 ");
				dao.boardwritePhoto(idx,oriFileName,newFileName);
				}
				
			}
		}
		
		
		
		

		
	}



	public BoardDTO re(String bnum) {
		// TODO Auto-generated method stub
		logger.info("re 값 : " + dao.re(bnum));
		return dao.re(bnum);
	}



	 public String boardUpdate(Map<String, String> params, MultipartFile[] photos, String bnum, String uid) {

			// bbs 테이블에 insert 한 글의 idx(auto_increment) 값을 가져오기
			//조건 1. 파라메터는 DTO 형태로 넣어야 한다.
			String page = "redirect:/boardMain";
			
			
	
			BoardDTO dto = new BoardDTO();
			dto.setB_subject(params.get("subject"));
			dto.setUser_id(uid);
			dto.setB_num(Integer.parseInt(bnum));
			dto.setB_content(params.get("editorTxt"));
			logger.info(bnum);
			dto.setB_num(Integer.parseInt(bnum));
			logger.info("dto값" + dto.getB_subject());
			logger.info("dto값" + dto.getUser_id());
			logger.info("dto값" + dto.getB_content());
			logger.info("dto값" + dto.getUser_id());
			logger.info("dto값" + dto.getB_num());
			dao.boardUpdate(dto);
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




	public void adboardDelete(int bnum) {

		dao.adboardDelete(bnum);
		
	}



	public boolean boardReport(String bnum, String con, String user_id) {


		dao.boardReport(bnum,con,user_id);
		
		return true;
	}







}
