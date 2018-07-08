<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/bottom-style.css">
<link rel="stylesheet" type="text/css" href="css/mypagenav-style.css">
<link rel="stylesheet" type="text/css"
	href="css/login-failure-modal.css">


<!-- Modal Icon -->
<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round"
	rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<!-- Jquery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>

<!-- BootStrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>수정</title>
</head>
<body>
<!--앞에서 세션값으로 그룹리더 값 받기 -->
<header>
 <%@ include file="include/nav/mypageNav.jsp"%>
<!-- 임의로 윗 상단 디자인  -->
</header>
<!-- 수정사이트 -->
<div class="container">
<form action="updatebasic.group" method="post" id="basicupdate">

<c:forEach var="result" items="${result }">
	<div class="row">
		<a href="#">← 설정으로 돌아가기 </a>
	</div>
	<div class="row">
		<h3>기본내용 수정하기 </h3>
	</div>
	
	<div class="row">
		<h4>Meetup Group name</h4>
	</div>
	<div class="row">
		<input type="text" id="groups" name="groupname" size="40" maxLength="200" value="${result.group_name }">
	</div>
	<div class="row">
	</div>
		<button type="button" id="duple">중복체크</button>
	<div class="row">
		<input type="text" id="isok" size="15" readonly="readonly">
	</div>	
	<!-- head line 삭제  -->
	
	<div class="row">
		<h4>Meetup Group description</h4>
	</div>
	<div class="row">
		<p>what is this meetup's purpose? who should join? why?</p>
	</div>
	<div class="row">
		<input type="text" id="aboutgroup" name="description" size="40"   value="${result.group_info }">
	</div>
	<div class="row">
		<h4>Where</h4>
	</div>
	<div class="row" >
		<input type="text" id ="local" name="location" size="40" value="${result.group_location }">
	</div>
	<div class="row"></div>
</c:forEach>	
	<button type="button" id="update">저장하기</button>
</form>	
</div>

<!-- footer -->
<footer>
	<%@ include file="include/bottom.jsp"%>
</footer>

<script >
$('#duple').click(function(e) {
	var nowdata = $("#groups").val();
	$.ajax({
		url:"duplecheck.group",
		type:"post",
		data:{val:nowdata},
		dataType : "json",
		success:function(response){
			console.log("AJAX Request 성공 ");
			console.log(response);
			var check = response.names;
			if(check==true){
				$("#isok").val("ok");
			}else{
				$("#isok").val("no");
			}
		},
		error:function(request,status,error){
			console.log(request.status+":"+status.responseText+":"+ error);
		},
		complete:function(){
			console.log("성공이건 실패건 어찌되었든 ajax 종료");
		}
	});
});


$('#update').click(function(e) {
	var isthat = $("#isok").val();
	if(isthat=="ok"){
		$('#basicupdate').submit();
	}else if(isthat=="no"){
		alert("중복되는 이름이 있습니다.");
	}else{
		alert("먼저 중복체크부터 해주세요");
	}
	
});

</script>
</body>
</html>