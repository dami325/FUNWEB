package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;

public class NoticeReplyDAO {

	public int insertReply(NoticeReplyDTO reply) {
		int insertCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "INSERT INTO notice_reply VALUES(null,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, reply.getBoardType());
			pstmt.setInt(2, reply.getRefNum());
			pstmt.setString(3, reply.getName());
			pstmt.setString(4, reply.getContent());
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return insertCount;
	}
		
	public List<NoticeReplyDTO> selectReplyList(int num) {
		List<NoticeReplyDTO> replyList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "SELECT * FROM notice_reply where refNum=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			replyList = new ArrayList<NoticeReplyDTO>();
			while(rs.next()) {
				NoticeReplyDTO reply = new NoticeReplyDTO();
				reply.setNum(rs.getInt("num"));
				reply.setBoardType(rs.getString("boardType"));;
				reply.setRefNum(rs.getInt("refNum"));
				reply.setName(rs.getString("name"));
				reply.setContent(rs.getString("content"));
				reply.setDate(rs.getTimestamp("date"));
				replyList.add(reply);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return replyList;
	}
	
	public int deleteReply(int num,String name) {
		int deleteCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		con = JdbcUtil.getConnection();
		
			try {
				String sql = "DELETE FROM notice_reply WHERE num=? AND name=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				pstmt.setString(2, name);
				deleteCount = pstmt.executeUpdate();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}	finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			return deleteCount;
		}
	
	
	
	
	
	
	
	
	
}//dao
