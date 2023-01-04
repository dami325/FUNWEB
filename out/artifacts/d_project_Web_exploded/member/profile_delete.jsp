<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id ="subdiv">
		<div  class ="profiletb">
			<h1>회원 탈퇴</h1>
			<form action="profile_deletePro.jsp?id=<%=request.getParameter("id") %>" method="post">
			
			
				<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
				<table id="notice_content">
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pass" ></td>
					</tr>

				<tr>
					<td>
					<input type="submit" value="회원 탈퇴" class="btn">
					<input type="reset" value="돌아가기" onclick="history.back()" class="cancel">
					</td>
				</tr>
				</table>
			</form>

		</div>
		</div>
		<!-- 푸터 들어가는곳 -->
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


