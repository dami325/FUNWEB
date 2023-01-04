<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String sId = (String)session.getAttribute("sId");
	// 오브젝트 타입을 가져오는데 실패하면 null
	// 스트링 타입을 가져오는데 실패하면 "" (널스트링)
%>
<script>
	function confirm_logout() {
		// confirm dialog 를 활용하여 "로그아웃 하시겠습니까? 질문 처리
		var result = confirm("로그아웃 하시겠습니까?");		
		
		//예(true)일 경우 logout.jsp 페이지로 이동
		if(result) {
			location.href = "../member/logout.jsp";
		}
	}
</script>

<header>
  <!-- login join -->
  <div id="top_menu">
  <div id="login">
  <ul>
  	<% if(sId == null){%>
  		<li><a id="aa" href="../member/login.jsp">로그인</a></li><li><a id="aa" href="../member/join.jsp">회원가입</a></li>
  	<% }else{%> 
  																		<!-- 로그아웃 클릭시 자바스크립트 함수 호출 -->
  		<li><a><%=sId %>님</a></li>
  		<li><a id="aa" href="../member/profile.jsp?id=<%=sId%>">내 정보</a></li>
  		<li><a id="aa"href="javascript:confirm_logout()">로그아웃</a></li>
<!--   		아이디에 하이퍼링크를 만들어 클릭시 회원정보 조회페이지 만들기 -->
  		
  	<% if(sId.equals("qkrwnekfa")){%> 
  					<li><a id="aa" href="../qkrwnekfa/qkrwnekfa.jsp?id=<%=sId%>">관리자페이지</a></li>
  	 <%}%>
  <% }%>
  </ul>
  </div>
  <!-- 로고들어가는 곳 -->
  <!-- 메뉴들어가는 곳 -->
  	<ul>
  		<li><a href="../main/main.jsp">홈</a></li>
  	</ul>
  	</div>
</header>