<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String mobile = request.getParameter("mobile");
MemberDAO dao = new MemberDAO();
int deleteCount = dao.deleteAdmin(id,mobile);


if(deleteCount > 0){
	%>
	<script>
	 	alert("회원제명 성공!")
	 	location.href="qkrwnekfa.jsp";
	</script>
	<%
} else {
	%>
	<script>
		alert("회원 전화번호를 확인하세요.");
		history.back();
	</script>
	<%
}


%>