package com.electronicGuideCQ.service;

import java.util.List;

import com.electronicGuideCQ.entity.*;

public interface UserService {

	boolean checkPassWord(String password, String userName);

	int updatePwdById(String password, Integer id);

	int edit(User user);

	boolean checkUserNameExist(String userName);

	int add(User user);

	int selectForInt(String userName, String sceDisName, Integer check);

	List<User> selectList(String userName, String sceDisName, Integer check, int page, int rows, String sort, String order);

	User getById(Integer id);
}
