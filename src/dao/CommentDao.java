package dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.Comment;
import dto.Freeboard;
import mybatis.SqlSessionBean;

public class CommentDao {
	
	SqlSessionFactory factory = SqlSessionBean.getSessionFactory();
	private static CommentDao dao = new CommentDao();
	
	private CommentDao() {  }
		public static CommentDao getInstance() {
			return dao;
		
	}
	//getList
	public List<Comment> getComments(int mref){
								//key(변수명처럼 이해) String, value는 int
		List<Comment> list = null;
		SqlSession mapper = factory.openSession();
		list = mapper.selectList("getComments", mref);
		mapper.close();
		return list;
	}
	
	public void insert(Comment dto) {
		SqlSession mapper = factory.openSession();
		mapper.insert("comment.insert",dto);   //mapper xml 파일의 네임스페이스.id로 첫번째 인자 값.   
		mapper.commit();
		mapper.close();
	}
	public void delete(int idx) {
		SqlSession mapper = factory.openSession();
		mapper.delete("comment.delete",idx);
		mapper.commit();
		mapper.close();
	}
	
	
	public void updateCommentCnt(int idx) {
		SqlSession mapper = factory.openSession();
		mapper.update("updateCommentCnt",idx);
		mapper.commit();
		mapper.close();
	}
	public void updateCountAll(int idx) {
		SqlSession mapper = factory.openSession();
		mapper.update("updateCountAll",idx);
		mapper.commit();
		mapper.close();
	}
	
	
	
	
	
	
	
	
	
	
}
