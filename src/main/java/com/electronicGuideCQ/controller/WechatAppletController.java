package com.electronicGuideCQ.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
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
			jsonMap.put("message", "����������");
		}
		else {
			jsonMap.put("status", "ok");
			jsonMap.put("sceDis", scenicDistrict);
		}
		return jsonMap;
	}

	@RequestMapping(value="/requestSDApi")
	@ResponseBody
	public Map<String, Object> requestSDApi(String url) {

		Map<String, Object> resultMap = null;
		try {
			resultMap=JSON.parseObject(getRespJson(url, null).get("result").toString(), Map.class);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultMap;
	}
	
	public Map<String, Object> getRespJson(String url,List<NameValuePair> params) throws Exception {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		// TODO Auto-generated method stub
		//POST��URL
		//����HttpPost����
		HttpPost httppost=new HttpPost(url);
		//��Ӳ���
		if(params!=null)
			httppost.setEntity(new UrlEncodedFormEntity(params,HTTP.UTF_8));
		//���ñ���
		HttpResponse response=new DefaultHttpClient().execute(httppost);
		//����Post,������һ��HttpResponse����
		if(response.getStatusLine().getStatusCode()==200){//���״̬��Ϊ200,������������
		String result=EntityUtils.toString(response.getEntity());
		//�õ����ص��ַ���,��ӡ���
	//	System.out.println(result);
		jsonMap.put("result", result);
		}
		return jsonMap;
	}
}
