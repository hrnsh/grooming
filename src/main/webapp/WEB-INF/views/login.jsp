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
	<form action="logingo" method="post">
	    <table>
	        <tr>
	            <th>ID</th>
	            <th colspan="2">
	                <input type="text" name="id" value="" placeholder="아이디를 입력 하세요"/>
	            </th>
	        </tr>
	        <tr>
	            <th>PW</th>
	            <th colspan="2">
	                <input type="password" name="pw" value="" placeholder="비밀번호를 입력 하세요"/>
	            </th>                
	        </tr>
	        <tr>
	            <th colspan="2">
	                <input type="submit" value="login"/>
	            </th>	        
	        </tr>
	        <tr>
	            <th colspan="3">
	                <input id="regist" type="button" value="회원가입"/>
	                <input id ="findID" type="button" value="아이디 찾기"/>
	                <input id ="findPW" type="button" value="비밀번호 찾기"/>
	            </th>    
	        </tr>
	    </table>
	</form>
</body>
<script>
	$('#regist').on('click',function(){
		location.href='joinForm';
	});
	
	$('#findID').on('click',function(){
		location.href='findID';
	});	

	$('#findPW').on('click',function(){
		location.href='findPW';
	});
	
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}


</script>
</html>