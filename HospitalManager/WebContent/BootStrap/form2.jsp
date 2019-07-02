<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/plugin/css/bootstrap.3.3.7.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/plugin/css/bootstrap-theme.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/js/bootstrap3.3.7.min.js"></script>

</head>
<body>
<form class="form-inline">
  <div class="form-group">
    <label for="exampleInputName2">Name</label>
    <input type="text" class="form-control" id="exampleInputName2" placeholder="Jane Doe">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail2">Email</label>
    <input type="email" class="form-control" id="exampleInputEmail2" placeholder="jane.doe@example.com">
  </div>
   <div class="form-group">
    <label for="exampleInputEmail2">Sex</label>
    <input type="email" class="form-control" id="exampleInputEmail2" placeholder="性别">
  </div>
  <button type="submit" class="btn btn-default">Send invitation</button>
</form>

</body>
</html>