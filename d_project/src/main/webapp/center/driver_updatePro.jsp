<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

String uploadPath = File.separator + "upload";
String realPath = request.getServletContext().getRealPath(uploadPath);
int fileSize = 1024 * 1024 * 10; 
MultipartRequest multi = new MultipartRequest(
	request,
	realPath,
	fileSize,
	"UTF-8", 
	new DefaultFileRenamePolicy() 
);

FileBoardDTO board = new FileBoardDTO();
board.setNum(Integer.parseInt(multi.getParameter("num"))); // 원본 글번호
board.setName(multi.getParameter("name"));
board.setPass(multi.getParameter("pass"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));
String fileElement = multi.getFileNames().nextElement().toString();
board.setOriginal_file(multi.getOriginalFileName(fileElement)); // 원본 파일명
board.setReal_file(multi.getFilesystemName(fileElement)); // 실제 업로드 된 파일명

FileBoardDAO dao = new FileBoardDAO();
int updateCount = dao.updateFileBoard(board);

if(updateCount > 0) { // 수정 성공 시
	String realFile = multi.getParameter("real_file"); // 기존 업로드 된 파일명 가져오기
	
	File f = new File(realPath, realFile);
	if(f.exists()) {
		f.delete();
	}
	response.sendRedirect("driver_content.jsp?num=" + board.getNum());	
} else {
	%>
	<script>
		alert("비밀번호 불일치");
		history.back();
	</script>
	<%
}
%>
    
    
    
    
    
    