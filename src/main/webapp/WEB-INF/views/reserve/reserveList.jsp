<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
table,th, td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
		
	}
	
	table {
		width:500px
	}
	
	input[type="text"]{
		width:100%;
	}
	button{
		margin: 5px 0;
	}
	
	textarea{
		width: 100%;	
		height : 150px;
		resize: none;
	}
	
</style>
</head>
<body>
	<table>
		<tr>
			<th>예약번호</th>
			<th>업체명</th>
			<th>시작 날짜</th>
			<th>종료 날짜</th>
			<th>상태</th>
		</tr>
		<!-- 내용 -->
		<c:if test="${reserveList.size()==0 }">
		<tr><td colspan="5">예약이 존재하지 않습니다.</td></tr>
		</c:if>
		<c:forEach items="${reserveList}" var="bbs">
		<tr>
			<td>${bbs.r_num}</td>
			<td>${bbs.com_id}</td>
			<td>${bbs.r_start}</td>
			<td>${bbs.r_end}</td>
			<td>${bbs.r_state}</td>
		</tr>
		</c:forEach>
	</table>
</body>
<script></script>
</html>