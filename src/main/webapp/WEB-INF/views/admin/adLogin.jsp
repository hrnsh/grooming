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
	<form action="adLoginGo" method="post">
	    <table>
	        <tr>
	            <th style="width:40px;">ID</th>
	            <th colspan="2">
	                <input type="text" name="ad_id" value="" placeholder="아이디를 입력 하세요"/>
	            </th>
	        </tr>
	        <tr>
	            <th style="width:40px;">PW</th>
	            <th colspan="2">
	                <input type="password" name="ad_pw" value="" placeholder="비밀번호를 입력 하세요"/>
	            </th>                
	        </tr>
	        <tr>
	            <th colspan="2">
	                <input type="submit" value="login"/>
	            </th>	        
	        </tr>
	    </table>
	</form>
</body>
<script>

	var msg = '${msg}';
	if(msg != ''){
		alert(msg);
	}

</script>
</html>