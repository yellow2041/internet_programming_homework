package myBean.DB;

import java.sql.*;
import javax.naming.NamingException;
import myBean.DB.DsCon;

public class ArticleDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ArticleDB() throws SQLException, NamingException {
		con = DsCon.getConnection();
	}

	public void insertRecord(Article art) throws SQLException {
		String sql = "INSERT INTO user(id, name, birth, pwd) VALUES(?, ?, ?, ?)";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, art.getId());
		pstmt.setString(2, art.getName());
		pstmt.setString(3, art.getBirth());
		pstmt.setString(4, art.getPwd());

		pstmt.executeUpdate();
	}

	public void updateRecord(Article art) throws SQLException {
		String sql = "UPDATE user SET id=?, name=?, birth=?, pwd=? WHERE idx=?";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, art.getId());
		pstmt.setString(2, art.getName());
		pstmt.setString(3, art.getPwd());
		pstmt.setInt(4, art.getIdx());

		pstmt.executeUpdate();
	}

	public Article getRecord(int idx) throws SQLException {
		String sql = "SELECT id, name, birth, pwd FROM user WHERE idx=?";

		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);

		rs = pstmt.executeQuery();

		rs.next();

		Article art = new Article();
		art.setId(rs.getString("id"));
		art.setName(rs.getString("name"));
		art.setBirth(rs.getString("birth"));
		art.setPwd(rs.getString("pwd"));
		art.setIdx(idx);

		return art;
	}
	
	public void deleteRecord(int idx)throws SQLException {
		String sql="DELETE FROM user WHERE idx=?";
		
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		
		pstmt.executeUpdate();
	}
	
	public void close() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
}
