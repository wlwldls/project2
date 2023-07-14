<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/qna/register.css">
<script src="${path}/resources/ckeditor/ckeditor.js"></script>
<script>
$(function(){
	$("#submit_btn").on("click", function(e){
		if ($('input[id=impcheck]').is(":checked")) {
		    $('input[name=impcheck]').val('1');
		} else {
		    $('input[name=impcheck]').val('0');
		}
		self.location = "${path}/qna/register";
	});
	$("#reset_btn").on("click", function(){
		self.location = "${path}/qna/list";
	})
})
var ckeditor_config = {
       height: 300,
       enterMode : CKEDITOR.ENTER_BR.CKEDITOR,
       shiftEnterMode: CKEDITOR.ENTER_P,
       filebrowserUploadUrl:''
   }
</script>
<title>게시글작성</title>
	<div id="wrap">
		<div id="content1">
			<h1>게시글작성</h1>
            <div id="path">
                <a id="home" href="${path}">
                    <img src="${path}/resources/images/qna/neo_bg_path_home.png" alt="">
                    홈
                </a>
                >
                <a href="${path}/board/list">
                    의사소통
                </a>
                >
                <strong>게시글작성</strong>
            </div>
        </div>
        <form class="register_form" method="post" action="${path}/qna/register" enctype="multipart/form-data">
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
	                            <input class="title_area" id="tinput" maxlength="50" name="title" value="${get.title}" required="required"/>
	                        </td>
	                        <th id="important">
	                            <label id="ilabel">
	                                유형
	                            </label>
	                        </th>
	                        <td id="itd">
	                            <select id="type" name="ptype">
	                            	<option value="잡담">잡담</option>
	                            	<option value="질문">질문</option>
	                            	<option value="기타">기타</option>
	                            </select>
	                        </td>
	                    </tr>
	                    <tr id="main1">
	                        <th id="writer">
	                            <label id="wlabel">
	                                작성자
	                            </label>
	                        </th>
	                        <td id="wtd">
	                            <input class="title_area" id="winput" maxlength="50" readonly="readonly" name="writer" value="${auth.userid }"/>
	                        </td>
	                        <th id="regdate">
	                            <label id="rlabel">
	                                작성일
	                            </label>
	                        </th>
	                        <td id="rtd">
	                            
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
	                            <textarea class="written_area" id="contentbox" name="content" required="required">${get.content}</textarea>
	                        </td>
	                    </tr>
	                    <tr id="main3">
	                        <th id="file">
	                            <label id="flabel">
	                                첨부파일
	                            </label>
	                        </th>
	                        <td id="ftd">
								<input type="file" name="file">
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
	            <div class="register_submit">
            		<button class="register_submit_button" id="submit_btn" type="submit">작성</button>
					<button class="register_submit_button" id="reset_btn">취소</button>
        		</div>
	        </div>
	    </form>
    </div>
<script>
    CKEDITOR.replace("contentbox",ckeditor_config)
</script>
<%@include file="../includes/footer.jsp" %>