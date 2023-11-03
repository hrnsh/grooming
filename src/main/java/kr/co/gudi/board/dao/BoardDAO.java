package kr.co.gudi.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import kr.co.gudi.board.dto.BoardDTO;

public interface BoardDAO {
	/*
	 * ArrayList<BoardDTO> boardList(String filter);
	 */
	ArrayList<BoardDTO> searchList(String searchtag, String searchindex, int pagePerNum, int offset);

	ArrayList<BoardDTO> boardList(String filter, int offset, int pagePerNum);

	int maxpage(int pagePerNum, int filter);

	HashMap<String, String> boardDetail(String b_num);

	String boarduse(String b_num);

	void boardDelete(int bnum);

	void hit(String b_num);

	int searchmaxpage(int parseInt, String searchtag, String searchindex);

	
	void writeBoard(BoardDTO dto);

	void writePhoto(int idx, String oriFileName, String newFileName);


	//ArrayList<BoardDTO> dboardList();


}
