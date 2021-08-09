package com.electronicGuideCQ.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.electronicGuideCQ.entity.*;
import com.electronicGuideCQ.dao.*;
import com.electronicGuideCQ.service.*;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userDao;
	@Autowired
	private ScenicDistrictMapper scenicDistrictDao;

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

	@Override
	public int edit(User user) {
		// TODO Auto-generated method stub
		return userDao.edit(user);
	}

	@Override
	public boolean checkUserNameExist(String userName) {
		// TODO Auto-generated method stub
		int count=userDao.checkUserNameExist(userName);
		return count>0?true:false;
	}

	@Override
	public int add(User user) {
		// TODO Auto-generated method stub
		return userDao.add(user);
	}

	@Override
	public int selectCheckForInt(String userName, String sceDisName) {
		// TODO Auto-generated method stub
		return userDao.selectCheckForInt(userName,sceDisName);
	}

	@Override
	public List<User> selectCheckList(String userName, String sceDisName, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return userDao.selectCheckList(userName,sceDisName,(page-1)*rows, rows, sort, order);
	}

	@Override
	public int selectForInt(String userName, String sceDisName, Integer check) {
		// TODO Auto-generated method stub
		return userDao.selectForInt(userName,sceDisName,check);
	}

	@Override
	public List<User> selectList(String userName, String sceDisName, Integer check, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return userDao.selectList(userName,sceDisName,check,(page-1)*rows, rows, sort, order);
	}

	@Override
	public User getById(Integer id) {
		// TODO Auto-generated method stub
		return userDao.getById(id);
	}

	@Override
	public int checkById(Integer check, String resultStr, String content, Integer id) {
		// TODO Auto-generated method stub
		int count=userDao.updateCheckById(check,id);
		if(count>0) {
			/*
			MerchantMessage mm=new MerchantMessage();
			mm.setTitle(resultStr);
			mm.setContent(content);
			mm.setShopId(shopId);
			count=merchantMessageDao.add(mm);
			*/
		}
		return count;
	}

	@Override
	public User getEntity(String userName, String password) {
		// TODO Auto-generated method stub
		User whereUser=new User(userName,password);
		User user = userDao.get(whereUser);
		ScenicDistrict scenicDistrict = scenicDistrictDao.selectById(user.getSceDisId().toString());
		user.setScenicDistrict(scenicDistrict);
		return user;
	}
}
