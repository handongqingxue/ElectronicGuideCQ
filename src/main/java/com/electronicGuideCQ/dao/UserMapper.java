package com.electronicGuideCQ.dao;

import org.apache.ibatis.annotations.Param;

import com.electronicGuideCQ.entity.*;

public interface UserMapper {

	public User get(User user);

	public String getPwdByUserName(@Param("userName")String userName);

	public int updatePwdById(@Param("password")String password, @Param("id")Integer id);

	int edit(User user);

	public int checkUserNameExist(@Param("userName")String userName);

	public int add(User user);
}
