package kr.co.gudi.admin.dao;

import java.util.ArrayList;

import kr.co.gudi.admin.dto.AdBoardDTO;
import kr.co.gudi.board.dto.BoardDTO;
import kr.co.gudi.photo.dto.photoDTO;

public interface AdminBoardDAO {

	ArrayList<AdBoardDTO> admyBoardList(String loginId, int offset);

	int adbmaxpage(String loginId);

	AdBoardDTO adbdata(String idx);

	void adbhit(String idx);

	String ch(String user_id);

	int adbDelList(int b_num);

	ArrayList<photoDTO> adbgetPhoto(String idx);

	ArrayList<AdBoardDTO> adbdatefilter(String loginId, String date, int offset);

	AdBoardDTO re(String bnum);

	void boardUpdate(String subject, String editorTxt, String bnum);

	ArrayList<AdBoardDTO> adboardList();

	

}
