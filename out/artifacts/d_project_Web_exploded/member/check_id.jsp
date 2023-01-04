<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
MemberDAO dao = new MemberDAO();
boolean checkid = dao.checkId(id);

if(checkid == false){
	%>
	<script>
	window.opener.document.getElementById("checkIdResult").innerHTML = "사용가능 O";
	window.opener.document.getElementById("checkIdResult").style.color =  "GREEN";
	window.close();
	</script>
	<%
} else if (checkid == true){
     %>
     <script>
     window.opener.document.getElementById("checkIdResult").innerHTML = "사용불가 X";
     window.opener.document.getElementById("checkIdResult").style.color = "RED";
     window.close();
     </script>
     <%
}
%>