package kr.co.gudi.board.controller;

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

import kr.co.gudi.board.service.BoardReplyService;

@Controller
public class BoardReplyController {
	@Autowired BoardReplyService service;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@RequestMapping(value = "boardreply")
	public String boardreply(@RequestParam String bnum, @RequestParam String reply, HttpSession session ) {
		logger.info("댓글 저장 컨트롤러 실행");
		logger.info("reply : "+reply);
		logger.info("bnum : "+bnum);
		logger.info("bnum : "+session);
		String id = (String) session.getAttribute("loginId");
		service.boardReply(bnum,id,reply);
		
		
		return "redirect:/boardDetail?b_num="+bnum;
	}
	
	
	@RequestMapping(value = "boardReplyList")
	@ResponseBody
	public Map<String, Object> boardReplyList (@RequestParam String bnum,@RequestParam String pagePerNum,@RequestParam String page ){
		

		
		logger.info("댓글 완료 값 : "+service.boardReplyList(bnum,pagePerNum,page));
		return service.boardReplyList(bnum,pagePerNum,page);
	}
	
	@RequestMapping(value = "boardReplyDelete")
	public String boardReplyDelete ( Model model ,HttpSession session ,@RequestParam String bnum ,@RequestParam String list_num ) {
		logger.info("일단 컨트롤러까진 옴");
		logger.info("bnum : "+bnum);
		logger.info("list_num : "+list_num);
		String real = service.getreid(list_num);
		String login = (String) session.getAttribute("loginId");
		if(real.equals(login)) {
		
		service.delre(list_num);
		
			model.addAttribute("msg","댓글이 삭제되엇습니다.");
		
		}else {
			
			model.addAttribute("msg","아이디를 확인해주세요");
			
		}
		
		return "redirect:/boardDetail?b_num="+bnum;
		
	
	}
	
	@RequestMapping(value = "boardReplyModify")
	public String boardReplyModify (@RequestParam String bnum ,@RequestParam String list_num ) {
		logger.info("일단 컨트롤러까진 옴");
		logger.info("bnum : "+bnum);
		logger.info("list_num : "+list_num);
		service.boardReplyModify(list_num);
		
		return "redirect:/boardDetail?b_num="+bnum;
		
	
	}

}
