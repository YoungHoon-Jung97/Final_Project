package com.nutmeg.project.dao;

import java.util.ArrayList;

import com.nutmeg.project.dto.CityDTO;
import com.nutmeg.project.dto.RegionDTO;

public interface IRegionDAO
{
	public ArrayList<RegionDTO> regionList();

	public ArrayList<CityDTO> cityList();

	

}
