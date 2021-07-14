package com.electronicGuideCQ.service;

import com.electronicGuideCQ.entity.*;

public interface UserService {

	boolean checkPassWord(String password, String userName);

	int updatePwdById(String password, Integer id);

	int edit(User user);

	boolean checkUserNameExist(String userName);

	int add(User user);
}
