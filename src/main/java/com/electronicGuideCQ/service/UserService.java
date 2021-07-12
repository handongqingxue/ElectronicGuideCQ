package com.electronicGuideCQ.service;

public interface UserService {

	boolean checkPassWord(String password, String userName);

	int updatePwdById(String password, Integer id);
}
