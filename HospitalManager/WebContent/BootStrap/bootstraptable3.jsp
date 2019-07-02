<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/plugin/css/bootstrap.3.3.7.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/plugin/css/bootstrap-theme.css" rel="stylesheet">
<!-- boostraptable -->
<link href="${pageContext.request.contextPath}/plugin/css/bootstrap-table.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/js/bootstrap3.3.7.min.js"></script>
<!-- boostraptable -->
<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/js/bootstrap-table.js"></script>

</head>
<body>

 <table id="table"></table>
 <script type="text/javascript">
    $(function(){
    	
    	//表格数据的加载
    	$('#table').bootstrapTable({
    		  columns: [{
    		    field: 'id',
    		    title: 'Item ID'
    		  }, {
    		    field: 'name',
    		    title: 'Item Name'
    		  }, {
    		    field: 'price',
    		    title: 'Item Price'
    		  }],
    		  data: [{
    		    id: 1,
    		    name: 'Item 1',
    		    price: '$1'
    		  }, {
    		    id: 2,
    		    name: 'Item 2',
    		    price: '$2'
    		  }]
    		})
    })
    
 </script>

</body>
</html>