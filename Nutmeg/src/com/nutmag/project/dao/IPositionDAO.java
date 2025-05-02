package com.nutmag.project.dao;

import java.util.ArrayList;

import javax.swing.text.Position;

import com.nutmag.project.dto.PositionDTO;



public interface IPositionDAO
{
	//포지션 정보 출력
	public ArrayList<PositionDTO> positionList();
	
}
