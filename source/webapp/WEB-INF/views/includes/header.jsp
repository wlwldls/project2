<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
    <link rel="stylesheet" href="${path}/resources/css/includes/header.css">
    <link rel="stylesheet" href="${path}/resources/css/includes/footer.css">
    <script src="${path}/resources/js/jquery.js"></script>
</head>
<body>
    <header>
        <div id="linebox">
            <div id="inner-header">
                <div id="logo1">
                    <a href="${path}">
                        <img src="${path}/resources/images/includes/header/neis_logo.png" alt="로고">
                    </a>
                </div>
                <div id="top-signup">
                    <ul>
                        <li>
                            <a href="${path}">나이스홈</a>
                        </li>
                        <li id="line">
                            <a href="${path}">처음으로</a>
                        </li>
                        <li id="line">
                            <c:choose>
                            	<c:when test="${not empty auth}">
                                	<a id="a3" href="${path}/member/logout">
                                		<span>로그아웃</span>
                                	</a>
                                </c:when>
                            	<c:otherwise>
                            		<a id="a3" href="${path}/member/login">
	                                	<img src="${path}/resources/images/includes/header/neo_icon_login.png" alt="">
	                                	<span>로그인</span>
                                	</a>
                            	</c:otherwise>
                            </c:choose>
                        </li>
                        <li id="line">
                            <c:choose>
                            	<c:when test="${not empty auth}">
                                	<a id="a4" href="#">
	                                	<span><c:out value="${auth.username}"/>님</span>
                                	</a>
                                </c:when>
                            	<c:otherwise>
                            		<a id="a4" href="${path}/member/signup">
	                                	<span>회원가입</span>
                                	</a>
                            	</c:otherwise>
                            </c:choose>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <nav>
            <div id="imgbox"></div>
        </nav>   
    </header>