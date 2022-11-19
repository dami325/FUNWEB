<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
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
SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");


String sId = (String)session.getAttribute("sId");

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
<title>파일 게시판</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>

			<div id="subdiv">
		<div class="driver_table">

			<h1>사진 게시판</h1>
			<table id="notice">
				<tr id="first_tr">
					<th>사진</th>
					<th>조회수</th>
					<th>제목</th>
					<th>작성자</th>
					<th>글번호</th>
					<th>작성일</th>
				</tr>
				<%
		int listLimit = 10; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
		
		int pageNum = 1; // 현재 페이지 번호 기본값을 1로 설정
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		int startRow = (pageNum - 1) * listLimit; 
		
		int endRow = startRow + listLimit - 1;
				
		FileBoardDAO dao = new FileBoardDAO();
		
		ArrayList<FileBoardDTO> boardList = dao.selectBoardList(startRow, listLimit);
		
		for(FileBoardDTO board : boardList){
			%>
			<tr onclick="location.href='driver_content.jsp?num=<%=board.getNum()%>'" id="maintr">
					<td><img src="../upload/<%=board.getReal_file() %>" style="width: 150px;height: 100px"></td>
					<td><%=board.getReadcount()%></td>
					<td><%=board.getSubject()%></td>
					<td><%=board.getName()%></td>
					<td><%=board.getNum()%></td>
					<td><%=sdf.format(board.getDate()) %></td>
				</tr>
			<% 
		}
		%>
			<tr><td><input type="button" value="글쓰기" class="btn" onclick="location.href='driver_write.jsp'"></td>
				<td><input type="reset" value="돌아가기" onclick="history.back()" class="cancel"></td>
			<!-- 검색 기능 -->
				<form action="driver_search.jsp" method="get">
					<td><input type="text" name="keyword" class="input_box" required="required"></td>
					<td><input type="submit" value="Search" class="btn"></td>
				</form>
				</tr>
				</table>
			<%
			int boardListCount = dao.selectBoardListCount();
			
			int pageListLimit = 10; // 한 페이지에서 표시할 페이지 목록을 10개로 제한
			
			int maxPage = boardListCount / pageListLimit + (boardListCount % pageListLimit == 0 ? 0 : 1); 
				
			
			int startPage = (pageNum - 1 ) / pageListLimit * pageListLimit + 1;
			
			int endPage = startPage + pageListLimit - 1;
			
			if(endPage > maxPage){
				endPage = maxPage;
			}
			
			
			
			%>
			
				<div id="pageNum">
				<%if(pageNum == 1){ %>
					<a href="javascript:void(0)">Prev</a>
				<%}else{ %>
				<a href="driver.jsp?pageNum=<%=pageNum-1%>">Prev</a>
				<%} %>
				
				<% for(int i = startPage; i <= endPage; i++){%>
					<%if(pageNum == i){ %>
						<a href="javascript:void(0)"><%=i %></a>
					<%}else{ %>
					<a href="driver.jsp?pageNum=<%=i %>"><%=i %></a>
					<%} %>
				<%} %>
				<!--  다음 페이지 버튼(Next) 클릭 시 현재 페이지 번호 + 1 값 전달 -->
				<%if(pageNum == maxPage){ %>
						<a href="javascript:void(0)">Next</a>
				<%}else{ %>
				<a href="driver.jsp?pageNum=<%=pageNum+1%>">Next</a>
				<%} %>
			</div>
		</div>
		</div>
	</div>
</body>
</html>


