package com.electronicGuideCQ.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.electronicGuideCQ.dao.*;
import com.electronicGuideCQ.service.*;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userDao;

	@Override
	public boolean checkPassWord(String password, String userName) {
		// TODO Auto-generated method stub
		String pwd = userDao.getPwdByUserName(userName);
		if(pwd.equals(password)) {
			return true;
		}
		else
			return false;
	}

	@Override
	public int updatePwdById(String password, Integer id) {
		// TODO Auto-generated method stub
		return userDao.updatePwdById(password,id);
	}
}
