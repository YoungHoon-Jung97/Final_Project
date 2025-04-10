package com.nutmag.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.MercenaryDTO;

public interface IMercenaryDAO
{
    // 전체 용병 조회

	public List<MercenaryDTO> mercenaryList();

	public List<MercenaryDTO> searchMercenaryList(@Param("field") String field, @Param("keyword") String keyword);

	List<MercenaryDTO> mercenaryListPaginated(@Param("offset") int offset, @Param("limit") int limit);
	int totalCount();

	List<MercenaryDTO> searchMercenaryListPaginated(@Param("field") String field, @Param("keyword") String keyword,
	                                                @Param("offset") int offset, @Param("limit") int limit);
	int searchCount(@Param("field") String field, @Param("keyword") String keyword);

	

}
