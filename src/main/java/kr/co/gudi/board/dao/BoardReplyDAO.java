package kr.co.gudi.board.dao;

import java.util.ArrayList;

import kr.co.gudi.board.dto.BoardReplyDTO;

public interface BoardReplyDAO {
	
	void boardReply(String bnum, String id, String reply);

	ArrayList<BoardReplyDTO> boardrlist(int bnum,int parseInt,  int offset);

	int rmaxpage(int parseInt, String bnum);

	void delre(String list_num);

	void repmodify(String list_num);

	String getreid(String list_num);

}
