package com.nutmag.project.dao;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.MercenaryDTO;

public interface IMercenaryDAO
{
    // 전체 용병 조회
	public ArrayList<MercenaryDTO> mercenaryList(String time);


	//용병등록
	void insertMercenary(MercenaryDTO dto);

}
