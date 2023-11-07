package com.lime.account.service;

import java.util.List;

import com.lime.account.vo.AccountVo;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface AccountService {
		
		//저장
		public int accountInsertPro(AccountVo accountVo);
		
		//전체리스트
		public List<AccountVo> selectList(int start, int end);
		
		//수정페이지 이동
		public EgovMap accountDetail(int accountSeq);
	
		//수정
		public int accountUpdatePro(AccountVo accountVo);
		
		// 게시물 총 개수
		public int listCount();
		
		// 엑셀 다운로드 
		public List<AccountVo> excelDownload();
}
