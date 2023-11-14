<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
        	position: relative;
			right: 100px;
			
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
   <form action="join" id="joinForm" method = "post">
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
    <input type = "text" name = "phone" placeholder="'-' 없이 입력해주세요"/>
    
    <p/>이메일
    <input type = "email" name = "email" placeholder="이메일을 입력해주세요"/>
     <input type = "button" id = "overlayEmail" value="이메일 중복확인"/>
    <p/><span class="label2"></span>

     <br/>
 	<input type="button" value="돌봐주개 회원가입" id="join"/>
   </form>
</body>
<script>

// 아이디 중복 확인
var overlayChk=false; 

$('#overlayId').on('click', function(){
	var user_id = $('input[name="user_id"]').val();
	console.log('user_id='+user_id);
	
	if(user_id!=""){
		$.ajax({
			type : 'post',
			url : 'overlayId',
			data : {'user_id' : user_id},
			dataType : 'JSON',
			success : function(data){
				console.log(data);
				overlayChk=data.use;
				if(overlayChk){
					$(".label1").text("사용이 가능한 ID입니다.").css("color", "green").css("font=size", "8px");
				}else if(!data.use){
					$(".label1").text("이미 사용중인 아이디입니다.").css("color", "red").css("font=size", "8px");
					$('input[name="user_id"]').val("");
				}
			},
			error : function(e){
				console.log(e);
			}
		});
	}else{
		$(".label1").text("아이디를 입력해 주세요.").css("color", "red").css("font=size", "8px");
	}
});


// 이메일 중복 확인
var overlayEmailChk = false;
var $email;

$('#overlayEmail').on('click', function(){
	$email = $('input[name="email"]').val();
	console.log('email='+$email);
	
	if($email != ""){
	$.ajax({
		type : 'post',
		url : 'overlayEmail',
		data : {'email' : $email},
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			overlayEmailChk = data.use;
			if(data.use){
				$(".label2").text("사용이 가능한 이메일 입니다.").css("color", "green").css("font=size", "8px");
			}else{
				$(".label2").text("이미 사용중인 이메일 입니다.").css("color", "red").css("font=size", "8px");
				$('input[name="email"]').val("");
			}
		},
		error : function(e){
		}
	});
	}else{
		$(".label2").text("이메일을 입력해주세요!").css("color", "red").css("font=size", "8px");
	}
});


// 아이디, 이메일 중복 확인 후 회원가입 검사
$('#join').on('click',function(){
	var name = $('input[name="name"]');
	var user_id = $('input[name="user_id"]');
	var pw = $('input[name="pw"]');
	var phone = $('input[name="phone"]');
	var email = $('input[name="email"]');
	
	if(overlayChk && overlayEmailChk){
		if(name.val()==''){
			alert('이름을 입력해 주세요!');
			name.focus(); //해당 input 으로 커서 이동 
		}else if(user_id.val()==''){
			alert('아이디를 입력해 주세요!');
			user_id.focus();
		}else if(pw.val()==''){
	         alert('비밀 번호를 입력해 주세요!');
	         pw.focus();
	    }else if(phone.val()==''){
	         alert('전화 번호를 입력해 주세요!');
	         phone.focus();
	    }else if(email.val()==''){
	         alert('이메일을 입력해 주세요!');
	         email.focus();
	    }else{
	    	var regex = new RegExp('[a-zA-Zㄱ-ㅎ가-힣]'); // 0-9로 넣고 false 일 경우로 처리해도 된다.
	         var match = regex.test(phone.val()); // 패턴이 일치하면 true, 아니면 false 반환
	         console.log("match : "+match);
	         if(match){
	        	 alert('숫자만 넣어 주세요');
	        	 phone.val('');
	        	 phone.focus();
	        	 return false; 
	         }
	         
	         $('#joinForm').submit();
	    }
	}else{
		alert('아이디 또는 이메일 중복 체크를 해주세요!');
	}
});

</script>
</html>