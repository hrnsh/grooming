<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<!-- 페이징 처리를 위한 라이브러리 -->
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
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

select {
    width: 100%;
    padding: 8px;
    margin: 5px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
    border-radius: 4px;
}

input[type="submit"] {
    background-color: rgb(163, 161, 161);
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type="submit"]:hover {
    background-color: rgb(243, 208, 204);
}

#paging {
    margin-top: 20px;
}

.container {
    text-align: center;
}

.pagination {
    display: inline-block;
    padding: 0;
    margin: 0;
}

.pagination li {
    display: inline;
    margin: 0;
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

textarea {
    width: 100%;
    padding: 8px;
    margin: 5px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
    border-radius: 4px;
}

</style>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th class="user_id">회원ID</th>
				<th class="user_name">이름</th>
				<th>
				<select id="user_state" name="user_state">
				<option value="전체">전체</option>
				<option value="일반">일반</option>
				<option value="업체">업체</option>
				<option value="승인요청">승인요청</option>
				<option value="정지">정지</option>
				</select>
				</th>
			</tr>
		</thead>
		<tbody id="adUserManageList">

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
			<form action="adUserManageResult">
				<input type="submit" value="처리내역"/>
			</form>
	
			
	<!-- detail 모달 -->		
	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>			
			<form action="saveManage">
				<table>
					<tr>
						<th>ID</th>
						<td id="user_id"></td>
						<th>관리자</th>
					</tr>
					<tr>
						<th>이름</th>
						<td id="name"></td>
						<td id="ad_id"></td>
					</tr>
					<tr>
						<th>상태</th>
						<td id="state"></td>
						<td>
							<select id="state" name="state">
							<option value="일반">일반</option>
							<option value="업체">업체</option>
							<option value="정지">정지</option>							
							</select>
						</td>
					</tr>
					<tr>
						<th colspan="3">사업자 등록증</th>
					</tr>
					<tr>
						<th>사유</th>
					</tr>
					<tr>
						<td colspan="3"><textarea name="m_content"></textarea></td>
					</tr>
					<tr>
						<th>처리내역</th>
						<td>
							<select id="m_type" name="m_type">
							<option value="승인요청">승인요청</option>
							<option value="정지">정지</option>
							<option value="정지해제">정지해제</option>							
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="3"><textarea name="m_complet"></textarea></td>
					</tr>
					<tr>
						<th>요청일시</th>
						<td>날짜</td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" onclick="saveManage()"
							value="수정" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
			
</body>
<script>

var showPage = 1;
adUserManageListCall(showPage)

// 상태 필터링
$('#user_state').change(function(){
	console.log($(this).val());
	adUserManageListCall(showPage);
});

function adUserManageListCall(page){	
	var loginId = "${sessionScope.loginId}";
	console.log("여기");
	$.ajax({
		type:'get',
		url:'adUserManageList',
		data:{'loginId':loginId,'user_state':$('#user_state').val(), 'page':page}, 
		dataType:'JSON',
		success: function(data){
			console.log("초기 리스트"+data)
			drawAdUserManageList(data);	
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawAdUserManageList(adUserManageList){
	console.log(adUserManageList);
	$('#adUserManageList').empty();
	var content='';
	adUserManageList.list.forEach(function(item, idx){ 
		content+='<tr>';
		content+='<td><a href="#" onclick="openModal(\'' + item.user_id + '\')">'+item.user_id+'</a></td>';
		content+='<td>'+item.name+'</td>';
		content+='<td>'+item.state+'</td>';
		content+='</tr>';
	});

	$('#adUserManageList').append(content);
	$('#pagination').twbsPagination({
		startPage:adUserManageList.currPage, // 보여줄 페이지
		totalPages:adUserManageList.pages,// 총 페이지 수(총갯수/페이지당보여줄게시물수) : 서버에서 계산해서 가져와야함
		visiblePages:5,//[1][2][3][4][5]
		onPageClick:function(e,page){ // 번호 클릭시 실행할 내용
			//console.log(e);
			if(showPage != page){
				console.log(page);
				showPage = page; // 클릭해서 다른 페이지를 보여주게 되면 현재 보고 있는 페이지 번호도 변경해 준다.
				adUserManageListCall(page);
			}
		}
	});
}
var modal = document.getElementById('myModal');
function openModal(user_id) {
	modal.style.display = 'block';
	console.log(user_id);
	var loginId="${sessionScope.ad_id}";
	console.log("관리자"+loginId);
	document.getElementById('ad_id').innerHTML = loginId;
	$.ajax({
		type:'get',
		url:'manageDetail',
		data:{'loginId':loginId,'user_id':user_id}, 
		dataType:'JSON',
		success: function(data){
			console.log("회원정보");	
			console.log(data);
			data.mDetail.forEach(function(item, idx){ 
				document.getElementById('user_id').innerHTML = item.user_id;
				document.getElementById('name').innerHTML = item.name;
				document.getElementById('state').innerHTML = item.state;
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
	
</script>
</html>