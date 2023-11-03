<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>

table{
width: 1000px;
padding : 5px 10px;
	margin-left:auto; 
    margin-right:auto;

}

body{

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
	padding: 0px 40px;
}

#delete {

	margin-left: 58%;

}

#reply{
	float:left;
	width : 550px;
	height: 55px
}

#getreply, #list, #delete, #modify{

	cursor: pointer;


}
#uid,#ucon, #ure{
	float : left;
	border : 1px solid black;
	border-collapse: collapse;
}

#uid

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
			
			<p>신고</p>
			
			
			</div>
			
			
			<div id="b_hit">
			
			
			<p>${list.b_hit}</p>
			
			
			</div>
						
			</td>
		</tr>
		
		
		<tr>
			<!-- <td>${bbs.user_name}</td> -->
			
			<td id="content">
			
			${list.b_content}
		<c:if test="${photos.size()>0}">
		<tr>
			<th>사진</th>
			<td>
			<c:forEach items="${photos}" var="photo">
			
			<img alt="${photo.oriFileName}" src="/photo/${photo.newFileName}" width="500">
			
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
		
		<c:if test="${login=='boarduse'}">
		<div id="delete">
		<p>삭제하기</p>
		</div>
		<div id="modify">
		<p>수정하기</p>
		</div>
		</c:if>
		
<%-- 			<input type="button" onclick="location.href='./list'" value="리스트" />
			<input type="button" onclick="location.href='./del?idx=${bbs.idx}'" value="삭제" />
			<input type="button" onclick="location.href='./updateForm?idx=${bbs.idx}'" value="수정" />
 --%>
		</th>
		</tr>
				<tr>
			<td>
			
			<input id="reply" type="text" />
			
			<div id="getreply" >
				<p>댓글달기</p>
			</div>
			
			</td>
			<!-- <td>${bbs.content}</td> -->
			
		</tr>
		<tr>
		<td>
		
		<div id="uid">유저아이디</div>
		<div id="ucon">댓글내용</div>
		<div id="ure">수정 / 삭제</div>
				
		</td>
		</tr>
	</table>
</body>
<script>
var bnum = ${list.b_num};
console.log(""+bnum);
var reply ;



$("#delete").on('click',function(){
	
	console.log("삭제 하기");
	
	var result = confirm("정말로 삭제 하실건가요?");
	if(result){
		
		location.href="boardDelete?bnum=" + '${list.b_num}'+"&user_id=" + '${list.user_id}';
	   
	    
	}else{
	    
	}
	
	
	
});

$("#modify").on('click',function(){
	
	console.log("수정하기");
	location.href="boardUpdate";
	
});


$("#getreply").on("click", function(){
	reply = $("#reply").val();
	console.log($("#reply").val());
	location.href="boardreply?bnum=" + '${list.b_num}'+'&'+"="+'reply';
	
	
});

	$("#list").on('click',function(){
		
		console.log("목록으로 가기");
		location.href='boardMain';
		
	});

</script>
</html>