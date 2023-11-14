package kr.co.gudi.admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.admin.dto.ManageDTO;
import kr.co.gudi.admin.service.ManageService;

@Controller
public class ManageController {
	
	@Autowired ManageService service;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/adUserManage")
	public String adUserManage() {
		return "admin/adUserManage";
	}
	
	@RequestMapping(value="/adUserManageList",method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object>adUserManageList(
			@RequestParam String user_state,@RequestParam String page){
		HashMap<String, Object> adList = new HashMap<>();
		adList=service.adList(user_state,page);
		logger.info("상태: "+user_state);
		return adList;
	}
	String log_user_id="";
	String log_ad_id="";
	@RequestMapping(value="/manageDetail")
	@ResponseBody
	public HashMap<String, Object> manageDetail(@RequestParam String user_id
			,@RequestParam String loginId){
		log_user_id=user_id;
		log_ad_id=loginId;
		HashMap<String, Object>  manageDetail= new HashMap<>();
		ArrayList<ManageDTO> dto = service.manageDetail(user_id);
		
		manageDetail.put("mDetail", dto);

		return manageDetail;
	}
	
	@RequestMapping(value="/saveManage")
	public String saveManage(@RequestParam HashMap<String, Object> params) {
		String user_id = log_user_id;
		String ad_id = log_ad_id;
		params.put("user_id", user_id);
		params.put("ad_id", ad_id);
		logger.info("받아온데이터: "+params);
		logger.info("회원:"+user_id+"/관리자: "+ad_id);
		service.saveManage(params);
		return "admin/adUserManage";
	}
	
	@RequestMapping(value="/adUserManageResult")
	public String adUserManageResult() {
		return "admin/adUserManageResult";
	}
	
	@RequestMapping(value="/adUserManageResultList",method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object>adUserManageResultList(
			@RequestParam String m_type,@RequestParam String page){
		HashMap<String, Object> adResultList = new HashMap<>();
		adResultList=service.adResultList(m_type,page);

		return adResultList;
	}
	
	@RequestMapping(value="/dateFilter",method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> dateFilter(@RequestParam String selectedDate
			,@RequestParam String page){
		HashMap<String, Object> adResultList = new HashMap<>();
		logger.info("선택날짜: "+selectedDate);
		adResultList=service.dateFilter(selectedDate,page);
		return adResultList;
	}

	@RequestMapping(value="/idFilter",method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> idFilter(@RequestParam String ad_id
			,@RequestParam String user_id,@RequestParam String page){
		HashMap<String, Object> adResultList = new HashMap<>();
		logger.info("ad_id: "+ad_id);
		logger.info("user_id: "+user_id);
		logger.info("page: "+page);
		adResultList=service.idFilter(ad_id,user_id,page);
		return adResultList;
	}
	
	@RequestMapping(value="/resultDetail",method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> resultDetail(@RequestParam int m_num){
		HashMap<String, Object> resultDetail = new HashMap<String, Object>();
		ArrayList<ManageDTO>dto= service.resultDetail(m_num);
		resultDetail.put("resultDetail", dto);
		logger.info("처리번호: "+m_num);
		
		return resultDetail;
	}
}
