package com.electronicGuideCQ.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.electronicGuideCQ.entity.*;
import com.electronicGuideCQ.util.*;

import net.sf.json.JSONObject;

import com.electronicGuideCQ.service.*;

@Controller
@RequestMapping(BackgroundController.MODULE_NAME)
public class BackgroundController {

	@Autowired
	private UtilService utilService;
	@Autowired
	private ScenicDistrictService scenicDistrictService;
	@Autowired
	private UserService userService;
	public static final String MODULE_NAME="/background";
	
	/**
	 * ��ת����¼ҳ��
	 * @return
	 */
	@RequestMapping(value="/goLogin",method=RequestMethod.GET)
	public String goLogin() {
		return MODULE_NAME+"/login";
	}

	/**
	 * ��ת��ע��ҳ��
	 * @return
	 */
	@RequestMapping(value="/regist",method=RequestMethod.GET)
	public String regist() {
		return MODULE_NAME+"/regist";
	}

	/**
	 * Ϊ��¼ҳ���ȡ��֤��
	 * @param session
	 * @param identity
	 * @param response
	 */
	@RequestMapping(value="/getKaptchaImage")
	public void getKaptchaImage(HttpSession session, String identity, HttpServletResponse response) {
		utilService.getKaptchaImage(session, identity, response);
	}

	/**
	 * ��̨�û���¼
	 * @param userName
	 * @param password
	 * @param rememberMe
	 * @param loginVCode
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String login(String userName,String password,
			String rememberMe,String loginVCode,HttpServletRequest request) {
		System.out.println("===��¼�ӿ�===");
		//����ֵ��json
		PlanResult plan=new PlanResult();
		HttpSession session=request.getSession();
		String verifyCode = (String) session.getAttribute("��֤��");
		System.out.println("verifyCode==="+verifyCode);
		System.out.println("loginVCode==="+loginVCode);
		if(verifyCode.equals(loginVCode)) {
			//TODO���⸽����ӵ�¼������Ϣ���裬���û����˺��Լ����봢�浽shiro��ܵĹ������õ��з��������ѯ
			try {
				System.out.println("��֤��һ��");
				UsernamePasswordToken token = new UsernamePasswordToken(userName,password);  
				Subject currentUser = SecurityUtils.getSubject();  
				if (!currentUser.isAuthenticated()){
					//ʹ��shiro����֤  
					token.setRememberMe(true);  
					currentUser.login(token);//��֤��ɫ��Ȩ��  
				}
			}catch (Exception e) {
				e.printStackTrace();
				plan.setStatus(1);
				plan.setMsg("��½ʧ��");
				return JsonUtil.getJsonFromObject(plan);
			}
			User user=(User)SecurityUtils.getSubject().getPrincipal();
			
			plan.setStatus(0);
			plan.setMsg("��֤ͨ��");
			session.setAttribute("user", user);
			System.out.println("sessionId==="+session.getId());
			String url=null;
			if("admin".equals(user.getUserName())) {
				url=request.getContextPath()+"/background/user/info/info";
			}
			else {
				String serverPath = scenicDistrictService.getServerPathById(user.getSceDisId());
				url=serverPath+"/background/loginFromCQ?serverPath="+serverPath+"&userName="+userName+"&password="+password;
			}
			plan.setUrl(url);
			return JsonUtil.getJsonFromObject(plan);
		}
		plan.setStatus(1);
		plan.setMsg("��֤�����");
		return JsonUtil.getJsonFromObject(plan);
	}
	
	@RequestMapping(value="/selectSceDisCBBList")
	@ResponseBody
	public Map<String, Object> selectSceDisCBBList() {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<ScenicDistrict> sdList=scenicDistrictService.selectList();

		if(sdList.size()==0) {
			jsonMap.put("message", "no");
		}
		else {
			jsonMap.put("message", "ok");
			jsonMap.put("data", sdList);
		}
		return jsonMap;
	}

	/**
	 * ��֤�û����Ƿ����
	 * @param userName
	 * @return
	 */
	@RequestMapping(value="/checkUserNameExist")
	@ResponseBody
	public Map<String, Object> checkUserNameExist(String userName) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		boolean bool=userService.checkUserNameExist(userName);
		if(bool) {
			jsonMap.put("status", "no");
			jsonMap.put("message", "�û�����ע��");
		}
		else {
			jsonMap.put("status", "ok");
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/addUser",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addUser(User user,
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
					if("�ɹ�".equals(fileJson.get("msg"))) {
						JSONObject dataJO = (JSONObject)fileJson.get("data");
						switch (i) {
						case 0:
							user.setHeadImgUrl(dataJO.get("src").toString());
							break;
						}
					}
				}
			}
			int count=userService.add(user);
			if(count==0) {
				plan.setStatus(0);
				plan.setMsg("ע���û���Ϣʧ�ܣ�");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(1);
				plan.setMsg("ע���û���Ϣ�ɹ���");
				json=JsonUtil.getJsonFromObject(plan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}

	@RequestMapping(value="/exit")
	public String exit(HttpSession session) {
		System.out.println("�˳��ӿ�");
		 Subject currentUser = SecurityUtils.getSubject();
	       currentUser.logout();    
		return "/background/login";
	}
}
