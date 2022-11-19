<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_write.jsp</title>
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	// 세션에 저장된 아이디가 null 이면 자바스크립트를 통해 회원만접근가능합니다 출력 후 돌아가기
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
	
	<script>
	function func1(fileName){
		
		
	}
	
	</script>	
	<div id="wrap">
		<jsp:include page="../inc/top.jsp" />
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id ="subdiv">
		<div  class ="writetb">
			<h1>사진 게시판</h1>
			<form action="driver_writePro.jsp?id=<%=sId %>"  method="post" enctype="multipart/form-data" name="fr">
				<table id="notice">

					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" required="required" maxlength="20"></td>
					</tr>
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name" value="<%=sId %>" required="required" readonly="readonly"></td>
					</tr>
					<tr>
						<td>파일</td>
						<td><input type="file" name="original_file" required="required" id ="file" onchange="func1(this.value)"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="15" cols="60" name="content" required="required" maxlength="40"></textarea></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pass" required="required"></td>
					</tr>

				<tr>
				<div id="table_search">
					<td><input type="submit" value="글쓰기" class="btn"></td>
					<td><input type="reset" value="돌아가기" onclick="history.back()" class="cancel"></td>
				</div>
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


