package com.electronicGuideCQ.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.electronicGuideCQ.entity.*;
import com.electronicGuideCQ.service.*;

@Controller
@RequestMapping(ScenicDistrictController.MODULE_NAME)
public class ScenicDistrictController {

	@Autowired
	private ScenicDistrictService scenicDistrictService;
	public static final String MODULE_NAME="/background/scenicDistrict";
	
	@RequestMapping(value="/scenicDistrict/list")
	public String goScenicDistrictList(HttpServletRequest request) {

		return MODULE_NAME+"/scenicDistrict/list";
	}
	
	@RequestMapping(value="/selectList")
	@ResponseBody
	public Map<String, Object> selectList(String name,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=scenicDistrictService.selectForInt(name);
		List<ScenicDistrict> sdList=scenicDistrictService.selectList(name, page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", sdList);
			
		return jsonMap;
	}
}
