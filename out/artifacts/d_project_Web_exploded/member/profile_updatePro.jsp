<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");

MemberDTO member = new MemberDTO();
MemberDAO dao = new MemberDAO();
member.setId(id);
member.setPass(pass);
member.setName(name);
member.setAddress1(address1);
member.setAddress2(address2);
int updateCount = dao.updateMember(member);

if(updateCount > 0 ) {
	%>
	<script>
		alert("정보 수정 완료!")
	</script>
	<%
	response.sendRedirect("profile.jsp?id="+id);
} else {
	%>
	<script>
		alert("비밀번호가 일치하지 않습니다!");
		history.back();
	</script>
	<% 
}

%>    
    
    
    
    
    
    
    
    
    