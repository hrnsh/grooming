package kr.co.gudi.reserve.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.reserve.dto.ReserveDTO;
import kr.co.gudi.reserve.service.ReserveListService;


@Controller
public class ReserveListController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ReserveListService service;
	
	@RequestMapping(value="/revList")
	public String revList(HttpSession session) {
		String page ="";
		String loginId=(String) session.getAttribute("loginId");
		int checkId=service.checkId(loginId);
		logger.info("로그인ID :"+checkId);
	
		if(checkId==0) {			
			page = "reserve/reserveList";
		}else {
			page="reserve/reserveComList";
		}
		return page;
	}
	
	@RequestMapping(value="/booking")
	public String booking(Model model, HttpSession session
			,@RequestParam HashMap<String, Object> params){		
		String page ="";
		String loginId=(String) session.getAttribute("loginId");
		 //service.findAni();
		 SimpleDateFormat inputDateFormat = new SimpleDateFormat("MM/dd/yyyy");
	     SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	     String r_start="";
		 String r_end="";
	     try {
	            // MM/dd/yyyy 형식의 문자열을 Date 객체로 파싱
	           Date day1 = inputDateFormat.parse((String) params.get("startRe"));
	            Date day2 = inputDateFormat.parse((String) params.get("endRe"));
	            // yyyy/MM/dd 형식의 문자열로 변환
	            r_start = outputDateFormat.format(day1);
	            r_end = outputDateFormat.format(day2);	            
	        } catch (ParseException e) {
	            // 날짜 형식이 올바르지 않은 경우 처리
	            e.printStackTrace();            
	        }		
	     params.put("r_start", r_start);
	     params.put("r_end", r_end);
	     String ani = (String) params.get("ani");
	     String a_num=service.findAni(loginId,ani);
	     params.put("a_num", a_num);
	     params.put("user_id",loginId);
	     logger.info("예약정보데이터: "+params);
		int checkId=service.checkId(loginId);
		logger.info("로그인ID :"+checkId);
		service.saveReserve(params);
		if(checkId==0) {			
			page = "reserve/reserveList";
		}else {
			page="reserve/reserveComList";
		}
		
		return page;
	}
	
	@RequestMapping(value="/reserveList")
	@ResponseBody
	public HashMap<String, Object> reserveList(HttpSession session,@RequestParam String loginId
			,@RequestParam String page){
		HashMap<String, Object> reserveList=service.reserveList(loginId,page);
		logger.info("일반리스트: "+reserveList);
		return reserveList;
	}
	
	@RequestMapping(value="/reserveComList")
	@ResponseBody
	public HashMap<String, Object> reserveComList(HttpSession session,@RequestParam String loginId
			,@RequestParam String page){
		HashMap<String, Object> revComList=service.reserveComList(loginId,page);
		logger.info("페이지: "+page);
		return revComList;
	}
	
	@RequestMapping(value="/check", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> check(@RequestParam String date1,
			@RequestParam String date2,HttpSession session
			,@RequestParam String page){
		HashMap<String, Object> check = new HashMap<String, Object>();
		String loginId=(String) session.getAttribute("loginId");
		logger.info("여기부터 :"+date1);
		logger.info("여기까지 :"+date2);
		if(date1.equals("")&&date2.equals("")) {
			check = service.reserveComList(loginId,page);
			
		}else {
		 SimpleDateFormat inputDateFormat = new SimpleDateFormat("MM/dd/yyyy");
	     SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	     String formattedDate1="";   
	     String formattedDate2="";  
	     try {
	            // MM/dd/yyyy 형식의 문자열을 Date 객체로 파싱
	           Date day1 = inputDateFormat.parse(date1);
	            Date day2 = inputDateFormat.parse(date2);
	            // yyyy/MM/dd 형식의 문자열로 변환
	            formattedDate1 = outputDateFormat.format(day1);
	            formattedDate2 = outputDateFormat.format(day2);	            
	        } catch (ParseException e) {
	            // 날짜 형식이 올바르지 않은 경우 처리
	            e.printStackTrace();
	            
	        }			     
	     	logger.info("여기부터 :"+formattedDate1);
			logger.info("여기까지 :"+formattedDate2);
			check = service.section(loginId,formattedDate1,formattedDate2,page);
	
		}
			return check;
	}
	
			@RequestMapping(value="/state")
			@ResponseBody
			public HashMap<String, Object> state(@RequestParam String stateFilter,HttpSession session
					,@RequestParam String page){
				HashMap<String, Object> stat = new HashMap<>();
				logger.info("상태 :"+stateFilter);
				String loginId=(String) session.getAttribute("loginId");
				int checkId=service.checkId(loginId);
				logger.info("로그인ID :"+checkId);
		
					if(stateFilter.equals("전체")) {
						stat =service.all(loginId,stateFilter,page,checkId);
					}else {
						stat =service.state(loginId,stateFilter,page,checkId);
					}
				
				
				return stat;
			}
			
			int r_num=0;
			
			@RequestMapping(value="/reserveDetail")
			public String reserveDetail(HttpSession session,@RequestParam int idx
					,Model model) {
				HashMap<String, Object> revDetail = new HashMap<>();
				r_num=idx;
				String loginId=(String) session.getAttribute("loginId");
				logger.info("예약번호 :"+idx);
				int auto=service.auto(loginId);
				logger.info("업체회원?:"+auto);
				model.addAttribute("auto",auto);
				ArrayList<ReserveDTO> detail = service.detail(loginId,idx);
				logger.info("예약정보 회원:"+detail);
				model.addAttribute("detail",detail);
				for(ReserveDTO dto : detail) {
					model.addAttribute("rStart",dto.getR_start());
					}
				for(ReserveDTO dto : detail) {
					model.addAttribute("rState",dto.getR_state());
					}
				ArrayList<ReserveDTO> rivdetail = service.rivDetail(idx);
				model.addAttribute("review",rivdetail);
				
				ArrayList<ReserveDTO> revCancel = service.cancelReason(idx);
				model.addAttribute("revCancel",revCancel);
				
				ArrayList<ReserveDTO> replyDetail = service.replyDetail(idx);
				model.addAttribute("replyDetail",replyDetail);
				
				
				return "reserve/reserveDetail";
			}
			
			@RequestMapping(value="/change")
			public String change(@RequestParam String selState,
					HttpSession session) {
				logger.info("예약번호2: "+r_num);
				logger.info("상태값 : "+selState);
				String loginId=(String) session.getAttribute("loginId");
				service.change(r_num,selState,loginId);
				return "reserve/reserveComList";
			}
			
			@RequestMapping(value="/saveReview")
			public String saveReview(@RequestParam HashMap<String, Object> params
					,HttpSession session) {											
				String loginId=(String) session.getAttribute("loginId");
				logger.info("리뷰 정보: "+params);
				service.saveReview(params,loginId);
				String page="";
				int checkId=service.checkId(loginId);
				logger.info("로그인ID :"+checkId);
			
				if(checkId==0) {			
					page = "reserve/reserveList";
				}else {
					page="reserve/reserveComList";
				}
				return page;
			}
			
			@RequestMapping(value="/revCancel")
			public String revCancel(HttpSession session,@RequestParam String c_reason) {
				String loginId=(String) session.getAttribute("loginId");
				service.revCancel(r_num);
				service.saveRevCancel(r_num,loginId,c_reason);
				
				String page="";
				int checkId=service.checkId(loginId);
				logger.info("로그인ID :"+checkId);
			
				if(checkId==0) {			
					page = "reserve/reserveList";
				}else {
					page="reserve/reserveComList";
				}
				return page;
			}
			
			@RequestMapping(value="/saveReply")
			public String saveReply(@RequestParam int rev_num,@RequestParam String rrep_content
					,Model model,HttpSession session) {
				logger.info("리뷰번호: "+rev_num);
				service.saveReply(rev_num,rrep_content);				
				String page="";
				String loginId=(String) session.getAttribute("loginId");
				int checkId=service.checkId(loginId);
				logger.info("로그인ID :"+checkId);
			
				if(checkId==0) {			
					page = "reserve/reserveList";
				}else {
					page="reserve/reserveComList";
				}
				return page;
			}
			
			@RequestMapping(value="/reviewDel")
			public String reviewDel(@RequestParam int rev_num) {
				logger.info("리뷰번호: "+ rev_num);
				service.reviewDel(rev_num);
				return "reserve/reserveList";
			}
			
			@RequestMapping(value="/rrepDel")
			public String rrepDel(@RequestParam int rrep_num) {
				service.rrepDel(rrep_num);
				return "reserve/reserveComList";
			}
}










