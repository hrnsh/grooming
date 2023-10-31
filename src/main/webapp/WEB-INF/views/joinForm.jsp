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
<form action="join" method="post">
     <table>
         <tr>
             <th>아이디</th>
             <th>
                 <input type="text" name="id"/>
             </th>
         </tr>
         <tr>
             <th>비밀번호</th>
             <th>
                 <input type="password" name="pw"/>
             </th>
         </tr>
         <tr>
             <!--공백문자-->
             <th>이&nbsp;&nbsp;&nbsp;&nbsp;름</th>
             <th>
                 <input type="text" name="name"/>
             </th>
         </tr>
         <tr>
             <th>이메일</th>
             <th>
                 <input type="email" name="email"/>
             </th>
         </tr>
         <tr>
             <th colspan="2">
                 <input type="submit" value="회원가입"/>
             </th>
         </tr>
     </table>
 </form>
</body>
<script></script>
</html>