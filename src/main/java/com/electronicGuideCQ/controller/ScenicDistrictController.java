package com.electronicGuideCQ.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.electronicGuideCQ.entity.*;
import com.electronicGuideCQ.service.*;
import com.electronicGuideCQ.util.*;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(ScenicDistrictController.MODULE_NAME)
public class ScenicDistrictController {

	@Autowired
	private ScenicDistrictService scenicDistrictService;
	public static final String MODULE_NAME="/background/scenicDistrict";
	
	@RequestMapping(value="/scenicDistrict/add")
	public String goScenicDistrictAdd(HttpServletRequest request) {

		return MODULE_NAME+"/scenicDistrict/add";
	}

	@RequestMapping(value="/scenicDistrict/edit")
	public String goScenicDistrictEdit(HttpServletRequest request) {
		
		ScenicDistrict sd = scenicDistrictService.selectById(request.getParameter("id"));
		request.setAttribute("scenicDistrict", sd);
		
		return MODULE_NAME+"/scenicDistrict/edit";
	}
	
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

	@RequestMapping(value="/addScenicDistrict",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addScenicDistrict(ScenicDistrict scenicDistrict,
			@RequestParam(value="qrcodeUrl_file",required=false) MultipartFile qrcodeUrl_file,
			@RequestParam(value="mapUrl_file",required=false) MultipartFile mapUrl_file,
			HttpServletRequest request) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			MultipartFile[] fileArr=new MultipartFile[2];
			fileArr[0]=qrcodeUrl_file;
			fileArr[1]=mapUrl_file;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i].getSize()>0) {
					String folder=null;
					switch (i) {
					case 0:
						folder="qrcode";
						break;
					case 1:
						folder="map";
						break;
					}
					jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],folder);
					JSONObject fileJson = JSONObject.fromObject(jsonStr);
					if("成功".equals(fileJson.get("msg"))) {
						JSONObject dataJO = (JSONObject)fileJson.get("data");
						switch (i) {
						case 0:
							scenicDistrict.setQrcodeUrl(dataJO.get("src").toString());
							break;
						case 1:
							scenicDistrict.setMapUrl(dataJO.get("src").toString());
							break;
						}
					}
				}
			}
			int count=scenicDistrictService.add(scenicDistrict);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("添加景区失败！");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("添加景区成功！");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}

	@RequestMapping(value="/editScenicDistrict",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String editTrade(ScenicDistrict scenicDistrict,
			@RequestParam(value="qrcodeUrl_file",required=false) MultipartFile qrcodeUrl_file,
			@RequestParam(value="mapUrl_file",required=false) MultipartFile mapUrl_file,
			HttpServletRequest request) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			MultipartFile[] fileArr=new MultipartFile[2];
			fileArr[0]=qrcodeUrl_file;
			fileArr[1]=mapUrl_file;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i].getSize()>0) {
					String folder=null;
					switch (i) {
					case 0:
						folder="qrcode";
						break;
					case 1:
						folder="map";
						break;
					}
					jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],folder);
					JSONObject fileJson = JSONObject.fromObject(jsonStr);
					if("成功".equals(fileJson.get("msg"))) {
						JSONObject dataJO = (JSONObject)fileJson.get("data");
						switch (i) {
						case 0:
							scenicDistrict.setQrcodeUrl(dataJO.get("src").toString());
							break;
						case 1:
							scenicDistrict.setMapUrl(dataJO.get("src").toString());
							break;
						}
					}
				}
			}
			int count=scenicDistrictService.edit(scenicDistrict);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("编辑景区失败！");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("编辑景区成功！");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}
}
