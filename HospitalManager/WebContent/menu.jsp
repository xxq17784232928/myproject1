<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/plugin/css/bootstrap.3.3.7.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/plugin/css/bootstrap-theme.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/plugin/css/bootstrap-table.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/plugin/kindeditor/themes/default/default.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/plugin/ztree/css/zTreeStyle/zTreeStyle.css"> 

<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/js/bootstrap3.3.7.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/js/bootstrap-table-zh-CN.js"></script>
<script src="${pageContext.request.contextPath}/plugin/kindeditor/kindeditor.js"></script>
<script src="${pageContext.request.contextPath}/plugin/kindeditor/lang/zh_CN.js"></script>
<script src="${pageContext.request.contextPath}/plugin/ztree/js/jquery.ztree.all.min.js"></script>

<style type="text/css">
   .table-striped > tbody > tr:nth-of-type(odd) {
        background-color: #f1f1ec;
}
.table-hover > tbody > tr:nth-of-type(even) {
    background-color: #ccccc2;
}
.fixed-table-toolbar .columns {
    position: relative;
    margin-top: 10px;
    margin-bottom: 10px;
    line-height: 34px;
    margin-right: 50px;
}
.btn-group > .btn:first-child:not(:last-child):not(.dropdown-toggle) {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
    height: 34px;
}
.fixed-table-toolbar .bs-bars, .fixed-table-toolbar .search, .fixed-table-toolbar .columns {
    position: relative;
    margin-top: 10px;
    margin-bottom: 10px;
    line-height: 34px;
    margin-left: 10px;
    width: 300px;
}
</style>

</head>
<body>

<!-- 工具栏 -->
<div id="toolbar">
		<div id="addas" class="a">
			<form  id="myForm1"  class="form-horizontal">
			    <div style="float:left">
				菜单名称: <input type="text" name="roleName"  id="txt_search_roleName">
				</div>
				<div style="float:left;">
				<button type="button" id="btn_query" class="btn btn-success">搜索</button>
				</div>
			</form>
		</div>
		<button id="add" class="btn btn-success">新增菜单信息</button>
		<button id="open" class="btn btn-success">展开或折叠搜索框</button>
	</div>
<table id="tb_user"></table>

<script type="text/javascript">

    $(function(){
    	$("#open").click(function(){
			 if($("#addas").attr("class")=="a")
		        {
				 $("#addas").attr("class","b");
				 $("#addas").slideDown("fast");
		        }
		        else
		        {
		        	 $("#addas").attr("class","a");
		        	 $("#addas").slideUp("fast");
		        }
		})
    	 
    	$("#tb_user").bootstrapTable({
    		url:"${pageContext.request.contextPath}/menuQuery.do",//访问地址
    		method:"get",//请求的方式
    		toolbar:"#toolbar",//工具栏
    		pagination:true,//允许分页
    		pageSize:8,//每页显示的条数
    		pageList:[2,3,5,8,10],//每页显示的条数集合
    		showColumns:true,//是否显示所有的列
    		showRefresh:true,//是否显示刷新
    		//search:true,//是否允许搜索
    		//searchAlign:"left",//左边显示
    		//showExport:true,//是否显示导出
    		//exportDataType:"all",
    		striped:true,//隔行变色
    		columns:[{
    			checkbox:true
    		},{
    			field:"menuId",//json数据中的key   字段名称
    			title:"编号",//列的标题
    			sortable:true//允许排序
    		},{
    			field:"menuName",
    			title:"菜单名称"
    		},{
    			field:"menuImage",
    			title:"菜单图标"
    		},{
    			title:"操作",
    			align:"center",
    			formatter:function(value,row,index){
    				var  updateValue = '<button type="button" onclick="updateFun('+row.menuId+')" class="btn btn-success">修改</button>';
    				var  deleteValue = '<button type="button" onclick="deleteFun('+row.menuId+')" class="btn btn-success">删除</button>';
    				return updateValue+deleteValue;
    			}
    		}]
    	})
    	
    	<!--修改按钮事件-->
    	  $("#btn_update").click(function(){
    		    //获取表单中的数据
    		    var formData = $("#myForm").serializeArray();
    		    $.ajax({
    		    	type:"post",//请求方式
    		    	url:"${pageContext.request.contextPath}/updateUser.do",//请求后台的地址
    		        data:formData,//传到后台的数据
    		        datatype:"text",//传到后台的数据类型
    		        timeout:50000,//超时的时间
    		        contentType:"application/x-www-form-urlencoded;charset=utf-8",//文档类型
    		        success:function(data){
    		        	if(data>0){
    		        		//刷新表格中的数据
    		        		$('#tb_user').bootstrapTable('refresh');// 数据加载成功后刷新
      		        	}else{
    		        		alert("修改失败!");
    		        	}
    		        }
    		        
    		    })
    	  })
    	<!--修改按钮事件-->
    	  
    	<!--搜索条件-->
    	//条件搜索
		$("#btn_query").click(function() {
	                var roleName = $("#txt_search_roleName").val();
	              
	                $.ajax({
	                     type: "post",
	                     url: "${pageContext.request.contextPath}/queryRole.do",
	                     data: {roleName:roleName}, //查询条件
	                     dataType:"json",
	                     success : function(json) {
	                        $("#tb_user").bootstrapTable('load', json);//主要是要这种写法
	                    }
	                });

	    });
    	<!--搜索条件-->
    	
    	<!--权限保存-->
    	$("#btn_saveAuthority").click(function(){
    		//菜单集合
    		var menuIds = zTreeOnCheck();
    		
    		//角色id
    		var roleId  = $("#roleId").val();
    		
    		$.ajax({
        		type:"post",//请求方式 get,post
        		url:"${pageContext.request.contextPath}/saveAuthority.do?menuIds="+menuIds,//请求后台的地址
        		data:{roleId:roleId},//传递到后台的数据
        		dataType:"json",//传到后台的数据类型json  xml、html、txt等
        		success: function(msg){
        		     alert(msg);
        		}
        	})	
    	    
    	})
    	<!--权限保存--> 
    })
    
<!--放大图片-->
function showImage(imageUrl){
	
	$('#myImageModel').modal().on('shown.bs.modal', function () {
		
		$("#myImage").attr("src","/imgURL/"+imageUrl);
	})
}
<!--放大图片-->

<!--分配权限的窗体显示事件-->
function authorityFun(roleId){
	 // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
	 var setting = {
			 //复选框
			 check:{
				 enable:true
			 },
			 //异步
			 async: {
					enable: true,
					url: "${pageContext.request.contextPath}/sendAuthority.do?roleId="+roleId,
					autoParam: ["roleId="+roleId]
			 }
	 };
	 
	 $(function(){
		 <!--ztree树形节点数据展示-->
	    	//加载事件
	 		 var zTreeObj = $.fn.zTree.init($("#treeDemo"), setting);
	 		<!--ztree树形节点数据展示-->
	 })
	
	$('#myAuthorityModel').modal().on('shown.bs.modal', function () {
		
		//给隐藏框赋值
		$("#roleId").val(roleId);
	})
	
}

<!--点击事件-->
function zTreeOnCheck() {
	 //得到选中ztree对象
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	 
	 //得到ztree中选中的节点
	var nodes = treeObj.getCheckedNodes(true);
	 
	var v = [];//保存菜单的id集合
	
	//循环取选中的节点
	for(var i = 0;i < nodes.length;i++){
		v.push(nodes[i].id);
	}
	
	return v;
}
<!--点击事件-->
<!--分配权限的窗体显示事件-->

<!--跳转到修改页面-->
function updateFun(userIds){
    	$.ajax({
    		type:"post",//请求方式 get,post
    		url:"${pageContext.request.contextPath}/findUserById.do",//请求后台的地址
    		data:{userId:userIds},//传递到后台的数据
    		dataType:"json",//传到后台的数据类型json  xml、html、txt等
    		success:function(data,status){
    			  $('#myUpdateModel').modal().on('shown.bs.modal', function () {
    			       
    			         //给表单的内容赋值
    			         $("#userId").val(data.userId);
    			         $("#tx_username").val(data.username);
    			         $("#tx_password").val(data.password);
    			         $("#tx_photo").val(data.photo);//显示图片名称的文本框
    			         $("#image_photo").attr("src","/imgURL/"+data.photo);//图片控件设置的值 
    			         $("#tx_birthday").val(data.birthday);
    			         $("#tx_state").val(data.state);
    			   })
    		}
    	})	
 }
<!--跳转到修改页面-->



</script>
<!--分配权限窗体-->
<form class="form-horizontal" method="post">
<div class="modal fade"  id="myAuthorityModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
          <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span></button>
		  </div>
		  <input type="hidden" name="roleId" id="roleId">
		  <div class="form-group" style="margin-top: 10px;margin-left: 100px;">
		     <ul id="treeDemo" class="ztree"></ul>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button  id="btn_saveAuthority" class="btn btn-success">保存</button>
		    </div>
		  </div>
    </div>
  </div>
</div>
</form>
<!-- 分配权限窗体 -->

<!-- 放大图片的页面窗体 -->
<div class="modal fade"  id="myImageModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
          <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span></button>
		  </div>
         <img  style="margin-left: 30px;margin-bottom: 30px;" id="myImage" alt="" src="" width="300" height="300">
    </div>
  </div>
</div>
<!-- 放大图片的页面窗体 -->


<!-- 修改的页面窗体 -->
<form class="form-horizontal"  id="myForm" method="post">
<div class="modal fade"  id="myUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
          <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">修改用户信息</h4>
		  </div>
		  
        <!-- 隐藏框   为了后台接收主键进行修改 -->
		   <input type="hidden" name="userId" id="userId">
		  <div class="form-group" style="margin-top: 10px;">
		    <label for="inputEmail3" class="col-sm-2 control-label">用户名:</label>
		    <div class="col-sm-6">
		      <input type="text" name="username" class="form-control" id="tx_username" placeholder="请输入用户名:">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputPassword3" class="col-sm-2 control-label">密码:</label>
		    <div class="col-sm-6">
		      <input type="password" name="password" class="form-control" id="tx_password" placeholder="请输入密码：">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">图片:</label>
		    <div class="col-sm-6">
		      <input type="hidden" name="photo" class="form-control" id="tx_photo" placeholder="请输入头像:">
		      <img id="image_photo" alt="" src="" width="100" height="100">
		      <input type="button" id="imageButton" value="选择图片" />（本地上传）
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">生日日期:</label>
		    <div class="col-sm-6">
		      <input type="date" name="birthdays" class="form-control" id="tx_birthday" placeholder="请输入生日日期:">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputEmail3" class="col-sm-2 control-label">状态:</label>
		    <div class="col-sm-6">
		          <select class="form-control" name="state" id="tx_state">
					  <option value="1">在职</option>
					  <option value="0">离职</option>
					</select>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button  id="btn_update" class="btn btn-success">保存</button>
		    </div>
		  </div>
	    </div>
	  </div>
</div>
</form>
<!-- 修改的页面窗体 -->


 <script type="text/javascript">
		    KindEditor.ready(function(K) {
				var editor = K.editor({
					allowFileManager : true//允许文件管理
				});
				K('#imageButton').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							imageUrl : K('#tx_photo').val(),
							clickFn : function(url, title, width, height, border, align) {
								
								//截取url地址
								var str = "D://projectimage/image/";
								var urlValue = url.substring(str.length);
								K('#tx_photo').val(urlValue);
								$("#image_photo").attr("src","/imgURL/"+urlValue);//给图片框的src赋值
								editor.hideDialog();
							}
						});
					});
				});
			})
		    </script>

</body>
</html>