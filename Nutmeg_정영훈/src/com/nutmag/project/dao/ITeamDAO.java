package com.nutmag.project.dao;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.server.PathParam;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.TeamApplyDTO;
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
	public TeamDTO getTeamInfo(int teamId);
	

	//-------------------------------------------------
	//my임시 동호회 찾기
	public Integer searchMyTempTeam(int userCode);
	
	//my정식 동호회 찾기
	public Integer searchMyTeam(int userCode);
	
	//정식 동호회 정보 찾기
	public Integer searchTempTeam(int teamId);
	//----------------------------------------------------
	
	//임시 동호회 인원 
	public ArrayList<TeamApplyDTO> tempTeamMemberList(int teamId);
	
	//정식 동호회 인원
	public ArrayList<TeamApplyDTO> teamMemberList(int teamId);
	
	//임시 동호회 신청자 명단
	public ArrayList<TeamApplyDTO> tempTeamApplyList(int teamId);
	
	// 임시 동호회 중복 신청 검사
    int checkedTempTeamApply(@Param("user_code_id") int user_code_id,
                             @Param("team_id") int team_id);

    // 정식 동호회 중복 신청 검사
    int checkedTeamApply(@Param("user_code_id") int user_code_id,
                         @Param("team_id") int team_id);
	//정식 동호회 신청자 명단
	public ArrayList<TeamApplyDTO> teamApplyList(int teamId);
	
	//----------------------------------------------------------------
	//임시 팀 가입 
	public int applyedTempTeam(TeamApplyDTO teamApply);
	
	//정식 팀 가입 
	public int applyedTeam(TeamApplyDTO teamApply);
	
	//임시 동호회 멤버 추가
	public int addtempTeamMember(@PathParam("team_apply_id") int team_apply_id);
	
	//정식 동호회 멤버 추가
	public int addteamMember(@PathParam("team_apply_id") int team_apply_id);
	//----------------------------------------------------------------
}
