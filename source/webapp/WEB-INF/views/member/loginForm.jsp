<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../includes/header.jsp"%>
    <link rel="stylesheet" href="${path}/resources/css/login/style.css">
    <link rel="stylesheet" href="${path}/resources/css/login/contents.css">
    <title>로그인</title>
    <script type="text/javascript" src="${path}/resources/js/login.js"></script>
    <script>
    	$(function(){
    		var error = '<c:out value="${error}"/>';
    		if(error==""){
    			return;
    		}
    		if(error=="nonuser"){
    			alert("없는 사용자입니다.");
    			$("#userid").focus();
    		}else if(error=="nomatch"){
    			alert("비밀번호가 일치하지않습니다.");
    			$("#userpwd").focus();
    		}
    	})
    </script>
    <div id="wrap">
        <div id="content1">
            <h1>로그인</h1>
            <div id="path">
                <a id="home" href="${path}">
                    <img src="${path}/resources/images/login/neo_bg_path_home.png" alt="">
                    홈
                </a>
                >
                <a href="${path}/member/login">
                    회원마당
                </a>
                >
                <strong>로그인</strong>
            </div>
        </div>
        <div id="notice">
            <p id="first">
                <strong>아이디 로그인을 하시면 학생서비스의 일부만 열람</strong>
                하실 수 있습니다.
                <br>
                모든 서비스를 원활하게 이용하시려면
                <strong>회원가입 후 등록한 인증서로 로그인</strong>
                하여 이용바랍니다.
                <br>
                ※ 단, ‘간편인증’ 또는 ‘디지털원패스’로 로그인하시면 인증서 
                로그인과 동일하게 서비스 이용이 가능합니다.
                <br>
                ※ 만 14세 미만의 학생의 경우, 간편인증 사용에 제약이 있습니다. 
                '디지털원패스'를 이용하여 주십시오.
            </p>
            <p id="second">
                <strong>개인민감정보의 입력은 가상키패드(기본)를 통하여
                    입력이 가능합니다.</strong>
                <br>
                ※ 가상키패드 사용을 원하지 않는 경우 일반 키보드 입력이 가능합니다.
                <br>
                ※ 보안성 향상을 위하여 가상키패드 사용을 권장합니다.
            </p>
        </div>
        <div id="login">
            <h1>
                <img src="${path}/resources/images/login/neo_login_title_ico_03.gif" alt="">
                <span>아이디 로그인</span>
            </h1>
            <div id="id_input">
                <form role="form" id="formlogin" name="frmLogin" method="post" action="${path}/member/login">
                    <input type="text" id="userid" name="userid" placeholder="아이디"><br>
                    <input type="password" id="userpwd" name="userpwd" placeholder="비밀번호"><br>
                    <button type="submit" id="submitBtn" style="display:none;"></button>
                    <a href="#" id="loginbtn">
                        <img src="${path}/resources/images/login/neo_btn_login_sp.png">
                    </a>
                </form>
            </div>
            <p id="misstxt">아이디나 비밀번호를 잊어버리셨나요?</p>
            <div id="searchbtn">
                <a href="#">
                    <img src="${path}/resources/images/login/neo_btn_login_id_search.png" alt="">
                </a>
                <a href="#">
                    <img src="${path}/resources/images/login/neo_btn_login_password_search.png" alt="">
                </a>
            </div>
            <p id="signuptxt">
                <br>
                아직 회원이 아니신가요? 회원갑입을 하시면 나이스 대국민서비스에서는
                <strong>
                    학교생활 전반에 관한 성적표, 생활기록부, 식단, 시간표 등의 
                    <br>
                    열람이 가능 합니다.
                </strong>
            </p>
            <div id="information">
                <a href="#">
                    <img src="${path}/resources/images/login/neo_btn_login_membership_guide.png" alt="">
                </a>
                <a href="${path}/member/signup">
                    <img src="${path}/resources/images/login/neo_btn_login_membership.png" alt="">
                </a>
            </div>
        </div>
    </div>
<%@include file="../includes/footer.jsp" %>