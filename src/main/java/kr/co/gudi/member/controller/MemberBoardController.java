package kr.co.gudi.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.gudi.member.dto.MemberBoardDTO;
import kr.co.gudi.member.service.MemberBoardService;

@Controller
public class MemberBoardController {
	@Autowired MemberBoardService service;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping (value = "/pfWrite")
	
	
	
	public String pfWrite(HttpSession session) {
		
		String ad_id = (String) session.getAttribute("ad_id");
		String go = "/user/meBoard";
		
		if(ad_id!=null) {
			
			go = "/admin/adBoard";
		}
		
		
		logger.info("내가쓴글");
		
		
		return go;
	}
	
	
	@RequestMapping (value = "/memyBoardList")
	@ResponseBody
	public Map<String, Object> memyBoardList(@RequestParam String page,
			@RequestParam String loginId, @RequestParam String date)
	{
		
		
		return service.memyBoardList(page,loginId,date);
	}
	
	@RequestMapping (value = "/mebDelList")
	@ResponseBody
	public HashMap<String, Object> mebDelList(@RequestParam (value = "mebDelList[]")ArrayList<String>mebDelList){
		
		
		logger.info("mebDelList"+mebDelList);
		
		int cnt = service.relist(mebDelList);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("cnt", cnt);
		
		return result ;
	}
	
	
	


}
