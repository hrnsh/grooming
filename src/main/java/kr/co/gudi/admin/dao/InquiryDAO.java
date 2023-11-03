package kr.co.gudi.admin.dao;

import java.util.ArrayList;

import kr.co.gudi.admin.dto.InquiryDTO;

public interface InquiryDAO {

	ArrayList<InquiryDTO> sentList(int offset);

	int totalPage();

	ArrayList<InquiryDTO> receiveList(int offset);
	

}
