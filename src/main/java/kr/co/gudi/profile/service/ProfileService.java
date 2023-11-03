package kr.co.gudi.profile.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.gudi.profile.dao.ProfileDAO;
import kr.co.gudi.profile.dto.ProfileDTO;

@Service
public class ProfileService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired ProfileDAO dao;

	public ProfileDTO profile(String user_id) {
		return dao.profile(user_id);
	}

	public ArrayList<ProfileDTO> list(String user_id) {
		return dao.list(user_id);
	}

}
