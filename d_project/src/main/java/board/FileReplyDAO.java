package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;

public class FileReplyDAO {

	public int insertReply(FileReplyDTO reply) {
		int insertCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "INSERT INTO file_reply VALUES(null,?,?,?,?,now())";
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
		
	public List<FileReplyDTO> selectReplyList(int num) {
		List<FileReplyDTO> replyList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			String sql = "SELECT * FROM file_reply where refNum=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			replyList = new ArrayList<FileReplyDTO>();
			while(rs.next()) {
				FileReplyDTO reply = new FileReplyDTO();
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
				String sql = "DELETE FROM file_reply WHERE num=? AND name=?";
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
