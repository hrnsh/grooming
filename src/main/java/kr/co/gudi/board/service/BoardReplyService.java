package kr.co.gudi.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.board.dao.BoardReplyDAO;
import kr.co.gudi.board.dto.BoardDTO;
import kr.co.gudi.board.dto.BoardReplyDTO;

@Service
public class BoardReplyService {
	@Autowired BoardReplyDAO dao;
	
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public void boardReply(String bnum, String id, String reply) {

		dao.boardReply(bnum,id,reply);
		
	}



	public Map<String, Object> boardReplyList(String bnum, String pagePerNum, String page) {
		int offset = 0;
		int p =Integer.parseInt(page);
		offset = (int) (Integer.parseInt(pagePerNum)*(p-1));
		ArrayList<BoardReplyDTO> list = dao.boardrlist(Integer.parseInt(bnum),Integer.parseInt(pagePerNum),offset);
		
		//만들수 있는 총 페이지수
		logger.info("pagePerNum : "+Integer.parseInt(pagePerNum));
		logger.info("bnum : "+Integer.parseInt(bnum));
		int max = dao.rmaxpage(Integer.parseInt(pagePerNum),bnum);
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
		
		logger.info("댓글 완료값 : "+map);
		
		return map;
	}



	public void delre(String list_num) {
		dao.delre(list_num);
		
	}



	public void boardReplyModify(String list_num) {
		dao.repmodify(list_num);
		
	}



	public String getreid(String list_num) {

		return dao.getreid(list_num);
		
	}

}
