package com.nutmag.project.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.TeamFeeDTO;
import com.nutmag.project.dto.TeamMemberFeeDTO;

public interface ITeamFeeDAO {
	
	//회비 정보 등록
	public void addTeamFeeInfo(TeamFeeDTO teamFee);
	
	//동호회 가계부 정보 가져오기
	public ArrayList<TeamFeeDTO> getTeamFeeList(@Param("start") int start,@Param("end") int end,@Param("team_id") int team_id);
	
	//팀 총 수입
	public int getTeamIncome(int team_id);
	
	//팀 총 지출
	public int getTeamexpense(int team_id);
	
	//동호회 회비 리스트 
	public ArrayList<TeamFeeDTO> getTeamMonthFeeList(int team_id);
	
	//회비 납부
	public void addMonthFee(TeamFeeDTO teamFee);
	
	//회비 납부자 명단
	public List<TeamMemberFeeDTO> getMemberFeeList(int team_fee_id);
	
	//가계부 자료수
	public int countTeamFee(int team_id);
}
