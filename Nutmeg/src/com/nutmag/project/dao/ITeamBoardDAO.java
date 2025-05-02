package com.nutmag.project.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.TeamBoardDTO;

public interface ITeamBoardDAO {

	// 전체 게시글 수 조회
    public int getTotalCount(int team_id);
    
    // 페이징된 게시글 목록 조회
    public ArrayList<TeamBoardDTO> getList(@Param("start") int start,@Param("end") int end,@Param("team_id") int team_id);
    
    // 게시글 추가
    public int insertTeamBoard(TeamBoardDTO teamBoard);
    
    // 게시글 상세 조회
    public TeamBoardDTO getTeamBoard(int team_board_id);
    
    
}
