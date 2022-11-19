package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;

public class BoardDAO {
	
	//전체 게시물 수 조회
	public int selectBoardListCount() {
		int boardListCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "SELECT COUNT(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				boardListCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		return boardListCount;
	}
	//검색기능추가 오버로딩
	public int selectBoardListCount(String keyword) {
		int boardListCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "SELECT COUNT(*) from board WHERE subject LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" +keyword+ "%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				boardListCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		return boardListCount;
	}
	
	public ArrayList<BoardDTO> selectBoardList(int startRow, int listLimit) { // notice.jsp
		ArrayList<BoardDTO> boardList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
			
			try {
				con = JdbcUtil.getConnection();
							//LIMIT 시작행번호, 페이지당 게시물목록수
				String sql = "SELECT * FROM board ORDER BY num desc LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, listLimit);
				
				rs = pstmt.executeQuery();
				
				boardList = new ArrayList<BoardDTO>();
				while(rs.next()) {
					BoardDTO board = new BoardDTO();
					board.setNum(rs.getInt("num"));
					board.setName(rs.getString("name"));
					board.setPass(rs.getString("pass"));
					board.setSubject(rs.getString("subject"));
					board.setContent(rs.getString("content"));
					board.setReadcount(rs.getInt("readcount"));
					board.setDate(rs.getTimestamp("date"));
					boardList.add(board);
				}
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - selectBoardList");
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
		return boardList;
	}
	// 오버로딩 검색기능 추가
	public ArrayList<BoardDTO> selectBoardList(int startRow, int listLimit, String keyword) { // notice.jsp
		ArrayList<BoardDTO> boardList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
			
			try {
				con = JdbcUtil.getConnection();
							//LIMIT 시작행번호, 페이지당 게시물목록수
				String sql = "SELECT * FROM board WHERE subject LIKE ? ORDER BY num desc LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" +keyword+ "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, listLimit);
				
				rs = pstmt.executeQuery();
				
				boardList = new ArrayList<BoardDTO>();
				while(rs.next()) {
					BoardDTO board = new BoardDTO();
					board.setNum(rs.getInt("num"));
					board.setName(rs.getString("name"));
					board.setPass(rs.getString("pass"));
					board.setSubject(rs.getString("subject"));
					board.setContent(rs.getString("content"));
					board.setReadcount(rs.getInt("readcount"));
					board.setDate(rs.getTimestamp("date"));
					boardList.add(board);
				}
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - selectBoardList");
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
		return boardList;
	}
	
	//최근 게시물 목록 조회
	public ArrayList<BoardDTO> selectRecentlyBoardList(){
		ArrayList<BoardDTO> boardList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "SELECT * FROM board ORDER BY num desc LIMIT 5";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			boardList = new ArrayList<BoardDTO>();
			while(rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setReadcount(rs.getInt("readcount"));
				board.setDate(rs.getTimestamp("date"));
				boardList.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return boardList;
	}
	//-------------------------------------------------------------------------------------
	
	//글쓰기
		public int insertBoard(BoardDTO board,String id) { // notice_writePro.jsp
			int insertCount = 0;

			Connection con = null;
			PreparedStatement pstmt = null, pstmt2 =null, pstmt3 =null;
			ResultSet rs = null ,rs2 = null;
			int num = 1;	
			
				con = JdbcUtil.getConnection();
				

				try {
					
					
					String sql = "select * from member where id=? AND pass=?";
					pstmt3 = con.prepareStatement(sql);
					
					pstmt3.setString(1, id);
					pstmt3.setString(2, board.getPass());
					rs2 = pstmt3.executeQuery();
					if(!(rs2.next())) {
						return insertCount;
					}else {
						sql = "SELECT MAX(num) FROM board";
						pstmt = con.prepareStatement(sql);

						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							num = rs.getInt(1) + 1;
						}
						
						sql = "INSERT INTO board VALUES (?,?,?,?,?,?,now())";
						pstmt2 = con.prepareStatement(sql);
						
						pstmt2.setInt(1, num); 
						pstmt2.setString(2, board.getName()); 
						pstmt2.setString(3, board.getPass());
						pstmt2.setString(4, board.getSubject()); 
						pstmt2.setString(5, board.getContent()); 
						pstmt2.setInt(6, 0);
						
						insertCount = pstmt2.executeUpdate();
					}
					
					
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					
					JdbcUtil.close(rs);
					JdbcUtil.close(rs2);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(pstmt2);
					JdbcUtil.close(pstmt3);
					JdbcUtil.close(con);
				}
			return insertCount;
		}
		//--------------------------------------------------------------------------
		
		//글 상세정보
		public BoardDTO selectBoard(int num) { // notice_content.jsp
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoardDTO board = null;
			
			try {
				con = JdbcUtil.getConnection();
				
				String sql="SELECT * FROM board WHERE num=?";
				pstmt = con.prepareStatement(sql);
				
				
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					board = new BoardDTO();
					
					board.setNum(num);
					board.setName(rs.getString("name"));
					board.setPass(rs.getString("pass"));
					board.setSubject(rs.getString("subject"));
					board.setContent(rs.getString("content"));
					board.setReadcount(rs.getInt("readcount"));
					board.setDate(rs.getTimestamp("date"));
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			return board;
		}
		
		
		
		//조회수 증가
		public void updateReadcount(int num) { //notice_content.jsp
				
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = JdbcUtil.getConnection();
				
				String sql = "UPDATE board SET readcount=readcount+1 WHERE num=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			
		}
		
		//글삭제
		public int deleteBoard(int num, String pass) {
			int deleteCount = 0;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			con = JdbcUtil.getConnection();
			
			try {
				String sql = "DELETE FROM board WHERE num=? AND pass=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, pass);
				
				deleteCount = pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			return deleteCount;
		}
		
		//글 수정
		public int updateBoard(BoardDTO board) {
			int updateCount = 0;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			con = JdbcUtil.getConnection();
			
			
				try {
					String sql = "UPDATE board SET name=?,subject=?,content=? WHERE num=? AND pass=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, board.getName());
					pstmt.setString(2, board.getSubject());
					pstmt.setString(3, board.getContent());
					pstmt.setInt(4, board.getNum());
					pstmt.setString(5, board.getPass());
					
					updateCount = pstmt.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
				}
			
			return updateCount;
		}
		
		
	
	
}// class
