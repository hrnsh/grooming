<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>처리 내역</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<!-- 페이징 처리를 위한 라이브러리 -->
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="resources/css/adminProfileCommon.css" type="text/css">

<style>

.nav {
	height: 150px;
	display: flex;
	justify-content: space-between;
	margin-top: 40px;
}

.logo {
	position: relative;
	right: 330px;
}

h1{
	position: relative;
	right: 220px;
	top: 50px;
}


table, th, td{
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
}

.listTable{	
	width: 100%;
	height: 100%;
	border-radius: 10px;
  	border-style: hidden;
  	box-shadow: 0 0 0 1px #000;
  	table-layout:fixed;
}

.listTable th{
	text-align:center;
}

.tableBox{
	width: 700px;
	height:450px;
	position: relative;
	bottom: 5%;
	left: 5%;
}

.searchbox{
	width: 90%;
    height: 6%;
    display: flex;
    position: relative;
    bottom: 30px;
    left: 20%;
}

input[type="button"]{
	height: 25px;
	width: 40px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
	position: relative;
	left: 20px;
}

#paging {
	position: relative;
	right: 35%;
}

.input-group {
    position: relative;
    width: 100%;
}

.input-group .input-group-append {
    position: absolute;
    right: 0;
    top: 0;
    cursor: pointer;
}

.input-group .input-group-append span {
    padding: 8px;
    background-color: #f2f2f2;
    border: 1px solid #ccc;
    border-radius: 4px;
    position: relative;
    bottom: 20px;
    left: 5px;
}

.calendar-icon:hover {
    background-color: #ddd;
}


.modal{
  position: fixed;
  top:0; left: 0; bottom: 0; right: 0;
  background: rgba(0, 0, 0, 0.8);
}

.modal-content{
	width: 600px;
    height: 560px;
	left: 30%;
	top: 15%;
	border: 1px solid rgb(94, 94, 94);
	align-items:center;
}

.modalTable{
	width: 500px;
    height: 450px;
	position: relative;
	left: 50px;
	top: 50px;
	text-align:center;
	border-radius: 10px;
  	border-style: hidden;
  	box-shadow: 0 0 0 1px #000;
}

.modalTable td{
	text-align: left;
}

.tableBox{
	width: 700px;
	height:450px;
	position: relative;
	bottom: 5%;
	left: 5%;
}

.close {
  color: gray;
  float: right;
  font-size: 28px;
  font-weight: bold;
  display:relative;
  right: 10px;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

textarea{
	resize: none;
	width: 100%;
	height: 100px;
	border: none;
}

</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<h1> 처리 내역 </h1>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="profButton">내 프로필</button>
			<button onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 관리</button>
			<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="profButton">일반 문의 관리</button>
			<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="profButton">신고 문의 관리</button>
		</div>

		
		<div class="tableBox">
			<div class="searchbox" >
				<div>관리자ID : <input type="text" id="selAd_id"/></div>
				<div style="position:relative; left: 10px;">회원ID : <input type="text" id="selUser_id"/></div>
				<div><input type="button" value="조회" onclick="idFilter()"/></div>
			</div>
		<table class="listTable">
			<thead>
				<tr>
					<th style="width:60px;">번호</th>
					<th class="user_id">회원ID</th>
					<th><select id="m_type" name="m_type">
							<option value="전체">전체</option>
							<option value="일반">일반</option>
							<option value="업체">업체</option>
							<option value="승인요청">승인요청</option>
							<option value="정지">정지</option>
					</select></th>
					<th>처리날짜
						<div class="input-group date">
							<!-- 숨겨진 input 태그 -->
							<input type="text" id="datepicker" class="form-control"
								style="display: none;">
							<!-- 달력 아이콘을 나타내는 버튼 -->
							<div class="input-group-append">
								<span class="input-group-text calendar-icon"
									onclick="showDatePicker()"> &#128197; <!-- 유니코드로 달력 아이콘 표시 -->
								</span>
							</div>
						</div>
					</th>
					<th>담당자</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody id="adUserManageResultList">
	
			</tbody>
		</table>
			<div id="paging">	
				<!-- 	플러그인 사용	(twbsPagination)	- 이렇게 사용하라고 tutorial 에서 제공-->
				<div class="container">									
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination"></ul>
					</nav>					
				</div>
			</div>
		</div>
	
			
	<!-- detail 모달 -->		
	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>			
				<table class="modalTable">
					<tr>
						<th style="width:100px;">ID</th>
						<td id="user_id"></td>
						<th style="text-align:center;">관리자</th>
					</tr>
					<tr>
						<th>이름</th>
						<td id="name"></td>
						<td id="ad_id"></td>
					</tr>
					<tr>
						<th>분류</th>
						<td id="mm_type"></td>
					</tr>
					<tr>
						<th>상태</th>
						<td id="m_state"></td>
					</tr>
					<tr>
						<th>사업자 등록증</th>
						<td colspan="2" style="text-align:left;">사업자 등록증 이미지 링크</td>
					</tr>
					<tr>
						<th>사유</th>
					</tr>
					<tr>
						<td colspan="3"><textarea readonly id="m_content" placeholder="사유를 입력해 주세요."></textarea></td>
					</tr>
					<tr>
						<th>처리내역</th>
					</tr>
					<tr>
						<td colspan="3"><textarea readonly id="m_complet" placeholder="내용을 입력해 주세요."></textarea></td>
					</tr>
					<tr>
						<th>처리일시</th>
						<td id="m_date" colspan="2"></td>
					</tr>
				</table>
		</div>
	</div>
			</main>
</body>
<script>

var showPage = 1;
adUserManageResultListCall(showPage)

// 상태 필터링
$('#m_type').change(function(){
	console.log($(this).val());
	adUserManageResultListCall(showPage);
});

function adUserManageResultListCall(page){	
	console.log("여기");
	$.ajax({
		type:'get',
		url:'adUserManageResultList',
		data:{'m_type':$('#m_type').val(), 'page':page}, 
		dataType:'JSON',
		success: function(data){
			console.log("초기 리스트"+data)
			drawAdUserManageResultList(data);	
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawAdUserManageResultList(adUserManageResultList){
	console.log(adUserManageResultList);
	$('#adUserManageResultList').empty();
	var content='';
	adUserManageResultList.list.forEach(function(item, idx){ 
		var date = new Date(item.m_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		content+='<tr style="text-align:center;">';
		content+='<td><a href="#" onclick="openModal(\'' + item.m_num + '\')">'+item.m_num+'</a></td>';
		content+='<td>'+item.user_id+'</td>';
		content+='<td>'+item.m_type+'</td>';
		content+='<td>'+dateStr+'</td>';
		content+='<td>'+item.ad_id+'</td>';
		content+='<td>'+item.m_state+'</td>';
		content+='</tr>';
	});

	$('#adUserManageResultList').append(content);
	$('#pagination').twbsPagination({
		startPage:adUserManageResultList.currPage, // 보여줄 페이지
		totalPages:adUserManageResultList.pages,// 총 페이지 수(총갯수/페이지당보여줄게시물수) : 서버에서 계산해서 가져와야함
		visiblePages:5,//[1][2][3][4][5]
		onPageClick:function(e,page){ // 번호 클릭시 실행할 내용
			//console.log(e);
			if(showPage != page){
				console.log(page);
				showPage = page; // 클릭해서 다른 페이지를 보여주게 되면 현재 보고 있는 페이지 번호도 변경해 준다.
				adUserManageResultListCall(page);
			}
		}
	});
}
var modal = document.getElementById('myModal');
function openModal(m_num) {
	modal.style.display = 'block';
	$.ajax({
		type:'get',
		url:'resultDetail',
		data:{'m_num':m_num}, 
		dataType:'JSON',
		success: function(data){
			console.log("회원정보");	
			console.log(data);
			data.resultDetail.forEach(function(item, idx){ 
				var date = new Date(item.m_date);
				var dateStr = date.toLocaleDateString("ko-KR");
				document.getElementById('user_id').innerHTML = item.user_id;
				document.getElementById('ad_id').innerHTML = item.ad_id;
				document.getElementById('name').innerHTML = item.name;
				document.getElementById('mm_type').innerHTML = item.m_type;
				document.getElementById('m_state').innerHTML = item.m_state;
				document.getElementById('m_complet').innerHTML = item.m_complet;
				document.getElementById('m_content').innerHTML = item.m_content;
				document.getElementById('m_date').innerHTML = dateStr;
			});
		},
		error:function(e){
			console.log(e)
		}
	}); 
}

function closeModal() {
	confirm("정말로 취소하시겠습니까?");
	modal.style.display = 'none';
}

function saveManage(){
	confirm("정말로 수정하시겠습니까?");
	modal.style.display = 'none';
}

var selectedDate;
function showDatePicker() {
	$("#datepicker").datepicker({
        onSelect: function (dateText, inst) {
        	 selectedDate = new Date(dateText);

             // 날짜를 "yyyy-mm-dd" 형식으로 변환
             var formattedDate = selectedDate.toLocaleDateString("en-CA", {
                 year: "numeric",
                 month: "2-digit",
                 day: "2-digit"
             });
             console.log("Selected Date:"+formattedDate);
             $.ajax({
                 type: "get",
                 url: "dateFilter", // 여기에 실제 컨트롤러의 URL을 입력하세요.
                 data: { "selectedDate": formattedDate,"page":showPage},
                 dataType:'JSON',
                 success: function (data) {
                     console.log("Data sent successfully:", data);
                     drawAdUserManageResultList(data);
                 },
                 error: function (error) {
                     console.error("Error sending data:", error);
                 }
             });
        }
    });
    // 숨겨진 input 태그에 datepicker 적용
    $("#datepicker").datepicker("show");
}

// ID 필터

function idFilter(){
	$.ajax({
        type: "get",
        url: "idFilter", // 여기에 실제 컨트롤러의 URL을 입력하세요.
        data: { "ad_id": $('#selAd_id').val(),
        	"user_id":$('#selUser_id').val(),"page":showPage},
        dataType:'JSON',
        success: function (data) {
            console.log("id필터성공:", data);
            drawAdUserManageResultList(data);
        },
        error: function (error) {
            console.error("Error sending data:", error);
        }
    });
}
</script>
</html>