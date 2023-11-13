package kr.co.gudi.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gudi.admin.dto.AdBoardDTO;
import kr.co.gudi.admin.service.AdminBoardService;
import kr.co.gudi.board.dto.BoardDTO;

@Controller
public class AdminBoardController {
	@Autowired AdminBoardService service;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@RequestMapping (value = "adWrite")
	public String pfAdWrite(@RequestParam String ad_id, HttpSession session) {
		
		String go = "./main";

		String admin = (String) session.getAttribute("admin");	
		if (admin.equals("admin")) {
			
			
			go = "/admin/adBoard";
		}
		
		
		return go;
	}
	
	@RequestMapping (value = "admyBoardList")
	@ResponseBody
	public Map<String, Object> admyBoardList(@RequestParam String page, @RequestParam String loginId, @RequestParam String date){
		
		
		return service.admyBoardList(page,loginId,date);
	}
	
	
	@RequestMapping(value = "adpfNoteSend")
	public String adpfNoteSend (Model model, @RequestParam String idx)
	{
		
		service.adbdata(idx,model);
		
		return "/admin/adBoardDetail";
	}
	
	@RequestMapping (value = "adbDelList")
	@ResponseBody
	public HashMap<String, Object> adbDelList(@RequestParam (value = "adbDelList[]")ArrayList<String>adbDelList){
		
		
		logger.info("adbDelList"+adbDelList);
		
		int cnt = service.relist(adbDelList);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("cnt", cnt);
		
		return result ;
	}
	

	
	
	@RequestMapping (value = "/adboardUpdateForm")
	public String adboardUpdate(HttpSession session, @RequestParam String bnum, Model model) {
		logger.info("bnum"+bnum);
		AdBoardDTO re = service.re(bnum);
		session.setAttribute("bnum",bnum);
		model.addAttribute("re",re);
		return "/admin/adboardUpdate";
	}
	
	
	@RequestMapping (value = "/adboardUpdate")
	public String adboardUpdate(MultipartFile[] photos, @RequestParam Map<String, String> params,HttpSession session, Model model) {
		  
		  
		  logger.info("boardUpdate"+session); 
		  logger.info("boardUpdate"+params);
		  String bnum = (String) session.getAttribute("bnum");
		  logger.info("boardUpdate"+bnum);
		  String uid = (String) session.getAttribute("loginId");
			return service.adboardUpdate(params,photos,bnum,uid);
		 
		  }
	
	@RequestMapping (value = "/adboardList")
	@ResponseBody
	public Map<String, Object> adboardList(){
		
		
		return service.adboardList();
	}
	
	
	
}
