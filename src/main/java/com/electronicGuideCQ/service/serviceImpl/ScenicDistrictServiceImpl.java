package com.electronicGuideCQ.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.electronicGuideCQ.dao.*;
import com.electronicGuideCQ.entity.*;
import com.electronicGuideCQ.service.*;

@Service
public class ScenicDistrictServiceImpl implements ScenicDistrictService {

	@Autowired
	private ScenicDistrictMapper scenicDistrictDao;
	
	@Override
	public int selectForInt(String name) {
		// TODO Auto-generated method stub
		return scenicDistrictDao.selectForInt(name);
	}

	@Override
	public List<ScenicDistrict> selectList(String name, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return scenicDistrictDao.selectList(name, (page-1)*rows, rows, sort, order);
	}

}