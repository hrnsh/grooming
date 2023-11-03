package kr.co.gudi.reserve.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.events.Event;

import kr.co.gudi.reserve.dao.ReserveDAO;
import kr.co.gudi.reserve.dto.ReserveDTO;

@Service
public class ReserveService {
	@Autowired ReserveDAO dao;



	/*
	 * public List<Event> getAllEvents() { return dao.getAllEvents(); }
	 */



	public List<Calendar> getCalendar() {
		return dao.getCalendar();
	}



	public ArrayList<ReserveDTO> animal() {
		return dao.animail();
	}
	

	
}
