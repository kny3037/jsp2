<%@page import="dto.Comment"%>
<%@page import="java.util.List"%>
<%@page import="dao.CommentDao"%>
<%@page import="dto.Freeboard"%>
<%@page import="dao.FreeboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//글 상세보기
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pageNo = Integer.parseInt(request.getParameter("page"));
	
	FreeboardDao dao = FreeboardDao.getInstance();
	if(session.getAttribute("readIdx")!=null){     
		//세션은 클라이언트 별로 서버에 저장되는 정보, 프로퍼티는 객체 내에 선언되어있는 변수를 의미,애트리뷰트는 속성
		StringBuilder readIdx = (StringBuilder)session.getAttribute("readIdx");
		boolean status = readIdx.toString().contains("/"+idx+"/");
		if(!status){ //읽은 글 목록 문자열에 idx가 포함되어있지 않으면 
			dao.readCount(idx);  //조회수 증가
			readIdx.append(idx + "/");   //읽은 글 목록에 추가
		}
	}else{
		StringBuilder readIdx=new StringBuilder("/");
		session.setAttribute("readIdx", readIdx);
	}
	
	
	
	
	Freeboard bean = dao.getOne(idx);
	
	//freeboard 테이블 idx 의 댓글목록 가져오기
	CommentDao cdao = CommentDao.getInstance();
	cdao.updateCountAll(idx);    //댓글 갯수 update
	List<Comment> cmts = cdao.getComments(idx);
	request.setAttribute("cmtlist", cmts);
	
	request.setAttribute("page", pageNo);
	
	//bean 객체로 참조하고 있는값은 detailView.jsp 에게 전달하고 브라우저에 출력하도록 합니다.
	request.setAttribute("bean", bean);
	pageContext.forward("detailView.jsp");
%>
