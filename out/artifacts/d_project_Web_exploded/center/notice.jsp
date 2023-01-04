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
String keyword = request.getParameter("keyword");

// 검색어 파라미터가 없을 경우 기본값을 널스트링""으로 설정
if(keyword == null){
	keyword = "";
}

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
<title></title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id="subdiv">
		<div class="notice_table">
			<h1>일반 게시판</h1>
			<table>
				<tr id="first_tr">
					<th class="tno">글번호</th>
					<th class="ttitle">제목</th>
					<th class="twrite">작성자</th>
					<th class="tdate">작성일</th>
					<th class="tread">조회수</th>
				</tr>
				<%
		int listLimit = 10; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
		
		int pageNum = 1; // 현재 페이지 번호 기본값을 1로 설정
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		int startRow = (pageNum - 1) * listLimit; 
		
		int endRow = startRow + listLimit - 1;
				
		BoardDAO dao = new BoardDAO();	
		
		ArrayList<BoardDTO> boardList = dao.selectBoardList(startRow, listLimit);
		
		for(BoardDTO board : boardList){
			%>
			<tr onclick="location.href='notice_content.jsp?num=<%=board.getNum()%>'"id="maintr">
					<td><%=board.getNum()%></td>
					<td class="left"><%=board.getSubject()%></td>
					<td><%=board.getName()%></td>
					<td><%=sdf.format(board.getDate())%></td>
					<td><%=board.getReadcount()%></td>
				</tr>
			<% 
		}
		%>
			
				<tr><td><input type="button" value="글쓰기" class="btn" onclick="location.href='notice_write.jsp'"></td>
				<td><input type="reset" value="돌아가기" onclick="history.back()" class="cancel"></td>
			<!-- 검색 기능 -->
				<form action="notice_search.jsp" method="get">
					<td><input type="text" name="keyword"  value="<%=keyword %>" class="input_box" required="required"></td>
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
					<a href="notice.jsp?pageNum=<%=pageNum-1%>">Prev</a>
				<%} %>
				
			<% for(int i = startPage; i <= endPage; i++){%>
				<%if(pageNum == i){ %>
						<a href="javascript:void(0)"><%=i %></a>
				<%}else{ %>
						<a href="notice.jsp?pageNum=<%=i %>"><%=i %></a>
				<%} %>
			<%} %>
				<!--  다음 페이지 버튼(Next) 클릭 시 현재 페이지 번호 + 1 값 전달 -->
				<%if(pageNum == maxPage){ %>
						<a href="javascript:void(0)">Next</a>
				<%}else{ %>
				<a href="notice.jsp?pageNum=<%=pageNum+1%>">Next</a>
				<%} %>
				</div>
				</div>
				</div>
	</div>
</body>
</html>


