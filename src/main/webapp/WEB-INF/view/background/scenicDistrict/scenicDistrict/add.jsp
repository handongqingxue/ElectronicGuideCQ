<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加景区</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.center_con_div{
	height: 90vh;
	margin-left:205px;
	position: absolute;
}
.page_location_div{
	height: 50px;
	line-height: 50px;
	margin-left: 20px;
	font-size: 18px;
}
.name_inp{
	width: 150px;
	height:30px;
}
.address_inp{
	width: 250px;
	height:30px;
}
.mapWidth_inp,.mapHeight_inp,.picWidth_inp,.picHeight_inp,.serverName_inp{
	width: 170px;
	height:30px;
}
.longitudeStart_inp,.longitudeEnd_inp,.latitudeStart_inp,.latitudeEnd_inp{
	width: 130px;
	height:30px;
}
.sort_inp{
	width: 100px;
	height:30px;
}
.upQrcodeBut_div,.upMapBut_div{
	width: 120px;
	height: 30px;
	line-height:30px;
	text-align:center;
	color:#fff;
	background-color: #1777FF;
	border-radius:5px;
}
.qrcodeUrl_img,.mapUrl_img{
	width: 180px;
	height:180px;
	margin-top: 10px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var scenicDistrictPath='<%=basePath%>'+"background/scenicDistrict/";
var shopId='${sessionScope.merchant.id }';
var dialogTop=10;
var dialogLeft=20;
var ndNum=0;
$(function(){
	initNewDialog();

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var ndpw=$("body").find(".panel.window").eq(ndNum);
	var ndws=$("body").find(".window-shadow").eq(ndNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(ndpw);
	ccDiv.append(ndws);
	ccDiv.css("width",setFitWidthInParent("body","center_con_div")+"px");
}

function initNewDialog(){
	dialogTop+=20;
	$("#new_div").dialog({
		title:"景区信息",
		width:setFitWidthInParent("body","new_div"),
		height:730,
		top:dialogTop,
		left:dialogLeft,
		buttons:[
           {text:"保存",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkAdd();
           }}
        ]
	});

	$("#new_div table").css("width",(setFitWidthInParent("body","new_div_table"))+"px");
	$("#new_div table").css("magin","-100px");
	$("#new_div table td").css("padding-left","50px");
	$("#new_div table td").css("padding-right","20px");
	$("#new_div table td").css("font-size","15px");
	$("#new_div table .td1").css("width","10%");
	$("#new_div table .td2").css("width","35%");
	$("#new_div table tr").css("border-bottom","#CAD9EA solid 1px");
	$("#new_div table tr").each(function(i){
		if(i==1)
			$(this).css("height","250px");
		else if(i==6)
			$(this).css("height","200px");
		else
			$(this).css("height","45px");
	});

	$(".panel.window").eq(ndNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ndNum).css("color","#000");
	$(".panel.window .panel-title").eq(ndNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ndNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ndNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ndNum).css("border-color","#ddd");

	$("#new_div #ok_but").css("left","45%");
	$("#new_div #ok_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

function checkAdd(){
	if(checkName()){
		if(checkAddress()){
			if(checkMapWidth()){
				if(checkMapHeight()){
					if(checkPicWidth()){
						if(checkPicHeight()){
							if(checkLongitudeStart()){
								if(checkLongitudeEnd()){
									if(checkLatitudeStart()){
										if(checkLatitudeEnd()){
											if(checkServerName()){
												if(checkIntroduce()){
													addScenicDistrict();
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

function addScenicDistrict(){
	var formData = new FormData($("#form1")[0]);
	$.ajax({
		type:"post",
		url:scenicDistrictPath+"addScenicDistrict",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.status==1){
				alert(data.msg);
				location.href=scenicDistrictPath+"scenicDistrict/list";
			}
			else{
				alert(data.msg);
			}
		}
	});
}

function focusName(){
	var name = $("#name").val();
	if(name=="景区名称不能为空"){
		$("#name").val("");
		$("#name").css("color", "#555555");
	}
}

//验证景区名称
function checkName(){
	var name = $("#name").val();
	if(name==null||name==""||name=="景区名称不能为空"){
		$("#name").css("color","#E15748");
    	$("#name").val("景区名称不能为空");
    	return false;
	}
	else
		return true;
}

function focusAddress(){
	var address = $("#address").val();
	if(address=="景区名称不能为空"){
		$("#address").val("");
		$("#address").css("color", "#555555");
	}
}

//验证景区地址
function checkAddress(){
	var address = $("#address").val();
	if(address==null||address==""||address=="景区名称不能为空"){
		$("#address").css("color","#E15748");
    	$("#address").val("景区地址不能为空");
    	return false;
	}
	else
		return true;
}

//验证地图显示宽度
function checkMapWidth(){
	var mapWidth = $("#mapWidth").val();
	if(mapWidth==null||mapWidth==""){
	  	alert("请输入地图显示宽度");
	  	return false;
	}
	else
		return true;
}

//验证地图显示高度
function checkMapHeight(){
	var mapHeight = $("#mapHeight").val();
	if(mapHeight==null||mapHeight==""){
	  	alert("请输入地图显示高度");
	  	return false;
	}
	else
		return true;
}

//验证地图图片宽度
function checkPicWidth(){
	var picWidth = $("#picWidth").val();
	if(picWidth==null||picWidth==""){
	  	alert("请输入地图图片宽度");
	  	return false;
	}
	else
		return true;
}

//验证地图图片高度
function checkPicHeight(){
	var picHeight = $("#picHeight").val();
	if(picHeight==null||picHeight==""){
	  	alert("请输入地图图片高度");
	  	return false;
	}
	else
		return true;
}

//验证开始经度
function checkLongitudeStart(){
	var longitudeStart = $("#longitudeStart").val();
	if(longitudeStart==null||longitudeStart==""){
	  	alert("请输入开始经度");
	  	return false;
	}
	else
		return true;
}

//验证结束经度
function checkLongitudeEnd(){
	var longitudeEnd = $("#longitudeEnd").val();
	if(longitudeEnd==null||longitudeEnd==""){
	  	alert("请输入结束经度");
	  	return false;
	}
	else
		return true;
}

//验证开始纬度
function checkLatitudeStart(){
	var latitudeStart = $("#latitudeStart").val();
	if(latitudeStart==null||latitudeStart==""){
	  	alert("请输入开始纬度");
	  	return false;
	}
	else
		return true;
}

//验证结束纬度
function checkLatitudeEnd(){
	var latitudeEnd = $("#latitudeEnd").val();
	if(latitudeEnd==null||latitudeEnd==""){
	  	alert("请输入结束纬度");
	  	return false;
	}
	else
		return true;
}

function focusServerName(){
	var serverName = $("#serverName").val();
	if(serverName=="服务器ip不能为空"){
		$("#serverName").val("");
		$("#serverName").css("color", "#555555");
	}
}

//验证服务器ip
function checkServerName(){
	var serverName = $("#serverName").val();
	if(serverName==null||serverName==""||serverName=="服务器ip不能为空"){
		$("#serverName").css("color","#E15748");
    	$("#serverName").val("服务器ip不能为空");
    	return false;
	}
	else
		return true;
}

function focusIntroduce(){
	var introduce = $("#introduce").val();
	if(introduce=="景区介绍不能为空"){
		$("#introduce").val("");
		$("#introduce").css("color", "#555555");
	}
}

//验证景区介绍
function checkIntroduce(){
	var introduce = $("#introduce").val();
	if(introduce==null||introduce==""||introduce=="景区介绍不能为空"){
		$("#introduce").css("color","#E15748");
    	$("#introduce").val("景区介绍不能为空");
    	return false;
	}
	else
		return true;
}

function uploadQrcodeUrl(){
	document.getElementById("qrcodeUrl_file").click();
}

function uploadMapUrl(){
	document.getElementById("mapUrl_file").click();
}

function showQrcodeUrl(obj){
	var file = $(obj);
    var fileObj = file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#qrcodeUrl_img");

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

function showMapUrl(obj){
	var file = $(obj);
    var fileObj = file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#mapUrl_img");

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

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "center_con_div":
		space=205;
		break;
	case "new_div":
		space=340;
		break;
	case "new_div_table":
	case "panel_window":
		space=355;
		break;
	}
	var width=$(parent).css("width");
	return width.substring(0,width.length-2)-space;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">	
<%@include file="../../side.jsp"%>
<div class="center_con_div" id="center_con_div">
	<div class="page_location_div">添加景区</div>
	
	<div id="new_div">
		<form id="form1" name="form1" method="post" action="" enctype="multipart/form-data">
		<table>
		  <tr>
			<td class="td1" align="right">
				名称
			</td>
			<td class="td2">
				<input type="text" class="name_inp" id="name" name="name" placeholder="请输入景区名称" onfocus="focusName()" onblur="checkName()"/>
			</td>
			<td class="td1" align="right">
				地址
			</td>
			<td class="td2">
				<input type="text" class="address_inp" id="address" name="address" placeholder="请输入景区地址" onfocus="focusAddress()" onblur="checkAddress()"/>
			</td>
		  </tr>
		  <tr>
			<td class="td1" align="right">
				二维码
			</td>
			<td class="td2">
				<div class="upQrcodeBut_div" onclick="uploadQrcodeUrl()">选择二维码</div>
				<input type="file" id="qrcodeUrl_file" name="qrcodeUrl_file" style="display: none;" onchange="showQrcodeUrl(this)"/>
				<img class="qrcodeUrl_img" id="qrcodeUrl_img" alt=""/>
			</td>
			<td class="td1" align="right">
				地图
			</td>
			<td class="td2">
				<div class="upMapBut_div" onclick="uploadMapUrl()">选择地图</div>
				<input type="file" id="mapUrl_file" name="mapUrl_file" style="display: none;" onchange="showMapUrl(this)"/>
				<img class="mapUrl_img" id="mapUrl_img" alt=""/>
			</td>
		  </tr>
		  <tr>
			<td class="td1" align="right">
				地图显示宽度
			</td>
			<td class="td2">
				<input type="number" class="mapWidth_inp" id="mapWidth" name="mapWidth" placeholder="请输入地图显示宽度"/>px
			</td>
			<td class="td1" align="right">
				地图显示长度
			</td>
			<td class="td2">
				<input type="number" class="mapHeight_inp" id="mapHeight" name="mapHeight" placeholder="请输入地图显示长度"/>px
			</td>
		  </tr>
		  <tr>
			<td class="td1" align="right">
				地图图片宽度
			</td>
			<td class="td2">
				<input type="number" class="picWidth_inp" id="picWidth" name="picWidth" placeholder="请输入地图图片宽度"/>px
			</td>
			<td class="td1" align="right">
				地图图片长度
			</td>
			<td class="td2">
				<input type="number" class="picHeight_inp" id="picHeight" name="picHeight" placeholder="请输入地图图片长度"/>px
			</td>
		  </tr>
		  <tr>
			<td class="td1" align="right">
				经度
			</td>
			<td class="td2">
				<input type="number" class="longitudeStart_inp" id="longitudeStart" name="longitudeStart" placeholder="请输入开始经度"/>
				-
				<input type="number" class="longitudeEnd_inp" id="longitudeEnd" name="longitudeEnd" placeholder="请输入结束经度"/>
			</td>
			<td class="td1" align="right">
				纬度
			</td>
			<td class="td2">
				<input type="number" class="latitudeStart_inp" id="latitudeStart" name="latitudeStart" placeholder="请输入开始纬度"/>
				-
				<input type="number" class="latitudeEnd_inp" id="latitudeEnd" name="latitudeEnd" placeholder="请输入结束纬度"/>
			</td>
		  </tr>
		  <tr>
			<td class="td1" align="right">
				服务器ip
			</td>
			<td class="td2">
				<input type="text" class="serverName_inp" id="serverName" name="serverName" placeholder="请输入服务器ip" onfocus="focusServerName()" onblur="checkServerName()"/>
			</td>
			<td class="td1" align="right">
				排序
			</td>
			<td class="td2">
				<input type="number" class="sort_inp" id="sort" name="sort" placeholder="请输入排序"/>
			</td>
		  </tr>
		  <tr>
			<td class="td1" align="right">
				景区介绍
			</td>
			<td class="td2">
				<textarea rows="8" cols="50" id="introduce" name="introduce" placeholder="请输入景区介绍" onfocus="focusIntroduce()" onblur="checkIntroduce()"></textarea>
			</td>
			<td class="td1" align="right">
			</td>
			<td class="td2">
			</td>
		  </tr>
		</table>
		</form>
	</div>
	<%@include file="../../foot.jsp"%>
	</div>
</div>
</body>
</html>