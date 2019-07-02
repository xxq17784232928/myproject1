<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- jsp包含指令 -->
<%@ include file="common/commoncss.jsp" %>
<%@ include file="common/commonjs.jsp" %>


<style type="text/css">
  .a{
     display: inline;//显示
  }
  .b{
     display: none;//隐藏
  }
</style>

</head>
<body>
 
<!-- 搜索工具栏 -->

<div id="toolbar">
   <div id="showorhide" class="a">
          <form class="form-inline" id="mySearchForm">
			  <div class="form-group">
			    <label for="exampleInputName2">岗位名称:</label>
			    <input type="text" name="poName" class="form-control" id="deptNameSearch" placeholder="岗位名称">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputName2">基本薪资:</label>
			    <input type="text" name="poSalary1" class="form-control" id="deptAddressSearch" placeholder="最低基本薪资">
			    &nbsp;到&nbsp;<input type="text" name="poSalary2" class="form-control" id="deptAddressSearch" placeholder="最高基本薪资">
			  </div>
			  <div class="form-group">
			    <label for="exampleInputEmail2">科室:</label>
			    <select name="deptId" id="deptIdSearch">
			        <option value="0">请选择</option>
			    </select>
			  </div>
			  <button id="btn_query" type="button" class="btn btn-success">查询</button>
			  
		 </form>
   </div>
   <button id="open" class="btn btn-success">展开或折叠</button>
</div>


<table id="table"></table>

<!-- 工具栏 -->
<div id="toolbar"></div>

<script type="text/javascript">

    $(function(){
    	 
    	$("#table").bootstrapTable({
    		url:"${pageContext.request.contextPath}/position?method=query",//访问地址
    		method:"get",//请求的方式
    		toolbar:"#toolbar",//工具栏
    		pagination:true,//允许分页
    		pageSize:8,//每页显示的条数
    		pageList:[2,3,5,8,10],//每页显示的条数集合
    		showColumns:true,//是否显示所有的列
    		showRefresh:true,//是否显示刷新
    		striped:true,//隔行变色   每一行的唯一标识，一般为主键列
		    showExport:true,//允许导出
  		    exportDataType:'all',//可以全部导出
  		    exportTypes:['pdf','excel'],//导出的数据类型（pdf文件、excel文件）
    		columns: [{
    		    field: 'poId',
    		    title: '岗位编号',
    		    sortable:true
    		  }, {
    		    field: 'poName',
    		    title: '岗位名称'
    		  }, {
    		    field: 'department.deptName',
    		    title: '科室名称'
    		  }, {
    		    field: 'poSalary',
    		    title: '基本薪资'
    		  },{
    			  title:"操作",
    			  formatter:function(value,row,index){
    				  var updateValue =' <button  onclick="updateFun('+row.poId+')" type="button" class="btn btn-success">修改</button>';
    				  var authorityValue = ' <button  onclick="authorityFun('+row.poId+')" type="button" class="btn btn-success">分配权限</button>';
    				  var deleteValue =' <button  onclick="deleteFun('+row.poId+')" type="button" class="btn btn-success">删除</button>';
    				  
    				  return updateValue+authorityValue+deleteValue;
    			  }
    		  }]
    	})
    	
    	<!--展开或折叠   #:id名称     .:class名称-->
    	$("#open").click(function(){
    		
    		 //判断  attr：属性   a:显示      b：隐藏
    		 if($("#showorhide").attr("class")=="a"){
    			 
    			 $("#showorhide").attr("class","b");//由显示变为隐藏
    			 $("#showorhide").slideDown("fast");//向下快速滑动
    		 }else{
    			 $("#showorhide").attr("class","a");//由显示变为隐藏
    			 $("#showorhide").slideUp("fast");//向上快速滑动
    		 }
    	})
    	
    	 //下拉数据加载  
        $.ajax({  
            type : 'get',  
            url : "${pageContext.request.contextPath}/department?method=query",  
            dataType : 'json',      
            success : function(datas) {//返回list数据并循环获取  
            	
                var select = $("#deptIdSearch");
                for (var i = 0; i < datas.length; i++) { 
                	select.append("<option value='" +datas[i].deptId+ "'>"  
                            + datas[i].deptName + "</option>");  
                }  
              
            } 
            
        }); 
    	
    })
 </script>
 
 
 <script type="text/javascript">
  $(function(){
	  <!--搜索条件-->
  	//条件搜索
		$("#btn_query").click(function() {
	                
					//获取表单中的数据
				     var searchPosition = $("#mySearchForm").serializeArray();
	              
	                $.ajax({
	                     type: "post",//请求的方式
	                     url: "${pageContext.request.contextPath}/position?method=query",
	                     data: searchPosition, //查询条件
	                     dataType:"json",//返回的数据类型为json
	                     success : function(json) {
	                        $("#table").bootstrapTable('load', json);//主要是要这种写法
	                    }
	                });

	    });
  })
  
   //修改
   function updateFun(deptId){
	 
	  $.ajax({
		    type:"post",//提交方式
		    url:"${pageContext.request.contextPath}/department?method=sendUpdate",
		    data:{deptId:deptId},//传主键值
		    dataType:"json",//返回的数据类型为json
		    success:function(data){
		    	
		    	  //弹出修改窗体
		    	 $('#myUpdateModal').modal().on('shown.bs.modal',function() {
		    		
		    		   $("#deptIdUpdate").val(data.deptId);
		    		   $("#deptNameUpdate").val(data.deptName);
		    		   $("#deptAddressUpdate").val(data.deptAddress);
		    		   $("#deptPhoneUpdate").val(data.deptPhone);
		    	})
		    }
	  })
  }
  
 </script>
 
 
<!-- 修改页面窗体 -->
<!-- 模态框（Modal） -->
<form id="myUpdateForm" method="post">

<input type="hidden" name="deptId" id="deptIdUpdate">

<div class="modal fade" id="myUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改科室信息</h4>
            </div>
            <div class="modal-body">
                   <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">科室名称:</label>
					    <div class="col-sm-10">
					      <input type="text" name="deptName" class="form-control" id="deptNameUpdate" placeholder="科室名称；">
					    </div>
				 </div>
				 <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">科室地址:</label>
					    <div class="col-sm-10">
					      <input type="text" name="deptAddress" class="form-control" id="deptAddressUpdate" placeholder="科室地址；">
					    </div>
				 </div>
				 <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">科室电话:</label>
					    <div class="col-sm-10">
					      <input type="text" name="deptPhone" class="form-control" id="deptPhoneUpdate" placeholder="科室电话；">
					    </div>
				 </div>
				 <div class="form-group">
					    <label for="inputEmail3" class="col-sm-2 control-label">科室负责人:</label>
					    <div class="col-sm-10">
					         <select id="userUpdate" name="userId">
					              <option value="1">张三</option>
					              <option value="2">李四</option>
					         </select>
					    </div>
				 </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="btnUpadte" class="btn btn-primary">更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</form>
 
<script type="text/javascript">
  $("#btnUpadte").click(function(){
	  
	    //获取表单中的数据
	     var tDepartemnt = $("#myUpdateForm").serializeArray();
	    
	    $.ajax({
	    	 type:"post",//提交方式
	    	 url:"${pageContext.request.contextPath}/department?method=update",
	    	 data:tDepartemnt,//数据
	    	 dataType:"json",//返回的数据类型为json
	    	 success:function(json){
	    		 
	    		 if(json ==1){
	    			 
	    			 $("#myUpdateModal").modal('hide');  //手动关闭
	    			 $("#table").bootstrapTable("refresh");//刷新表格中的数据
	    			 
	    			 
	    		 }
	    	 }
	    })
  })
  
  <!-- 分配权限 -->
function authorityFun(poId){
	
	// zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
	 var setting = {
			 //复选框
			 check:{
				 enable:true
			 },
			 //异步
			 async: {
					enable: true,
					url: "${pageContext.request.contextPath}/position?method=sendAuthority&poId="+poId,
					autoParam: ["poId="+poId]
			 }
	 };
	 
	 $(function(){
		 <!--ztree树形节点数据展示-->
	    	//加载事件
	 		 var zTreeObj = $.fn.zTree.init($("#treeDemo"), setting);
	 		<!--ztree树形节点数据展示-->
	 })
	
	 //弹出分配权限窗体
	 $('#myAuthorityModal').modal().on('shown.bs.modal',function() {
		  $("#poIdAuthority").val(poId);
		  
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

$(function(){
	<!--权限保存-->
	$("#btn_saveAuthority").click(function(){
		
		//菜单集合
		var menuIds = zTreeOnCheck();
		
		//角色id
		var poId  = $("#poIdAuthority").val();
		
		$.ajax({
			type:"post",//请求方式 get,post
			url:"${pageContext.request.contextPath}/position?method=saveAuthority&menuIds="+menuIds,//请求后台的地址
			data:{poId:poId},//传递到后台的数据
			dataType:"json",//传到后台的数据类型json  xml、html、txt等
			success: function(msg){
			     
				if(msg ==1){
					 $("#myAuthorityModal").modal('hide');  //手动关闭
	    			 $("#table").bootstrapTable("refresh");//刷新表格中的数据
				}
			}
		})	
	    
	})
	<!--权限保存--> 
})
<!-- 分配权限 -->

</script>
<!-- 修改页面窗体 -->
 
<!-- 分配权限窗体 -->
<div class="modal fade" id="myAuthorityModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改科室信息</h4>
            </div>
             <input type="hidden" name="poId" id="poIdAuthority">
			  <div class="form-group" style="margin-top: 10px;margin-left: 100px;">
			     <ul id="treeDemo" class="ztree"></ul>
			  </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button  id="btn_saveAuthority" class="btn btn-success">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- 分配权限窗体 -->
 
 
</body>
</html>