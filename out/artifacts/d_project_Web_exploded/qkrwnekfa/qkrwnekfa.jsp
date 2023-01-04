<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
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
%>	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
		<div id="wrap">
			<jsp:include page="../inc/top.jsp" />
			<jsp:include page="../inc/left.jsp"></jsp:include>
			<div id ="subdiv">
		<div  class ="profiletb">
			<h1>회원 관리</h1>
			<table>
				<tr id="first_tr">
					<th class="tdate">아이디</th>
					<th class="tdate">이름</th>
					<th></th>
				</tr>
				
				
				<%
		int listLimit = 10; 
		
		int pageNum = 1; 
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		int startRow = (pageNum - 1) * listLimit; 
		int endRow = startRow + listLimit - 1;
		MemberDAO dao = new MemberDAO();
		ArrayList<MemberDTO> memberList = dao.selectMemberList(startRow, listLimit);
		for(MemberDTO member : memberList){
			%>
				
					<tr id="maintr" onclick="location.href='admin_delete.jsp?id=<%=member.getId()%>&mobile=<%=member.getMobile()%>'">
						<td><%=member.getId()%></td>
						<td><%=member.getName()%></td>
			<td><div id="table_search">
<a href="#" id="aa"><input type="button" value="자세히" onclick="location.href='admin_delete.jsp?id=<%=member.getId()%>&mobile=<%=member.getMobile()%>'"></a>
		</div>
			</td>
					</tr>
			<% 
		}
		%>
		</table>
			

		

			<%
			int memberListCount = dao.selectMemberListCount();
			
			int pageListLimit = 10; 
			
			int maxPage = memberListCount / pageListLimit + (memberListCount % pageListLimit == 0 ? 0 : 1); 
				
			
			int startPage = (pageNum - 1 ) / pageListLimit * pageListLimit + 1;
			
			int endPage = startPage + pageListLimit - 1;
			
			if(endPage > maxPage){
				endPage = maxPage;
			}
			%>
			<div id="pageNum" style="text-align: left;">
				<%if(pageNum == 1){ %>
					<a href="javascript:void(0)">Prev</a>
				<%}else{ %>
				<a href="qkrwnekfa.jsp?pageNum=<%=pageNum-1%>">Prev</a>
				<%} %>
				
				<% for(int i = startPage; i <= endPage; i++){%>
					<%if(pageNum == i){ %>
						<a href="javascript:void(0)"><%=i %></a>
					<%}else{ %>
					<a href="qkrwnekfa.jsp?pageNum=<%=i %>"><%=i %></a>
					<%} %>
				<%} %>
				<!--  다음 페이지 버튼(Next) 클릭 시 현재 페이지 번호 + 1 값 전달 -->
				<%if(pageNum == maxPage){ %>
						<a href="javascript:void(0)">Next</a>
				<%}else{ %>
				<a href="qkrwnekfa.jsp?pageNum=<%=pageNum+1%>">Next</a>
				<%} %>
				</div>
		</div>
		</div>
		</div>
</body>
</html>


