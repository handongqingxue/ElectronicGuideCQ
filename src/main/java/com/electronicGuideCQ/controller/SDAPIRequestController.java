package com.electronicGuideCQ.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.electronicGuideCQ.entity.User;
import com.electronicGuideCQ.service.UserService;

@Controller
@RequestMapping(SDAPIRequestController.MODULE_NAME)
public class SDAPIRequestController {

	@Autowired
	private UserService userService;
	public static final String MODULE_NAME="/background/sdApiRequest";

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

	@RequestMapping(value="/checkUserLogin")
	@ResponseBody
	public void checkUserLogin(HttpServletRequest request, HttpServletResponse response) {

		try {
			HttpSession session = request.getSession();
			System.out.println("sessionId2==="+session.getId());
			Object userObj = session.getAttribute("user");
			System.out.println("userObj==="+userObj);
			String jsonpCallback=null;
			if(userObj==null)
				jsonpCallback="jsonpCallback(\"{\\\"ifLogin\\\":\\\"no\\\"}\")";
			else {
				jsonpCallback="jsonpCallback(\"{\\\"ifLogin\\\":\\\"ok\\\"}\")";
			}
			response.getWriter().print(jsonpCallback);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
