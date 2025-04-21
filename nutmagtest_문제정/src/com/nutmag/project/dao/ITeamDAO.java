package com.nutmag.project.dao;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.server.PathParam;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.MatchDTO;
import com.nutmag.project.dto.TeamApplyDTO;
import com.nutmag.project.dto.TeamDTO;
import com.nutmag.project.dto.UserDTO;

public interface ITeamDAO {

	//팀 정보 입력
	public int teamInsert(TeamDTO team);
	
	//팀이름 검색
	public String searchTeamName(String team_name);
	
	//임시 팀가입 확인 
	public int searchTempTeamMember(int user_code_id);
	
	//정식 팀가입 확인
	public int searchTeamMember(int user_code_id);
	
	// 모든팀 정보 출력
	public List<TeamDTO> getTeamList();
	
	// 팀 정보 출력
	public TeamDTO getTeamInfo(int team_id);
	

	//-------------------------------------------------
	//my임시 동호회 찾기
	public Integer searchMyTempTeam(int user_code_id);
	
	//my정식 동호회 찾기
	public Integer searchMyTeam(int user_code_id);
	
	//정식 동호회 정보 찾기
	public Integer searchTempTeam(int teamId);
	
	
	//----------------------------------------------------
	
	//임시 동호회 인원 
	public ArrayList<TeamApplyDTO> tempTeamMemberList(int team_id);
	
	//정식 동호회 인원
	public ArrayList<TeamApplyDTO> teamMemberList(int team_id);
	
	//임시 동호회 신청자 명단
	public ArrayList<TeamApplyDTO> tempTeamApplyList(int team_id);
	
	//정식 동호회 신청자 명단
	public ArrayList<TeamApplyDTO> teamApplyList(int team_id);
	
	// 임시 동호회 중복 신청 검사
    int checkedTempTeamApply(@Param("user_code_id") int user_code_id,
                             @Param("team_id") int team_id);
    
    TeamApplyDTO searchTeamMemberCode(@Param("team_id") int team_id, @Param("user_code_id") int user_code_id);

    // 정식 동호회 중복 신청 검사
    int checkedTeamApply(@Param("user_code_id") int user_code_id,
                         @Param("team_id") int team_id);
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
	//임시 동호회 신청 삭제
	public int canceledApplyTempTeam(@PathParam("team_apply_id") int team_apply_id);
	
	//정식 동호회 신청 삭제
	public int canceledApplyTeam(@PathParam("team_apply_id") int team_apply_id);
	
	//임시 동호회 인원 삭제
	public int dropTempTeamMember(@PathParam("team_member_id") int team_member_id);
	
	
	//정식 동호회 인원 삭제
	public int dropTeamMember(@PathParam("team_member_id") int team_member_id);
	
	//임시 동호회 사용자 코드 찾기
	public TeamApplyDTO searchTempTeamUeserCode(int team_member_id);
	
	//정식 동호회 사용자 코드 찾기
	public TeamApplyDTO searchTeamUeserCode(int team_member_id);
	
	//임시 동호회 신청자 코드 찾기
	public TeamApplyDTO searchTempTeamApplyUser(int team_apply_id);
	
	//정식 동호회 신청자 코드 찾기
	public TeamApplyDTO searchTeamApplyUser(int team_apply_id);
	
	//------------------------------------------------------------------------
	
	//임시 동호회원 수
	public int tempTeamMemberCount(int temp_team_id);
	
	//정식 동호회원 수
	public int teamMemberCount(int team_id);
	
	//-------------------------------------------------------------------------------
	

	
}
