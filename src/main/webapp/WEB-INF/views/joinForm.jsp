<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
    table, th, td{
        border: 1px solid black;
        border-collapse: collapse;
        padding: 5px 10px;
    }
</style>
</head>
<body>
   <form action="join" method = "post">
   <h2>Welcome 돌봐주개!</h2>
	
    <p/>이&nbsp;&nbsp;&nbsp;&nbsp;름
    <input type = "text" name = "name" placeholder="이름을 입력해주세요"/>

    <p/>아이디
    <input type = "text" name = "user_id" placeholder="이름을 입력해주세요"/>
    <input type = "button" id = "overlayId" value="아이디 중복확인"/>
    <p/><span class="label1"></span>
    
    <p/>비밀번호
    <input type = "password" name = "pw" placeholder="비밀번호를 입력해주세요"/>
    
    <p/>전화번호
    <input type = "text" name = "phone" placeholder="'-'없이 입력해주세요"/>
    
    <p/>이메일
    <input type = "email" name = "email" placeholder="이메일을 입력해주세요"/>
    <input type = "button" id = "overlayEmail" value="이메일 중복확인"/>
    <p/><span class="label2"></span>

     <br/>
 	<input type="submit" value="돌봐주개 회원가입"/>
   </form>
</body>
<script>
var overlayIdChk = false;
var $id;


$('#overlayId').on('click', function(){
	$id = $('input[name="user_id"]').val();
	console.log('user_id='+$id);
	
	$.ajax({
		type : 'post',
		url : 'overlayId',
		data : {'user_id' : $id},
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			overlayIdChk = data.use;
			if(data.use){
				$(".label1").text("사용이 가능한 ID입니다.").css("color", "green").css("font=size", "8px");
			}else{
				$(".label1").text("이미 사용중인 아이디입니다.").css("color", "red").css("font=size", "8px");
				$('input[name="user_id"]').val("");
			}
		},
		error : function(e){
		}
	});
});
<<<<<<< HEAD
=======
	
>>>>>>> origin/master
var overlayEmailChk = false;
var $email;

$('#overlayEmail').on('click', function(){
	$email = $('input[name="email"]').val();
	console.log('email='+$email);
	
	if($email = ""){
		$(".label2").text("ID를 입력해주세요!").css("color", "red").css("font=size", "8px");
		return false;
	}

	$.ajax({
		type : 'post',
		url : 'overlayEmail',
		data : {'email' : $email},
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			overlayEmailChk = data.use;
			if(data.use){
				$(".label2").text("사용이 가능한 ID입니다.").css("color", "green").css("font=size", "8px");
			}else{
				$(".label2").text("이미 사용중인 아이디입니다.").css("color", "red").css("font=size", "8px");
				$('input[name="email"]').val("");
			}
		},
		error : function(e){
		}
	});
});
</script>
</html>