package kr.co.gudi.reserve.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.w3c.dom.events.Event;

import kr.co.gudi.reserve.dto.ReserveDTO;

public interface ReserveDAO {


	/* List<Event> getAllEvents(); */

	List<Calendar> getCalendar();

	List<ReserveDTO> animal();

	

}
