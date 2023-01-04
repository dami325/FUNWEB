<%@page import="board.ReplyDAO"%>
<%@page import="board.ReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

ReplyDAO dao = new ReplyDAO();

int num = Integer.parseInt(request.getParameter("num"));
String sId = (String)session.getAttribute("sId");
String name = request.getParameter("name");
if(sId == null){
%>
<script>
	alert("댓글 삭제 실패!")
	histroy.back();
</script>

<%
	
}

int deleteCount = dao.deleteReply(num,name);


if(deleteCount > 0){
	
		response.sendRedirect("notice_content.jsp?num="+ request.getParameter("refNum"));
	
	
	} else {
	%>
	<script>
		alert("댓글 삭제 실패!")
		histroy.back();
	</script>
	
	<%
	}
%>
    
    
    
    
    