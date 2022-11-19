<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");


int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");


BoardDTO board = new BoardDTO();
BoardDAO dao = new BoardDAO();
board.setNum(num);
board.setName(name);
board.setPass(pass);
board.setSubject(subject);
board.setContent(content);

int updateCount = dao.updateBoard(board);

if(updateCount > 0 ) {
	response.sendRedirect("notice_content.jsp?num="+num);
} else {
	%>
	<script>
		alert("비밀번호 불일치");
		history.back();
	</script>
	<% 
}

%>    
    
    
    
    
    
    
    
    
    