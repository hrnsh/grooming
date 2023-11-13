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

table{
width: 1000px;
padding : 5px 10px;
	margin-left:auto; 
    margin-right:auto;

}

body{
		margin-left:auto; 
	    margin-right:auto;
		padding-top: 90px;
		padding-bottom: 90px;

}

#subject {
	
	border-bottom : 1px solid black;
	border-collapse: collapse;

}

#first{

	border-bottom : 1px solid black;
	font-size: 30px;
}

#user_id{

	border-right: 1px solid black; 
	float: left;
	padding: 0px 20px;
	
}
#writedate{
border-right: 1px solid black; 
	float: left;
	padding: 0px 20px;
}

#report{

border-right: 1px solid black;
padding: 0px 20px;
margin-left: 55%; 
float: left;


}

#b_hit{
padding: 0px 20px;
float: left;
}

#content{

border: 1px solid gray;
border-collapse: collapse;
height: 800px;
border-radius: 5px;

}

#getreply, #list , #delete, #modify{

	border: 1px solid black;
	border-collapse: collapse;
	float: left;
	border-radius: 5px;
	padding: 0px 30px;
}

#delete {

	margin-left: 58%;

}

#reply{

	margin-top : 30px;
	float:left;
	width : 500px;
	height: 55px
}

#getreply, #list, #delete, #modify, #rp{

	cursor: pointer;


}
#uid,#ucon,#ure{
	float : left;
	border-left : 1px solid black;
	border-collapse: collapse;
}

#ucon{

	width: 400px;

}

#uid{

	width: 100px;

}

#r, #d{
	float : left;
	border-radius: 5px;
	border : 1px solid black;
	border-collapse: collapse;
	cursor: pointer;

}

# pagination {

	width : 10px;

}


#rp{

	border: 1px solid black;
	border-collapse: collapse;
	width: 65px;
	height: 25px;

}













/* 테스트 */
/*popup*/
.popup_layer {position:fixed;top:0;left:0;z-index: 10000; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.4); }
/*팝업 박스*/
.popup_box{position: relative;top:50%;left:50%; overflow: auto; height: 600px; width:375px;transform:translate(-50%, -50%);z-index:1002;box-sizing:border-box;background:#fff;box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);-webkit-box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);-moz-box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);}
/*컨텐츠 영역*/
.popup_box .popup_cont {padding:50px;line-height:1.4rem;font-size:14px; }
.popup_box .popup_cont h2 {padding:15px 0;color:#333;margin:0;}
.popup_box .popup_cont p{ border-top: 1px solid #666;padding-top: 30px;}
/*버튼영역*/
.popup_box .popup_btn {display:table;table-layout: fixed;width:100%;height:70px;background:#ECECEC;word-break: break-word;}
.popup_box .popup_btn a {position: relative; display: table-cell; height:70px;  font-size:17px;text-align:center;vertical-align:middle;text-decoration:none; background:#ECECEC;}
.popup_box .popup_btn a:before{content:'';display:block;position:absolute;top:26px;right:29px;width:1px;height:21px;background:#fff;-moz-transform: rotate(-45deg); -webkit-transform: rotate(-45deg); -ms-transform: rotate(-45deg); -o-transform: rotate(-45deg); transform: rotate(-45deg);}
.popup_box .popup_btn a:after{content:'';display:block;position:absolute;top:26px;right:29px;width:1px;height:21px;background:#fff;-moz-transform: rotate(45deg); -webkit-transform: rotate(45deg); -ms-transform: rotate(45deg); -o-transform: rotate(45deg); transform: rotate(45deg);}
.popup_box .popup_btn a.close_day {background:#5d5d5d;}
.popup_box .popup_btn a.close_day:before, .popup_box .popup_btn a.close_day:after{display:none;}
/*오버레이 뒷배경*/
.popup_overlay{position:fixed;top:0px;right:0;left:0;bottom:0;z-index:1001;;background:rgba(0,0,0,0.5);}
/*popup*/
#rpname {padding-left: 100px;}
#rpbt {border: 1px solid black; border-collapse: collapse; cursor: pointer;}


#conp {

	float: none;
	


}


#getreply{

	padding-left: 10px;

}





</style>
</head>
<body>
	
	<table>
	
		<tr id="subject">
			<!-- <th>${bbs.b_subject}</th> -->
			<td id="first" >${list.b_subject}</td>
		</tr>
		
		
		<tr>
			<td>
			
			<!-- ${bbs.b_hit} -->
			<div id="user_id">
			
			<p>${list.user_id}</p>
			
			</div>
			
			<div id="writedate">
			
			<p>${list.b_date}</p>
			
			
			</div>
			
			<div id="report">
			<div id="rb">
			<p>
			<c:if test="${can!=null||sessionScope.admin=='admin'}">
			<a id="goreportform" href="javascript:openPop()">신고</a>
			</c:if>
			</p>
			</div>
			</div>
			
			
			<div id="b_hit">
			
			
			<p>${list.b_hit}</p>
			
			
			</div>
						
			</td>
		</tr>
		
		
		<tr>
			<!-- <td>${bbs.user_name}</td> -->
			
			<td id="content">
			
			<pre>${list.b_content}</pre>
		<c:if test="${photos.size()>0}">
		
			<tr>
			<td >
			<c:forEach items="${photos}" var="photo">
			
			<img src="/photo/${photo.newFileName}" width="200" alt="${photo.oriFileName}">
			
			</c:forEach>
			
			
			</td>
				</tr>
		</c:if> 
			
			</td>
			
		</tr>
		
		
		


		<tr>
		<th colspan="2">
		
		<div id="list">
		<p>목록</p>
		</div>
		
		<c:if test="${login=='boarduse'||sessionScope.admin=='admin'}">
		<div id="delete">
		<p>삭제하기</p>
		</div>
		<c:if test="${login=='boarduse'}">
		<div id="modify">
		<p>수정하기</p>
		</div>
		</c:if>
		</c:if>
		
<%-- 			<input type="button" onclick="location.href='./list'" value="리스트" />
			<input type="button" onclick="location.href='./del?idx=${bbs.idx}'" value="삭제" />
			<input type="button" onclick="location.href='./updateForm?idx=${bbs.idx}'" value="수정" />
 --%>
		</th>
		</tr>
			<tr>
				<td>
					<c:if test="${can!=null}">
					<input id="reply" type="text" />
					
					<div id="getreply">
						<p>댓글달기</p>
					</div>
					</c:if>
				</td>
				<!-- <td>${bbs.content}</td> -->
			
			</tr>

		<thead>
		<tr id="mb">
		
		</tr >
		</thead>
		<tbody id="repl">
		
		</tbody>
		<tr>
			<td colspan="5" id="paging">	
				<!-- 	플러그인 사용	(twbsPagination)	 이렇게 사용하라고 tutorial에서 제공-->
				<div class="container">									
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination pagination-sm" id="pagination"></ul>
					</nav>					
				</div>
			</td>
		</tr>

	</table>






<div class="popup_layer" id="popup_layer" style="display: none;">
  <div class="popup_box">
      <div style="height: 10px; width: 375px; float: top;">
        <a href="javascript:closePop();"><img src="resources/img/down.png" class="m_header-banner-close" width="30px" height="30px"></a>
      </div>
      <!--팝업 컨텐츠 영역-->
      <div><p id="rpname">게시글 신고</p></div>
      <div class="popup_cont">
          <h5>신고 게시글 : ${list.b_subject}</h5>
          <h5>작성자 : ${list.user_id}</h5>
		<pre><textarea id="con" rows="" cols="" style= "width: 250px; height: 320px; resize: none;"></textarea></pre>
      </div>
      <div id="rpbt">
      <!--팝업 버튼 영역-->
<!--       <div class="popup_btn" style="float: bottom; margin-top: 100px;">
      뭔가 들어가기 -->
      
      	버튼
      </div>
  </div>
</div>




</body>



<script>
var bnum = ${list.b_num};
console.log(""+bnum);
var reply ;
var showPage=1;
listCall(showPage);




//팝업 띄우기
function openPop() {
    document.getElementById("popup_layer").style.display = "block";

}

//팝업 닫기
function closePop() {
    document.getElementById("popup_layer").style.display = "none";
}

$("#rpbt").on("click",function(){
	
	console.log("신고버튼눌림");
	var con = $("#con").val();
	
	
	
	$.ajax({
		type:'post',
		url:'boardReport',
		data:{"bnum": ${list.b_num}, "con":con},
		dataType:'JSON',
		success:function(data){//data안들어옴
			console.log("data들어오나? : "+data.bnum);
			
			if(data.get==true){
				alert("신고완료");
				location.href="boardDetail?b_num=${list.b_num}";
			}else{
				alert("신고실패");
			}	
			
		},
		eorror:function(e){
			console.log(e);
			
		}
	});
	
	
});















$("#delete").on('click',function(){
	
	console.log("삭제 하기");
	
	var result = confirm("정말로 삭제 하실건가요?");
	if(result){
		
		location.href="boardDelete?bnum=" + '${list.b_num}'+"&user_id=" +'${list.user_id}';
	   
	    
	}else{
	    
	}
	
});

$("#modify").on('click',function(){
	
	console.log("수정하기");
	location.href="boardUpdateForm?bnum="+bnum;
	
});



$("#getreply").on("click", function(){
	reply = $("#reply").val();
	console.log($("#reply").val());
	location.href="boardreply?bnum=" + ${list.b_num}+'&reply='+reply;
	

});



	$("#list").on('click',function(){
		
		console.log("목록으로 가기");
		location.href='boardMain';
		
	});
	
	
	
	/* 여기서 부터는 댓글 리스트 뽑아내기 */
	
	
	
	function listCall(page) {
		
		$.ajax({
			type:'post',
			url:'boardReplyList',
			data:{"bnum": bnum,'pagePerNum':5, 'page':page},
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
		content += '<td id="uid">'+item.user_id+'</td>';
		content += '<td id="ucon" name ="ucon">'+item.brep_content+'</td>';
		// java.sql.Date 는 jsp 에서는 정상동작 되나 js 에서는 밀리세컨드를 반환 한다.
		// 방법 1. DTO 에서 reg_date 를 String 으로 반환하는 방법
		// content += '<td>'+item.reg_date+'</td>';
		// 방법 2. js 에서 직접 변환
		var date = new Date(item.brep_date);
		var dateStr = date.toLocaleDateString("ko-KR"); //en-US
		content += '<td id="ure">'+dateStr+'</td>';	
		content += '<td >'+'<div id="ure">'+'<div id="d" onclick='+"'location.href="+'"boardReplyDelete?bnum='+item.b_num+'&list_num='+item.brep_num+'"'+"'>"+'삭제하기</div>'+'</td>';
		content += '</tr>';
		
		console.log(content);
	});
	$('#repl').empty();
	$('#repl').append(content);
	
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
	
	
	console.log($('#d').filter('#ucon').val());
function rede (e){
	
	
	console.log("delete");
	
	
}

function rere (){
	
	
	console.log("rewrite");
	
}
	



</script>
</html>