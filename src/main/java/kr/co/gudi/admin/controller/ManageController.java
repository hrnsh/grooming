package kr.co.gudi.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	@RequestMapping(value="/adUserManageList",method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object>adUserManageList(){
		HashMap<String, Object> adList = new HashMap<>();
		ArrayList<ManageDTO> adUserManageList=service.adList();
		adList.put("list", adUserManageList);
		
		return adList;
	}
}
