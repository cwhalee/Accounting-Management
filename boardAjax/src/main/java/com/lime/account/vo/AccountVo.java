package com.lime.account.vo;

public class AccountVo {
	
	private int accountSeq;
	private String profitCost;
	private String bigGroup;
	private String middleGroup;
	private String smallGroup;
	private String detailGroup;
	private String comment;
	private int transactionMoney;
	private String transactionDate;
	private String writer;
	private String regDate;
	
	public AccountVo() {
		super();
	}

	public int getAccountSeq() {
		return accountSeq;
	}

	public void setAccountSeq(int accountSeq) {
		this.accountSeq = accountSeq;
	}

	public String getProfitCost() {
		return profitCost;
	}

	public void setProfitCost(String profitCost) {
		this.profitCost = profitCost;
	}

	public String getBigGroup() {
		return bigGroup;
	}

	public void setBigGroup(String bigGroup) {
		this.bigGroup = bigGroup;
	}

	public String getMiddleGroup() {
		return middleGroup;
	}

	public void setMiddleGroup(String middleGroup) {
		this.middleGroup = middleGroup;
	}

	public String getSmallGroup() {
		return smallGroup;
	}

	public void setSmallGroup(String smallGroup) {
		this.smallGroup = smallGroup;
	}

	public String getDetailGroup() {
		return detailGroup;
	}

	public void setDetailGroup(String detailGroup) {
		this.detailGroup = detailGroup;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getTransactionMoney() {
		return transactionMoney;
	}

	public void setTransactionMoney(int transactionMoney) {
		this.transactionMoney = transactionMoney;
	}

	public String getTransactionDate() {
		return transactionDate;
	}

	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "AccountVo [accountSeq=" + accountSeq + ", profitCost=" + profitCost + ", bigGroup=" + bigGroup
				+ ", middleGroup=" + middleGroup + ", smallGroup=" + smallGroup + ", detailGroup=" + detailGroup
				+ ", comment=" + comment + ", transactionMoney=" + transactionMoney + ", transactionDate="
				+ transactionDate + ", writer=" + writer + ", regDate=" + regDate + "]";
	}
	
}
