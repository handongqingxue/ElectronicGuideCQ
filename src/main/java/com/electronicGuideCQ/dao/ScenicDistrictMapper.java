package com.electronicGuideCQ.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.electronicGuideCQ.entity.ScenicDistrict;

public interface ScenicDistrictMapper {

	int selectForInt(@Param("name")String name);

	List<ScenicDistrict> selectList(@Param("name")String name, @Param("start")int start, @Param("rows")int rows, String sort, String order);

	ScenicDistrict selectById(@Param("id")String id);

}
