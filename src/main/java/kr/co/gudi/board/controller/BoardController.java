package kr.co.gudi.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gudi.board.dto.BoardDTO;
import kr.co.gudi.board.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	BoardService service;

	Logger logger = LoggerFactory.getLogger(getClass());

	/*
	 * @RequestMapping (value = {"/","/BoardList"}) public String normalList(Model
	 * model) { logger.info("노멀호출"); ArrayList<BoardDTO> list = service.boardList();
	 * model.addAttribute("list", list); return "normalList"; }
	 */
	/*
	 * @RequestMapping (value = {"/DBoardList"}) public String deptList(Model model)
	 * { logger.info("dept호출"); ArrayList<BoardDTO> list = service.dboardList();
	 * model.addAttribute("list", list); return "deptList"; }
	 */
	@RequestMapping(value = "/boardWriteForm")
	public String boardWriteForm(Model model) {

		return "/board/boardWrite";
	}
	
	
	
	
	
	

	
	@RequestMapping (value = "/boardWrite")
	public String boardWrite(MultipartFile[] photos, @RequestParam Map<String, String> params) {
		logger.info("file 갯수 : "+photos.length);
		logger.info("params : "+params);
		return service.boardWrite(params,photos);
	}
	
	
	
	
	
	

	@RequestMapping(value = { "/boardMain" })
	public String boardMain(HttpSession session, Model model) {

		session.setAttribute("login", "first");//세션 설정
		Object loginInfo = session.getAttribute("login");
		model.addAttribute("login", loginInfo);
		return "/board/boardMain";

	}
	
	
	
	
	
	
	
	@RequestMapping(value="/boardList")
	@ResponseBody
	public Map<String, Object> boardList( @RequestParam String filter,@RequestParam String searchtag,@RequestParam String searchindex, @RequestParam String pagePerNum,
			@RequestParam String page) {
		logger.info("페이지당 보여줄 게시글 수 : "+pagePerNum);
		logger.info("보여줄 페이지 : "+page);
		logger.info("필터 : "+filter);
		logger.info("searchtag 와 searchindex : "+searchtag+" / "+searchindex);
		logger.info("결과 : "+service.boardList(filter,searchtag,searchindex,pagePerNum, page));
		
		return service.boardList(filter,searchtag,searchindex,pagePerNum, page);
	}

	/*
	 * @RequestMapping(value = "/boardList")
	 * 
	 * @ResponseBody public HashMap<String, Object> boardList(@RequestParam String
	 * filter,@RequestParam String pagePerNum,
	 * 
	 * @RequestParam String page) {
	 * 
	 * 
	 * 
	 * ArrayList<BoardDTO> list = service.boardList(filter); HashMap<String, Object>
	 * result = new HashMap<String, Object>(); HashMap<String, Object> pages =
	 * service.page(pagePerNum, page); result.put("list", list); return result;
	 * 
	 * logger.info("페이지당 보여줄 게시글 수 : "+pagePerNum); logger.info("보여줄 페이지 : "+page);
	 * logger.info("보여줄 페이지 : "+filter);
	 * 
	 * return service.list(pagePerNum, page, filter); }
	 */

	/*
	 * @RequestMapping(value = "/boardSearch")
	 * 
	 * @ResponseBody public Map<String, Object> boardSearch(@RequestParam String
	 * searchindex, @RequestParam String searchtag ,@RequestParam String pagePerNum,
	 * 
	 * @RequestParam String page ) {
	 * 
	 * logger.info("컨트롤러로 들어온 값 : " + searchindex); logger.info("컨트롤러로 들어온 값 : " +
	 * searchtag); logger.info("컨트롤러로 들어온 값 : " + pagePerNum);
	 * logger.info("컨트롤러로 들어온 값 : " + page);
	 * 
	 * logger.info("구해온 검색 : " +
	 * service.searchList(searchtag,searchindex,pagePerNum,page));
	 * 
	 * return service.searchList(searchtag,searchindex,pagePerNum,page); }
	 */

	@RequestMapping(value = "/boardDetail")
	public String detailBoard(HttpSession session, Model model, @RequestParam String b_num) {

		logger.info("b_num : "+b_num);
		String go = "/board/boardDetail";
		
		String login = (String) session.getAttribute("login");

		HashMap<String, String> data = service.boardDetail(b_num);
		model.addAttribute("list", data);
		
		String boarduse = service.boarduse(b_num);
		logger.info("체크값 : "+boarduse);
		if(login.equals(boarduse)) {
			
			logger.info("같습니다.");
			model.addAttribute("login", "boarduse");
			
		}else {
			
			logger.info("다릅니다.");
		}
		
		
		return go;
	}
	
	
	
	
	
	
	
	@RequestMapping(value = "boardreply")
	public String boardreply(@RequestParam String bnum, @RequestParam String reply ) {
		logger.info("댓글 저장 컨트롤러 실행");
		logger.info("reply"+reply);
		
		return "";
	}
	
	
	
	
	
	
	
	
	@RequestMapping (value = "/boardUpdate")
	public String boardUpdate(HttpSession session) {
		
		return "boardUpdate";
	}
	
	
	
	
	
	
	
	
	
	@RequestMapping (value = "/boardDelete")
	public String boardDelete(HttpSession session,@RequestParam int bnum,@RequestParam String user_id) {
		
		String login = (String) session.getAttribute("login");
		String path = "redirect:/boardMain";
		if(login.equals(user_id)) {
		logger.info("받은값"+bnum);
		logger.info("받은값2"+user_id);
		service.boardDelete(bnum);
		}else {
			
		}
		return path;
	}

}
