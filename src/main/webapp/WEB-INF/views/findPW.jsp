<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style>
    input[type="submit"]{
    	height: 30px;
    }    
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
   <h2>비밀번호 찾기</h2>
    <form action="dofindPW" method="post">
        <label for="name">이름:</label>
        <input type="text" id="name" name="name" placeholder="이름을 입력해주세요"><br>
        <label for="user_id">아이디:</label>
        <input type="text" id="user_id" name="user_id" placeholder="아이디를 입력해주세요"><br>
        <label for="email">이메일:</label>
        <input type="text" id="email" name="email" placeholder="이메일을 입력해주세요"><br>
        <button type="submit">비밀번호 찾기</button>
    </form>
</body>
<script>


</script>
</html>