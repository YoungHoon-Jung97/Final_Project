package com.nutmag.project.dao;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.FieldResMainPageDTO;
import com.nutmag.project.dto.MatchDTO;
import com.nutmag.project.dto.MercenaryDTO;
import com.nutmag.project.dto.MercenaryOfferDTO;
import com.nutmag.project.dto.UserDTO;

public interface IMercenaryDAO
{
    // 전체 용병 조회
	public ArrayList<MercenaryDTO> searchTimeMercenary(String time);

	//용병등록
	public void insertMercenary(MercenaryDTO dto);
	
	//용병 등록 확인
	public int checkedMercenary(int userCode);
	
	//용병 시간 변경
	public int updateMercenaryTime(MercenaryDTO mercenary);
	
	//용병 지역 검색
	public ArrayList<MercenaryDTO> searchMercenary(Map<String, Object> params);
	
	//용병 고용
	public void sendMercenary(MercenaryDTO mercenary);
	
	//팀참여 매치
	public ArrayList<MatchDTO> searchTeamMatch(@Param("team_id")int team_id);
	
	//용병 사용자 코드 조회
	public MercenaryDTO searchUsercode(@Param("mercenary_id")int mercenary_id);
	
	//용병 신청 리스트
	public ArrayList<MercenaryOfferDTO> getMercenaryOfferList(@Param("user_code_id")int user_code_id);
	
	//용병 신청 응답
	public void mercenaryResponse(MercenaryDTO mercenary);

}
