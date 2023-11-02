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
     <table>
        <tr>
             <!--공백문자-->
             <th>이&nbsp;&nbsp;&nbsp;&nbsp;름</th>
             <th>
                 <input type="text" name="name" maxlength="5"/>
             </th>
         </tr>
         <tr>
             <th>아이디</th>
             <th>
                 <input type="text" name="id" maxlength="13"/>
             </th>
             <th>
                <input type = "button" id = "overlay" value = "ID 중복 체크"/>
             </th>
         </tr>
         <tr>
             <th>비밀번호</th>
             <th>
                 <input type="password" name="pw" maxlength="15"/>
             </th>
         </tr>
         <tr>
         	<th>연락처</th>
         	<th>
         		<input type="text" maxlength="11" name="phone" placeholder="(-없이)01012345678"/>
         	</th>
         </tr>
         <tr>
             <th>이메일</th>
             <th>
                 <input type="email" id="email" name="email"/>
             </th>
             <th>
                 <input type="button" onclick="" value="인증번호 발송"/>
             </th>
         </tr>
         <tr>
             <th>인증번호</th>
             <th>
                 <input type="text" id="verification" name="number"/>
             </th>
             <th>
                 <input type="button" onclick="" value="인증"/>
             </th>
         </tr>
         <tr>
             <th colspan="2">
                 <input type="button" id = "join" value="회원가입"/>
             </th>
         </tr>
     </table>
</body>
<script>
var overlayChk = false;

$('#join').on('click',function(){
	var $name = $('input[name="name"]');
	var $id = $('input[name="id"]');
	var $pw = $('input[name="pw"]');
	var $phone = $('input[name="phone"]');
	var $email = $('input[name="email"]');
	
	if(overlayChk){
		if($name.val()==''){
			alert('이름을 입력해주세요');
		}else if($id.val()==''){
			alert('아이디를 입력해 주세요!');
			$id.focus();
		}else if($pw.val()==''){
			alert('비밀번호를 입력해 주세요');
			$pw.focus();
		}else if($phone.val()==''){
			alert('번호를 입력해 주세요');
			$name.focus();
		}else if($email.val()==''){
			alert('이메일을 입력해 주세요');
			$email.focus();
		}else{

			var param = {};
			param.name = $name.val();
			param.id = $id.val();
			param['pw'] = $pw.val();
			
			var regex = new RegExp('[a-zA-Zㄱ-ㅎ가-힣]');
			var match = regex.test($phone.val());
			console.log("match : "+match);
			if(match){
				alert('전화번호는 숫자만 넣어 주세요');
				return false;
			}			
			param.email = $email.val();
			
			
			console.log(param);
			
			$.ajax({
				type:'post',
				url:'join',
				data:param,
				dataType:'JSON',
				success:function(data){
					console.log(data);
					if(data.success>0){
						alert('회원 가입에 성공했습니다.');
						location.href='/login';
					}else{
						alert('회원 가입에 실패했습니다.');
					}
				},
				error:function(e){
					console.log(e);
				}
			});
			
		}
	}else{
		alert('아이디 중복 체크를 해주세요');
	}
	
});



$('#overlay').on('click',function(){
	var id = $('input[name="id"]').val();
	console.log('id='+id);
	
	$.ajax({
		type : 'get',
		url:'overlay', 
		data : {'id':id},
		dataType : 'JSON', 
		success : function(data){
			console.log(data)
			overlayChk = data.use;
			if(data.use){
				alert('사용 가능한 아이디 입니다.');
			}else{
				alert('이미 사용중인 아이디 입니다.');
				$('input[name="id"]').val('');
			}
			}, 
		error : function(error){console.log(error)} 
	});	
})




</script>
</html>