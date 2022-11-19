<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));

BoardDAO dao = new BoardDAO();
BoardDTO board = dao.selectBoard(num);


%>	
	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_update.jsp</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
	String id = (String)session.getAttribute("sId");
	
	if(id == null || !id.equals("qkrwnekfa") && !id.equals(board.getName())) {
		%>
		<script>
			alert("작성자만 접근가능");
			history.back();
		</script>
		<%
	}
	%>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id ="subdiv">
		<div  class ="writetb">
			<h1>게시글 수정</h1>
			<form action="notice_updatePro.jsp" method="post">
			<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
				<table id="notice">
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name" value="<%=board.getName() %>" required="required" readonly="readonly"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value="<%=board.getSubject() %>" required="required"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="15" cols="60" name="content" required="required"><%=board.getContent() %></textarea></td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<td>
						<input type="submit" value="수정하기" class="btn">
						</td>
						<td>
						<input type="reset" value="돌아가기" onclick="history.back()" class="cancel">
						</td>
					</tr>
				</table>

			</form>
		</div>
		</div>

		<!-- 푸터 들어가는곳 -->
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


