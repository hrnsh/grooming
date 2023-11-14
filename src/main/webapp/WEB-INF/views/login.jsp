<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style>
   		body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h2 {
            text-align: center;
            color: #333;
            position: relative;
            bottom: 240px;
            left: 200px;
            font-size: 30px;
            top: -200px;
        }

        form {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 400px;
            right: 50px;
            position: relative;
            padding: 30px; 
            width: 350px; 
            top: 40px;
        }

        table {
            width: 100%;
            padding: 10px;
        }

        th {
            text-align: left;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 12px; /* 조정된 부분: 높이를 조절하려면 이 값을 조정하세요 */
            margin-top: 10px; /* 조정된 부분: 상단 여백을 조절하려면 이 값을 조정하세요 */
        }

        input[type="submit"],
        input[type="button"] {
            width: 100%;
            background-color: rgb(243, 208, 204);
            color: rgb(115, 112, 112);
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            padding: 14px; /* 조정된 부분: 높이를 조절하려면 이 값을 조정하세요 */
        }

        input[type="submit"]:hover,
        input[type="button"]:hover {
            background-color: rgb(227, 156, 147);
        }

        #regist,
        #findID,
        #findPW {
            background-color: rgb(224, 224, 224);
            color: rgb(115, 112, 112);
            border: none;
            padding: 8px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
            padding: 12px 16px; /* 조정된 부분: 높이와 너비를 조절하려면 이 값을 조정하세요 */
        }

        #regist:hover,
        #findID:hover,
        #findPW:hover {
            background-color: rgb(163, 161, 161);
        }
        
        .arrowBtn{
        	position: relative;
			top: 50px;
			
			background-color: rgb(243, 208, 204);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 20px;
        }
        
</style>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
	<button onclick="location.href='./'" class="arrowBtn"> ← </button>
	<h2>LOGIN</h2>
	<form action="logingo" id="logingo" method="post">
	    <table>
	        <tr>
	            <th style="width:40px;">ID</th>
	            <th colspan="2">
	                <input type="text" name="user_id" value="" placeholder="아이디를 입력 하세요"/>
	            </th>
	        </tr>
	        <tr>
	            <th style="width:40px;">PW</th>
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