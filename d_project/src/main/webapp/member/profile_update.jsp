<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");

MemberDAO dao = new MemberDAO();
MemberDTO member = dao.profile(id);


%>	
	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/profile_update.jsp</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id ="subdiv">
		<div  class ="profiletb">
			<h1>내정보 수정</h1>
			<form action="profile_updatePro.jsp?id=<%=member.getId() %>" method="post">
				<table>
					<tr>
						<td>아이디</td>
						<td><a><%=member.getId()%></a></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><a><%=member.getMobile()%></a></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name" value="<%=member.getName()%>"></td>
					</tr>
					<tr>
						<td>주소1</td>
						<td><input type="text" name="address1" value="<%=member.getAddress1() %>" ></td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td><input type="text" name="address2" value="<%=member.getAddress2() %>" ></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<td>
							<input type="submit" value="수정하기" class="btn">
							<input type="button" value="돌아가기" class="btn" onclick="history.back()">
						</td>
					</tr>
				</table>
			</form>
			</div>
			</div>
	</div>
</body>
</html>


