<%@page import="board.NoticeReplyDAO"%>
<%@page import="board.NoticeReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String boardType = request.getParameter("boardType");
int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String content = request.getParameter("content");
out.println(num + "," + name + ", " + content);

NoticeReplyDTO reply = new NoticeReplyDTO();
reply.setBoardType(boardType);
reply.setRefNum(num);
reply.setName(name);
reply.setContent(content);


NoticeReplyDAO dao = new NoticeReplyDAO();

int insertCount = dao.insertReply(reply);

if(insertCount > 0){
	response.sendRedirect("main_content.jsp?num=" + num);
} else{
	%>
	<script>
		alert("댓글 등록 실패!");
		history.back();
	</script>
	<%
}
%>