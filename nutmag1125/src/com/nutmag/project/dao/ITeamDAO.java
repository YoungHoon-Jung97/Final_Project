package com.nutmag.project.dao;

import java.util.List;

import com.nutmag.project.dto.MyInfoDTO;
import com.nutmag.project.dto.TeamDTO;
import com.nutmag.project.dto.UserDTO;

public interface ITeamDAO {

	//팀 정보 입력
	public int teamInsert(TeamDTO team);
	
	//팀이름 검색
	public String searchTeamName(String teamName);
	
	//임시 팀가입 확인 
	public int searchTempTeamMember(int userCode);
	
	//정식 팀가입 확인
	public int searchTeamMember(int userCode);
	
	// 모든팀 정보 출력
	public List<TeamDTO> getTeamList();
	
	// 팀 정보 출력
	public TeamDTO getTeam(int teamId);
	
}
