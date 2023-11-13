<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
    body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 300px;
        }

        h2 {
            text-align: center;
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
        }

        p {
            margin-bottom: 8px;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="button"],
        input[type="submit"] {
            width: 100%;
            background-color: rgb(243, 208, 204);
            color: rgb(115, 112, 112);
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="button"]:hover,
        input[type="submit"]:hover {
            background-color: rgb(227, 156, 147);
        }

        .label1,
        .label2 {
            color: #e74c3c;
        }
        
        .arrowBtn{
        	position: absolute;
			right: 930px;
			top: 60px;
			
			background-color: rgb(243, 208, 204);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 20px;
        }
        
</style>
</head>
<body>
	<button onclick="location.href='./login'" class="arrowBtn"> ← </button>
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