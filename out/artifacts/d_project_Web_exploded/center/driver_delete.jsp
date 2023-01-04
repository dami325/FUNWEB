<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
int num = Integer.parseInt(request.getParameter("num"));

FileBoardDAO dao = new FileBoardDAO();
FileBoardDTO board = dao.selectFileBoard(num);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_delete.jsp</title>
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
	<div  class ="profiletb">
			<h1>글 삭제</h1>
			<form action="driver_deletePro.jsp" method="post">
			
			
				<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
				<table id="notice_content">
					<tr>
						<td>패스워드</td>
						<td><input type="password" name="pass" ></td>
					</tr>
					<tr>
						<td><input type="submit" value="글삭제" class="btn"></td>
				
						<td><input type="reset" value="돌아가기" onclick="history.back()" class="cancel">
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


