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
<body>
	<h2>LOGIN</h2>
	<hr/>
	<form action="userfind" method="post">
	    <table>
	        <tr>
	            <th>이름</th>
	            <th colspan="2">
	                <input type="text" name="name" value="" placeholder="이름을 입력 하세요"/>
	            </th>
	        </tr>
	        <tr>
	            <th>아이디</th>
	            <th colspan="2">
	                <input type="text" name="id" value="" placeholder="아이디를 입력하세요"/>
	            </th>                
	        </tr>
	        <tr>
	            <th>이메일</th>
	            <th colspan="2">
	                <input type="email" name="email" value="" placeholder="이메일을 입력하세요"/>
	            </th>                
	        </tr>
	        <tr>
	            <th colspan="3">
	                <input id ="userFind" type="button" value="비밀번호 찾기"/>
	            </th>    
	        </tr>
	    </table>
	</form>
</body>
<script>
	$('#userFind').on('click',function(){
		location.href='joinForm';
	});
	
	
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}


</script>
</html>