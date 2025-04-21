package com.nutmag.project.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.nutmag.project.dto.AdminFieldApprDTO;
import com.nutmag.project.dto.FieldApprListDTO;
import com.nutmag.project.dto.FieldEnvironmentDTO;
import com.nutmag.project.dto.FieldRegInsertDTO;
import com.nutmag.project.dto.FieldRegSearchDTO;
import com.nutmag.project.dto.FieldResInsertDTO;
import com.nutmag.project.dto.FieldResMainPageDTO;
import com.nutmag.project.dto.FieldResOperatorDTO;
import com.nutmag.project.dto.FieldTypeDTO;
import com.nutmag.project.dto.MatchDTO;

public interface IFieldDAO
{
	// 경기장 타입
	public ArrayList<FieldTypeDTO> fieldTypeList();
	
	// 경기장 환경
	public ArrayList<FieldEnvironmentDTO> fieldEnviromentList();
	
	// 경기장 인서트 폼
	public int fieldInsertForm(FieldRegInsertDTO field);
	
	// 경기장 인서트
	public int fieldInsert(FieldRegInsertDTO fieldDTO);
	
	// 경기장 전체 리스트 (승인,반려,미승인 전부)
	public ArrayList<FieldRegSearchDTO> fieldAllList();
	
	// 선택된 구장의 경기장 리스트 검색
	public ArrayList<FieldRegSearchDTO> fieldSearchList(int stadium_reg_id);
	
	// 경기장 미승인 리스트
	public ArrayList<FieldRegSearchDTO> fieldBeforeApprList();
	
	// 승인된 경기장 리스트
	public ArrayList<FieldResMainPageDTO> fieldApprOkList();
	
	// 승인된 경기장 리스트 유저 코드로 검색
	public ArrayList<FieldResMainPageDTO> fieldApprOkSearchIdList(int user_code_id);
	
	// 경기장 예약 메인 페이지 지역 선택시 나오는 경기장 리스트
	public ArrayList<FieldResMainPageDTO> searchFieldList(Map<String, Object> params);
	
	// 경기장 예약 선택시 나오는 경기장 정보 조회
	public ArrayList<FieldResMainPageDTO> fieldApprOkSearchList(int field_code_id);
	
	// 경기장 예약 불가 시간 찾기
	List<Map<String, Object>> FieldUnavailableTime(Map<String, Object> params);
	
	// 경기장 주인 정보 불러오기
	FieldResOperatorDTO fieldOperatorInfo(@Param("field_code_id") int field_code_id);
	
	// 경기장 인원수 리스트
	public ArrayList<FieldResMainPageDTO> inwonList();
	
	// 예약 인서트
	public int fieldResInsert(FieldResInsertDTO dto);
	
	// 경기장 수정
	public int fieldUpdate(FieldRegInsertDTO dto);
	
	// 경기장 승인 리스트 (구장 운영자 유저 코드로 검색)
	public ArrayList<FieldApprListDTO> operatorFieldApprOkSearchList(int user_code_id);
	
	// 경기장 취소 리스트 (구장 운영자 유저 코드로 검색)
	public ArrayList<FieldApprListDTO> operatorFieldApprCancelSearchList(int user_code_id);
	
	// 경기장 예약 내역
	public ArrayList<MatchDTO> operatorFieldResHistory(int user_code_id);
	
	// 페이징 처리
	ArrayList<MatchDTO> operatorFieldResHistoryPaged(@Param("user_code_id") int user_code_id,@Param("offset") int offset,
		    @Param("pageSize") int pageSize);
	// 전체 카운트
	int fieldResHistoryCount(@Param("user_code_id") int user_code_id);
	
	
	// 운영자 소유 구장 수
	public int getMyStadiumCount(int user_code_id);

	// 오늘 예약 수
	public int getTodayReservationCount(int user_code_id);

	// 이번달 총 매출
	public int getMonthlyRevenue(int user_code_id);

	// 예약 승인 대기 건수
	public int getPendingApprovalCount(int user_code_id);

	// 최근 예약 5건
	public ArrayList<MatchDTO> getRecentReservationList(int user_code_id);
	
	
	
}