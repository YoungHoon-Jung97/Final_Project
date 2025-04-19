package com.nutmag.project.dao;

import java.util.ArrayList;

import com.nutmag.project.dto.TeamFeeDTO;

public interface ITeamFeeDAO {
	
	//회비 정보 등록
	public void addTeamFeeInfo(TeamFeeDTO teamFee);
	
	//동호회 가계부 정보 가져오기
	public ArrayList<TeamFeeDTO> getTeamFeeList(int team_id);
	
	//팀 총 수입
	public int getTeamIncome(int team_id);
	
	//팀 총 지출
	public int getTeamexpense(int team_id);
	
	//동호회 회비 리스트 
	public ArrayList<TeamFeeDTO> getTeamMonthFeeList(int team_id);
	
	//회비 납부
	public void addMonthFee(TeamFeeDTO teamFee);
}
