package com.nutmag.project.dto;


public class TeamFeeDTO {
	
	private int team_fee_id
	,team_fee_price
	,team_id
	,net_amount 		// 수입 - 지출액
	,income_amount		//수입액
	,expense_amount    //지출액 
	,team_member_fee_pay_price
	,team_member_id;
	
	private String  team_fee_desc
	,transaction_type 	// 수입/지출
	,transaction_date 	// 돈 기록 일시
	,description 		// 설명
	,team_fee_pay_start_at
	,team_fee_pay_end_at
	,team_member_fee_pay_at;
	
	public int getTeam_member_fee_pay_price() {
		return team_member_fee_pay_price;
	}
	public void setTeam_member_fee_pay_price(int team_member_fee_pay_price) {
		this.team_member_fee_pay_price = team_member_fee_pay_price;
	}
	public int getTeam_member_id() {
		return team_member_id;
	}
	public void setTeam_member_id(int team_member_id) {
		this.team_member_id = team_member_id;
	}
	public String getTeam_member_fee_pay_at() {
		return team_member_fee_pay_at;
	}
	public void setTeam_member_fee_pay_at(String team_member_fee_pay_at) {
		this.team_member_fee_pay_at = team_member_fee_pay_at;
	}
	public int getIncome_amount() {
		return income_amount;
	}
	public void setIncome_amount(int income_amount) {
		this.income_amount = income_amount;
	}
	public int getExpense_amount() {
		return expense_amount;
	}
	public void setExpense_amount(int expense_amount) {
		this.expense_amount = expense_amount;
	}
	public int getNet_amount() {
		return net_amount;
	}
	public void setNet_amount(int net_amount) {
		this.net_amount = net_amount;
	}
	public String getTransaction_type() {
		return transaction_type;
	}
	public void setTransaction_type(String transaction_type) {
		this.transaction_type = transaction_type;
	}
	public String getTransaction_date() {
		return transaction_date;
	}
	public void setTransaction_date(String transaction_date) {
		this.transaction_date = transaction_date;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getTeam_fee_id() {
		return team_fee_id;
	}
	public void setTeam_fee_id(int team_fee_id) {
		this.team_fee_id = team_fee_id;
	}
	public int getTeam_fee_price() {
		return team_fee_price;
	}
	public void setTeam_fee_price(int team_fee_price) {
		this.team_fee_price = team_fee_price;
	}
	public int getTeam_id() {
		return team_id;
	}
	public void setTeam_id(int team_id) {
		this.team_id = team_id;
	}
	public String getTeam_fee_desc() {
		return team_fee_desc;
	}
	public void setTeam_fee_desc(String team_fee_desc) {
		this.team_fee_desc = team_fee_desc;
	}
	public String getTeam_fee_pay_start_at() {
		return team_fee_pay_start_at;
	}
	public void setTeam_fee_pay_start_at(String team_fee_pay_start_at) {
		this.team_fee_pay_start_at = team_fee_pay_start_at;
	}
	public String getTeam_fee_pay_end_at() {
		return team_fee_pay_end_at;
	}
	public void setTeam_fee_pay_end_at(String team_fee_pay_end_at) {
		this.team_fee_pay_end_at = team_fee_pay_end_at;
	}
	
	

}
