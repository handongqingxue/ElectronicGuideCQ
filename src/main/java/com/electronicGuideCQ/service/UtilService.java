package com.electronicGuideCQ.service;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public interface UtilService {
	public void getKaptchaImageByMerchant(HttpSession session, String identity, HttpServletResponse response);
}