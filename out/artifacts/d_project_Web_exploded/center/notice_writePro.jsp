<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

BoardDTO board = new BoardDTO();
BoardDAO dao = new BoardDAO();
board.setName(name);
board.setPass(pass);
board.setSubject(subject);
board.setContent(content);




int insertCount = dao.insertBoard(board,id);

if(insertCount > 0) {
	response.sendRedirect("notice.jsp");
} else { 
	%>
	<script>
		alert("비밀번호가 틀렸습니다!");
		history.back();
	</script>
	<%
}



%>