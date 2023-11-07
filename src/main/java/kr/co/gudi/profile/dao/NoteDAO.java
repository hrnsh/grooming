package kr.co.gudi.profile.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import kr.co.gudi.profile.dto.NoteDTO;

public interface NoteDAO {
	
	int totalPage();

	int updateState(String idx);

	ArrayList<NoteDTO> receiveList(int offset, String loginId);

	ArrayList<NoteDTO> receiveListRead(int offset, String loginId);

	ArrayList<NoteDTO> receiveListUnread(int offset, String loginId);

	ArrayList<NoteDTO> sentList(int offset, String loginId);

	ArrayList<NoteDTO> sentListRead(int offset, String loginId);

	ArrayList<NoteDTO> sentListUnread(int offset, String loginId);
	
	NoteDTO callDetail(String idx);

	void sendNote(Map<String, String> params, String sender);

	void sendNote(String subject, String content, String receiver, String sender);

	int delSent(String idx);

	int delReceive(String idx);

}
