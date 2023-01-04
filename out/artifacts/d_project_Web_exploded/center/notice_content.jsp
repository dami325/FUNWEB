<%@page import="board.ReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.ReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<%
			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
		
			String sId = (String)session.getAttribute("sId");
			int num = Integer.parseInt(request.getParameter("num"));
			
			BoardDAO dao = new BoardDAO();
			
			BoardDTO board = dao.selectBoard(num);
			
			
			
			if(sId == null){
				%>
				<script>
				alert("로그인후 사용 가능합니다!");
				location.href="../member/login.jsp";
				</script>
			<% }%>
				
		<%
			
			
			if(board != null) { // 조회 결과가 존재할 경우
				
				dao.updateReadcount(num);			
			
				board.setReadcount(board.getReadcount()+1);
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
		function forwardReply(){
			
		  <%if(sId != null) {%>	
			var content = document.getElementById("reply_content").value;
			
			location.href = "notice_content_reply_writePro.jsp?boardType=notice&num=<%=board.getNum()%>&name=<%=sId%>&content=" + content;
			<%} else {%>
				alert("댓글은 로그인 후 사용 가능합니다!");
			<%}%>
		
		
		}
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id ="subdiv">
		<div  class ="writetb">
				<h1>글쓴이 : <%=board.getName() %></h1>
				<table id="notice_content">
					<tr>
						<td>글번호</td>
						<td><%=num %></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>작성일</td>
						<td><%=sdf.format(board.getDate())%></td>
						<td>조회수</td>
						<td><%=board.getReadcount() %></td>
					</tr>
					<tr>
						<td>제목</td>
						<td colspan="3"><%=board.getSubject() %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="3"><%=board.getContent()%></td>
					</tr>
					<tr>
					<td>댓글</td>
					<td colspan="2" class="content_reply">
						<textarea rows="1" id="reply_content" cols="60"></textarea>
					</td>
					<td>
						<input type="button" class="reply_btn" value="쓰기" 
							onclick="forwardReply()">
					</td>
				</tr>
				<% //댓글목록
				ReplyDAO replyDAO = new ReplyDAO();
				List<ReplyDTO> replyList = replyDAO.selectReplyList(num);
				
				
				//날짜 및 시각 형식을 :월월-일일  시시:분분" 형식으로 설정
				SimpleDateFormat sdf2 = new SimpleDateFormat("MM-dd HH:mm");
				
				for(ReplyDTO reply : replyList){
				%>
				<tr id="reply">
					<td>ID)<%=reply.getName() %></td>
					<td>댓글)<%=reply.getContent() %></td>
					<td>작성일)<%=sdf2.format(reply.getDate()) %></td>
					<td>
						<%if(sId.equals(reply.getName())){%>
						<input type="button" value="x" onclick="location.href='notice_content_reply_deletePro.jsp?num=<%=reply.getNum()%>&refNum=<%=num%>&name=<%=reply.getName()%>'">
								
							<% }%>
					</td>
				</tr>
					<% 
				}
				%>
					<tr>
						<%if(board.getName().equals(sId)){ %>
						<td><input type="button" value="글수정" class="btn" onclick="location.href='notice_update.jsp?num=<%=num%>'"></td> 
						<td><input type="button" value="글삭제" class="btn" onclick="location.href='notice_delete.jsp?num=<%=num%>'"> </td>
						<%} %>
						<td><input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'"></td>
						<td><input type="button" value="돌아가기" class="btn" onclick="history.back()">
						</td>
							
					</tr>
				</table>
			</div>
			</div>
	</div>
</body>
	<%} else {%>
		 <script>
			alert("게시물 상세정보 조회 실패!");
			history.back();
		</script>
		<%
	}
	%>



</html>