package kr.co.gudi.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import kr.co.gudi.board.dto.BoardDTO;
import kr.co.gudi.board.dto.adminBoardDTO;
import kr.co.gudi.photo.dto.photoDTO;

public interface BoardDAO {
	/*
	 * ArrayList<BoardDTO> boardList(String filter);
	 */
	ArrayList<BoardDTO> searchList(String searchtag, String searchindex, int pagePerNum, int offset);

	ArrayList<BoardDTO> boardList(String filter, int offset, int pagePerNum);

	int maxpage(int pagePerNum, String filter);

	BoardDTO boardDetail(String b_num);

	String boarduse(String b_num);

	void boardDelete(int bnum);

	void hit(String b_num);

	int searchmaxpage(int parseInt, String searchtag, String searchindex);

	
	void writeBoard(BoardDTO dto);
	void adminwriteBoard(adminBoardDTO dto);

	void boardwritePhoto(int idx, String oriFileName, String newFileName);

	ArrayList<photoDTO> getPhoto(String b_num);

	BoardDTO re(String bnum);

	void boardUpdate(BoardDTO dto);

	void adminboardwritePhoto(int idx, String oriFileName, String newFileName);

	void adboardDelete(int bnum);

	void boardReport(String bnum, String con, String user_id);









	//ArrayList<BoardDTO> dboardList();


}
