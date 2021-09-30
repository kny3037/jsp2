<%@page import="dao.FreeboardDao"%>
<%@page import="dto.Freeboard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  <!-- 1시43분 다시 듣기 -->
<%
	//가장 첫줄에 작성할 코드는? : request.setCharacterEncoding("UTF-8");
	//수정 버튼 -> 내용 변경 -> 저장버튼으로 실행
	request.setCharacterEncoding("UTF-8");
	int pageNo = Integer.parseInt(request.getParameter("page"));
	int idx = Integer.parseInt(request.getParameter("idx"));
	String subject = request.getParameter("subject");
//	String password = request.getParameter("password");
	String content = request.getParameter("content");
//	String ip = request.getRemoteAddr();
	
	Freeboard dto = new Freeboard();
//	dto.setIp(ip);
//	dto.setPassword(password);
	dto.setIdx(idx);
	dto.setSubject(subject);
	dto.setContent(content);
	
	FreeboardDao dao = FreeboardDao.getInstance();
	dao.update(dto);
	/* response.sendRedirect("updateAction.jsp?idx="+idx); */
	response.sendRedirect("detailAction.jsp?idx="+idx+"&page="+pageNo);






%>