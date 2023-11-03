package kr.co.gudi.profile.dao;

import java.util.ArrayList;

import kr.co.gudi.profile.dto.ProfileDTO;

public interface ProfileDAO {

	ProfileDTO profile(String user_id);

	ArrayList<ProfileDTO> list(String user_id);

}
