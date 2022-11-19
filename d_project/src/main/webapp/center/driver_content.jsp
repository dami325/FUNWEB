<%@page import="board.FileReplyDTO"%>
<%@page import="board.FileReplyDAO"%>
<%@page import="java.util.List"%>
<%@page import="board.ReplyDAO"%>
<%@page import="board.ReplyDTO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<%
			String sId = (String)session.getAttribute("sId");
			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
		
			int num = Integer.parseInt(request.getParameter("num"));
			
			FileBoardDAO dao = new FileBoardDAO();
			
			FileBoardDTO board = dao.selectFileBoard(num);
			
			
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
<title>center/driver_content.jsp</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
		function forwardReply(){
			
		  <%if(sId != null) {%>	
			var content = document.getElementById("reply_content").value;
			
			location.href = "driver_content_reply_writePro.jsp?boardType=notice&num=<%=board.getNum()%>&name=<%=sId%>&content=" + content;
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
		<div id ="driver_content">
		<div  class ="drivertb">
				<h1>제목	:	<%=board.getSubject() %></h1>
				<table id="notice_content">
					<tr>
						<td>작성자 	: 	<%=board.getName() %></td>
						<td>글번호 	: 	<%=num %></td>
						<td>조회수 	: 	<%=board.getReadcount() %></td>
						<td>작성일 	: 	<%=sdf.format(board.getDate())%></td>
					</tr>
					<tr>
					<td>사진</td>
						<td colspan="3"><img src="../upload/<%=board.getReal_file() %>"></td>
					</tr>
					<tr>
						<td>사진 설명</td>
						<td colspan="3"><%=board.getContent()%></td>
					</tr>
					<tr>
					<td>이미지 다운</td>
					<td>
						<a href="../upload/<%=board.getReal_file()%>" download="<%=board.getOriginal_file()%>"><%=board.getOriginal_file()%></a>
					</td>
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
					FileReplyDAO replyDAO = new FileReplyDAO();
					List<FileReplyDTO> replyList = replyDAO.selectReplyList(num);
					
					
					//날짜 및 시각 형식을 :월월-일일  시시:분분" 형식으로 설정
					SimpleDateFormat sdf2 = new SimpleDateFormat("MM-dd HH:mm");
					
					for(FileReplyDTO reply : replyList){
					%>
					<tr id="reply">
						<td>ID)<%=reply.getName() %></td>
						<td>댓글)<%=reply.getContent() %></td>
						<td>작성일)<%=sdf2.format(reply.getDate()) %></td>
						<td>
							<%if(sId.equals(reply.getName())){%>
							<input type="button" value="x" onclick="location.href='driver_content_reply_deletePro.jsp?num=<%=reply.getNum()%>&refNum=<%=num%>&name=<%=reply.getName()%>'">
								
							<% }%>
						</td>
					</tr>
							<% 
							}
							%>
					<tr>
						<%if(board.getName().equals(sId)){ %>
						<td><input type="button" value="글수정" class="btn" onclick="location.href='driver_update.jsp?num=<%=num%>'"></td> 
						<td><input type="button" value="글삭제" class="btn" onclick="location.href='driver_delete.jsp?num=<%=num%>'"> </td>
						<%} %>
						<td><input type="button" value="글목록" class="btn" onclick="location.href='driver.jsp'"></td>
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