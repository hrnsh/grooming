<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>

    
    	table , th, td {
	
		/* border: 1px solid black; */
		border-collapse: collapse;
	
	}

	table {
	
		
		margin-left:auto; 
   		margin-right:auto;
	
	}
	
	#subject{
	
	width:00px;
	height:30px;
	font-size:25px;
	width: 500px;
	
	}
	

	body {
	
		padding-top: 20px;
	
	}
	
	#picture{
	
		
	
	}
	
	textarea{
	
		resize: none;
	
	}
</style>
</head>
<body>


<form action="adboardUpdate" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td><input id="subject" type="text" name="subject" maxlength="20" placeholder="제목은20글자만 가능합니다." value="${re.adb_subject}"/></td>
		</tr>
		<tr>
			<td><pre><textarea name="editorTxt" id="editorTxt" rows="20" cols="10" placeholder="내용을 입력해 주세요" style="width:500px" >${re.adb_content}</textarea></pre></td>
		</tr>
		<tr>
			<td><input type="file" id="picture" name="photos" multiple="multiple" /></td>
		</tr>
		<tr>
		<th colspan="2">
			<input type="button" onclick="location.href='./boardMain'" value="리스트" />
			<button id="save">저장</button>
		</th>
		</tr>
	</table>
</form>
</body>
<script>


</script>
</html>