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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.reserve.dto.ReserveDTO;
import kr.co.gudi.reserve.service.ReserveService;

@Controller
public class ReserveController {
		Logger logger = LoggerFactory.getLogger(getClass());
		@Autowired ReserveService service;
		
		String com_id="";
		@RequestMapping(value="/reserve")
		public String reserve(@RequestParam String companyName
				,Model model,HttpSession session) {
			String user_id=(String) session.getAttribute("loginId");
			List<ReserveDTO> dtoList=service.myAni(user_id);
			List<String> aNameList = new ArrayList<>(); 
			List<String> aKindList = new ArrayList<>(); 
			for(ReserveDTO dto : dtoList) {
				aNameList.add(dto.getA_name());
				}
			for(ReserveDTO dto : dtoList) {
				aKindList.add(dto.getA_kind());
			}
			model.addAttribute("aKindList",aKindList);
			logger.info("동물종류: "+aKindList);
			model.addAttribute("aNameList",aNameList);
			logger.info("동물정보: "+aNameList);
			logger.info("업체명: "+companyName);
			com_id=service.findCom_id(companyName);
			logger.info("업체명과같은 id: "+com_id);
			String findPick=service.findPick(com_id);
			model.addAttribute("findPick",findPick);
			model.addAttribute("com_id",com_id);
			model.addAttribute("companyName",companyName);
			return "reserve/reserve";
		}


		
		@RequestMapping(value="/revDis",method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> revDis(@RequestBody HashMap<String, Double> requestData){
			HashMap<String, Object> revInfo = new HashMap<>();
			double latitude = requestData.get("latitude");
			double longitude = requestData.get("longitude");
			logger.info("받아온 위도: " + latitude + ", 경도: " + longitude);
			revInfo =service.lat(com_id);
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
		
		/*
		 * @RequestMapping(value="/tPrice",method = RequestMethod.POST)
		 * 
		 * @ResponseBody public HashMap<String, Object> tPrice(@RequestBody
		 * HashMap<String, String> requestData){ HashMap<String, Object> tPrice = new
		 * HashMap<>(); String button = requestData.get("buttonValue");
		 * logger.info("이용권 종류:"+button); if(button.equals("종일권")) { int ticket=
		 * Integer.parseInt(service.tPrice()); logger.info("티켓가격:"+ticket);
		 * tPrice.put("ticket", ticket); } if(button.equals("오전권")) { int ticket=
		 * Integer.parseInt(service.tAmPrice()); logger.info("티켓가격:"+ticket);
		 * tPrice.put("ticket", ticket); } if(button.equals("오후권")) { int ticket=
		 * Integer.parseInt(service.tPmPrice()); logger.info("티켓가격:"+ticket);
		 * tPrice.put("ticket", ticket); } return tPrice; }
		 */
		
		@RequestMapping(value="/selPrice",method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> selPrice(@RequestParam String date1,
				@RequestParam String date2){
			HashMap<String, Object> selPrice = new HashMap<>();
			logger.info("시작일"+date1);
			logger.info("종료일"+date2);
			
			/*
			 * if(time1.equals("amOption")&&time2.equals("amOption")) { int timeTicket=
			 * Integer.parseInt(service.tAmPrice()); selPrice.put("timeTicket", timeTicket);
			 * } if(time1.equals("amOption")&&time2.equals("pmOption")) { int timeTicket=
			 * Integer.parseInt(service.tAmPrice())+ Integer.parseInt(service.tPmPrice());
			 * selPrice.put("timeTicket", timeTicket); }
			 * if(time1.equals("pmOption")&&time2.equals("pmOption")){ int timeTicket=
			 * Integer.parseInt(service.tPmPrice()); selPrice.put("timeTicket", timeTicket);
			 * }
			 */
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
	            int dayTicket= (int) (Integer.parseInt(service.tPrice(com_id))*(dayDifference+1));
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
			logger.info("어떤업체?: "+com_id);
			ArrayList<ReserveDTO> revInfo = service.revInfo(com_id)	;	
			HashMap<String, Object> findRev = new HashMap<String, Object>();
		    int findAcc = service.findAcc(com_id);
		    logger.info("수용가능수: "+findAcc);
			findRev.put("findRev", revInfo);
			findRev.put("findAcc", findAcc);
			logger.info("findRev"+revInfo);
			return findRev;
		}

		@RequestMapping(value="/writeNote")
		public String writeNote(@RequestParam String r_num,Model model) {
			logger.info("r_num: "+r_num);
			// 보낸사람 받는사람 찾기
			int r_num1=Integer.parseInt(r_num);
			ArrayList<ReserveDTO> findReceiver=service.findReceiver(r_num1);
			model.addAttribute("rev",findReceiver);
			logger.info("못가져왔나?:"+findReceiver);
			return "/reserve/writeNote";
		}
		
		@RequestMapping(value="/revNote")
		public String revNote(@RequestParam HashMap<String, Object> params
				, HttpSession session) {
			String user_id = (String) session.getAttribute("loginId");
			logger.info("들어왔니?");
			params.put("sender", user_id);
			logger.info("받아온 데이터: "+params);
			service.writeNote(params);
 
			return "reserve/reserveList";
		}
	}

