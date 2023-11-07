package com.lime.account.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lime.account.service.AccountService;
import com.lime.account.vo.AccountVo;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

	@Resource(name="accountDAO")
	private AccountDAO accountDAO;

	@Override
	public int accountInsertPro(AccountVo accountVo)  {
		return accountDAO.accountInsertPro(accountVo);
	}
	
	@Override
	public List<AccountVo> selectList(int start, int end){
		return accountDAO.selectList(start, end);
	}
	
	@Override
	public EgovMap accountDetail(int accountSeq){
		return accountDAO.accountDetail(accountSeq);
	}
	
	@Override
	public int accountUpdatePro(AccountVo accountVo){
		return accountDAO.accountUpdatePro(accountVo);
	}
	
	@Override
	public int listCount() {
		return accountDAO.listCount();
	}
	
	@Override
	public List<AccountVo> excelDownload(){
		return accountDAO.excelDownload();
	}
	
}
