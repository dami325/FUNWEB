<%@page import="board.NoticeDTO"%>
<%@page import="board.NoticeDAO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
    
String sId = (String)session.getAttribute("sId");
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>main/main.jsp</title>
		<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">


</script>
<body>
	<div id="main_wrap">
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<jsp:include page="../inc/slider.html"></jsp:include>
		<%if(sId != null){%>
			
	
			<div id="main_imgtable">
		<h1 style="text-align: center; color:#8B4513;">    인기사진     </h1>
			<%
				FileBoardDAO filedao = new FileBoardDAO();
			ArrayList<FileBoardDTO> fileboardList = filedao.selectRecentlyFileBoardList();
			
			for(FileBoardDTO fileboard : fileboardList){
			%>
			<table>
			
			<tr id="noticetr">
				<th>제목 : <%=fileboard.getSubject() %></th>
				<th>조회수 : <%=fileboard.getReadcount() %></th>
			</tr>
			<tr id="maintr" onclick="location.href='../center/driver_content.jsp?num=<%=fileboard.getNum()%>'">
				<td colspan="2">
					<img src="../upload/<%=fileboard.getReal_file() %>" width="325px" height="170px" style="float: left;">
				</td>
			</tr>
			<% }%>
			</table>
			</div>
			<div id="main_table">
		  		<table>
		  			<tr>
		  				<th colspan="3" style="color: #8B4513; border-style: none;">     최근 올라온 게시글     </th>
		  			</tr>
		  			<tr id="noticetr">
		  				<th><a id="aa">제목</a></th>
		  				<th><a id="aa">작성자</a></th>
		  				<th><a id="aa">작성 시간</a></th>
		  			</tr>
		  			<%
		  			BoardDAO dao = new BoardDAO();
		  			ArrayList<BoardDTO> boardList = dao.selectRecentlyBoardList();
		  			
		  			for(BoardDTO board : boardList){
		  			%>
		  			<tr id="maintr"onclick="location.href='../center/notice_content.jsp?num=<%=board.getNum()%>'">
		  				<td><a id="aa"> <%=board.getSubject() %></a></td>
		  				<td><a><%=board.getName() %></a></td>
		  				<td><a><%=sdf.format(board.getDate()) %></a></td>
		  			</tr>
		  			<%} %>
		  		</table>
		  	</div>
		  	<div id="main_notice">
		  		<table>
		  			<tr>
		  				<th colspan="3" style="color: #8B4513; border-style: none;">     공 지 사 항     </th>
		  			</tr>
		  			<tr id="noticetr">
		  				<th><a id="aa">제목</a></th>
		  				<th><a id="aa">관리자</a></th>
		  				<th><a id="aa">작성 시간</a></th>
		  			</tr>
		  			<%
		  			NoticeDAO noticedao = new NoticeDAO();
		  			ArrayList<NoticeDTO> noticeList = noticedao.selectRecentlyNoticeList();
		  			
		  			for(NoticeDTO board : noticeList){
		  			%>
		  			<tr id="maintr"onclick="location.href='main_content.jsp?num=<%=board.getNum()%>'">
		  				<td><a id="aa"> <%=board.getSubject() %></a></td>
		  				<td><a><%=board.getName() %></a></td>
		  				<td><a><%=sdf.format(board.getDate()) %></a></td>
		  			</tr>
		  			<%} %>
		  		</table>
		  		
		  	</div>
		  	
		  	
		  	<%	} else{ %>
					<img src="../image/3.png" width="700px;" style="margin: 150px 80px 0px -20px;">
		  
		 <% }%>
	</div>
</body>
</html>


