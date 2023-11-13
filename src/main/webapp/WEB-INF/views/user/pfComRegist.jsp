<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
table, th, td {
	margin: 10px;
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
	height: 80px;
}

table {
	float: left;
}

button {
	float: left;
	display: flex;
	align-items: left;
}

::-webkit-scrollbar {
	display: none;
}

.profile {
	width: 30%;
	height: 300px;
	float: left;
	border: solid;
	padding: 10px;
}

.animalprofile {
	width: 30%;
	height: 300px;
	float: left;
	border: solid;
	float: left;
}
</style>
</head>
<body>
	<div class="logo">
		<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120 />
	</div>
	<h1 style="text-align: center;">업체 등록</h1>
	<table>
		<tr>
			<th>
				<button onclick="location.href='profile?user_id=${sessionScope.loginId}'" class="button">내 프로필</button>
			</th>
		</tr>
		<tr>
			<th>
				<button	onclick="location.href='pfNoteList?user_id=${sessionScope.loginId}'"	class="button">쪽지함</button>
			</th>
		</tr>
		<tr>
			<th>
				<button	onclick="location.href='pfWrite?user_id=${sessionScope.loginId}'"	class="button">내가 쓴 글</button>
			</th>
		</tr>
		<tr>
			<th>
				<button	onclick="location.href='pfReportList?user_id=${sessionScope.loginId}'" class="button">신고 내역</button>
			</th>
		</tr>
	</table>

	<input type="button" id="comregister" value="등록 완료" />

	<table style="text-align: left;">
		<tr>
			<th>유저 ID</th>
			<th colspan="3"><input style="border: none; background: transparent;" type="text" name="user_id" readonly="readonly" value="${sessionScope.loginId}" /></th>
		</tr>
		<tr>
			<th>업체명</th>
			<th colspan="3"><input type="text" name="com_name" value="" /></th>
		</tr>
		<tr>
			<th>주소지</th>
			<th colspan="3">
				<input type="text" id="sample4_postcode" placeholder="우편번호"> 
				<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
				<br>
				<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
				<input type="text" id="sample4_jibunAddress" name="address" placeholder="지번주소">
				<span id="guide" style="color: #999; display: none"></span>
				<input type="text" id="sample4_detailAddress" placeholder="상세주소" />
				<input type="text" id="sample4_extraAddress" placeholder="참고항목">
			</th>
		</tr>
		<tr>
			<th>영업시간</th>
			<th colspan="3"><input type="text" name="com_time" value="" /></th>
		</tr>
		<tr>
			<th>수용 가능 수</th>
			<th colspan="3"><input type="text" name="accept" value="" /></th>
		</tr>
		<tr>
			<th>픽업여부</th>
			<th colspan="3">
				<input type="radio" name="pickup" value="Y" />픽업 가능
				<input type="radio" name="pickup" value="N" />픽업 불가능
			</th>
		</tr>
		
		<tr>
			<th>사진 등록</th>
			<th colspan="4"></th>
		</tr>
	</table>
</body>
<script>
	
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample4_postcode').value = data.zonecode;
						document.getElementById("sample4_roadAddress").value = roadAddr;
						document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("sample4_extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("sample4_extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
	
	
	$('#comregister').on('click',function(){
		var $user_id = $('input[name="user_id"]');
		var $com_name = $('input[name="com_name"]');
		var $address = $('input[name="address"]');
		var $com_time = $('input[name="com_time"]');
		var $pickup = $('input[name="pickup"]:checked');
		var $accept = $('input[name="accept"]');
		
		var param = {};
		param.user_id = $user_id.val();
		param.com_name = $com_name.val();
		param.address = $address.val();
		param.com_time = $com_time.val();
		param.pickup = $pickup.val();
		param.accept = $accept.val();
		
		console.log("업체 등록 파라메터 : " + param);
		
		$.ajax({
			type:'post',
			url:'comregister',
			data:param,
			dataType:'JSON',
			success:function(data){
				console.log(data);
				if(data.success>0){
					console.log("업체 등록 성공");
					location.href='/gudi/profile?user_id='+param.user_id;
				}else{
					console.log("업체 등록 실패");
				}
			},
			error:function(e){
				console.log(e);
			}
		});
		
	});
	
	
	
</script>
</html>