package kr.co.gudi.reserve.controller;


import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.metadata.PostgresCallMetaDataProvider;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.gudi.reserve.dto.ReserveDTO;
import kr.co.gudi.reserve.service.ReserveService;

@Controller
public class ReserveController {
		Logger logger = LoggerFactory.getLogger(getClass());
		@Autowired ReserveService service;

		@RequestMapping(value="/reserve")

		public String reserve() {
			return "reserve/reserve";
		}

		public ModelAndView home() {
	        ModelAndView modelAndView = new ModelAndView("reserve/reserve"); // JSP 페이지 이름 지정
	       	
	        List<ReserveDTO> dtoList =service.myAni();
	        List<String> aNameList = new ArrayList<>();
	        for (ReserveDTO dto : dtoList) {
	            aNameList.add(dto.getA_name());
	        }
	        
	        modelAndView.addObject("aNameList", aNameList);
	        logger.info("동물 이름: "+aNameList);
	        return modelAndView;
	    }
		
		@RequestMapping(value="/revDis",method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> revDis(@RequestBody HashMap<String, Double> requestData){
			HashMap<String, Object> revInfo = new HashMap<>();
			double latitude = requestData.get("latitude");
			double longitude = requestData.get("longitude");
			logger.info("받아온 위도: " + latitude + ", 경도: " + longitude);
			revInfo =service.lat();
			logger.info("업체경도:"+revInfo);

			Object latObject = revInfo.get("lat");
			Object lonObject = revInfo.get("lon");
			double comLat=0;
			double comLon=0;
			
			if (latObject instanceof BigDecimal) {
			    comLat = ((BigDecimal) latObject).doubleValue();
			    logger.info("업체 위도: " + comLat);
			}
			if (lonObject instanceof BigDecimal) {
			    comLon = ((BigDecimal) lonObject).doubleValue();
			    logger.info("업체 경도: " + comLon);
			}
			double distance=service.calDis(latitude, longitude,comLat,comLon);	
			logger.info("두 지점 간의 거리: " + distance + " km");
			revInfo.put("distance", distance);
			if(distance<3) {
				int pick = Integer.parseInt(service.p3Price());
				revInfo.put("pick", pick);
			}
			if(distance<5) {
				int pick = Integer.parseInt(service.p5Price());
				revInfo.put("pick", pick);
			}
			if(distance<10) {
				int pick = Integer.parseInt(service.p10Price());
				revInfo.put("pick", pick);
			}
			
			return revInfo;
		}
		
		@RequestMapping(value="/tPrice",method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> tPrice(@RequestBody HashMap<String, String> requestData){
			HashMap<String, Object> tPrice = new HashMap<>();
			String button = requestData.get("buttonValue");
			logger.info("이용권 종류:"+button);
			if(button.equals("종일권")) {
				int ticket= Integer.parseInt(service.tPrice());
				logger.info("티켓가격:"+ticket);
				tPrice.put("ticket", ticket);
			}
			if(button.equals("오전권")) {
				int ticket= Integer.parseInt(service.tAmPrice());
				logger.info("티켓가격:"+ticket);
				tPrice.put("ticket", ticket);
			}
			if(button.equals("오후권")) {
				int ticket= Integer.parseInt(service.tPmPrice());
				logger.info("티켓가격:"+ticket);
				tPrice.put("ticket", ticket);
			}
			return tPrice;
		}
		
		@RequestMapping(value="/selPrice",method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> selPrice(@RequestParam String date1,
				@RequestParam String date2,@RequestParam String time1,
				@RequestParam String time2){
			HashMap<String, Object> selPrice = new HashMap<>();
			logger.info("시작일"+date1);
			logger.info("시작시간"+time1);
			logger.info("종료일"+date2);
			logger.info("시작시간"+time2);
			
			if(time1.equals("amOption")&&time2.equals("amOption")) {
				int timeTicket= Integer.parseInt(service.tAmPrice());
				selPrice.put("timeTicket", timeTicket);
			}
			if(time1.equals("amOption")&&time2.equals("pmOption")) {
				int timeTicket= Integer.parseInt(service.tAmPrice())+
						Integer.parseInt(service.tPmPrice());	
				selPrice.put("timeTicket", timeTicket);
			}
			if(time1.equals("pmOption")&&time2.equals("pmOption")){
				int timeTicket= Integer.parseInt(service.tPmPrice());
				selPrice.put("timeTicket", timeTicket);
			}
			String startDateString = date1;
	        String endDateString = date2;
	        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy"); // 날짜 형식 지정
			
	        try {
	            Date startDate = sdf.parse(startDateString);
	            Date endDate = sdf.parse(endDateString);

	            // 날짜 간 차이 계산 (일 단위)
	            long timeDifference = endDate.getTime() - startDate.getTime();
	            long dayDifference = timeDifference / (1000 * 60 * 60 * 24);
	         
	            logger.info("일 차이 :"+dayDifference);
	            int dayTicket= (int) (Integer.parseInt(service.tPrice())*dayDifference);
	            selPrice.put("dayTicket", dayTicket);
	        } catch (ParseException e) {
	            // 날짜 파싱 실패 시 예외 처리
	            e.printStackTrace();
	            selPrice.put("error", "날짜 파싱 오류");
	        }
			return selPrice;
		}
		
		@RequestMapping(value="/findRev",method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> findRev(){
			String com_id="abcd002";
			ArrayList<ReserveDTO> revInfo = service.revInfo(com_id)	;	
			HashMap<String, Object> findRev = new HashMap<String, Object>();
		    findRev.put("findRev", revInfo);
			
			logger.info("findRev"+revInfo);
			return findRev;
		}
		
		@RequestMapping(value="/writeNote")
		public String writeNote() {
			return "/reserve/writeNote";
		}
		
		@RequestMapping(value="/sendNote")
		public String sendNote(@RequestParam String r_num, @RequestParam String subject, 
				@RequestParam String content, HttpSession session) {
			String user_id = (String) session.getAttribute("loginId");
			service.writeNote(r_num,subject, content, user_id);
			return "redirect:/reserveDetail";
		}
	}

