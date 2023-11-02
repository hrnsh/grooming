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
	<form  action="dofindID" method="post">
	<h2>아이디 찾기</h2>
	<hr/>
	    <table>
	        <tr>
	            <th>이름</th>
	            <th colspan="2">
	                <input type="text" name="name" value="" placeholder="이름을 입력 하세요"/>
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
	                <input type = "button" value="아이디찾기" onclick = "idsearch"/>
	            </th>    
	        </tr>
	    </table>
	    </form>
</body>
<script>
function idsearch() { 
 	var ids = document.findID;

 	if (ids.name.value.length < 1) {
	  alert("이름을 입력해주세요");
	  return;
	 }

	 if (ids.email.value.length < 0) {
		  alert("이메일 형식에 맞게 입력해주세요");
		  return;
	 }

 ids.method = "post";
 ids.action = "findIDresult.jsp";
 ids.submit();  
 }

</script>
</html>