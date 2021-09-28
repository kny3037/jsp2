<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동아리 커뮤니티</title>
<link rel="stylesheet" href="../css/boardlist.css?v=3">
</head>
<body>
<h3>동아리 커뮤니티</h3>
<hr>
<div style="margin:auto;">
<ul id="main">
	<li>
		<ul  class="row">
			<li>번호</li>   <!-- css child(1) -->
			<li>제목</li>   <!-- css child(2) -->
			<li>작성자</li>  <!-- css child(3) -->
			<li>조회수</li>  <!-- css child(4) -->
			<li>작성일</li>  <!-- css child(5) -->
		</ul>
	</li>
 	<c:forEach var="vo" items="${list}"> 
	<li>
	<ul  class="row">
		<li>${vo.idx }</li>
		<li><a href="detailAction.jsp?idx=${vo.idx}&page=1" class="title">${vo.subject }</a>
	 		...<span style="color:orange;font-size: 80%;">(${vo.commentCount })
	 		</span></li>
		<li>${vo.name }</li>
		<li>${vo.readCount }</li>
		<li><fmt:formatDate value="${vo.wdate }" pattern="yyyy-MM-dd"/></li>
	</ul>
	</li>
 	</c:forEach>
</ul>
<div style="margin:auto;">
 	Go!<a class="button" href="insert.jsp">글쓰기</a>
 	<a class="button" href="${pageContext.request.contextPath }">홈</a>작성글 총 개수 : 
</div>
</div>
</body>
</html>