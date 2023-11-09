<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>

textarea{
	width: 100%;
	height: 250px;
	resize: none;
	font-size: 16px;
	padding: 10px;
}

</style>
</head>
<body>
	<h2>문의 보내기 DB 테스트용</h2>
	<form action="sendInquiry" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>제목 : <input type="text" name="subject" /></td>
			</tr>
			<tr>
				<td colspan="3">
					<textarea name="content" placeholder="내용을 입력해 주세요."></textarea>
				</td>
			</tr>
		</table>
		<input type="file" name="photo"/>
		<input type="submit" value="보내기" class="sendBtn" />
	</form>
</body>
<script>
var loginId="${sessionScope.loginId}";
if (!loginId) {
    alert("로그인이 필요합니다. 로그인 후 이 페이지를 이용하실 수 있습니다.");
    location.href = "./"; 
}
</script>
</html>