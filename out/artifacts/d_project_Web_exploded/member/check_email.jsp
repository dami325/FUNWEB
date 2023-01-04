<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");

String email = request.getParameter("email");
out.println(email);
MemberDAO dao = new MemberDAO();
String checkEmail = dao.checkEmail(email);

if(checkEmail == null){
	%>
	<script>
	window.opener.document.getElementById("checkEmailResult").innerHTML = "사용가능 O";
	window.opener.document.getElementById("checkEmailResult").style.color =  "GREEN";
	window.close();
	</script>
	<%
} else if (checkEmail != null){
     %>
     <script>
     window.opener.document.getElementById("checkEmailResult").innerHTML = "사용불가 X";
     window.opener.document.getElementById("checkEmailResult").style.color = "RED";
     window.close();
     </script>
     <%
}
%>