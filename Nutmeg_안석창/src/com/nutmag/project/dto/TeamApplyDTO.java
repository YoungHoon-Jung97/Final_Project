package com.nutmag.project.dto;

public class TeamApplyDTO
{
	private int team_apply_id, user_code_id, position_id,temp_team_id,team_id,
	team_member_id,age;
	private String team_apply_desc,team_apply_at,team_apply_appr_at,position_name
	,user_name,team_name,user_nick_name,gender,
	member_status="동호회원";
	
	
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getMember_status() {
		return member_status;
	}
	public void setMember_status(String member_status) {
		this.member_status = member_status;
	}
	public String getUser_nick_name()
	{
		return user_nick_name;
	}
	public void setUser_nick_name(String user_nick_name)
	{
		this.user_nick_name = user_nick_name;
	}
	public int getTeam_apply_id()
	{
		return team_apply_id;
	}
	public void setTeam_apply_id(int team_apply_id)
	{
		this.team_apply_id = team_apply_id;
	}
	public int getUser_code_id()
	{
		return user_code_id;
	}
	public void setUser_code_id(int user_code_id)
	{
		this.user_code_id = user_code_id;
	}
	public int getPosition_id()
	{
		return position_id;
	}
	public void setPosition_id(int position_id)
	{
		this.position_id = position_id;
	}
	public int getTemp_team_id()
	{
		return temp_team_id;
	}
	public void setTemp_team_id(int temp_team_id)
	{
		this.temp_team_id = temp_team_id;
	}
	public int getTeam_id()
	{
		return team_id;
	}
	public void setTeam_id(int team_id)
	{
		this.team_id = team_id;
	}
	public int getTeam_member_id()
	{
		return team_member_id;
	}
	public void setTeam_member_id(int team_member_id)
	{
		this.team_member_id = team_member_id;
	}
	public String getTeam_apply_desc()
	{
		return team_apply_desc;
	}
	public void setTeam_apply_desc(String team_apply_desc)
	{
		this.team_apply_desc = team_apply_desc;
	}
	public String getTeam_apply_at()
	{
		return team_apply_at;
	}
	public void setTeam_apply_at(String team_apply_at)
	{
		this.team_apply_at = team_apply_at;
	}
	public String getTeam_apply_appr_at()
	{
		return team_apply_appr_at;
	}
	public void setTeam_apply_appr_at(String team_apply_appr_at)
	{
		this.team_apply_appr_at = team_apply_appr_at;
	}
	public String getPosition_name()
	{
		return position_name;
	}
	public void setPosition_name(String position_name)
	{
		this.position_name = position_name;
	}
	public String getUser_name()
	{
		return user_name;
	}
	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}
	public String getTeam_name()
	{
		return team_name;
	}
	public void setTeam_name(String team_name)
	{
		this.team_name = team_name;
	}
	
	
	
	
	
	
}
