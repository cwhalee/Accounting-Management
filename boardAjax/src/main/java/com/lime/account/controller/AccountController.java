package com.lime.account.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import com.lime.account.service.AccountService;
import com.lime.account.vo.AccountVo;
//import com.lime.account.vo.PaginationInfo;
import com.lime.common.service.CommonService;
import com.lime.login.service.LoginService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class AccountController {


	@Resource(name = "jsonView")
	private MappingJackson2JsonView jsonView;

	@Resource(name="accountService")
	private AccountService accountService;

	@Resource(name="commonService")
	private CommonService commonService;
	
	@Resource(name="loginService")
	private LoginService loginService;

	/**
	 *
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/account/accountList.do")
	public ModelAndView selectSampleList(HttpServletRequest request, ModelMap model, @RequestParam(defaultValue = "1") int pageNo) throws Exception {
		int count=accountService.listCount();
		
	    PaginationInfo paginationInfo = new PaginationInfo();
	    paginationInfo.setCurrentPageNo(pageNo); // 현재 페이지 번호
	    paginationInfo.setRecordCountPerPage(10); //한 페이지에 게시되는 게시물 건수
	    paginationInfo.setTotalRecordCount(count); // 총 레코드 수
	    paginationInfo.setPageSize(5); // 페이지 크기 

	    int start = paginationInfo.getFirstRecordIndex();
	    int end = paginationInfo.getLastRecordIndex();

	    ModelAndView mav = new ModelAndView();
	    List<AccountVo> accountList = accountService.selectList(start, end);
	    
	    System.out.println(accountList);
	   
	    model.addAttribute("paginationInfo", paginationInfo);
	    mav.setViewName("/account/accountList");
	    mav.addObject("accountList", accountList);
	    return mav;
	}
	
//  // MySQL 리스트
//	@RequestMapping(value = "/account/accountList.do")
//	public ModelAndView selectSampleList(HttpServletRequest request, ModelMap model, @RequestParam(defaultValue = "1") int curPage)
//	        throws Exception {
//	    int count = accountService.listCount();
//
//	    // 페이지 관련 설정
//	    int itemsPerPage = 10; // 한 페이지에 표시할 항목 수
//	    int start = (curPage - 1) * itemsPerPage; // 시작 레코드 인덱스
//	    int end = itemsPerPage; // 가져올 레코드 수
//
//	    ModelAndView mav = new ModelAndView();
//	    List<AccountVo> accountList = accountService.selectList(start, end);
//	    Map<String, Object> inOutMap = CommUtils.getFormParam(request);
//
//	    inOutMap.put("accountList", accountList);
//	    inOutMap.put("curPage", curPage); // 현재 페이지 번호
//	    inOutMap.put("totalPages", (int) Math.ceil((double) count / itemsPerPage)); // 전체 페이지 수
//	    mav.setViewName("/account/accountList");
//	    mav.addObject("inOutMap", inOutMap);
//	    return mav;
//	}


	/**
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/account/accountInsert.do")
	public String accountInsert(HttpServletRequest request, ModelMap model) throws Exception{
		Map<String, Object> inOutMap = new HashMap<>();
		
		inOutMap.put("category", "A000000");
		List<EgovMap> resultMap= commonService.selectCombo(inOutMap);
		
		System.out.println(resultMap);
		
		model.put("resultMap", resultMap);
		return "/account/accountInsert";
	}

	/**
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 */
	// 다중 Select Box  
	@ResponseBody
	@RequestMapping(value="/account/selectCombo.do", method= {RequestMethod.POST})
	public List<EgovMap> selectCombo(@RequestBody Map<String, Object> category, HttpSession session) throws Exception {	
		List<EgovMap> resultList = commonService.selectCombo(category);
		
		return resultList;
	}
	
	// 등록하기
	@ResponseBody
	@RequestMapping(value="/account/accountInsertPro.do", method= {RequestMethod.POST})
	public int accountInsertPro( @RequestBody AccountVo accountVo, Model model) {		
		accountService.accountInsertPro(accountVo);
		int acc = accountVo.getAccountSeq();
		
		return acc;
	}
	
	// 수정페이지로 이동
	@RequestMapping(value="/account/accountDetail.do")
	public String accountDetail(HttpServletRequest request, Model model) {
		int accountSeq = Integer.parseInt(request.getParameter("acc"));		
		EgovMap result = accountService.accountDetail(accountSeq);
		model.addAttribute("result",result);

		return "/account/accountDetail";
	}
	
	// 수정하기
	@ResponseBody
	@RequestMapping(value="/account/accountUpdatePro.do", method= {RequestMethod.POST})
	public int accountUpdatetPro( @RequestBody AccountVo accountVo, Model model) {
		int acc = accountVo.getAccountSeq();
		accountService.accountUpdatePro(accountVo);
		
		
		return acc;
	}
	
	// 엑셀 다운로드
	@RequestMapping("/account/excelDownload.do")
	public void excelDownload(HttpServletResponse response,@RequestParam(defaultValue="1") int pageNo) throws Exception{
		List<AccountVo> accountList = accountService.excelDownload();

	    System.out.println(accountList);
	    
	    SXSSFWorkbook wb = new SXSSFWorkbook();
	    SXSSFSheet sheet = wb.createSheet("회계정보");
	    sheet.setColumnWidth(0, 4440);
	    
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;
	    
	    CellStyle headStyle = wb.createCellStyle();
	    CellStyle bodyStyle = wb.createCellStyle();
	    
	    bodyStyle.setDataFormat(wb.createDataFormat().getFormat("#,##0"));
	   
	    row = sheet.createRow(rowNo++);

	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("seq");

	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("수익/비용");

	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("관");

	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("항");

	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("목");

	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("과");

	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상세 입력");
	    
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellStyle(bodyStyle);
	    cell.setCellValue("금액");

	    cell = row.createCell(8);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("거래일자");

	    cell = row.createCell(9);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("등록일자");

	    cell = row.createCell(10);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("작성자");

	    for(AccountVo vo : accountList) {

	        row = sheet.createRow(rowNo++);

	        cell = row.createCell(0);
	        cell.setCellValue(vo.getAccountSeq());

	        cell = row.createCell(1);
	        cell.setCellValue(vo.getProfitCost());

	        cell = row.createCell(2);
	        cell.setCellValue(vo.getBigGroup());

	        cell = row.createCell(3);
	        cell.setCellValue(vo.getMiddleGroup());

	        cell = row.createCell(4);
	        cell.setCellValue(vo.getSmallGroup());

	        cell = row.createCell(5);
	        cell.setCellValue(vo.getDetailGroup());

	        cell = row.createCell(6);
	        cell.setCellValue(vo.getComment());
	        
	        cell = row.createCell(7);
	        cell.setCellValue(vo.getTransactionMoney());

	        cell = row.createCell(8);
	        cell.setCellValue(vo.getTransactionDate());

	        cell = row.createCell(9);
	        cell.setCellValue(vo.getRegDate());
	        
	        cell = row.createCell(10);
	        cell.setCellValue(vo.getWriter());
	    }
	    response.setHeader("Content-Disposition", "ATTachment; Filename="+URLEncoder.encode("회계정보","UTF-8")+".xls");
	    // 헤더 설정 후 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
}// end