package com.lime.account.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lime.account.vo.AccountVo;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Repository("accountDAO")
public class AccountDAO extends EgovAbstractMapper{
		
		@Autowired
		private SqlSession sqlSession;
		
		// 등록
		public int accountInsertPro(AccountVo accountVo) {
			System.out.println("accountInsertDao" + accountVo);
			return sqlSession.insert("Common.accountInsertPro", accountVo);
		}
		
		// 게시물 총 수
		public int listCount() {
			return sqlSession.selectOne("Common.listCount");

		}
		
		// 리스트 
		public List<AccountVo> selectList(int start, int end) {
			Map<String,Object> map=new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			return sqlSession.selectList("Common.selectList",map);
		}
		
		// 디테일
		public EgovMap accountDetail(int accountSeq){
			System.out.println("DAO                     "+accountSeq);
			return sqlSession.selectOne("Common.accountDetail", accountSeq);
		}
		
		// 수정
		public int accountUpdatePro(AccountVo accountVo){
			return sqlSession.update("Common.accountUpdatePro", accountVo);
		}
		
		// 엑셀 다운로드 
		public List<AccountVo> excelDownload(){
			return sqlSession.selectList("Common.excelDownload");
		}
		
}
