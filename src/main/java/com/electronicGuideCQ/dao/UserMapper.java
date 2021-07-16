package com.electronicGuideCQ.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.electronicGuideCQ.entity.*;

public interface UserMapper {

	public User get(User user);

	public String getPwdByUserName(@Param("userName")String userName);

	public int updatePwdById(@Param("password")String password, @Param("id")Integer id);

	int edit(User user);

	public int checkUserNameExist(@Param("userName")String userName);

	public int add(User user);

	public int selectCheckForInt(@Param("userName")String userName, @Param("sceDisName")String sceDisName);

	public List<User> selectCheckList(@Param("userName")String userName, @Param("sceDisName")String sceDisName, @Param("start")int start, @Param("rows")int rows, String sort, String order);

	public int selectForInt(@Param("userName")String userName, @Param("sceDisName")String sceDisName, @Param("check")Integer check);

	public List<User> selectList(@Param("userName")String userName, @Param("sceDisName")String sceDisName, @Param("check")Integer check, @Param("start")int start, @Param("rows")int rows, String sort, String order);

	public User getById(@Param("id")Integer id);

	int updateCheckById(@Param("check")Integer check, @Param("id")Integer id);
}
