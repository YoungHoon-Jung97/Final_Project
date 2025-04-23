package com.nutmag.project.dto;

public class MercenaryDTO
{
	private int mercenary_id,region_id,user_code_id,position_id,city_id,field_res_id,team_id;
	private String mercenary_reg_at,position_name,city_name,region_name,user_name,user_nick_name,
	mercenary_time_start_at,mercenary_time_end_at, time;
	
	public int getTeam_id()
	{
		return team_id;
	}
	public void setTeam_id(int team_id)
	{
		this.team_id = team_id;
	}
	public int getField_res_id()
	{
		return field_res_id;
	}
	public void setField_res_id(int field_res_id)
	{
		this.field_res_id = field_res_id;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getUser_nick_name() {
		return user_nick_name;
	}
	public void setUser_nick_name(String user_nick_name) {
		this.user_nick_name = user_nick_name;
	}
	public int getMercenary_id() {
		return mercenary_id;
	}
	public void setMercenary_id(int mercenary_id) {
		this.mercenary_id = mercenary_id;
	}
	public String getMercenary_time_start_at() {
		return mercenary_time_start_at;
	}
	public void setMercenary_time_start_at(String mercenary_time_start_at) {
		this.mercenary_time_start_at = mercenary_time_start_at;
	}
	public String getMercenary_time_end_at() {
		return mercenary_time_end_at;
	}
	public void setMercenary_time_end_at(String mercenary_time_end_at) {
		this.mercenary_time_end_at = mercenary_time_end_at;
	}
	public int getRegion_id() {
		return region_id;
	}
	public void setRegion_id(int region_id) {
		this.region_id = region_id;
	}
	public int getUser_code_id() {
		return user_code_id;
	}
	public void setUser_code_id(int user_code_id) {
		this.user_code_id = user_code_id;
	}
	public int getPosition_id() {
		return position_id;
	}
	public void setPosition_id(int position_id) {
		this.position_id = position_id;
	}
	public int getCity_id() {
		return city_id;
	}
	public void setCity_id(int city_id) {
		this.city_id = city_id;
	}
	public String getMercenary_reg_at() {
		return mercenary_reg_at;
	}
	public void setMercenary_reg_at(String mercenary_reg_at) {
		this.mercenary_reg_at = mercenary_reg_at;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	public String getCity_name() {
		return city_name;
	}
	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
	public String getRegion_name() {
		return region_name;
	}
	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
   
}
