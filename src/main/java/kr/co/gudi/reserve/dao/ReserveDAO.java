package kr.co.gudi.reserve.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.gudi.reserve.dto.ReserveDTO;

public interface ReserveDAO {

	int amCnt();

	int pmCnt();

	int apmCnt();

	ArrayList<ReserveDTO> aniName();

	

}
