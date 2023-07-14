<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/timetbl/style.css">
<title>시간표</title>
<div id="wrap">
	<div id="content1">
		<h1>
			<c:out value="${auth.schoolname}"/> 
			<c:out value="${auth.grade}"/>학년 
			<c:out value="${auth.classnum}"/>반 
			시간표
		</h1>
           <div id="path">
               <a id="home" href="${path}">
                   <img src="${path}/resources/images/timetbl/neo_bg_path_home.png" alt="">
                   홈
               </a>
               >
               <a href="${path}/time/timetbl">
                   나의정보
               </a>
               >
               <strong>시간표</strong>
           </div>
       </div>
	<div id="content2">
		<table id="table">
    		<thead>
		        <th id="timenum">교시</th>
		        <th id="time">시간</th>
		        <th id="monday">월요일</th>
		        <th id="tuesday">화요일</th>
		        <th id="wednesday">수요일</th>
		        <th id="thursday">목요일</th>
		        <th id="friday">금요일</th>
		        <th id="saturday">토요일</th>
   			</thead>
  			<c:forEach items="${timelist}" var="list" varStatus="status">
				<tr>
					<td><input type="text" class="inputtext" name="timenum" value='<c:out value="${list.timenum}"/>'readonly/></td>
					<td><input type="text" class="inputtext" name="time" id="inputtime" value='<c:out value="${list.time}"/>'readonly/></td>
					<td><input type="text" class="inputtext" name="monday" value='<c:out value="${list.monday}"/>'readonly/></td>
					<td><input type="text" class="inputtext" name="tuesday" value='<c:out value="${list.tuesday}"/>'readonly/></td>
					<td><input type="text" class="inputtext" name="wednesday" value='<c:out value="${list.wednesday}"/>'readonly/></td>
					<td><input type="text" class="inputtext" name="thursday" value='<c:out value="${list.thursday}"/>'readonly/></td>
					<td><input type="text" class="inputtext" name="friday" value='<c:out value="${list.friday}"/>'readonly/></td>
					<td><input type="text" class="inputtext" name="saturday" value='<c:out value="${list.saturday}"/>'readonly/></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<c:choose>
		<c:when test="${auth.memcheck eq '1'}">
			<div class="board_bottom">
				<button class="modify_btn" id="modify_btn">수정</button>
			</div>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
</div>
<%@include file="../includes/footer.jsp" %>