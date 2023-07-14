<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/record/list.css">
<title>생활기록부</title>
	<div id="wrap">
		<div id="content1">
			<h1><c:out value="${auth.schoolname}"/> 
			<c:out value="${auth.grade}"/>학년 
			<c:out value="${auth.classnum}"/>반 
			생활기록부
			</h1>
            <div id="path">
                <a id="home" href="${path}">
                    <img src="${path}/resources/images/record/neo_bg_path_home.png" alt="">
                    홈
                </a>
                >
                <a href="${path}">
                    회원마당
                </a>
                >
                <strong>생활기록부</strong>
            </div>
        </div>
        <div id="content2">
            <table>
                <thead>
                    <th id="stdnum">번호</th>
                    <th id="username">이름</th>
                    <th id="userid">아이디</th>
                    <th id="custom">비고</th>
                </thead>
				<c:forEach items="${map['list']}" var="item" varStatus="status">
				    <tr>
				        <td><c:out value="${item.stdnum}"/></td>
				        <td><c:out value="${item.username}"/></td>
				        <td><c:out value="${item.userid}"/></td>
				        <td>
				            <c:choose>
				                <c:when test="${map['rcheck'][status.index] == '0'}">
				                    <button class="write_btn" id="write_btn">작성</button>
				                </c:when>
				                <c:otherwise>
				                    <button class="modify_btn" id="modify_btn">수정</button>
				                </c:otherwise>
				            </c:choose>
				        </td>
				    </tr>
				</c:forEach>
			</table>
		</div>
    </div>
<%@include file="../includes/footer.jsp" %>