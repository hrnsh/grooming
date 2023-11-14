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
            bottom: 180px;
            left: 160px;
        }

        form {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 300px;
            position: relative;
            right: 70px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        input {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: rgb(243, 208, 204);
            color: rgb(115, 112, 112);
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: rgb(227, 156, 147);
        }
        
        .arrowBtn{
        	position: relative;
			
			background-color: rgb(243, 208, 204);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 20px;
        }
        
#modal{
	display: none; 
	width:300px; 
	height:150px; 
	background: rgb(237, 237, 237); 
	border:1px solid gray; 
	text-align:center;
	position:absolute; 
	left:50%; 
	margin-left:200px;
}

.modalBtn{
	height: 35px;
	width: 80px;
	color: white;
	border: none;
	border-radius: 10px;
	background-color: rgb(94, 94, 94);
}
        
</style>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
	<button onclick="location.href='./login'" class="arrowBtn"> ← </button>
   <h2>아이디 찾기</h2>
    <form action="dofindID" id="dofindID" method="post">
        <label for="name">이름:</label>
        <input type="text" id="name" name="name" placeholder="이름을 입력해주세요"><br>
        <label for="email">이메일:</label>
        <input type="text" id="email" name="email" placeholder="이메일을 입력해주세요"><br>
        <input type="submit" value="아이디 찾기" onclick="modalOpen()"/>
    </form>
</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}


</script>
</html>