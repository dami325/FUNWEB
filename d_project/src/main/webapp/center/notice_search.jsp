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



String keyword = request.getParameter("keyword");

// 검색어 파라미터가 없을 경우 기본값을 널스트링""으로 설정
if(keyword == null){
	keyword = "";
}
%>	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
			<h1>게시판</h1>
			<table id="notice">
				<tr>
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
		//---------------------------------------------------------
		BoardDAO dao = new BoardDAO();
		
		ArrayList<BoardDTO> boardList = dao.selectBoardList(startRow, listLimit, keyword);
		
		for(BoardDTO board : boardList){
			%>
			<tr onclick="location.href='notice_content.jsp?num=<%=board.getNum()%>'">
					<td><%=board.getNum()%></td>
					<td class="left"><%=board.getSubject()%></td>
					<td><%=board.getName()%></td>
					<td><%=sdf.format(board.getDate())%></td>
					<td><%=board.getReadcount()%></td>
				</tr>
			<% 
		}
		%>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='notice_write.jsp'">
				<input type="reset" value="돌아가기" onclick="history.back()" class="cancel">
			</div>
			<div id="table_search">
			<!-- 검색 기능 -->
				<form action="notice_search.jsp" method="get">
					<input type="text" name="keyword" value="<%=keyword %>" class="input_box" required="required">
					<input type="submit" value="제목검색" class="btn">
				</form>
			</div>

			<div class="clear"></div>
			<div id="page_control">
			<%
			// 한 페이지에서 보여줄 페이지 갯수 계산
			// 1. BoardDAO 객체의 selectBoardListCount() 메서드를 호출하여 전체 게시물 수 조회
			int boardListCount = dao.selectBoardListCount(keyword);
			
			//2, 한 페이지에서 표시할 페이지 목록 갯수 설정
			int pageListLimit = 10; // 한 페이지에서 표시할 페이지 목록을 10개로 제한
			
			//3, 전체 페이지 수 계산
			int maxPage = boardListCount / pageListLimit + (boardListCount % pageListLimit == 0 ? 0 : 1); 
				
			
			//4. 시작 페이지 번호 계산
			// => 시작 페이지 =(현재 페이지 - 1) / 페이지목록갯수 * 페이지목록갯수 + 1
			// ex) 현재 페이지 : 1 => 시작페이지 = (1-1) / 10 * 10 + 1 = 1 페이지
			//     현재 페이지 : 2 => 시작페이지 = (2-1) / 10 * 10 + 1 = 1 페이지
			//     현재 페이지 : 10 => 시작페이지 = (10-1) / 10 * 10 + 1 = 1 페이지
			//     현재 페이지 : 15 => 시작페이지 = (15-1) / 10 * 10 + 1 = 11 페이지
			int startPage = (pageNum - 1 ) / pageListLimit * pageListLimit + 1;
			
			//5. 끝 페이지 번호 계산
			// = > 시작페이지 + 페이지목록갯수 -1
			int endPage = startPage + pageListLimit - 1;
			
			//6. 만약 끝 페이지 번호(endPage) 가 최대 페이지 번호(maxPage) 보다 클 경우
			//   끝 페이지 번호를 최대 페이지 번호로 교체
			if(endPage > maxPage){
				endPage = maxPage;
			}
			
			
			
			%>
			
				<!-- 이전 페이지 버튼(Prev) 클릭 시 현재 페이지 번호 -1 값 전달 -->
				<%if(pageNum == 1){ %>
					<a href="javascript:void(0)">Prev</a>
				<%}else{ %>
				<a href="notice_search.jsp?keyword=<%=keyword %>&pageNum=<%=pageNum-1%>">Prev</a>
				<%} %>
				
				<% for(int i = startPage; i <= endPage; i++){%>
					<%if(pageNum == i){ %>
						<a href="javascript:void(0)"><%=i %></a>
					<%}else{ %>
					<a href="notice.jsp?keyword=<%=keyword %>&pageNum=<%=i %>"><%=i %></a>
					<%} %>
				<%} %>
				<!--  다음 페이지 버튼(Next) 클릭 시 현재 페이지 번호 + 1 값 전달 -->
				<%if(pageNum == maxPage){ %>
						<a href="javascript:void(0)">Next</a>
				<%}else{ %>
				<a href="notice.jsp?keyword=<%=keyword %>&pageNum=<%=pageNum+1%>">Next</a>
				<%} %>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


