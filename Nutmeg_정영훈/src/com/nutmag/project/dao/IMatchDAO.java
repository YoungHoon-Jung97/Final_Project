package com.nutmag.project.dao;


import java.util.ArrayList;

import com.nutmag.project.dto.MatchDTO;
import com.nutmag.project.dto.TeamApplyDTO;

public interface IMatchDAO {

	//동호회원 찾기
	public TeamApplyDTO searchTeamMember(int user_code_id);
	
	//동호회 일정 출력
	public ArrayList<MatchDTO> matchList(int team_id);
	
	//매치 정보 출력
	public MatchDTO getMatch(int field_res_id);
	
	
	//--------------------------------------------------
	//홈팀 동호회 인원 참여
	public int addHomeTeamMember(MatchDTO matchDTO);
	
	//홈팀 동호회 인원 참여 중복 검사
	public int searchHomeTeamMember(MatchDTO matchDTO);
	
	//어웨이 동호회 인원 참여
	public int addAwayTeamMember(MatchDTO matchDTO);
	
	//어웨이 동호회 인원 참여 중복 검사
	public int searchAwayTeamMember(MatchDTO matchDTO);
	
	//-----------------------------------------------------
	//홈팀 매치 참여자 출력
	public ArrayList<MatchDTO> homeTeamPaticipantList(int field_res_id);
	
	//어웨이팀 매치 참여자 출력
	public ArrayList<MatchDTO> awayTeamPaticipantList(int field_res_id);
}
