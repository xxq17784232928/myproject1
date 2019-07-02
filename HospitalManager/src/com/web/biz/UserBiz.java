package com.web.biz;

import org.apache.ibatis.annotations.Param;

import com.web.entity.TUser;

public interface UserBiz {

	/**
	 * 根据用户名和密码登录查询
	 * @param userName
	 * @param userPwd
	 * @return
	 */
	public TUser login(@Param("userName") String userName,@Param("userPwd") String userPwd);

}
