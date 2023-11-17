<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
 .nav {
  	width:1200px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
}

.logo img {
    cursor: pointer;
}

.iconAll{
	width:100px;
    text-align: center;
}

div{text-align: center;}

.button {
    margin-top: 5px;
    padding: 5px 10px;
    font-size: 14px;
    background-color: rgb(163, 161, 161);
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}

.button:hover {
    background-color: rgb(243, 208, 204);
}
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
}

form {
    margin-top: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}

table, th, td {
    border: 1px solid #ddd;
}

th, td {
    padding: 10px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
}

input[type="text"],
select,
textarea {
    width: 100%;
    padding: 8px;
    margin: 5px 0 15px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
    border-radius: 4px;
}

input[type="button"],
input[type="submit"] {
    background-color: rgb(163, 161, 161);
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type="button"]:hover,
input[type="submit"]:hover {
    background-color: rgb(243, 208, 204);
}

ul.box {
    list-style: none;
    padding: 0;
}

ul.box li {
    margin-bottom: 20px;
}

ul.left_box, ul.right_box {
    list-style: none;
    padding: 0;
    display: flex;
}

ul.left_box li, ul.right_box li {
    width: 50%;
    box-sizing: border-box;
    padding: 10px;
}

ul.inner_box {
    border: 1px solid #ddd;
    border-radius: 5px;
}



.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.starR{
  display: inline-block;
  width: 30px;
  height: 30px;
  color: transparent;
  text-shadow: 0 0 0 #f0f0f0;
  font-size: 1.8em;
  box-sizing: border-box;
  cursor: pointer;
}

/* 별 이모지에 마우스 오버 시 */
.starR:hover {
  text-shadow: 0 0 0 #ccc;
}

/* 별 이모지를 클릭 후 class="on"이 되었을 경우 */
.starR.on{
  text-shadow: 0 0 0 #ffbc00;
}
</style>
</head>
<body>
<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width="150" height="120"/>
		</div>	
		<div class="iconAll">
			<img src="resources/img/mapIcon.jpg" alt="mapIcon" width=100 height=100/>
			<button onclick="location.href='./locationSearch'" class="button">위치 탐색</button>
		</div>
		<div class="iconAll">
			<img src="resources/img/calendarIcon.jpg" alt="calendarIcon" width=100 height=100/>
			<button onclick="location.href='./revList'" class="button">예약 관리</button>
		</div>
		<div class="iconAll">
			<img src="resources/img/boardIcon.jpg" alt="boardIcon" width=100 height=100/>
			<button onclick="location.href='./boardMain'" class="button">게시판</button>
		</div>
		</nav>
	<form action="change">
		<table>
			<tr>
				<th>
					<h1>예약 정보</h1>
				</th>
				<c:if test="${auto>0}">
				<th>
				<select id="changeState" name="selState">
						<option value="예약완료">예약완료</option>
						<option value="이용중">이용중</option>
						<option value="이용완료">이용완료</option>
						<option value="취소">취소</option>
				</select>
				</th>
				<th><input type="submit" value="수정" /></th>
			</c:if>
			</tr>
		</table>
	</form>
	<ul class="box">
		<c:forEach items="${detail}" var="rev">
			<li>
				<ul class="left_box inner_box">
					<li>
						<ul class="">
							<li>예약번호</li>
							<li>업체명</li>
							<li>전화번호</li>
							<li>예약자</li>
							<li>동물정보</li>
							<li>특이사항</li>
							<li>요청사항</li>
							<li>예약 시작 시간</li>
							<li>예약 종료 시간</li>
						</ul>
					</li>
					<li>
						<ul>
							<li>${rev.r_num}</li>
							<li>${rev.com_name}</li>
							<li>${rev.phone}</li>
							<li>${rev.user_id}</li>
							<li>${rev.a_name}/ ${rev.a_gender} / ${rev.a_age}살 /
								${rev.a_kind}</li>
							<li>${rev.a_spec}</li>
							<li>${rev.r_spec}</li>
							<li>${rev.r_start}</li>
							<li>${rev.r_end}</li>
						</ul>
					</li>
				</ul>
			</li>
			<li>
				<ul class="right_box inner_box">
					<li>
						<ul class="">
							<li>픽업</li>
							<li>픽업 주소</li>
							<li>총 이용금액</li>
							<li>예약 상태</li>
						</ul>
					</li>
					<li>
						<ul>
							<li>${rev.r_pick}</li>
							<li>${rev.r_pickaddr}</li>
							<li>${rev.r_totalprice}</li>
							<li>${rev.r_state}</li>

						</ul> 
						<c:if test="${auto==0}">
						<input type="button" value="리뷰쓰기" onclick="openModal()" />
						</c:if>						 
						<input type="button" value="예약취소" onclick="openCancelModal()" /> 
						<input type="button" value="쪽지쓰기" onclick="location.href='./writeNote?r_num=${rev.r_num}'" />
					</li>
				</ul>
			</li>
		</c:forEach>
	</ul>

	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>리뷰 작성</h2>
			<form action="saveReview">
				<table>
					<tr>
						<th>제목</th>
						<td><input type="text" name="rev_subject" /></td>
					</tr>
					<tr>
						<th>작성자</th>
						<c:forEach items="${detail}" var="rev">
							<td>${rev.user_id}</td>
							<input type="hidden" name="r_num" value="${rev.r_num}">
						</c:forEach>
					</tr>
					<tr>
						<th colspan="2"><textarea name="rev_content"></textarea></th>
					</tr>
					<tr>
						<th>첨부파일</th>
						<th><input type="file" name="photo" value="파일선택" /></th>
					</tr>
					<tr>
						<th>사진이름+삭제버튼</th>
						<td>
							<div class="starRev">
								<span class="starR on">⭐</span> <span class="starR">⭐</span> <span
									class="starR">⭐</span> <span class="starR">⭐</span> <span
									class="starR">⭐</span> <input type="hidden" name="rev_star" />
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" onclick="saveReview()"
							value="작성" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<!-- 리뷰 출력 -->
	<c:forEach items="${review}" var="riv">
		<div>
			<table>
				<tr>
					<td>제목</td>
					<td>${riv.rev_subject}</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>${riv.user_id}</td>
				</tr>
				<tr>
					<td colspan="2">${riv.rev_content}</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="starRev2" data-rev-star="${riv.rev_star}">
							<span class="starR">⭐</span> <span class="starR">⭐</span> <span
								class="starR">⭐</span> <span class="starR">⭐</span> <span
								class="starR">⭐</span>
						</div>
					</td>
				</tr>	
				<tr>			
				<td>
				<div id="commentTextAreaContainer" style="display: none;">
				<form action="saveReply">
					<c:forEach items="${review}" var="riv">							
							<input type="hidden" name="rev_num" value="${riv.rev_num}">
					</c:forEach>
					<textarea id="rrep_content" name="rrep_content"></textarea>
					<button onclick="closeCommentTextArea()">취소</button>
					<button type="submit">댓글 저장</button>
				</form>
				</div>
				</td>
				</tr>
				<tr>
					<c:if test="${auto>0}">
					<td><input type="button" value="댓글작성" onclick="showCommentTextArea()"/></td>
					</c:if>
					<c:if test="${auto==0}">
					<td><form action="reviewDel">
					<c:forEach items="${review}" var="riv">							
							<input type="hidden" name="rev_num" value="${riv.rev_num}">
					</c:forEach>
					<input type="submit" value="리뷰삭제"/>
					</form></td>
					</c:if>
				</tr>
					
			</table>
		</div>
	</c:forEach>
			<c:if test="${replyDetail.size()>0}">
			<form action="rrepDel">
			<c:forEach items="${replyDetail}" var="riv">							
					<input type="hidden" name="rrep_num" value="${riv.rrep_num}">
			</c:forEach>
				<table>
				<tr>
					<p>댓글</p>
				</tr>
					<c:forEach items="${replyDetail}" var="reply">							
				<tr>
					<td colspan="2">${reply.rrep_content}</td>
				</tr>
				<tr>
					<td>작성일</td>
					<td>${reply.rrep_date}</td>
				</tr>
					</c:forEach>
					</table>
					<c:if test="${auto>0}">
					<input type="submit" value="댓글삭제"/>
					</c:if>
					</form>
				</c:if>
	<!-- 취소 사유 출력 -->
	<c:forEach items="${revCancel}" var="revC">
		<div>
			<table>
				<tr>
					<td >취소사유</td>
				</tr>
				<tr>
					<td colspan="2">${revC.c_reason}</td>
				</tr>
				<tr>
					<td>취소자</td>
					<td>${revC.user_id}</td>
				</tr>
				<tr>
					<td>취소일</td>
					<td>${revC.c_date}</td>
				</tr>
			</table>
		</div>
	</c:forEach>
	
	<!-- 예약 취소 모달 -->
	<div id="cancelModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeCancelModal()">&times;</span>
			<form action="revCancel">
			<h2>예약 취소</h2>
				<textarea name="c_reason"></textarea>			
			<input type="submit" onclick="confirmCancel()" value="작성" />
		</form>
		</div>
	</div>
</body>
<script>
$(document).ready(function() {
    $(".starRev2").each(function() {
	var starCount = $(this).data("rev-star"); // 데이터 속성을 통해 별점 값을 읽어옴
			$(this).find(".starR:lt(" + starCount + ")").addClass("on"); // 별점 값을 기반으로 별을 표시함
		});
	});

	var modal = document.getElementById('myModal');
	var cancelModal = document.getElementById('cancelModal');

	function openModal() {
		var reviewSize = "${review.size()}";
		console.log("리뷰체크"+reviewSize);
		console.log("예약상태: "+"${rState}");
		if("${rState}"=="이용완료"){
		if(reviewSize>0){
			alert("리뷰는 한번만 작성할 수 있습니다.");
		}else{
			console.log("리뷰없음");
			modal.style.display = 'block';
		}
		}else{
			alert("이용완료된 예약에만 리뷰작성이 가능합니다.");
		}
	}

	function closeModal() {
		confirm("정말로 취소하시겠습니까?");
		modal.style.display = 'none';
	}

	function saveReview() {
		confirm("정말로 작성하시겠습니까?");
		console.log('리뷰 내용:', reviewText);
		modal.style.display = 'none';
	}

	$('.starRev span').click(function() {
		$(this).parent().children('span').removeClass('on');
		$(this).addClass('on').prevAll('span').addClass('on');
		// 선택된 별의 개수를 저장
		var selectedStars = $(this).index() + 1;

		// 별점의 개수를 form의 hidden input에 설정
		$('input[name="rev_star"]').val(selectedStars);
		return false;
	});

	function openCancelModal() {
		console.log("가져와야하는데"+"${rStart}");
		var receivedDate = new Date("${rStart}");
		var today = new Date();
		var timeDifference = (receivedDate - today) / (1000 * 60 * 60 * 24);
		if(timeDifference>1){
        cancelModal.style.display = 'block';			
		}else{
			alert("취소 가능한 시간이 지났습니다.");
		}
    }

    function closeCancelModal() {
    	confirm("정말로 취소하시겠습니까?");
        cancelModal.style.display = 'none';
    }
    
    function confirmCancel() {
        alert('정말로 예약을 취소하시겠습니까?');
        closeCancelModal();
    }
    
    // 댓글창
    function showCommentTextArea() {
        var commentTextAreaContainer = document.getElementById('commentTextAreaContainer');
        commentTextAreaContainer.style.display = 'block';
    }

    function closeCommentTextArea(){
    	var commentTextAreaContainer = document.getElementById('commentTextAreaContainer');
        commentTextAreaContainer.style.display = 'none';
    }
</script>
</html>