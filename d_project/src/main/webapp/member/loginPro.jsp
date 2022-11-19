<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDAO dao = new MemberDAO();

MemberDTO member = new MemberDTO();

member = dao.login(id,pass);


if(member != null){
	session.setAttribute("sId", id);
	response.sendRedirect("../main/main.jsp");
} else{
	%> 
	<script>
		alert("로그인 실패!");
		history.back();
	</script>
	<%
	
}


%>