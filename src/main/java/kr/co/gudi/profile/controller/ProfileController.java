package kr.co.gudi.profile.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gudi.profile.dto.ProfileDTO;
import kr.co.gudi.profile.service.ProfileService;

@Controller
public class ProfileController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired ProfileService service;
	
	@RequestMapping(value = "/profile")
	public String profile(@RequestParam String user_id, Model model) {
		ProfileDTO dto = service.profile(user_id);
		model.addAttribute("member", dto);
		logger.info("profile user_id : "+user_id);
		return "/user/pfNomal";
	}
	
	@RequestMapping(value="/listCall")
	@ResponseBody
	public HashMap<String, Object> listCall(HttpSession session, @RequestParam String user_id) {
		
		HashMap<String, Object>result = new HashMap<String, Object>();
		logger.info("aniamllist id : " + user_id);
		
		if(session.getAttribute("loginId") == null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			ArrayList<ProfileDTO> list = service.list(user_id);
			result.put("list", list);
		}
		return result;
	}

	@RequestMapping(value = "/profileUpdateForm")
	public String profileUpdate(Model model, @RequestParam String user_id) {
		model.addAttribute("member", service.profile(user_id));
		
		return "/user/pfUpdate";
	}
	
	@RequestMapping(value = "/profileupdate")
	public String profileupdate(Model model, @RequestParam HashMap<String, String> params) {
		logger.info("updateParams : " + params);
		String page = "redirect:/profileUpdateForm?user_id="+params.get("user_id");
		
		if(service.profileupdate(params)>0) {
			page = "redirect:/profile?user_id="+params.get("user_id");
		}
		
		return page;
	}
	
	@RequestMapping(value="/updatelistCall")
	@ResponseBody
	public HashMap<String, Object> updatelistCall(HttpSession session, @RequestParam String user_id) {
		
		HashMap<String, Object>result = new HashMap<String, Object>();
		logger.info("aniamllist id : " + user_id);
		
		if(session.getAttribute("loginId") == null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			ArrayList<ProfileDTO> updatelist = service.updatelist(user_id);
			result.put("updatelist", updatelist);
		}
		return result;
	}
	
	@RequestMapping(value = "/animalprofiledelete")
	@ResponseBody
	public HashMap<String, Object> animalprofiledelete(HttpSession session, @RequestParam(value="animaldeleteList[]") ArrayList<String> animaldeleteList){
		
		logger.info("animaldeleteList : " + animaldeleteList);
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		if(session.getAttribute("loginId")==null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			int delete_count = service.animalprofiledelete(animaldeleteList);
			result.put("delete_count", delete_count);
			logger.info("delcount : " + delete_count);
		}
		return result;
	}
	
	@RequestMapping(value = "/animalregisterForm")
	public String animalregisterForm(Model model, HttpSession session) {
		String page = "main";
		if (session.getAttribute("loginId") == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다");
		} else {
				page = "/user/pfanimalregister";
		}
		return page;
	}
	
	@RequestMapping(value = "/animalregister")
	public String animalregister(Model model, HttpSession session, @RequestParam HashMap<String, String> params) {
		logger.info("동물 등록 params : " + params);
		String page = "main";
		
		if (session.getAttribute("loginId") == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다");
			
		} else {
			service.animalregister(params);
			 page = "redirect:/profileUpdateForm?user_id="+params.get("user_id");
		}
		return page;
	}
	
	@RequestMapping(value = "/comregisterForm")
	public String comregister(Model model, HttpSession session, @RequestParam String user_id, @RequestParam HashMap<String, String> params) {
		logger.info("업체 등록 페이지");
		String page = "redirect:/profile?user_id="+params.get("user_id");
		
		ProfileDTO dto = service.userstatechecker(user_id);
		logger.info("dto : " + dto);
		
		if(dto.getState().equals("1")){
			logger.info("승인 대기중인 회원입니다");
			logger.info("statechecker : " + dto.getState());
			return page;
		}else if(dto.getState().equals("2")){
			logger.info("업체 등록된 회원입니다");
			logger.info("statechecker : " + dto.getState());
			return page;
		}else {
			logger.info("업체 등록 페이지로 이동");
			logger.info("statechecker : " + dto.getState());
			page = "/user/pfComRegist";
		}
		return page;
	}
	
//	@RequestMapping(value = "/comregister")
//	@ResponseBody
//	public HashMap<String, Object> comregister(@RequestParam HashMap<String, String> params){
//		logger.info("comregister params : " + params );
//		HashMap<String, Object> result = new HashMap<String, Object>();
//		int row = service.comregister(params);
//		result.put("success", row);
//		
//		return result;
//	}
	
	@RequestMapping(value = "/comregister")
	public String comregister(MultipartFile photos, @RequestParam Map<String, String> params) {
		logger.info("params : " + params);
		logger.info("file : " + photos);
		return service.comregister(params, photos);
	}
	
//	@RequestMapping(value = "/comregister")
//	public String comregister(@RequestParam HashMap<String, String> params, MultipartFile photo, HttpSession session) throws Exception {
//		
//		String loginId = (String)session.getAttribute("loginId");
//		ProfileDTO dto = service.comregister(photo);
//	
//		return  "redirect:/profile?user_id="+params.get("user_id");
//
//	}
	
	@RequestMapping(value="/comlistCall")
	@ResponseBody
	public HashMap<String, Object> comlistCall(HttpSession session, @RequestParam String user_id) {
		
		HashMap<String, Object>result = new HashMap<String, Object>();
		logger.info("comllist id : " + user_id);
		
		if(session.getAttribute("loginId") == null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			ArrayList<ProfileDTO> comlist = service.comlist(user_id);
			result.put("comlist", comlist);
		}
		
		
		return result;
	}
	
	@RequestMapping(value = "/userstatedeleter")
	@ResponseBody
	public HashMap<String, Object> userstatedeleter(@RequestParam String user_id, @RequestParam HashMap<String, String> params) {
		logger.info("userstatedeleter : " + user_id);
		HashMap<String, Object> result = new HashMap<String, Object>();
		int row = service.userstatedeleter(params);
		result.put("success", row);
		
		return result;
	}
	
	@RequestMapping(value = "/pickupinfoForm")
	public String pickupinfo(Model model, HttpSession session, @RequestParam String com_num) {
		logger.info("업체 수정 페이지 : " + com_num);
		model.addAttribute("com_num", com_num);
		return "/user/pfpickupinfo";
	}
	
	@RequestMapping(value="/pickuplistCall")
	@ResponseBody
	public HashMap<String, Object> pickuplistCall(HttpSession session, @RequestParam String com_num) {
		
		HashMap<String, Object>result = new HashMap<String, Object>();
		logger.info("!!!com_num!!! : " + com_num);
		
		if(session.getAttribute("loginId") == null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			ArrayList<ProfileDTO> pickuplist = service.pickuplist(com_num);
			result.put("pickuplist", pickuplist);
		}
		return result;
	}
	
	@RequestMapping(value = "/writepickupdistance")
	@ResponseBody
	public HashMap<String, Object> writepickupinfo(@RequestParam HashMap<String, String> params){
		logger.info("writepickupinfo params : " + params);
		HashMap<String, Object> result = new HashMap<String, Object>();
		int row = service.writepickupinfo(params);
		logger.info("writepickupdistance : " + row);
		result.put("success", row);
		
		return result;
	}
	
	@RequestMapping(value = "/pickuppricedelete")
	@ResponseBody
	public HashMap<String, Object> pickuppricedelete(HttpSession session, @RequestParam(value="pickuppricedeleteList[]") ArrayList<String> pickuppricedeleteList){
		
		logger.info("pickuppricedeleteList : " + pickuppricedeleteList);
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		if(session.getAttribute("loginId")==null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			int pickuppricedelete_count = service.pickuppricedelete(pickuppricedeleteList);
			result.put("pickuppricedelete_count", pickuppricedelete_count);
			logger.info("delcount : " + pickuppricedelete_count);
		}
		return result;
	}
	
	@RequestMapping(value = "/writeticketprice")
	@ResponseBody
	public HashMap<String, Object> writeticketprice(@RequestParam HashMap<String, String> params){
		logger.info("writeticketprice params : " + params);
		HashMap<String, Object> result = new HashMap<String, Object>();
		int row = service.writeticketprice(params);
		logger.info("writeticketprice : " + row);
		result.put("success", row);
		
		return result;
	}
	
	@RequestMapping(value="/ticketlistCall")
	@ResponseBody
	public HashMap<String, Object> ticketlistCall(HttpSession session, @RequestParam String com_num) {
		
		HashMap<String, Object>result = new HashMap<String, Object>();
		logger.info("???com_num??? : " + com_num);
		
		if(session.getAttribute("loginId") == null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			ArrayList<ProfileDTO> ticketlist = service.ticketlist(com_num);
			result.put("ticketlist", ticketlist);
		}
		return result;
	}
	
	@RequestMapping(value = "/ticketpricedelete")
	@ResponseBody
	public HashMap<String, Object> ticketpricedelete(HttpSession session, @RequestParam(value="ticketpricedeleteList[]") ArrayList<String> ticketpricedeleteList){
		
		logger.info("ticketpricedeleteList : " + ticketpricedeleteList);
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		if(session.getAttribute("loginId")==null) {
			result.put("login", false);
		}else {
			result.put("login", true);
			int ticketpricedelete_count = service.ticketpricedelete(ticketpricedeleteList);
			result.put("ticketpricedelete_count", ticketpricedelete_count);
			logger.info("delcount : " + ticketpricedelete_count);
		}
		return result;
	}
	
	@RequestMapping(value="/nomalLogout")
	public String adLogout(HttpSession session) {
		session.removeAttribute("loginId");
		return "redirect:/";
	}
	
//	@RequestMapping(value="/compicregistForm")
//	public String adInquirySend(Model model, @RequestParam String com_num) {
//		logger.info("업체 사진 등록 : " + com_num);
//		model.addAttribute("com_num",com_num);
//		return "/user/compicregistForm";
//	}
//	
//	@RequestMapping(value = "/compicregist", method = RequestMethod.POST)
//	public String compicregist(MultipartFile photo, HttpSession session, Model model, @RequestParam String com_num) throws Exception{
//		String loginId = (String) session.getAttribute("loginId");
//		service.savecompic(photo, loginId);
//		model.addAttribute("com_num", com_num);
//		
//		return "redirect:/pickupinfoForm";
//	}
	
}
