<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
    table, th, td{
        border: 1px solid black;
        border-collapse: collapse;
        padding: 5px 10px;
    }
</style>
</head>
<body>
<form action="update" method="post">


	<table>
		<tr>
			<th>제목</th>
			<td><input type="text" name="subject" value="<%-- ${bbs.subject} --%>"/></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="user_name"value="<%-- ${bbs.user_name} --%>"/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><input type="text" name="content"value="<%-- ${bbs.content} --%>"/> </td>
		</tr>
		<!-- 
		<tr>
			<th>사진</th>
			<td><input type="file" name="photos" multiple="multiple" /> </td>
		</tr> -->
         <tr>
             <th colspan="2">
                 <input type="submit" value="수정완료"/>
             </th>
         </tr>
     </table>
 </form>
</body>
<script></script>
</html>