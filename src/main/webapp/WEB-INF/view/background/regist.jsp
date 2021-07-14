<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新用户注册</title>
<%@include file="js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>resource/css/background/regist.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
var scenicDistrictPath='<%=basePath%>'+"background/scenicDistrict/";
$(function(){
	initSceDisCBB();
});

function initSceDisCBB(){
	$.post(scenicDistrictPath+"selectCBBList",
		function(result){
			if(result.message=="ok"){
				var sceDisList=result.data;
				var sceDisCBB=$("#sceDis_cbb");
				for(var i=0;i<sceDisList.length;i++){
					var sceDis=sceDisList[i];
					sceDisCBB.append("<option value=\""+sceDis.id+"\">"+sceDis.name+"</option>");
				}
			}
		}
	,"json");
}
</script>
</head>
<body>
<div class="regist_div" id="regist_div">
	<div class="title_div">用户注册</div>
	<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
	<div class="main_div">
		<div class="left_div">
			<div class="attr_div">
				<input type="text" class="userName_inp" id="userName" name="userName" placeholder="请输入用户名" onfocus="focusUserName();" onblur="checkUserName();"/>
			</div>
			<div class="attr_div">
				<input type="password" class="password_inp" id="password" placeholder="请输入密码" onblur="checkPassword();"/>
				<input type="hidden" id="pwd_hid" name="password"/>
			</div>
			<div class="attr_div">
				<input type="password" class="password1_inp" id="password1" placeholder="请再次输入密码" onblur="checkPassword1();"/>
			</div>
			<div class="attr_div">
				<input type="text" class="nickName_inp" id="nickName" name="nickName" placeholder="请输入昵称" onfocus="focusNickName();" onblur="checkNickName();"/>
			</div>
			<div class="attr_div sceDis_div">
				<select class="sceDis_cbb" id="sceDis_cbb" name="sceDisId">
					<option value="">请选择景区</option>
				</select>
			</div>
		</div>
		<div class="right_div">
			<div class="headImgUrl_div">
				<div class="upHiuBut_div" onclick="uploadHeadImgUrl()">选择头像</div>
				<input type="file" id="headImgUrl_inp" name="headImgUrl_inp" style="display: none;" onchange="showHeadImgUrl(this)"/>
				<img class="headImgUrl_img" id="headImgUrl_img" alt="" src=""/>
			</div>
		</div>
		<div class="option_but_div">
			<div class="submitBut_div" onclick="checkForm();">立即提交</div>
			<div class="resetBut_div" onclick="reset();">重置</div>
		</div>
	</div>
	</form>
 	<div class="zjdl_div">已有账号？<a class="zjdl_a" href="<%=basePath%>merchant/login">直接登录</a></div>
</div>
</body>
</html>