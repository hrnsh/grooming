package kr.co.gudi.profile.dao;

import java.util.ArrayList;

import kr.co.gudi.admin.dto.ReportDTO;

public interface PfReportDAO {

	ArrayList<ReportDTO> reportListCall(int offset, String user_id);

	int totalPage();

	ArrayList<ReportDTO> typeListCall(int offset, int tpOption, String user_id);

	ArrayList<ReportDTO> optionListCall(int offset, int stOption, String user_id);

	ReportDTO reportDetail(String report_num, String user_id);

}
