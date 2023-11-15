<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- bootstrap : 디자인을 위한 프레임워크 -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<!-- jquery 는 사용하는 플러그인과 다른 라이브러리와의 충돌 여부를 확인해야 한다. -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<!-- 페이징 처리를 위한 라이브러리 -->
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
	table , th , td{
		border : 1px solid black;
		border-collapse: collapse;
		padding: 10px 5px;
		
	
	}
	table {
	width : 1000px;
	margin-left:auto; 
    margin-right:auto;
	
	}
	
		h3{
	
		text-align: right;
		font-size : 300%;
		margin-right:20%;
	
	}
	
	p{
	margin-left:60%;
	margin-bottom: 30px;
	}
	
	.write{
	border : 1px solid black;
	border-collapse: collapse;
	padding: 20px 20px;
	margin-left:75%;
	margin-right:19%;
	margin-top: 30px;
	border-radius: 15px;
	cursor: pointer;
	
	}

	#searchpath{
	float : left;
	margin-left:65%;
	
	}
	
	#userfilter {
	border : 1px solid black;
	border-collapse: collapse;
	padding: 10px 40px;
	margin-left:11%;
	font-size : 30px;
	float: left;
	border-radius: 5px;
	cursor: pointer;
}
	#deptfilter {
	border : 1px solid black;
	border-collapse: collapse;
	padding: 10px 40px;
	font-size : 30px;
	float: left;
	border-radius: 5px;
	cursor: pointer;
}

body {

	padding-top: 20px;

}

.logo {
	cursor : pointer;
	margin-left: 50px;
}

#num {
width : 100px;

}

#subj{

width : 400px;
}

#us{
width : 120px;

}
#hit{
width:80px; 

}
#da{

width:120px; 
}

#paging{

	width : 300px;

}


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

/* gpt */

    body {
      font-family: 'Arial', sans-serif;
      background-color: white;
      margin: 0;
      padding: 0;
      margin-bottom:50px;
    }

    #userfilter, #deptfilter{
      text-align: center;
      padding: 15px;
      background-color: rgb(243, 208, 204);
      color: black;
      padding-left: 30px;
      padding-right: 30px;
      margin-bottom: 30px;
      border-radius: 5px
    }
    
        #userfilter:hover, #deptfilter:hover{
      text-align: center;
      padding: 15px;
      padding-left: 30px;
      padding-right: 30px;
      background-color: gray;
      color: #fff;
      margin-bottom: 30px;
      border-radius: 5px
    }

    #title {
      text-align: center;
      padding: 10px;
      background-color: rgb(243, 208, 204);
      color: black;
      margin-bottom: 20px;
      margin-left: 950px;
      border-radius: 5px
    }

    table {
      width: 80%;
      margin: 0 auto;
      background-color: #fff;
      border-collapse: collapse;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: center;
    }

    #num, #subj, #us, #hit, #da {
      background-color: rgb(243, 208, 204);
      color: black;
    }

    #searchpath, #searchval {
      padding: 8px;
      margin-right: 10px;
    }

    #btn {
      padding: 8px;
      padding-left:12px;
      padding-right:12px;
      background-color: rgb(243, 208, 204);
      color: black;
      border: none;
      cursor: pointer;
      border-radius: 5px;
    }

    #btn:hover {
      background-color: rgb(163, 161, 161);
      color: white;
    }

    .container {
      margin-top: 20px;
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

    .pagination li a, .pagination li span {
      padding: 8px;
      margin: 4px;
      border: 1px solid #ddd;
      text-decoration: none;
      color: #3498db;
      cursor: pointer;
    }

    .pagination li a:hover {
      background-color: #f2f2f2;
    }

    .write {
      padding: 20px;
      width: 120px;
      background-color: rgb(243, 208, 204);
      color: black;
      text-align: center;
      cursor: pointer;
      font-size: 20px;
    }

    .write:hover {
      background-color: rgb(163, 161, 161);
      color: white;
    }
    
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
	<div id="userfilter" >회원글</div>
	<div id="deptfilter">업체글</div>
	<h3 id="title">회원게시판</h3>

		            <th>
		                <select id="searchpath" name="searchtag">
		                	<option  value="b_subject" >제목</option>
		                	<option value="user_id">작성자</option>
		                </select>
		                <p><input id="searchval" class="searchval" type="text" name="searchval" value="" placeholder="검색할 내용을 입력해주세요"/><button id="btn">검색</button></p>
		            </th>
		<table>
			<thread>
			<tr>
				<th id="num">글번호</th>
				<th id="subj">제목</th>
				<th id="us">작성자</th>
				<th id="hit">조회수</th>
				<th id="da">작성날짜</th>
			</tr>
			</thread>
			<tbody id="adminlist">
			
			</tbody>			
			<tbody id="list">
			
			</tbody>
			<tr>
			<td colspan="5" id="paging">	
				<!-- 	플러그인 사용	(twbsPagination)	 이렇게 사용하라고 tutorial에서 제공-->
				<div class="container">									
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination"></ul>
					</nav>					
				</div>
			</td>
			</tr>
		</table>
		<c:if test="${login!=null || sessionScope.admin=='admin'}">
			<div class="write">글쓰기</div>
		</c:if>
</body>
<script>



var showPage=1;
var filter = 0;
var searchtag = "b_subject" ;
var searchindex = " ";
	adlistCall();
	listCall(showPage);


$('#userfilter').on('click',function(){
	filter = 0;
	document.getElementById("title").innerText="회원게시판";
	showPage=1;
	listCall(showPage);
});

$('#deptfilter').on('click',function(){
	filter = 2;
	document.getElementById("title").innerText="업체게시판";
	showPage=1;
	listCall(showPage);
});

$("#searchval").keypress(function(e){
	//검색어 입력 후 엔터키 입력하면 조회버튼 클릭
	if(e.keyCode && e.keyCode == 13){
		$("#btn").trigger("click");
		return false;
	}
	//엔터키 막기
	if(e.keyCode && e.keyCode == 13){
		  e.preventDefault();	
	}
});






$("#btn").click(function(){
	
	var storyLength = $("#searchval").val().length;
	if(storyLength < 2 ){
		alert("2자 이상 입력해주세요");
	    $("#searchval").focus();
	}else{
	//searchbox = $('#search').val();
	console.log($('#searchpath option:selected').val());
	searchtag = $('#searchpath option:selected').val();
	console.log($('#searchval').val());
	searchindex = $('#searchval').val();
	listCall(showPage);
	filter=10;
	}
});











//admin공지글

function adlistCall() {
		
		$.ajax({
			type:'post',
			url:'adboardList',
			data:{},
			dataType:'JSON',
			success:function(data){//data안들어옴
				console.log("addata들어오나? : "+data);
				
				addrawlist(data);	
				
			},
			eorror:function(e){
				console.log(e);
				
			}
		});
	}



function addrawlist(list){

var content="";
console.log(list.list);
//배열의 값을 하나씩빼서 함수를 실행(개별값, 인덱스)

list.list.forEach(function(item,idx){
	content += '<tr>';
	content += '<td>'+item.b_num+'</td>';
	content += '<td>'+"<a href ="+'adpfNoteSend?idx='+item.b_num+">[공지사항] "+item.adb_subject+'</a>'+'</td>';
	content += '<td>'+item.ad_id+'</td>';
	content += '<td>'+item.adb_hit+'</td>';
	// java.sql.Date 는 jsp 에서는 정상동작 되나 js 에서는 밀리세컨드를 반환 한다.
	// 방법 1. DTO 에서 reg_date 를 String 으로 반환하는 방법
	// content += '<td>'+item.reg_date+'</td>';
	// 방법 2. js 에서 직접 변환
	var date = new Date(item.adb_date);
	var dateStr = date.toLocaleDateString("ko-KR"); //en-US
	content += '<td>'+dateStr+'</td>';		
	content += '</tr>';
});
$('#adminlist').empty();
$('#adminlist').append(content);


}

/* 	
	function searchbox(page){
		$.ajax({
			type:'post',
			url:'boardSearch',
			data:{'searchtag':searchtag,'searchindex':searchindex,'pagePerNum':5, 'page':page},
			dataType:'JSON',
			success:function(data){
				
				console.log(data);
				drawlist(data);
				
				
			},
			eorror:function(e){
				console.log(e);
				
			}
		});
	}
	 */




	 function listCall(page) {
			
			$.ajax({
				type:'post',
				url:'boardList',
				data:{"filter":filter,'searchtag':searchtag,'searchindex':searchindex,'pagePerNum':5, 'page':page},
				dataType:'JSON',
				success:function(data){//data안들어옴
					console.log("data들어오나? : "+data.pages);
					
					drawlist(data);	
					
				},
				eorror:function(e){
					console.log(e);
					
				}
			});
		}



function drawlist(list){
	
	var content="";
	console.log(list.list);
	//배열의 값을 하나씩빼서 함수를 실행(개별값, 인덱스)

	list.list.forEach(function(item,idx){
		content += '<tr>';
		content += '<td>'+item.b_num+'</td>';
		content += '<td>'+"<a href ="+'boardDetail?b_num='+item.b_num+">"+item.b_subject+'</a>'+'</td>';
		content += '<td>'+item.user_id+'</td>';
		content += '<td>'+item.b_hit+'</td>';
		// java.sql.Date 는 jsp 에서는 정상동작 되나 js 에서는 밀리세컨드를 반환 한다.
		// 방법 1. DTO 에서 reg_date 를 String 으로 반환하는 방법
		// content += '<td>'+item.reg_date+'</td>';
		// 방법 2. js 에서 직접 변환
		var date = new Date(item.b_date);
		var dateStr = date.toLocaleDateString("ko-KR"); //en-US
		content += '<td>'+dateStr+'</td>';		
		content += '</tr>';
	});
	$('#list').empty();
	$('#list').append(content);
	
		console.log(list.pages);//(값 안들어오는중)
	 // 페이징 처리 UI 그리기(플러그인 사용)
	$('#pagination').twbsPagination({
		startPage:list.currPage,//보여줄 페이지
		totalPages:list.pages,//총페이지수(총갯수/페이지당 보여줄 게시물수) : 서버에서 계산해서 가져와야 한다.
		visiblePages:5,//[1][2][3][4][5]
		onPageClick:function(e,page){//번호 클릭시 실행할 내용
		
				
				if(showPage!=page){
					

					console.log("con1 : "+page);
					showPage = page;//클릭해서 다른 페이지를 보여주게 되면 현재 보고있는 페이지 번호도 변경해준다.
					
					listCall(page);
					
		}

		}
		
	});
	

}


$('.write').on('click',function(){
	location.href='boardWriteForm';//'joinForm.jsp'는 java에서 안먹힌다
});

$(".logo").on('click',function(){
	
	location.href='./';
	
});

$('#pagePerNum').change(function(e){
	//페이지당 보여줄 게시물 갯수가 변경되면 페이징 처리 UI를 지우고 다시 그려준다.
	//안그러면 처음계산한 페이지 값을 그대로 들고있다.
	listCall(showPage);	
	$('#pagination').twbsPagination('destroy');
	
}); 






</script>
</html>