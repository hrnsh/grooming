package kr.co.gudi.profile.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.admin.dao.InquiryDAO;
import kr.co.gudi.admin.dto.InquiryDTO;
import kr.co.gudi.profile.dao.NoteDAO;
import kr.co.gudi.profile.dto.NoteDTO;

@Service
public class NoteService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired NoteDAO noteDao;
	
	public Map<String, Object> sentList(String page, String loginId, String readOptionSent) {
		// parameter 값은 String으로 받아와서 int로 변환한다.
		int p = Integer.parseInt(page);
		// offset 구하기 
		int offset = (p-1) * 5;
			
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<NoteDTO> list = new ArrayList<NoteDTO>();
		
		if(readOptionSent.equals("all")){
			list = noteDao.sentList(offset, loginId);
		}else if (readOptionSent.equals("read")) {
			list = noteDao.sentListRead(offset, loginId);
		} else if (readOptionSent.equals("unread")) {
			list = noteDao.sentListUnread(offset, loginId);
		}
		
		
		map.put("list", list);
		// 만들 수 있는 총 페이지 수 / 페이지 당 게시글 수
		// select COUNT(idx)/ppn from bbs;
		int pages = noteDao.totalPage();
		//logger.info("만들 수 있는 총 페이지 수 : " +pages);
		map.put("pages", pages);
		// 만약 현재 보고있는 페이지가 총 페이지 수보다 크면 현재 페이지를 총 페이지 수로 변경한다.
		if(p>pages) {
			p=pages;
		}
		map.put("currPage", p);
		
		return map;
	}

	public Map<String, Object> receiveList(String page, String loginId, String readOptionReceive) {
		// parameter 값은 String으로 받아와서 int로 변환한다.
		int p = Integer.parseInt(page);
		// offset 구하기
		int offset = (p - 1) * 5;

		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<NoteDTO> list = new ArrayList<NoteDTO>();
		if(readOptionReceive.equals("all")) {
			list = noteDao.receiveList(offset, loginId);
		}else if(readOptionReceive.equals("read")) {
			list = noteDao.receiveListRead(offset,loginId);
		}else if(readOptionReceive.equals("unread")) {
			list = noteDao.receiveListUnread(offset,loginId);
		}
		map.put("list", list);
		// 만들 수 있는 총 페이지 수 / 페이지 당 게시글 수
		// select COUNT(idx)/ppn from bbs;
		int pages = noteDao.totalPage();
		//logger.info("만들 수 있는 총 페이지 수 : " + pages);
		map.put("pages", pages);
		// 만약 현재 보고있는 페이지가 총 페이지 수보다 크면 현재 페이지를 총 페이지 수로 변경한다.
		if (p > pages) {
			p = pages;
		}
		map.put("currPage", p);

		return map;
	}

	public NoteDTO callDetail(String idx) {
		return noteDao.callDetail(idx);
	}

	public NoteDTO receiveDetail(String idx) {
		updateState(idx);
		return noteDao.callDetail(idx);
	}
	
	private void updateState(String idx) {
		noteDao.updateState(idx);
	}

	public void sendNote(String subject, String content, String receiver, String sender) {
		noteDao.sendNote(subject,content,receiver, sender);
	}

	public int delSent(ArrayList<String> delList) {
		int cnt = 0;
		for(String idx : delList) {
			cnt+=noteDao.delSent(idx);
			logger.info("sent_hidden update 성공: "+cnt);
		}
		return cnt;
	}

	public int delReceive(ArrayList<String> delList) {
		int cnt = 0;
		for(String idx : delList) {
			cnt+=noteDao.delReceive(idx);
			logger.info("sent_hidden update 성공: "+cnt);
		}
		return cnt;
	}

	public void delNoteSend(String idx) {
		noteDao.delSent(idx);
	}

	public void delNoteReceive(String idx) {
		noteDao.delReceive(idx);
	}

	public Map<String, Object> dateFilter(String selectedDate, String page, String loginId) {
		// parameter 값은 String으로 받아와서 int로 변환한다.
				int p = Integer.parseInt(page);
				// offset 구하기
				int offset = (p - 1) * 5;

				Map<String, Object> map = new HashMap<String, Object>();
				ArrayList<NoteDTO> list = noteDao.dateFilter(loginId,selectedDate,offset);
				
				map.put("list", list);
				// 만들 수 있는 총 페이지 수 / 페이지 당 게시글 수
				// select COUNT(idx)/ppn from bbs;
				int pages = noteDao.totalPage();
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
