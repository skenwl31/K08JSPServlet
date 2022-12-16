package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.DBConnPool;


//JDBC를 이용한 DB연결을 위해 클래스 상속
public class MVCBoardDAO extends DBConnPool{
	
	//생성자에서 DBCP(커넥션풀)를 통해 오라클에 연결한다.
	public MVCBoardDAO() {
		super();
	}
	
	//게시물의 갯수를 카운트한다.
	public int selectCount(Map<String, Object> map) {
	
		int totalCount = 0;
		//만약 검색어가 있다면 조건에 맞는 게시물을 카운트
		//해야하므로 조건부(where)로 쿼리문을 추가한다.
		String query = "SELECT COUNT(*) FROM mvcboard";

		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		try {
			//정적쿼리문 실행을 위한 Statement객체 생성
			stmt = con.createStatement();
			//쿼리문 실행후 결과는 ResultSet으로 반환한다.
			rs = stmt.executeQuery(query);
			//커서를 첫번째 행으로 이동하여 레코드를 읽는다.
			rs.next();
			//첫번째 컬럼의 값을 가져와서 변수에 저장한다.
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	/*모델 1 방식에서는 board테이블 및 boardDTO클래스만 사용했지만
	 * 모델2 방식엥서는 mvcboard테이블 및 MVCBoardDTO를
	 * 사용하므로 해당 코드만 수정하면 된다.*/
	//조건에 맞는 게시물을 목록에 출력하기 위한 쿼리문을 실행
	public List<MVCBoardDTO> selectListPage(Map<String, Object> map){
		
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		
		String query = " "
				 	+ "SELECT * FROM ( "
				 	+ "    SELECT Tb.*, ROWNUM rNum FROM ( "
				 	+ "        SELECT * FROM mvcboard ";
		
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		//
		query += " ORDER BY idx DESC "
				+ "    ) Tb "
				+ " ) "
				+ " WHERE rNum BETWEEN ? ANd ?";
		
		try {
			//쿼리실행 및 결과값 반환
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			//2개 이상의 레코드가 반환될 수 있으므로 while문을 사용함
			//갯수만큼 반복하게된다.
			while(rs.next()){
				//하나의 레코드를 저장할 수 있는 DTO객체를 생성
				MVCBoardDTO dto = new MVCBoardDTO();
				
				//setter()를 이용해서 각 컬럼의 값을 저장
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				
				//List컬렉션에 DTO객체를 추가한다.
				board.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}
	
	//글쓰기 처리시 첨부파일까지 함께 입력한다.
	public int insertWrite(MVCBoardDTO dto) {
		int result = 0;
		try {
			/*
			ofile : 원본파일명
			sfile : 서버에 저장된 파일명
			pass : 비회원제 게시판이므로 수정,삭제를 위한
				   인증에 사용되는 비밀번호 
			*/
			String query = "INSERT INTO mvcboard ( "
						+ " idx, name, title, content, ofile, sfile, pass) "
						+ " VALUES ( "
						+ " seq_board_num.NEXTVAL,?,?,?,?,?,?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
}
