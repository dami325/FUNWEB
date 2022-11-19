<%@page import="board.NoticeDTO"%>
<%@page import="board.NoticeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");


String sId = (String)session.getAttribute("sId");

%>
<%

if(sId == null){
	%>
	<script>
	alert("로그인후 사용 가능합니다!");
	location.href="../member/login.jsp";
	</script>
	<% 
}

%>

	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id="subdiv">
		<div class="notice_table">
			<h1>공지사항</h1>
			<table>
				<tr id="first_tr">
					<th class="tno">글번호</th>
					<th class="ttitle">제목</th>
					<th class="twrite">작성자</th>
					<th class="tdate">작성일</th>
					<th class="tread">조회수</th>
				</tr>
				<%
		
		
				
		NoticeDAO dao = new NoticeDAO();	
		
		ArrayList<NoticeDTO> noticeList = dao.selectNoticeList();
		
		for(NoticeDTO board : noticeList){
			%>
			<tr onclick="location.href='main_content.jsp?num=<%=board.getNum()%>'"id="notice_tr">
					<td><%=board.getNum()%></td>
					<td class="left"><%=board.getSubject()%></td>
					<td><%=board.getName()%></td>
					<td><%=sdf.format(board.getDate())%></td>
					<td><%=board.getReadcount()%></td>
				</tr>
			<% 
		}
		%>
			
				<%if (sId != null && sId.equals("qkrwnekfa")) {%>
				<tr>
				<td><input type="button" value="글쓰기" class="btn" onclick="location.href='main_write.jsp'"></td>
				</tr>
				<%}%>
				</table>
				</div>
				</div>
	</div>
</body>
</html>


