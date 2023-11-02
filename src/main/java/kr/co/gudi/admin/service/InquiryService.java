package kr.co.gudi.admin.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.admin.dao.InquiryDAO;
import kr.co.gudi.admin.dto.InquiryDTO;

@Service
public class InquiryService {

	@Autowired InquiryDAO inquiryDao;
	
	public ArrayList<InquiryDTO> list() {
		return inquiryDao.list();
	}
}
