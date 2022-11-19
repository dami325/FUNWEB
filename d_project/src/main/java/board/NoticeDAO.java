package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;

public class NoticeDAO {
	
	//전체 게시물 수 조회
	public int selectNoticeListCount() {
		int boardListCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "SELECT COUNT(*) from notice_board";
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
	public int selectNoticeListCount(String keyword) {
		int boardListCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "SELECT COUNT(*) from notice_board WHERE subject LIKE ?";
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
	
	public ArrayList<NoticeDTO> selectNoticeList() { // notice.jsp
		ArrayList<NoticeDTO> noticeList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
			
			try {
				con = JdbcUtil.getConnection();
							//LIMIT 시작행번호, 페이지당 게시물목록수
				String sql = "SELECT * FROM notice_board ORDER BY num desc";
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				noticeList = new ArrayList<NoticeDTO>();
				while(rs.next()) {
					NoticeDTO board = new NoticeDTO();
					board.setNum(rs.getInt("num"));
					board.setName(rs.getString("name"));
					board.setPass(rs.getString("pass"));
					board.setSubject(rs.getString("subject"));
					board.setContent(rs.getString("content"));
					board.setReadcount(rs.getInt("readcount"));
					board.setDate(rs.getTimestamp("date"));
					noticeList.add(board);
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
		return noticeList;
	}
	// 오버로딩 검색기능 추가
	public ArrayList<NoticeDTO> selectNoticeList(int startRow, int listLimit, String keyword) { // notice.jsp
		ArrayList<NoticeDTO> noticeList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
			
			try {
				con = JdbcUtil.getConnection();
							//LIMIT 시작행번호, 페이지당 게시물목록수
				String sql = "SELECT * FROM notice_board WHERE subject LIKE ? ORDER BY num desc LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" +keyword+ "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, listLimit);
				
				rs = pstmt.executeQuery();
				
				noticeList = new ArrayList<NoticeDTO>();
				while(rs.next()) {
					NoticeDTO board = new NoticeDTO();
					board.setNum(rs.getInt("num"));
					board.setName(rs.getString("name"));
					board.setPass(rs.getString("pass"));
					board.setSubject(rs.getString("subject"));
					board.setContent(rs.getString("content"));
					board.setReadcount(rs.getInt("readcount"));
					board.setDate(rs.getTimestamp("date"));
					noticeList.add(board);
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
		return noticeList;
	}
	
	//최근 게시물 목록 조회
	public ArrayList<NoticeDTO> selectRecentlyNoticeList(){
		ArrayList<NoticeDTO> noticeList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "SELECT * FROM notice_board ORDER BY num desc LIMIT 5";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			noticeList = new ArrayList<NoticeDTO>();
			while(rs.next()) {
				NoticeDTO board = new NoticeDTO();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setReadcount(rs.getInt("readcount"));
				board.setDate(rs.getTimestamp("date"));
				noticeList.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return noticeList;
	}
	//-------------------------------------------------------------------------------------
	
	//글쓰기
		public int insertNotice(NoticeDTO board,String id) { // notice_writePro.jsp
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
						sql = "SELECT MAX(num) FROM notice_board";
						pstmt = con.prepareStatement(sql);

						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							num = rs.getInt(1) + 1;
						}
						
						sql = "INSERT INTO notice_board VALUES (?,?,?,?,?,?,now())";
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
		public NoticeDTO selectNotice(int num) { 
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			NoticeDTO board = null;
			
			try {
				con = JdbcUtil.getConnection();
				
				String sql="SELECT * FROM notice_board WHERE num=?";
				pstmt = con.prepareStatement(sql);
				
				
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					board = new NoticeDTO();
					
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
				
				String sql = "UPDATE notice_board SET readcount=readcount+1 WHERE num=?";
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
		public int deleteNotice(int num, String pass) {
			int deleteCount = 0;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			con = JdbcUtil.getConnection();
			
			try {
				String sql = "DELETE FROM notice_board WHERE num=? AND pass=?";
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
		public int updateNotice(NoticeDTO board) {
			int updateCount = 0;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			con = JdbcUtil.getConnection();
			
			
				try {
					String sql = "UPDATE notice_board SET name=?,subject=?,content=? WHERE num=? AND pass=?";
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
