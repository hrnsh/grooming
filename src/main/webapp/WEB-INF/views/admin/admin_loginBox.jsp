<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
h1 {
	text-align: center;
}
</style>
<h1 id="login">
	${sessionScope.loginId}
</h1>

</body>
<script>
	var loginId = "${sessionScope.loginId}";
	if (loginId == "") {
		alert("로그인이 필요한 서비스 입니다");
		location.href = "./";
	} else {
		$("#login").html('환영합니다 관리자 ' + loginId + '님');
	}
</script>