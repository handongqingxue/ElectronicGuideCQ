<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.tab1_div{
	margin-top:20px;
	margin-left: 220px;
}
.tab1_div .toolbar{
	height:32px;
}
.tab1_div .toolbar .userName_span,.tab1_div .toolbar .sceDisName_span{
	margin-left: 13px;
}
.tab1_div .toolbar .userName_inp,.tab1_div .toolbar .sceDisName_inp{
	width: 120px;height: 25px;
}
.tab1_div .toolbar .search_but{
	margin-left: 13px;
}
</style>
<title>用户审核</title>
<%@include file="../../js.jsp"%>
<script type="text/javascript">
var userPath='<%=basePath%>'+"background/user/";
$(function(){
	initSearchLB();
	initTab1();
});

function initSearchLB(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var userName=$("#toolbar #userName").val();
			var sceDisName=$("#toolbar #sceDisName").val();
			tab1.datagrid("load",{userName:userName,sceDisName:sceDisName});
		}
	});
}

function initTab1(){
	tab1=$("#tab1").datagrid({
		title:"用户审核查询",
		url:userPath+"selectCheckList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		columns:[[
			{field:"userName",title:"用户名",width:150},
			{field:"nickName",title:"昵称",width:150},
			{field:"sceDisName",title:"所属景区",width:250},
            {field:"createTime",title:"创建时间",width:150},
            {field:"check",title:"审核状态",width:80,formatter:function(value,row){
            	var str;
            	switch (value) {
				case 0:
					str="待审核";
					break;
				case 1:
					str="已通过";
					break;
				case 2:
					str="未通过";
					break;
				}
            	return str;
            }},
            {field:"id",title:"审核",width:110,formatter:function(value,row){
            	var str="<a href=\"detail?id="+value+"\">详情</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{userName:"<div style=\"text-align:center;\">暂无信息<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"userName",colspan:6});
				data.total=0;
			}
			
			$(".panel-header").css("background","linear-gradient(to bottom,#F4F4F4 0,#F4F4F4 20%)");
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
		}
	});
}

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-250;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
	<div class="tab1_div" id="tab1_div">
		<div class="toolbar" id="toolbar">
			<span class="userName_span">用户名：</span>
			<input type="text" class="userName_inp" id="userName" placeholder="请输入用户名"/>
			<span class="sceDisName_span">景区名称：</span>
			<input type="text" class="sceDisName_inp" id="sceDisName" placeholder="请输入景区名称"/>
			<a class="search_but" id="search_but">查询</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>