package kr.co.gudi.admin.dao;

import java.util.ArrayList;

import kr.co.gudi.admin.dto.InquiryDTO;
import kr.co.gudi.admin.dto.photoDTO;

public interface InquiryDAO {

	void saveInquiry(InquiryDTO dto);

	void savePhoto(String code, int num, String oriFileName, String newFileName);

	ArrayList<InquiryDTO> inquiryListCall(int offset);

	int totalPage();

	int updateState(String inq_num);
	
	InquiryDTO newIqDetail(String inq_num);
	
	photoDTO getPhoto(String inq_num, String inq_code);

	void insertIqHistory(String inq_num, String ad_id);

	void updateIqHis(String subject, String content, String inq_num);

	void sendNote(String subject, String content, String inq_num);

	void updateInqState(String inq_num);

	ArrayList<InquiryDTO> optionListCall(int offset, int stOption);



	
}
