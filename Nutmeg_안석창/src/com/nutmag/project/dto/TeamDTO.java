package com.nutmag.project.dto;

import org.springframework.web.multipart.MultipartFile;

public class TeamDTO {
	private int temp_team_id,user_code_id,bank_id,region_id,city_id,temp_team_person_count;
	private String temp_team_name,temp_team_desc,emblem,temp_team_apply_at,
	temp_team_account,temp_team_account_holder,region_name,city_name,team_id;
	
	private MultipartFile temp_team_emblem;
	
	public String getRegion_name()
	{
		return region_name;
	}
	public void setRegion_name(String region_name)
	{
		this.region_name = region_name;
	}
	public String getTeam_id()
	{
		return team_id;
	}
	public void setTeam_id(String team_id)
	{
		this.team_id = team_id;
	}
	public String getCity_name()
	{
		return city_name;
	}
	public void setCity_name(String city_name)
	{
		this.city_name = city_name;
	}
	public int getTemp_team_person_count() {
		return temp_team_person_count;
	}
	public void setTemp_team_person_count(int temp_team_person_count) {
		this.temp_team_person_count = temp_team_person_count;
	}
	public String getEmblem() {
		return emblem;
	}
	public void setEmblem(String emblem) {
		this.emblem = emblem;
	}
	public MultipartFile getTemp_team_emblem() {
		return temp_team_emblem;
	}
	public void setTemp_team_emblem(MultipartFile temp_team_emblem) {
		this.temp_team_emblem = temp_team_emblem;
	}
	public int getTemp_team_id() {
		return temp_team_id;
	}
	public void setTemp_team_id(int temp_team_id) {
		this.temp_team_id = temp_team_id;
	}
	public int getUser_code_id() {
		return user_code_id;
	}
	public void setUser_code_id(int user_code_id) {
		this.user_code_id = user_code_id;
	}
	public int getBank_id() {
		return bank_id;
	}
	public void setBank_id(int bank_id) {
		this.bank_id = bank_id;
	}
	public int getRegion_id() {
		return region_id;
	}
	public void setRegion_id(int region_id) {
		this.region_id = region_id;
	}
	public int getCity_id() {
		return city_id;
	}
	public void setCity_id(int city_id) {
		this.city_id = city_id;
	}
	public String getTemp_team_name() {
		return temp_team_name;
	}
	public void setTemp_team_name(String temp_team_name) {
		this.temp_team_name = temp_team_name;
	}
	public int getTemp_team_persom_count() {
		return temp_team_person_count;
	}
	public void setTemp_team_persom_count(int temp_team_person_count) {
		this.temp_team_person_count = temp_team_person_count;
	}
	public String getTemp_team_desc() {
		return temp_team_desc;
	}
	public void setTemp_team_desc(String temp_team_desc) {
		this.temp_team_desc = temp_team_desc;
	}
	public String getTemp_team_apply_at() {
		return temp_team_apply_at;
	}
	public void setTemp_team_apply_at(String temp_team_apply_at) {
		this.temp_team_apply_at = temp_team_apply_at;
	}
	public String getTemp_team_account() {
		return temp_team_account;
	}
	public void setTemp_team_account(String temp_team_account) {
		this.temp_team_account = temp_team_account;
	}
	public String getTemp_team_account_holder() {
		return temp_team_account_holder;
	}
	public void setTemp_team_account_holder(String temp_team_account_holder) {
		this.temp_team_account_holder = temp_team_account_holder;
	}
}
