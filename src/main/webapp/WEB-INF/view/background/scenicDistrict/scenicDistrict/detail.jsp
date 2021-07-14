<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>景区详情</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.center_con_div{
	height: 90vh;
	margin-left:205px;
	overflow-y: scroll;
	position: absolute;
}
.page_location_div{
	height: 50px;
	line-height: 50px;
	margin-left: 20px;
	font-size: 18px;
}
.qrcodeUrl_img,.mapUrl_img{
	width: 180px;
	height:180px;
	margin-top: 10px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var tradePath='<%=basePath%>'+"background/trade/";
var dialogTop=10;
var dialogLeft=20;
var ddNum=0;
$(function(){
	initDetailDialog();

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var ddpw=$("body").find(".panel.window").eq(ddNum);
	var ddws=$("body").find(".window-shadow").eq(ddNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(ddpw);
	ccDiv.append(ddws);
	ccDiv.css("width",setFitWidthInParent("body","center_con_div")+"px");
}

function initDetailDialog(){
	dialogTop+=20;
	$("#detail_div").dialog({
		title:"行业信息",
		width:setFitWidthInParent("body","detail_div"),
		height:730,
		top:dialogTop,
		left:dialogLeft
	});

	$("#detail_div table").css("width",(setFitWidthInParent("body","detail_div_table"))+"px");
	$("#detail_div table").css("magin","-100px");
	$("#detail_div table td").css("padding-left","50px");
	$("#detail_div table td").css("padding-right","20px");
	$("#detail_div table td").css("font-size","15px");
	$("#detail_div table .td1").css("width","10%");
	$("#detail_div table .td2").css("width","35%");
	$("#detail_div table tr").css("border-bottom","#CAD9EA solid 1px");
	$("#detail_div table tr").each(function(i){
		if(i==1)
			$(this).css("height","250px");
		else if(i==4)
			$(this).css("height","200px");
		else
			$(this).css("height","45px");
	});

	$(".panel.window").eq(ddNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ddNum).css("color","#000");
	$(".panel.window .panel-title").eq(ddNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ddNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ddNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ddNum).css("border-color","#ddd");
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "center_con_div":
		space=205;
		break;
	case "detail_div":
		space=340;
		break;
	case "detail_div_table":
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
		<div class="page_location_div">行业详情</div>
		
		<div id="detail_div">
			<input type="hidden" name="id" value="${requestScope.scenicDistrict.id }"/>
			<table>
			  <tr>
				<td class="td1">
					名称
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.name }</span>
				</td>
				<td class="td1" align="right">
					地址
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.address }</span>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					二维码
				</td>
				<td class="td2">
					<img class="qrcodeUrl_img" id="qrcodeUrl_img" alt="" src="${requestScope.scenicDistrict.qrcodeUrl }"/>
				</td>
				<td class="td1" align="right">
					地图
				</td>
				<td class="td2">
					<img class="mapUrl_img" id="mapUrl_img" alt="" src="${requestScope.scenicDistrict.mapUrl }"/>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					地图显示宽度
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.mapWidth }</span>
				</td>
				<td class="td1" align="right">
					地图显示长度
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.mapHeight }</span>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					地图图片宽度
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.picWidth }</span>
				</td>
				<td class="td1" align="right">
					地图图片长度
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.picHeight }</span>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					景区介绍
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.introduce }</span>
				</td>
				<td class="td1" align="right">
					排序
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.sort }</span>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					创建时间
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.createTime }</span>
				</td>
				<td class="td1" align="right">
					修改时间
				</td>
				<td class="td2">
					<span>${requestScope.scenicDistrict.modifyTime }</span>
				</td>
			  </tr>
			</table>
		</div>
		<%@include file="../../foot.jsp"%>
	</div>
</div>
</body>
</html>