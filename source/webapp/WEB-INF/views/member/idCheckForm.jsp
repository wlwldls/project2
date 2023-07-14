<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/idcheck/style.css">
<script src="${path}/resources/js/jquery.js"></script>
<script>
function pValue(){
	document.getElementById("userid").value = opener.document.allInfo.userid.value;
}
$(function(){
	$("#idchkbtn").on("click", function(e){
		e.preventDefault();
		if(isValid()){
	    	var id = {userid: $("#userid").val()}
	    	CheckService.check(id, function(result){
	    		if(result === "true"){
	    			document.getElementById("cancelbtn").style.display='none';
		    		document.getElementById("usebtn").style.display='block';
		    		document.getElementById("msg").innerText = "사용 가능한 아이디입니다.";
		    		document.getElementById("msg").style.color = '#777777';
	    		}else{
		    		document.getElementById("msg").innerText = "사용할 수 없는 아이디입니다.";
	    			document.getElementById("msg").style.color = 'red';
	    			document.getElementById("cancelbtn").style.display='block';
		    		document.getElementById("usebtn").style.display='none';
	    		}
	    	}, 
	    	function(error){
	    		alert(error);
	    	})
		}
	});
	class CheckService{
		static check(id, callback, error){
			$.ajax({
				type:"post",
				url:"${path}/check/idcheck",
				data: JSON.stringify(id),
				contentType: "application/json; charset=utf-8",
				success:function(result, status, xhr){
					if(callback){
						callback(result)
					}
				},
				error:function(xhr, status, er){
					if(error){
						error(xhr.status + ' ' + status);
					}
				}
			});
		}
	}
	function isValid(){
		var id = document.getElementById("userid").value;
		let reg = /^[a-z]+[a-z0-9]{5,19}$/g;

		if(id==""){
			alert("아이디를 입력하세요.");
			return false;
		}
		if(false === reg.test(id)){
			alert("아이디 구성방법과 일치하지않습니다.")
			return false;
		}
		return true;
	}
})
function sendCheckValue(){
		opener.document.allInfo.idchk.value = true;
		opener.document.allInfo.userid.value = document.getElementById("userid").value;
		
		if(opener != null){
			opener.chkForm = null;
			self.close();
		}
	}
</script>
<title>Insert title here</title>
</head>
<body onload="pValue()">
    <form id="checkForm" method="post">
        <div id="wrap">
            <header id="header">
                <h1 id="head">아이디 중복확인</h1>
            </header>
            <div id="main">
                <label id="mainlabel" for="userid">아이디 검색</label>
                <input id="userid" name="idinput" type="text">
                <button id="idchkbtn">중복확인</button>
            </div>
            <div id="noticebox">
                <p id="msg"></p>
            </div>
            <input id="cancelbtn" type="button" value="취소" onclick="window.close()"><br>
            <input id="usebtn" type="button" value="확인" onclick="sendCheckValue()">
        </div>
    </form>
</body>
</html>