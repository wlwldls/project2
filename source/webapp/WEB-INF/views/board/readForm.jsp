<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/board/read.css">
<script>
$(function(){
	const operForm = $("#operForm");
	$("#list_btn").on("click", function(e) {
		operForm.find("#bno").remove();
		operForm.attr("action","${path}/board/list");
		operForm.submit();
	});
	$("#modify_btn").on("click", function(e) {
		operForm.attr("action","${path}/board/modify").submit();
	});
	let bno = '<c:out value="${get.bno}"/>';
	$.getJSON("${path}/board/getAttachList/" + bno, function(attachList){
		let str = "";
		$(attachList).each(function(i, attach){
			if(attach.filetype){
				let fileCallPath = encodeURIComponent(attach.uploadpath+"\\s_"+attach.uuid+"_"+attach.filename);
				str += "<li data-path='"+attach.uploadpath+"'";
				str += "	data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'>";
				str += "	<div>";
				str += "		<span>"+attach.filename+"</span>";
				str += "		<img src='${path}/display?filename="+fileCallPath+"'>";
				str += "	</div>";
				str += "</li>"
			}else{
				str += "<li data-path='"+attach.uploadpath+"'";
				str += "	data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'>";
				str += "	<div>";
				str += "		<span>"+attach.filename+"</span>";
				str += "		<img src='${path}/resources/images/board/list/ico_attach.png'/>";
				str += "	</div>";
				str += "</li>"
			}
		});
		$(".uploadResult ul").html(str);
	});
	function showImage(fileCallPath){
		$(".bigPictureWrapper").css("display", "flex").show();
		$(".bigPicture").html("<img src='${path}/display?filename="+fileCallPath+"'>").animate({width:'100%', top:'0'}, 600);
	}
	$(".uploadResult").on("click", "li", function(e){
		let liobj = $(this);
		let path = encodeURIComponent(liobj.data("path")+"\\"+liobj.data("uuid")+"_"+liobj.data("filename"));	
		if(liobj.data("type")){
			showImage(path)
		}else{
			if(path.toLowerCase().endsWith('pdf')){
				window.open("${path}/pdfviewer?filename="+path);
				self.location = "${path}/downloadFile?filename="+path;
			}else{
				self.location = "${path}/downloadFile?filename="+path;
			}
		}
	});
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPictureWrapper").hide();
		$(".bigPicture").css("top", "15%");
	});
})
</script>
<title>공지사항확인</title>
	<div id="wrap">
		<div id="content1">
			<h1>공지사항확인</h1>
            <div id="path">
                <a id="home" href="${path}">
                    <img src="${path}/resources/images/board/neo_bg_path_home.png" alt="">
                    홈
                </a>
                >
                <a href="${path}/board/list">
                    의사소통
                </a>
                >
                <strong>공지사항확인</strong>
            </div>
        </div>
        <div id="content2">
            <table id="noticehead">
                <tbody id="tblhead">
                    <tr id="htr">
                        <th id="title">
                            <label id="tlabel">
                                제목
                            </label>
                        </th>
                        <td id="ttd">
                            <input class="title_area" id="tinput" maxlength="50" readonly="readonly" name="title" value="${get.title}" required="required"/>
                        </td>
                        <th id="important">
	                        <label id="ilabel">
	                            중요
	                        </label>
	                    </th>
	                    <td id="itd">
	                        <c:choose>
                               	<c:when test="${get.impcheck== '1'}">
                                   	<img src="${path}/resources/images/board/icon_point.gif" alt="">
                               	</c:when>
                              	<c:otherwise></c:otherwise>
                           	</c:choose>
	                    </td>
                    </tr>
                    <tr id="main1">
                        <th id="writer">
                            <label id="wlabel">
                                작성자
                            </label>
                        </th>
                        <td id="wtd">
                            <span>${get.writer}</span>
                        </td>
                        <th id="regdate">
                            <label id="rlabel">
                                작성일
                            </label>
                        </th>
                        <td id="rtd">
                            <c:choose>
                                <c:when test="${get.regdate } == ${get.updatedate }">
                                    <fmt:formatDate pattern="YY-MM-dd HH:mm" value="${get.regdate}"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatDate pattern="YY-MM-dd HH:mm" value="${get.updatedate}"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table id="tblbody">
                <tbody id="tblmain">
                    <tr id="main2">
                        <th id="content">
                            <label id="clabel">
                                내용
                            </label>
                        </th>
                        <td id="ctd">
                            <div id="contentbox">
                            	${get.content}
                            </div>
                        </td>
                    </tr>
                    <tr id="main3">
                        <th id="file">
                            <label id="flabel">
                                첨부파일
                            </label>
                        </th>
                        <td id="ftd">
                      		<div class="uploadResult">
								<ul></ul>
							</div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="register_submit">
            <button class="register_submit_button" id="list_btn">목록</button>
            <c:if test="${auth.userid eq get.writer}">
                <button class="register_submit_button" id='modify_btn'>수정</button>
            </c:if>
            <form id='operForm' action="${path}/board/modify" method="get">
                <input type='hidden' id='bno' name='bno' value='<c:out value="${get.bno}"/>'>
                <input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
                <input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
                <input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>
                <input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>
            </form>
        </div>
        <div class="bigPictureWrapper">
			<div class="bigPicture"></div>
		</div>
    </div>
<%@include file="../includes/footer.jsp" %>