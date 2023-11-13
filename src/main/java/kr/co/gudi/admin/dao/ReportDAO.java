package kr.co.gudi.admin.dao;

import java.util.ArrayList;

import kr.co.gudi.admin.dto.ReportDTO;

public interface ReportDAO {

	int totalPage();

	ArrayList<ReportDTO> reportListCall(int offset);

	ReportDTO reportDetail(String report_num);

	void updateState(String report_num);

	void insertHistory(String report_num, String ad_id);

	void updateRepHistory(String content, String report_num);

	void sendNote(String content, String report_num);

	void updateRepState(String report_num);

	ArrayList<ReportDTO> optionListCall(int offset, int stOption);

	ArrayList<ReportDTO> typeListCall(int offset, int tpOption);


}
