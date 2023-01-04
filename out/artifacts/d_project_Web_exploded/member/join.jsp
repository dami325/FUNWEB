<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/dami_css.css" rel="stylesheet" type="text/css">
<title>member/join.jsp</title>
</head>
<script>
var isDuplicate = true; 
var isEmailcheck = true;
var isCorrectPassword = false;
var isSamePass = false;




function func1() {//아이디 중복확인
	var spancheckIdResult = document.getElementById("checkIdResult");
	var id = document.fr.id.value;
	
	if(id.length > 3 && id.length < 17){
		window.open("check_id.jsp?id="+id,"ID중복확인","width=10,height=10")
		isDuplicate = false;
	} else if(!(id.length > 3 && id.length < 17)) {
		alert("4~16글자만 사용가능합니다!");
		isDuplicate = true;
		
		document.fr.id.select();
	}
}
  
	function emailCheck() { //e메일중복
		var EmailResult = document.getElementById("checkEmailResult");
		var email = document.fr.email.value;
		
		if (email.length >= 5 && email.length <= 50) {
			window.open("check_email.jsp?email="+email,"EMAIL중복확인","width=10,height=10")
			
			isEmailcheck = false;
		} else {
			
			isEmailcheck = true;
		}
		
	}

function func2(pass) { //비밀번호 길이확인
	var PasswdResult = document.getElementById("checkPasswdResult");
	
	if (pass.length >= 8 && pass.length <= 16) {
		PasswdResult.innerHTML = "사용 가능한 패스워드";
		PasswdResult.style.color = "GREEN";
		
		isCorrectPassword = true;
	} else {
		PasswdResult.innerHTML = "8 글자 이상 입력";
		PasswdResult.style.color = "RED";
		
		isCorrectPassword = false;
	}
	
}

function checkRetypePassword() {
	
	var pass = document.fr.pass.value;
	var pass2 = document.fr.pass2.value;
	
	
	if(pass == pass2){
		document.getElementById("retypePasswordResult").innerHTML = "패스워드 일치";
		document.getElementById("retypePasswordResult").style.color = "GREEN";
		isSamePass = true;
	}else { // 두 패스워드가 일치할 경우
		document.getElementById("retypePasswordResult").innerHTML = "패스워드 불일치";
		document.getElementById("retypePasswordResult").style.color = "RED";
		isSamePass = false;
	}
}
	
function mobileCheck(mobile) {
	var MobileResult = document.getElementById("checkMobileResult");
	
	if (mobile.length > 10){
		MobileResult.innerHTML = "O";
		MobileResult.style.color = "green";
		
	} else {
		MobileResult.innerHTML = "X";
		MobileResult.style.color = "red";
		alert("번호를 정확히 입력해주세요!")
		document.fr.mobile.select();
	}
}	
	


function checkForm(fr) {
	  if(!isCorrectPassword) { 
		alert("사용 불가능한 패스워드 입니다!");
		fr.pass.select();
		return false;
	} else if(isDuplicate) { //아이디가 중복일 경우(또는 사용 불가능할 경우)
		alert("아이디 중복 확인 필수!");
		fr.id.select();
		return false;
	} else if(isEmailcheck){
		alert("이메일 중복 확인 필수!")
		fr.email.select();
		return false;
	} else if(!isSamePass){
		alert("패스워드가 일치하지 않습니다!");
		document.fr.pass.select();
		return false;		
	}
	return true;
}

</script>
<!-- 다음 주소 api 사용을 위한 코드 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                document.getElementById('post_code').value = data.zonecode;
                document.getElementById("address1").value = roadAddr;
                document.getElementById("address2").focus();
                
            }
        }).open();
    }
</script>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<div id ="subdiv">
		<div class="joindiv">
		  	<h1>회원가입</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkForm(this)">
		  		<table>
		  			<tr>
		  				<td>아이디*</td>
		  				<td><input type="text" name="id" placeholder="4 ~ 16글자 사이 입력" maxlength="16" required="required">
			  				<input type="button" value="ID중복확인" required="required" onclick="func1(this.value)">
			  				<span id ="checkIdResult"></span>
		  				</td>
		  			</tr>
					<tr>
		  				<td>비밀번호*</td>
		  				<td><input type="password" name="pass" placeholder="8 ~ 16글자 사이 입력" maxlength="16" onchange="func2(this.value)" onchange="checkRetypePassword()" required="required">
			  				<span id ="checkPasswdResult"></span>
		  				</td>
		  			</tr>
		  			<tr>
		  				<td>비밀번호 확인*</td>
		  				<td><input type="password" name="pass2" required="required" onkeyup="checkRetypePassword()">
			  				<span id ="retypePasswordResult"></span>
		  				</td>
		  			</tr>
					<tr>
		  				<td>이름*</td>
		  				<td><input type="text" name="name"maxlength="10" required="required">
		  				</td>
		  			</tr>
					<tr>
		  				<td>이메일*</td>
		  				<td><input type="email" name="email" id="email" placeholder="5 ~ 50글자 사이 입력" required="required">
		  				<input type="button" value="이메일 확인" required="required" onclick="emailCheck(this.value)">
			  				<span id ="checkEmailResult"></span>
		  				</td>
		  			</tr>
		  			<tr>
		  				<td>핸드폰 번호*</td>
		  				<td><input type="text" name="mobile" maxlength=11; required="required" onchange="mobileCheck(this.value)">
		  					<span id ="checkMobileResult"></span>
		  				</td>
		  			</tr>
		  			<tr>
		  				<td>우편번호</td>
		  				<td><input type="text" name="post_code" id="post_code" placeholder="우편번호">
		  				<input type="button" onclick="execDaumPostcode()"value="우편번호"></td>
		  			</tr>
		  			<tr>
		  				<td>주소</td>
		  				<td><input type="text" name="address1" id="address1" placeholder="주소"> 
		  					<input type="text" name="address2" id="address2" placeholder="상세주소">
		  				</td>
		  			</tr>
		  			<tr>
		  				<td>
		  		<div id="buttons">
		  			<input type="submit" value="가입하기" class="submit" name="submit">
		  			<input type="reset" value="돌아가기" onclick="history.back()" class="cancel">
		  		</div>
		  				</td>
		  			</tr>
		  		</table>
		  	</form>
		  	</div>
		  </div>
	</div>
</body>
</html>



