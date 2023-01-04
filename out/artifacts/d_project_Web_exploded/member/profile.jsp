<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
<%
String id = request.getParameter("id");

MemberDAO dao = new MemberDAO();

MemberDTO member = new MemberDTO();

member = dao.profile(id);

if(member != null){
	

%>
	<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
	
	
		<div id ="subdiv">
		<div  class ="profiletb">
	<h1><%=member.getId() %> 님 정보</h1>
			<table>
				
				<tr>
					<td>아이디</td><td><%=member.getId() %></td>
				</tr>
				<tr>
					<td>이름</td><td><%=member.getName() %></td>
				</tr>
				<tr>
					<td>이메일</td><td><%=member.getEmail() %></td>
				</tr>
				<tr>
					<td>주소1</td><td><%=member.getAddress1() %></td>
				</tr>
				<tr>
					<td>주소2</td><td><%=member.getAddress2() %></td>
				</tr>
				<tr>
					<td>전화번호</td><td><%=member.getMobile() %></td>
				</tr>
				<tr>
					<td>아이디 생성일</td><td><%=member.getDate() %></td>
				</tr>
				<tr>
					<td>
						<input type="button" value="내정보 수정" class="btn" onclick="location.href='profile_update.jsp?id=<%=member.getId()%>'"> 
					</td>
					<td>
						<input type="button" value="회원탈퇴" class="btn" onclick="location.href='profile_delete.jsp?id=<%=member.getId()%>'">
					</td> 
					<td>
						<input type="reset" value="돌아가기" onclick="history.back()" class="cancel">
					</td>
				</tr>
			</table>
			</div>
		</div>	
		
		
	</div>
</body>
<%
}else {%>
	<script>
		alert("잘못된 접근입니다!")
		history.back();
	</script>
	<%
}
%>
</html>
