<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_write.jsp</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<%
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
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id ="subdiv">
		<div  class ="writetb">
		
			<h1>글쓰기</h1>
			<form action="notice_writePro.jsp?id=<%=sId %>" method="post" name="fr">
				<table id="notice">

					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name"  value="<%=sId %>"required="required" readonly="readonly"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" required="required" width="300px" maxlength="20" placeholder="1~20글자"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="15" cols="60" name="content" required="required"></textarea></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pass" required="required"></td>
					</tr>

					<tr>
						
				<div id="table_search" >
					<td><input type="submit" value="글쓰기" class="btn"></td>
					<td><input type="reset" value="돌아가기" onclick="history.back()" class="cancel"></td>
				</div>
					</tr>
				</table>
			</form>
		</div>
		</div>

	</div>
</body>
</html>


