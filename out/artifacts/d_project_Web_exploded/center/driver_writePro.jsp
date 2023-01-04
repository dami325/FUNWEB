<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");


String uploadPath = "/upload";

int fileSize = 1024 * 1024 * 10; // byte(1) - > kb( 1024 byte) -> mb(1024 kb) -> 10MB 단위로 변환

ServletContext context = request.getServletContext();
String realPath = context.getRealPath(uploadPath);
MultipartRequest multi = new MultipartRequest(
		request,
		realPath,
		fileSize,
		"UTF-8",
		new DefaultFileRenamePolicy()// 중복 파일명에 대한 기본 처리담당객체 생성 
		);

FileBoardDTO board = new FileBoardDTO();
FileBoardDAO dao = new FileBoardDAO();


board.setName(multi.getParameter("name"));
board.setPass(multi.getParameter("pass"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));


String fileElement = multi.getFileNames().nextElement().toString();


board.setOriginal_file(multi.getOriginalFileName(fileElement));
board.setReal_file(multi.getFilesystemName(fileElement));


int insertCount = dao.insertFileBoard(board,id);

if(insertCount > 0) {
	response.sendRedirect("driver.jsp");
} else { 
	%>
	<script>
	alert("비밀번호가 틀렸습니다!");
	history.back();
	</script>
	<%
}



%>