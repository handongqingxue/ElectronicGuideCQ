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
var backgroundPath='<%=basePath%>'+"background/";
$(function(){
	initSceDisCBB();
});

function initSceDisCBB(){
	$.post(backgroundPath+"selectSceDisCBBList",
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

function focusUserName(){
	var userName = $("#userName").val();
	if(userName=="用户名不能为空"||userName=="用户名已注册"){
		$("#userName").val("");
		$("#userName").css("color", "#555555");
	}
}

//验证用户名
function checkUserName(){
	var flag=false;
	var userName = $("#userName").val();
	if(userName==null||userName==""||userName=="用户名不能为空"){
		$("#userName").css("color","#E15748");
    	$("#userName").val("用户名不能为空");
    	flag=false;
	}
	else if(userName=="用户名已注册"){
		$("#userName").css("color","#E15748");
    	$("#userName").val("用户名已注册");
    	flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post(backgroundPath+"checkUserNameExist",
			{userName:userName},
			function(data){
				if(data.status=="ok"){
					flag=true;
				}
				else{
					$("#userName").css("color","#E15748");
			    	$("#userName").val(data.message);
			    	flag=false;
				}
			}
		,"json");
	}
	return flag;
}

function checkPassword(){
	var password=$("#password").val();
	if(password==null||password==""||password=="请输入密码"){
		alert("请输入密码");
		return false;
	}
	else
		return true;
}

function checkPassword1(){
	var password=$("#password").val();
	var password1=$("#password1").val();
	if(password1==null||password1==""||password1=="请输入确认密码"){
		alert("请输入确认密码");
		return false;
	}
	if(password!=password1){
		alert("两次密码不一致");
		return false;
	}
	else
		return true;
}

function focusNickName(){
	var nickName = $("#nickName").val();
	if(nickName=="昵称不能为空"){
		$("#nickName").val("");
		$("#nickName").css("color", "#555555");
	}
}

//验证昵称
function checkNickName(){
	var nickName = $("#nickName").val();
	if(nickName==null||nickName==""||nickName=="昵称不能为空"){
		$("#nickName").css("color","#E15748");
    	$("#nickName").val("昵称不能为空");
		return false;
	}
	else
		return true;
}

function checkSceDisId(){
	var sceDisId = $("#sceDis_cbb").val();
	if(sceDisId==null||sceDisId==""){
    	alert("请选择所属景区");
    	return false;
	}
	else
		return true;
}

function checkForm(){
	if(checkUserName()){
		if(checkPassword()){
			if(checkPassword1()){
				if(checkNickName()){
					if(checkSceDisId()){
						addUser();
					}
				}
			}
		}
	}
}

function addUser(){
	$("#pwd_hid").val(MD5($("#password").val()).toUpperCase());
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:backgroundPath+"addUser",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.status==1){
				alert(data.msg);
				location.href=backgroundPath+"/background/login";
			}
			else{
				alert(data.msg);
			}
		}
	});
}

function reset(){
	$("#userName").val("");
	$("#password").val("");
	$("#password1").val("");
	$("#nickName").val("");
}

function uploadHeadImgUrl(){
	document.getElementById("headImgUrl_inp").click();
}

function showHeadImgUrl(obj){
	var file = $(obj);
    var fileObj = file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#headImgUrl_img");

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);
    } else {
        dataURL = $file.val();
        var imgObj = document.getElementById("preview");
        // 两个坑:
        // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
        // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
        imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;

    }
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