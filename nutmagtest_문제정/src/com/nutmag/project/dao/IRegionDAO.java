package com.nutmag.project.dao;

import java.util.ArrayList;

import com.nutmag.project.dto.CityDTO;
import com.nutmag.project.dto.RegionDTO;

public interface IRegionDAO
{
	public ArrayList<RegionDTO> regionList();
	public ArrayList<CityDTO> cityList(int region);
}
