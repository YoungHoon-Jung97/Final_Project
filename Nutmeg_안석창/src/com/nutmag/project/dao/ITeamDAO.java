package com.nutmag.project.dao;

import java.util.List;

import com.nutmag.project.dto.TeamDTO;

public interface ITeamDAO {

	// 팀 정보 입력
	public int teamInsert(TeamDTO team);
	
	// 팀 이름 검색
	public String searchTeamName(String teamName);
	
	// 팀 정보 출력
	public List<TeamDTO> getTeamList();
}
