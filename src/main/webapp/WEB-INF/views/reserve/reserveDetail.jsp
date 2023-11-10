<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
textarea {
	width: 100%;
	height: 250px;
	resize: none;
	font-size: 16px;
	padding: 10px;
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
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
	padding-top: 60px;
}

.modal-content {
	position: relative;
	background-color: rgb(243, 208, 204);
	width: 30%;
	height: 500px;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #888;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

* {
	padding: 0px;
	margin: 0px;
}

ul, li {
	border-collapse: collapse;
	list-style: none;
	box-sizing: border-box;
}

li {
	height: 50px;
}

.box {
	position: relative;
	height: 600px;
	border: 1px solid #000;
}

.box>li {
	float: left;
	width: 50%;
	height: 600px;
}

.box>li:first-child {
	border-right: 1px solid #000;
}

.box>li>.inner_box>li {
	float: left;
	width: 50%;
	height: 600px;
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
	<form action="change">
		<table>
			<tr>
				<th>
					<p>예약 정보</p>
				</th>
				<th><select id="changeState" name="selState">
						<option value="예약완료">예약완료</option>
						<option value="이용중">이용중</option>
						<option value="이용완료">이용완료</option>
						<option value="취소">취소</option>
				</select></th>
				<th><input type="submit" value="수정" /></th>
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
							<li>상세 주소</li>
							<li>총 이용금액</li>
							<li>예약 상태</li>
						</ul>
					</li>
					<li>
						<ul>
							<li>${rev.r_pick}</li>
							<li>${rev.r_pickaddr}</li>
							<li></li>
							<li>${rev.r_totalprice}</li>
							<li>${rev.r_state}</li>
						</ul> <input type="button" value="리뷰쓰기" onclick="openModal()" /> <input
						type="button" value="예약취소" onclick="openCancelModal()" /> <input type="button" value="쪽지쓰기" />
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
					<td><input type="button" value="댓글작성" onclick="showCommentTextArea()"/></td>
				</tr>
			</table>
		</div>
	</c:forEach>
			<c:if test="${replyDetail.size()>0}">
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
		modal.style.display = 'block';
	}

	function closeModal() {
		confirm("정말로 취소하시겠습니까?");
		modal.style.display = 'none';
	}

	function saveReview() {
		confirm("정말로 작성하시겠습니까?");
		console.log('리뷰 내용:', reviewText);
		closeModal();
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
        cancelModal.style.display = 'block';
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