<%@page import="board.FileReplyDAO"%>
<%@page import="board.FileReplyDTO"%>
<%@page import="board.ReplyDAO"%>
<%@page import="board.ReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String boardType = request.getParameter("boardType");
int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String content = request.getParameter("content");
out.println(num + "," + name + ", " + content);

FileReplyDTO reply = new FileReplyDTO();
reply.setBoardType(boardType);
reply.setRefNum(num);
reply.setName(name);
reply.setContent(content);


FileReplyDAO dao = new FileReplyDAO();

int insertCount = dao.insertReply(reply);

if(insertCount > 0){
	response.sendRedirect("driver_content.jsp?num=" + num);
} else{
	%>
	<script>
		alert("댓글 등록 실패!");
		history.back();
	</script>
	<%
}
%>