package kr.co.gudi.admin.dao;

import java.util.ArrayList;

import kr.co.gudi.admin.dto.ReportDTO;

public interface ReportDAO {

	int totalPage();

	ArrayList<ReportDTO> reportListCall(int offset);

}
