<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>

<%
String id = request.getParameter("id");

MemberDAO dao = new MemberDAO();

MemberDTO member = new MemberDTO();

member = dao.profile(id);

if(member != null){
	

%>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
<script>
	function confirm_delete() {
		var result = confirm("제명 하시겠습니까?");		
		
		//예(true)일 경우 logout.jsp 페이지로 이동
		if(result) {
			location.href = "admin_deletePro.jsp?id=<%=request.getParameter("id") %>&mobile=<%=request.getParameter("mobile")%>";
		}
	}
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
			
			<div id ="subdiv">
			<div class="profiletb">

			<h1>회원 정보</h1>
			<form action="admin_deletePro.jsp?id=<%=request.getParameter("id") %>&mobile=<%=request.getParameter("mobile")%>" method="post">
			
			
				<table id="notice_content">
					<tr>
						<td>회원 아이디</td>
						<td><a><%=member.getId()%></a></td>
					</tr>
					<tr>
						<td>회원 이름</td>
						<td><a><%=member.getName()%></a></td>
					</tr>
					<tr>
						<td>회원 이메일</td>
						<td><a><%=member.getEmail()%></a></td>
					</tr>
					<tr>
						<td>회원 주소</td>
						<td><a><%=member.getAddress1()%></a></td>
					</tr>
					<tr>
						<td>회원 상세주소</td>
						<td><a><%=member.getAddress2() %></a></td>
					</tr>
					<tr>
						<td>회원 전화번호</td>
						<td><a><%=member.getMobile()%></a></td>
					</tr>
					<tr>
						<td>회원 가입일</td>
						<td><a><%=member.getDate()%></a></td>
					</tr>
					<tr>
						<td>
					<input type="button" value="제명하기" class="btn" onclick="confirm_delete()">
					<input type="button" value="돌아가기" class="btn" onclick="location.href='qkrwnekfa.jsp'">
						</td>
					</tr>
				</table>
			</form>
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


