package com.electronicGuideCQ.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.electronicGuideCQ.entity.User;
import com.electronicGuideCQ.service.UserService;
import com.electronicGuideCQ.util.JsonUtil;
import com.electronicGuideCQ.util.PlanResult;

@Controller
@RequestMapping(SDAPIRequestController.MODULE_NAME)
public class SDAPIRequestController {

	@Autowired
	private UserService userService;
	public static final String MODULE_NAME="/background/sdApiRequest";
	public static final String SERVER_PATH_CQ="http://www.qrcodesy.com:8080/ElectronicGuideCQ";

	@RequestMapping(value="/getUser")
	@ResponseBody
	public Map<String, Object> getUser(String userName, String password) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		User user=userService.getEntity(userName, password);
        if(user==null) {
        	jsonMap.put("status", "no");
        	jsonMap.put("message", "无此用户");
        }
        else {
        	jsonMap.put("status", "ok");
        	jsonMap.put("user", user);
        }
		return jsonMap;
	}
	
	@RequestMapping(value="/checkPassword")
	@ResponseBody
	public void checkPassword(String password, String userName, HttpServletRequest request, HttpServletResponse response) {
		
		try {
			String jsonpCallback=null;
			if(checkUserLogin(request)) {
				boolean bool=userService.checkPassWord(password,userName);
				if(bool) {
					jsonpCallback="jsonpCallback(\"{\\\"status\\\":\\\"ok\\\"}\")";
				}
				else {
					jsonpCallback="jsonpCallback(\"{\\\"status\\\":\\\"error\\\",\\\"message\\\":\\\"原密码错误！\\\"}\")";
				}
			}
			else {
				jsonpCallback="jsonpCallback(\"{\\\"status\\\":\\\"expire\\\",\\\"message\\\":\\\"登录信息失效，请重新登录！\\\",\\\"redirectUrl\\\":\\\""+SERVER_PATH_CQ+"/background/goLogin\\\"}\")";
			}
			response.getWriter().print(jsonpCallback);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/updatePwdById")
	@ResponseBody
	public void updatePwdById(String password, HttpServletRequest request, HttpServletResponse response) {
		try {
			String jsonpCallback=null;
			if(checkUserLogin(request)) {
				HttpSession session = request.getSession();
				User user=(User)session.getAttribute("user");
				Integer id = user.getId();
				int count = userService.updatePwdById(password,id);
				if(count==0) {
					jsonpCallback="jsonpCallback(\"{\\\"status\\\":\\\"error\\\",\\\"message\\\":\\\"修改密码失败！\\\"}\")";
				}
				else {
					jsonpCallback="jsonpCallback(\"{\\\"status\\\":\\\"ok\\\",\\\"message\\\":\\\"修改密码成功，重新登录生效！是否重新登录？\\\",\\\"redirectUrl\\\":\\\""+SERVER_PATH_CQ+"/background/goLogin\\\"}\")";
				}
			}
			else {
				jsonpCallback="jsonpCallback(\"{\\\"status\\\":\\\"expire\\\",\\\"message\\\":\\\"登录信息失效，请重新登录！\\\",\\\"redirectUrl\\\":\\\""+SERVER_PATH_CQ+"/background/goLogin\\\"}\")";
			}
			response.getWriter().print(jsonpCallback);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean checkUserLogin(HttpServletRequest request) {
		HttpSession session = request.getSession();
		System.out.println("sessionId2==="+session.getId());
		Object userObj = session.getAttribute("user");
		System.out.println("userObj==="+userObj);
		if(userObj==null)
			return false;
		else {
			return true;
		}
	}
}
