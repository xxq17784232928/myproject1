<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
afdsafdsa
<table border="1">
   <tr>
       <td>编号</td>
       <td>科室名称</td>
       <td>科室地址</td>
       <td>科室电话</td>
       <td>科室负责人</td>
       <td>操作</td>
   </tr>
   <c:forEach items="${list }" var="d">
     <tr>
           <td>${d.deptId }</td>
           <td>${d.deptName }</td>
           <td>${d.deptAddress }</td>
           <td>${d.deptPhone }</td>
           <td>${d.user.userName }</td>
           <td>修改    删除</td>
     </tr>
   </c:forEach>
</table>


</body>
</html>