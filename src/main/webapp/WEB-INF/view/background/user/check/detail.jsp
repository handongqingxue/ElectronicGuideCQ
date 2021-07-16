<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户详情</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.center_con_div{
	width: 100%;
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

.yhsh_bg_div{
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,.45);
	position: fixed;
	z-index: 9016;
	display:none;
}
.yhsh_div{
	width: 500px;
	height: 550px;
	margin: 100px auto 0;
	background-color: #fff;
	border-radius:5px;
	position: absolute;
	left: 0;
	right: 0;
}
.yhsh_div .title_div{
	width: 100%;
	height: 50px;
	line-height: 50px;
	border-bottom: #eee solid 1px;
}
.yhsh_div .title_span{
	margin-left: 30px;
}
.yhsh_div .close_span{
	float: right;
	margin-right: 30px;
	cursor: pointer;
}
.yhsh_dialog_div{
	width: 500px;
	height: 500px;
	position: absolute;
}
.yhsh_div .location_div{
	width: 100%;
	height: 50px;
	line-height: 50px;
}
.yhsh_div .location_span{
	margin-left: 30px;
}
.yhsh_jbsxz_dialog_div .title_div{
	height:50px;
	line-height:50px;
	margin-left: 20px;
}
.yhsh_jbsxz_dialog_div .content_ta{
	width: 380px;
	height:225px;
	margin-left: 20px;
	font-size:15px;
}

.headImgUrl_img{
	width: 180px;
	height:180px;
	margin-top: 10px;
}
</style>
<script type="text/javascript">
var path='<%=basePath %>';
var userPath='<%=basePath%>'+"background/user/";
var id='${requestScope.user.id }';
var dialogTop=10;
var dialogLeft=20;
var ddNum=0;
var yhshjbsxzdNum=1;
$(function(){
	initDetailDialog();
	initYHSHJBSXZDialog();//审核不通过窗口

	initDialogPosition();//将不同窗体移动到主要内容区域
});

function initDialogPosition(){
	//基本属性组
	var ddpw=$("body").find(".panel.window").eq(ddNum);
	var ddws=$("body").find(".window-shadow").eq(ddNum);

	//审核用户
	var dyhshjbsxdpw=$("body").find(".panel.window").eq(yhshjbsxzdNum);
	var dyhshjbsxdws=$("body").find(".window-shadow").eq(yhshjbsxzdNum);

	var ccDiv=$("#center_con_div");
	ccDiv.append(ddpw);
	ccDiv.append(ddws);

	var dyhshdDiv=$("#yhsh_dialog_div");
	dyhshdDiv.append(dyhshjbsxdpw);
	dyhshdDiv.append(dyhshjbsxdws);
}

function initDetailDialog(){
	dialogTop+=20;
	$("#detail_div").dialog({
		title:"用户详情",
		width:setFitWidthInParent("body","detail_div"),
		height:460,
		top:dialogTop,
		left:dialogLeft,
		buttons:[
           {text:"审核通过",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkById(1,id);
           }},
           {text:"审核不通过",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   openDetailYHSHDialog(1);
           }}
        ]
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
		$(this).css("height",(i==2?220:45)+"px");
	});

	$(".panel.window").eq(ddNum).css("margin-top","20px");
	$(".panel.window .panel-title").eq(ddNum).css("color","#000");
	$(".panel.window .panel-title").eq(ddNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(ddNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(ddNum).css("margin-top","20px");
	$(".window,.window .window-body").eq(ddNum).css("border-color","#ddd");

	$("#detail_div #ok_but").css("left","30%");
	$("#detail_div #ok_but").css("position","absolute");
	$("#detail_div #cancel_but").css("left","45%");
	$("#detail_div #cancel_but").css("position","absolute");
	
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

function initYHSHJBSXZDialog(){
	detailYHSHDialog=$("#yhsh_jbsxz_dialog_div").dialog({
		title:"审核不通过",
		width:setFitWidthInParent("#yhsh_div","yhsh_jbsxz_dialog_div"),
		height:410,
		top:10,
		left:20,
		buttons:[
           {text:"取消",id:"cancel_but",iconCls:"icon-cancel",handler:function(){
        	   openDetailYHSHDialog(0);
           }},
           {text:"提交",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkById(2,id);
           }}
        ]
	});
	
	$(".panel.window").eq(yhshjbsxzdNum).css("margin-top","40px");
	$(".panel.window .panel-title").eq(yhshjbsxzdNum).css("color","#000");
	$(".panel.window .panel-title").eq(yhshjbsxzdNum).css("font-size","15px");
	$(".panel.window .panel-title").eq(yhshjbsxzdNum).css("padding-left","10px");
	
	$(".panel-header, .panel-body").eq(yhshjbsxzdNum).css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").eq(yhshjbsxzdNum).css("margin-top","40px");
	$(".window,.window .window-body").eq(yhshjbsxzdNum).css("border-color","#ddd");

	$("#yhsh_jbsxz_dialog_div #cancel_but").css("left","20%");
	$("#yhsh_jbsxz_dialog_div #cancel_but").css("position","absolute");

	$("#yhsh_jbsxz_dialog_div #ok_but").css("left","50%");
	$("#yhsh_jbsxz_dialog_div #ok_but").css("position","absolute");
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
	//openDetailYHSHJBSXZDialog(0);
}

function openDetailYHSHDialog(flag){
	if(flag==1){
		$("#yhsh_bg_div").css("display","block");
	}
	else{
		$("#yhsh_bg_div").css("display","none");
	}
	openDetailYHSHJBSXZDialog(flag);
}

function openDetailYHSHJBSXZDialog(flag){
	if(flag==1){
		detailYHSHDialog.dialog("open");
	}
	else{
		detailYHSHDialog.dialog("close");
	}
}

function checkById(check,id){
	var content;
	if(check==2){
		content=$("#content").val();
	}
	$.post(userPath+"checkById",
		{check:check,content:content,id:id},
		function(data){
			if(data.status=="ok"){
				alert(data.message);
				location.href=userPath+"check/list";
			}
			else{
				alert(data.message);
			}
		}
	,"json");
}

function setFitWidthInParent(parent,self){
	var space=0;
	switch (self) {
	case "detail_div":
		space=340;
		break;
	case "detail_div_table":
	case "panel_window":
		space=355;
		break;
	case "yhsh_jbsxz_dialog_div":
		space=50;
		break;
	}
	var width=$(parent).css("width");
	return width.substring(0,width.length-2)-space;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">	
	<!-- 审核不通过 start -->
	<div class="yhsh_bg_div" id="yhsh_bg_div">
		<div class="yhsh_div" id="yhsh_div">
			<div class="title_div">
				<span class="title_span">审核用户</span>
				<span class="close_span" onclick="openDetailYHSHDialog(0)">X</span>
			</div>
			<div class="yhsh_dialog_div" id="yhsh_dialog_div">
				<div class="location_div">
					<span class="location_span">用户审核-用户详情-审核</span>
				</div>
				<div class="yhsh_jbsxz_dialog_div" id="yhsh_jbsxz_dialog_div">
					 <div class="title_div">不通过原因</div>
					<textarea rows="5" cols="10" class="content_ta" id="content"></textarea>
				</div>
			</div>
		</div>
	</div>

	<%@include file="../../side.jsp"%>
	<div class="center_con_div" id="center_con_div">
		<div class="page_location_div">用户详情</div>
		
		<div id="detail_div">
			<table>
			  <tr>
				<td class="td1" align="right">
					用户名
				</td>
				<td class="td2">
					<span>${requestScope.user.userName }</span>
				</td>
				<td class="td1" align="right">
					昵称
				</td>
				<td class="td2">
					<span>${requestScope.user.nickName }</span>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					所属景区
				</td>
				<td class="td2">
					<span>${requestScope.user.sceDisName }</span>
				</td>
				<td class="td1" align="right">
					景区地址
				</td>
				<td class="td2">
					<span>${requestScope.user.sceDisAddress }</span>
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					用户头像
				</td>
				<td class="td2">
					<img class="headImgUrl_img" src="${requestScope.user.headImgUrl }"/>
				</td>
				<td class="td1" align="right">
				</td>
				<td class="td2">
				</td>
			  </tr>
			  <tr>
				<td class="td1" align="right">
					创建时间
				</td>
				<td class="td2">
					<span>${requestScope.user.createTime }</span>
				</td>
				<td class="td1" align="right">
					审核状态
				</td>
				<td class="td2">
					<span>
						<c:if test="${requestScope.user.check eq 0 }">待审核</c:if>
						<c:if test="${requestScope.user.check eq 1 }">已通过</c:if>
						<c:if test="${requestScope.user.check eq 2 }">未通过</c:if>
					</span>
				</td>
			  </tr>
			</table>
		</div>
		<%@include file="../../foot.jsp"%>
	</div>
</div>
</body>
</html>