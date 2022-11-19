package member;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import board.BoardDTO;
import db.JdbcUtil;

public class MemberDAO {
	
	
	//로그인
	public MemberDTO login(String id, String pass) {
		MemberDTO member = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
			try {
				con = JdbcUtil.getConnection();
				String sql ="SELECT * FROM member WHERE id=? AND pass=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, id);
				pstmt.setString(2, pass);
				
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					member = new MemberDTO();
					member.setId(rs.getString("id"));
					member.setPass(rs.getString("pass"));
					member.setName(rs.getString("name"));
					member.setEmail("email");
					member.setPost_code("post_code");
					member.setAddress1(rs.getString("address1"));
					member.setAddress2(rs.getString("address2"));
					member.setMobile("mobile");
					member.setDate(rs.getDate("date"));
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
		
		
		return member;
	}
	
	//회원가입
	public int join(MemberDTO member) {
		int joinCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con = JdbcUtil.getConnection();

			String sql = "INSERT INTO member VALUES(?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getPost_code());
			pstmt.setString(6, member.getAddress1());
			pstmt.setString(7, member.getAddress2());
			pstmt.setString(8, member.getMobile());

			joinCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return joinCount;
	}
	
	
	public MemberDTO profile(String id) {
		MemberDTO member = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberDTO();
				member.setId(id);
				member.setPass(rs.getString("pass"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setPost_code(rs.getString("post_code"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setMobile(rs.getString("mobile"));
				member.setDate(rs.getDate("date"));
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return member;
	}
	
		
	
	
	public boolean checkId(String id) { //회원가입 아이디 중복확인
		
		boolean checkid = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				MemberDTO member = new MemberDTO();
				member.setId(id);
				
				checkid = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return checkid;
	}
	
	public String checkEmail(String email) {//email
		String checkemail = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "select * from member where email=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				MemberDTO member = new MemberDTO();
				member.setEmail(email);
				
				checkemail = email;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return checkemail;
	}
	
	
	
	//내 정보 수정
	public int updateMember(MemberDTO member) {
		int updateCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "UPDATE member SET address1=?,address2=?,name=? WHERE id=? AND pass=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, member.getAddress1());
			pstmt.setString(2, member.getAddress2());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getId());
			pstmt.setString(5, member.getPass());
			
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return updateCount;
	}
	
	//회원 탈퇴
	public int deleteMember(String id, String pass) {
		int deleteCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "DELETE FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		return deleteCount;
	}
	
	// 관리자 페이지 회원 제명
	public int deleteAdmin(String id,String mobile) {
		int deleteCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "DELETE FROM member WHERE id=? AND mobile=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, mobile);
			
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
	//회원목록 조회==================================================
	//전체 게시물 수 조회
		public int selectMemberListCount() {
			int memberListCount = 0;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = JdbcUtil.getConnection();
				String sql = "SELECT COUNT(*) from member";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					memberListCount = rs.getInt(1);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			return memberListCount;
		}
		//검색기능추가 오버로딩
		public int selectMemberListCount(String keyword) {
			int memberListCount = 0;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = JdbcUtil.getConnection();
				String sql = "SELECT COUNT(*) from member WHERE id LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" +keyword+ "%");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					memberListCount = rs.getInt(1);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			return memberListCount;
		}
		
		public ArrayList<MemberDTO> selectMemberList(int startRow, int listLimit) { // notice.jsp
			ArrayList<MemberDTO> memberList = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
				
				try {
					con = JdbcUtil.getConnection();
								//LIMIT 시작행번호, 페이지당 게시물목록수
					String sql = "SELECT * FROM member ORDER BY id desc LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, listLimit);
					
					rs = pstmt.executeQuery();
					
					memberList = new ArrayList<MemberDTO>();
					while(rs.next()) {
						MemberDTO member = new MemberDTO();
						member.setId(rs.getString("id"));
						member.setPass(rs.getString("pass"));
						member.setName(rs.getString("name"));
						member.setEmail(rs.getString("email"));
						member.setPost_code(rs.getString("post_code"));
						member.setAddress1(rs.getString("address1"));
						member.setAddress2(rs.getString("address2"));
						member.setMobile(rs.getString("mobile"));
						member.setDate(rs.getDate("date"));
						memberList.add(member);
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
			return memberList;
		}
		// 오버로딩 검색기능 추가
		public ArrayList<MemberDTO> selectMemberList(int startRow, int listLimit, String keyword) { // notice.jsp
			ArrayList<MemberDTO> memberList = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
				
				try {
					con = JdbcUtil.getConnection();
								//LIMIT 시작행번호, 페이지당 게시물목록수
					String sql = "SELECT * FROM member WHERE subject LIKE ? ORDER BY id desc LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" +keyword+ "%");
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, listLimit);
					
					rs = pstmt.executeQuery();
					
					memberList = new ArrayList<MemberDTO>();
					while(rs.next()) {
						MemberDTO member = new MemberDTO();
						member.setId(rs.getString("id"));
						member.setPass(rs.getString("pass"));
						member.setName(rs.getString("name"));
						member.setEmail(rs.getString("email"));
						member.setPost_code(rs.getString("post_code"));
						member.setAddress1(rs.getString("address1"));
						member.setAddress2(rs.getString("address2"));
						member.setMobile(rs.getString("mobile"));
						member.setDate(rs.getDate("date"));
						memberList.add(member);
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
			return memberList;
		}
	//------------------------------------------------------------------------------
	
	
	
	
} //class
