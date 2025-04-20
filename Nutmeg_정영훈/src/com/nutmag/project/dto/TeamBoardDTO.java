package com.nutmag.project.dto;

import java.sql.Date;

public class TeamBoardDTO {
	
    private int team_board_id;         // 게시글 ID
    private String team_board_title;   // 게시글 제목
    private String team_board_content; // 게시글 내용
    private Date team_board_create_at;  // 작성일자
    private int team_member_id;        // 작성자 ID
    private int team_id;
    private String user_nick_name;       // 작성자 이름
    private int rnum;
    
    

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public int getTeam_id() {
		return team_id;
	}

	public void setTeam_id(int team_id) {
		this.team_id = team_id;
	}

	// 추가 속성 - 조인 등으로 가져올 수 있는 정보

	public int getTeam_board_id() {
		return team_board_id;
	}

	public void setTeam_board_id(int team_board_id) {
		this.team_board_id = team_board_id;
	}

	public String getTeam_board_title() {
		return team_board_title;
	}

	public void setTeam_board_title(String team_board_title) {
		this.team_board_title = team_board_title;
	}

	public String getTeam_board_content() {
		return team_board_content;
	}

	public void setTeam_board_content(String team_board_content) {
		this.team_board_content = team_board_content;
	}


	public Date getTeam_board_create_at() {
		return team_board_create_at;
	}

	public void setTeam_board_create_at(Date team_board_createAt) {
		this.team_board_create_at = team_board_createAt;
	}

	public int getTeam_member_id() {
		return team_member_id;
	}

	public void setTeam_member_id(int team_member_id) {
		this.team_member_id = team_member_id;
	}

	public String getUser_nick_name() {
		return user_nick_name;
	}

	public void setUser_nick_name(String user_nick_name) {
		this.user_nick_name = user_nick_name;
	}
    
    
	
}
