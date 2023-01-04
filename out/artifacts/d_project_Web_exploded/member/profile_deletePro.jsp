<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDAO dao = new MemberDAO();
int deleteCount = dao.deleteMember(id,pass);


if(deleteCount > 0){
	%>
	<script>
	 	alert("회원탈퇴 성공!")
	 	location.href="logout.jsp";
	</script>
	<%
} else {
	%>
	<script>
		alert("비밀번호를 확인하세요!");
		history.back();
	</script>
	<%
}


%>