package com.nutmag.project.dao;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.FieldResMainPageDTO;
import com.nutmag.project.dto.MercenaryDTO;

public interface IMercenaryDAO
{
    // 전체 용병 조회
	public ArrayList<MercenaryDTO> mercenaryList(String time);

	//용병등록
	public void insertMercenary(MercenaryDTO dto);
	
	//용병 등록 확인
	public int checkedMercenary(int userCode);
	
	//용병 시간 변경
	public int updateMercenaryTime(MercenaryDTO mercenary);
	
	//용병 지역 검색
	public ArrayList<MercenaryDTO> searchMercenary(Map<String, Object> params);

}
