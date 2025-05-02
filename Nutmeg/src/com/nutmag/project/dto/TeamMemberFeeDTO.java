package com.nutmag.project.dto;

public class TeamMemberFeeDTO {
	private int team_member_fee_pay_id,
	team_member_fee_pay_price,
	team_fee_id,
	team_member_id,
	team_id;
	
	private String team_member_fee_pay_at,
	user_nick_name,temp_team_name;

	public String getTemp_team_name()
	{
		return temp_team_name;
	}

	public void setTemp_team_name(String temp_team_name)
	{
		this.temp_team_name = temp_team_name;
	}

	public int getTeam_member_fee_pay_id() {
		return team_member_fee_pay_id;
	}

	public void setTeam_member_fee_pay_id(int team_member_fee_pay_id) {
		this.team_member_fee_pay_id = team_member_fee_pay_id;
	}

	public int getTeam_member_fee_pay_price() {
		return team_member_fee_pay_price;
	}

	public void setTeam_member_fee_pay_price(int team_member_fee_pay_price) {
		this.team_member_fee_pay_price = team_member_fee_pay_price;
	}

	public int getTeam_fee_id() {
		return team_fee_id;
	}

	public void setTeam_fee_id(int team_fee_id) {
		this.team_fee_id = team_fee_id;
	}

	public int getTeam_member_id() {
		return team_member_id;
	}

	public void setTeam_member_id(int team_member_id) {
		this.team_member_id = team_member_id;
	}

	public int getTeam_id() {
		return team_id;
	}

	public void setTeam_id(int team_id) {
		this.team_id = team_id;
	}

	public String getTeam_member_fee_pay_at() {
		return team_member_fee_pay_at;
	}

	public void setTeam_member_fee_pay_at(String team_member_fee_pay_at) {
		this.team_member_fee_pay_at = team_member_fee_pay_at;
	}

	public String getUser_nick_name() {
		return user_nick_name;
	}

	public void setUser_nick_name(String user_nick_name) {
		this.user_nick_name = user_nick_name;
	}
	

}
