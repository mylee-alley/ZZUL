package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.JspNameDTO;

public class JspNameDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	// jsp 페이지 정보 조회
	public JspNameDTO getJspName(String path) {
		System.out.println("getJspName name ::: " + path);
		JspNameDTO jl = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from JSPNAME where path=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, path);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				jl = new JspNameDTO();
				jl.setNum(rs.getInt("num"));
				jl.setFolder(rs.getString("folder"));
				jl.setJsp(rs.getString("jsp"));
				jl.setUserShowExplain(rs.getString("userShowExplain"));
				System.out.println("getUserShowExplain :::" + jl.getUserShowExplain());
				jl.setExplain(rs.getString("explain"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			 OracleConnection.close(rs, pstmt, conn);
		}
		return jl;
	}
	
	
	// jsp 페이지 정보 목록 조회 - 관리자...만볼거라...필요 없을지도....나중에관리자용따로만들면사용할듯
	public List getJspList(String name) {
		List jspList = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from JSPNAME";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			jspList = new ArrayList();
			while(rs.next()) {
				JspNameDTO jl = new JspNameDTO();
				jl.setNum(rs.getInt("num"));
				jl.setFolder(rs.getString("folder"));
				jl.setJsp(rs.getString("jsp"));
				jl.setUserShowExplain(rs.getString("userShowExplain"));
				jl.setExplain(rs.getString("explain"));
				jspList.add(jl);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			 OracleConnection.close(rs, pstmt, conn);
		}
		return jspList;
	}

}
