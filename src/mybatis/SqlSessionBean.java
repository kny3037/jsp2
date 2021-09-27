package mybatis;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionBean {
/*
 * Mybatais 라이브러리의 SqlSession 클래스가 SQL 실행메소드를 제공합니다.
 * SqlSesseionFactoryBuilder --> SqlSessionFactory 객체 생성 --> SqlSession 객체 생성  : 클래스 의존관계
 * 	
 */
	public static SqlSessionFactory sqlSessionFactory;
	static {   //변수들이 static 영역에 저장됩니다.
		String resource = "mybatis/mybatis-config.xml";    //mybatis 설정파일
		InputStream inputStream=null;			//파일을 읽기위한 입력 스트림
	
	
		try {
			inputStream = Resources.getResourceAsStream(resource);   //리소스 파일 읽어오기
		}catch(IOException e) {
		
		}
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);   //읽어온 파일로 factory 생성
	}
	
	public static SqlSessionFactory getSessionFactory() {    //생성된 sqlSessionFactory 리턴하는 메소드
		return sqlSessionFactory;
	}
}