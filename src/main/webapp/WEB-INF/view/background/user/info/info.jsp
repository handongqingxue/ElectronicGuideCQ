<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户信息</title>
<%@include file="../../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>resource/css/background/user/info/info.css"/>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var userPath=path+"background/user/";
$(function(){
	$("#yhxx_div").css("width",setFitWidthInParent("body")+"px");
});

//验证原密码
function checkPassword(){
	var flag=false;
	var userName='${sessionScope.user.userName}';
	var password = $("#password").val();
	if(password==null||password==""){
		alert("原密码不能为空");
		flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post(userPath+"checkPassword",
			{password:MD5(password).toUpperCase(),userName:userName},
			function(data){
				if(data.status=="ok"){
					flag=true;
				}
				else{
					alert(data.message);
					flag=false;
				}
			}
		,"json");
	}
	return flag;
}

//验证新密码
function checkNewPwd(){
	var password = $("#password").val();
	var newPwd = $("#newPwd").val();
	if(newPwd==null||newPwd==""){
	  	alert("新密码不能为空");
	  	return false;
	}
	if(newPwd==password){
		alert("新密码不能和原密码一致！");
		return false;
	}
	else
		return true;
}

//验证确认密码
function checkNewPwd2(){
	var newPwd = $("#newPwd").val();
	var newPwd2 = $("#newPwd2").val();
	if(newPwd2==null||newPwd2==""){
	  	alert("确认密码不能为空");
	  	return false;
	}
	else if(newPwd!=newPwd2){
		alert("两次密码不一致！");
		return false;
	}
	else
		return true;
}

function focusNickName(){
	var shopName = $("#shopName").val();
	if(shopName=="公司名称不能为空"){
		$("#shopName").val("");
		$("#shopName").css("color", "#555555");
	}
}

//验证商家名称
function checkShopName(){
	var shopName = $("#shopName").val();
	if(shopName==null||shopName==""||shopName=="商家名称不能为空"){
		$("#shopName").css("color","#E15748");
    	$("#shopName").val("商家名称不能为空");
    	return false;
	}
	else
		return true;
}

function checkEditPwd(){
	if(checkPassword()){
		if(checkNewPwd()){
			if(checkNewPwd2()){
				var password = $("#newPwd").val();
				$.post(userPath+"updatePwdById",
					{password:MD5(password).toUpperCase()},
					function(result){
						var json=JSON.parse(result);
						if(json.status==1){
							$.messager.defaults.ok = "是";
						    $.messager.defaults.cancel = "否";
						    $.messager.defaults.width = 350;//更改消息框宽度
						    $.messager.confirm(
						    	"提示",
						    	"修改密码成功，重新登录生效！是否重新登录？"
						        ,function(r){    
						            if (r){    
						            	location.href=path+"background/exit";
						            }
						        }); 
						}
						else{
							$.messager.alert("提示","修改密码失败","warning");
						}
					}
				);
			}
		}
	}
}

function openEditPwdDialog(flag){
	$("#editPwdBg_div").css("display",flag==1?"block":"none");
}

function openEditUserDialog(flag){
	$("#editUserBg_div").css("display",flag==1?"block":"none");
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
	
function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-310;
}
</script>
</head>
<body>
<div class="editPwdBg_div" id="editPwdBg_div">
	<div class="editPwd_div">
		<div>
			<span class="close_span" onclick="openEditPwdDialog(0)">×</span>
		</div>
		<h4 class="title">修改密码</h4>
		<div class="ymm_div">
			<input type="password" id="password" placeholder="原密码"/>
		</div>
		<div class="xmm_div">
			<input type="password" id="newPwd" placeholder="新密码"/>
		</div>
		<div class="qrmm_div">
			<input type="password" id="newPwd2" placeholder="确认密码"/>
		</div>
		<div class="confirm_div" onclick="checkEditPwd()">确定</div>
		<div class="warn_div">注意：密码修改后需要重新登录系统</div>
	</div>
</div>

<div class="editUserBg_div" id="editUserBg_div">
	<div class="editUser_div" id="editUser_div">
		<div>
			<span class="close_span" onclick="openEditUserDialog(0)">×</span>
		</div>
		<h4 class="title">用户信息</h4>
		<form id="form1" name="form1" method="post" enctype="multipart/form-data">
		<input type="hidden" id="id" name="id" value="${sessionScope.merchant.id }">
		<div class="nickName_div">
			<span>昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称</span>
			<input type="text" id="shopName" name="shopName" value="${sessionScope.merchant.shopName }" onfocus="focusNickName()" onblur="checkShopName()"/>
		</div>
		<div class="headImgUrl_div">
			<span>头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像</span>
			<div class="img_div">
				<div class="upHiuBut_div" onclick="uploadHeadImgUrl()">选择头像</div>
				<input type="file" id="headImgUrl_inp" name="headImgUrl_inp" style="display: none;" onchange="showHeadImgUrl(this)"/>
				<img class="headImgUrl_img" id="headImgUrl_img" alt="" src="${sessionScope.merchant.headImgUrl }">
			</div>
		</div>
		</form>
		<div class="but_div">
			<button class="but cancel_but" onclick="openEditUserDialog(0)">取消</button>
			<button class="but submit_but" onclick="checkEditMerchant()">提交</button>
		</div>
	</div>
</div>

<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
	<div class="yhxx_div" id="yhxx_div">
		<div class="title_div">用户信息</div>
		<div class="attr_div">
			<span class="key_span">账&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</span>
			<span class="value_span">${sessionScope.user.userName }</span>
		</div>
		<div class="attr_div">
			<span class="key_span">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</span>
			<span class="value_span">已设置</span>
			<span class="xgmm_span" onclick="openEditPwdDialog(1)">修改密码</span>
		</div>
		<div class="attr_div">
			<span class="key_span">昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</span>
			<span class="value_span">${sessionScope.user.nickName }</span>
		</div>
		<div class="attr_div">
			<span class="key_span">头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像：</span>
			<img alt="" src="${sessionScope.user.headImgUrl }">
		</div>
		<div class="attr_div">
			<span class="key_span">创&nbsp;&nbsp;建&nbsp;&nbsp;&nbsp;时&nbsp;&nbsp;间：</span>
			<span class="value_span">${sessionScope.user.createTime }</span>
		</div>
		<div class="attr_div">
			<span class="eu_but_span" onclick="openEditUserDialog(1)">修改用户信息</span>
		</div>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>