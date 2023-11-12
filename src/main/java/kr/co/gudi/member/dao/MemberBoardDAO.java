package kr.co.gudi.member.dao;

import java.util.ArrayList;

import kr.co.gudi.member.dto.MemberBoardDTO;

public interface MemberBoardDAO {

	ArrayList<MemberBoardDTO> memyBoardList(String loginId, int offset);

	ArrayList<MemberBoardDTO> mebdatefilter(String loginId, String date, int offset);

	int mebmaxpage(String loginId);

	int mebDelList(int b_num);


}
