package com.electronicGuideCQ.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.electronicGuideCQ.service.*;
import com.electronicGuideCQ.entity.*;
import com.electronicGuideCQ.util.*;
import com.electronicGuideCQ.controller.UserController;
import com.electronicGuideCQ.entity.User;

@Controller
@RequestMapping(UserController.MODULE_NAME)
public class UserController {

	@Autowired
	private UserService userService;
	public static final String MODULE_NAME="/background/user";
	
	@RequestMapping(value="/info/info")
	public String goUserInfoInfo(HttpServletRequest request) {

		return MODULE_NAME+"/info/info";
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
			jsonMap.put("message", "‘≠√‹¬Î¥ÌŒÛ£°");
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
}
