<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/login.jsp</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id ="subdiv">
		<div  class ="profiletb">
		  	<h1>로그인</h1>
		  	<form action="loginPro.jsp" method="post" id="join">
		  			<table>
		  			<tr>
			  			<td>아이디</td>
			  			<td><input type="text" name="id" required="required"></td>
		  			</tr>
		  			<tr>
			  			<td>비밀번호</td>
			  			<td><input type="password" name="pass" required="required" ></td>
					</tr>
					<tr>
		  			<td><input type="submit" value="로그인" class="submit"></td>
		  			<td><input type="reset" value="돌아가기" onclick="history.back()" class="cancel"></td>
		  			</tr>
		  		
		  	</table>
		  	</form>
		  </div>
		  </div>
		  
	</div>
</body>
</html>


