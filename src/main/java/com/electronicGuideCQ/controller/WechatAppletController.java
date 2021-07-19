package com.electronicGuideCQ.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.electronicGuideCQ.entity.*;
import com.electronicGuideCQ.service.*;

@Controller
@RequestMapping(WechatAppletController.MODULE_NAME)
public class WechatAppletController {

	@Autowired
	private ScenicDistrictService scenicDistrictService;
	public static final String MODULE_NAME="/wechatApplet";

	@RequestMapping(value="/selectSceDisById")
	@ResponseBody
	public Map<String, Object> selectSceDisById(String id) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		ScenicDistrict scenicDistrict = scenicDistrictService.selectById(id);

		if(scenicDistrict==null) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "¾°Çø²»´æÔÚ");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("sceDis", scenicDistrict);
		}
		return jsonMap;
	}
}
