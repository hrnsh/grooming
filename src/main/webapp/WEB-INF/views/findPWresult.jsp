<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style>
    table, th, td{
        border: 1px solid black;
        border-collapse: collapse;
        padding: 5px 10px;
    }
    
    input[type="submit"]{
    	height: 30px;
    }    
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
    <title>비밀번호 찾기 결과</title>
</head>
<body>
    <c:if test="${pw != null}">
        <p>회원님의 비밀번호: ${pw}</p>
    </c:if>
    <c:if test="${pw == null}">
        <p>${message}</p>
    </c:if>
</body>
<script>

</script>
</html>