package com.electronicGuideCQ.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.electronicGuideCQ.service.*;
import com.electronicGuideCQ.entity.*;
import com.electronicGuideCQ.util.*;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(UserController.MODULE_NAME)
public class UserController {

	@Autowired
	private UserService userService;
	public static final String MODULE_NAME="/background/user";
	
	@RequestMapping(value="/info/info")
	public String goInfoInfo(HttpServletRequest request) {

		return MODULE_NAME+"/info/info";
	}
	
	@RequestMapping(value="/check/list")
	public String goCheckList(HttpServletRequest request) {

		return MODULE_NAME+"/check/list";
	}

	@RequestMapping(value="/check/detail")
	public String goCheckDetail(HttpServletRequest request) {

		Integer id = Integer.valueOf(request.getParameter("id"));
		User user = userService.getById(id);
		request.setAttribute("user", user);
		
		return MODULE_NAME+"/check/detail";
	}
	
	@RequestMapping(value="/all/list")
	public String goAllList(HttpServletRequest request) {

		return MODULE_NAME+"/all/list";
	}

	@RequestMapping(value="/all/detail")
	public String goAllDetail(HttpServletRequest request) {

		Integer id = Integer.valueOf(request.getParameter("id"));
		User user = userService.getById(id);
		request.setAttribute("user", user);
		
		return MODULE_NAME+"/all/detail";
	}
	
	@RequestMapping(value="/checkPassword")
	@ResponseBody
	public Map<String, Object> checkPassword(String password, String userName) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		boolean bool=userService.checkPassWord(password,userName);
		
		if(bool) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "????????????");
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/updatePwdById")
	@ResponseBody
	public String updatePwdById(String password) {
		User user=(User)SecurityUtils.getSubject().getPrincipal();
		Integer id = user.getId();
		int count = userService.updatePwdById(password,id);
		
		PlanResult plan=new PlanResult();
		if(count==0) {
			plan.setStatus(0);
		}
		else {
			plan.setStatus(1);
		}
		return JsonUtil.getJsonFromObject(plan);
	}
	
	@RequestMapping(value="/editUser",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String editUser(User user,
			@RequestParam(value="headImgUrl_inp",required=false) MultipartFile headImgUrl_inp,
			HttpServletRequest request) {

		String json=null;;
		try {
			PlanResult plan=new PlanResult();
			MultipartFile[] fileArr=new MultipartFile[1];
			fileArr[0]=headImgUrl_inp;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i].getSize()>0) {
					String folder=null;
					switch (i) {
					case 0:
						folder="UserHead";
						break;
					}
					jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],folder);
					JSONObject fileJson = JSONObject.fromObject(jsonStr);
					if("????".equals(fileJson.get("msg"))) {
						JSONObject dataJO = (JSONObject)fileJson.get("data");
						switch (i) {
						case 0:
							user.setHeadImgUrl(dataJO.get("src").toString());
							break;
						}
					}
				}
			
			}
			int count=userService.edit(user);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("??????????????????");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("????????????????????????????????????????????");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}
	
	@RequestMapping(value="/selectCheckList")
	@ResponseBody
	public Map<String, Object> selectCheckList(String userName,String sceDisName,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=userService.selectCheckForInt(userName,sceDisName);
		List<User> userList=userService.selectCheckList(userName,sceDisName, page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", userList);
			
		return jsonMap;
	}
	
	@RequestMapping(value="/selectList")
	@ResponseBody
	public Map<String, Object> selectList(String userName,String sceDisName,Integer check,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count=userService.selectForInt(userName,sceDisName,check);
		List<User> userList=userService.selectList(userName,sceDisName,check, page, rows, sort, order);

		jsonMap.put("total", count);
		jsonMap.put("rows", userList);
			
		return jsonMap;
	}

	@RequestMapping(value="/checkById")
	@ResponseBody
	public Map<String, Object> checkById(Integer check,String content,Integer id) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
    	String resultStr=null;
    	switch (check) {
			case User.SHEN_HE_TONG_GUO:
				resultStr="????????????";
				content="??????????????????????????????????????????????";
				break;
			case User.SHEN_HE_BU_HE_GE:
				resultStr="??????????????";
				break;
		}
		int count=userService.checkById(check,resultStr,content,id);
        if(count==0) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "??????????");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("message", resultStr);
        }
		return jsonMap;
	}
}
