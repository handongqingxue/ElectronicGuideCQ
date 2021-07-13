package com.electronicGuideCQ.service;

import java.util.List;

import com.electronicGuideCQ.entity.*;

public interface ScenicDistrictService {

	int selectForInt(String name);

	List<ScenicDistrict> selectList(String name, int page, int rows, String sort, String order);

	ScenicDistrict selectById(String id);

}
