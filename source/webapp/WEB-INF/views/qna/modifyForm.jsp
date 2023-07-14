<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/qna/modify.css">
<script src="${path}/resources/ckeditor/ckeditor.js"></script>
<script>
$(function(){
	var formObj = $("form");
	$('button').on("click", function(e){
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		
		if(operation === 'remove'){
			formObj.attr("action", "${path}/qna/remove");
		}else if(operation === 'list'){
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			formObj.empty();
			formObj.attr("action", "${path}/qna/list").attr("method", "get");
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(typeTag);
			formObj.append(keywordTag);
		}
		if ($('input[id=impcheck]').is(":checked")) {
		    $('input[name=impcheck]').val('1');
		} else {
		    $('input[name=impcheck]').val('0');
		}
		formObj.submit();
	});
	 $("input[id='file-delete']").on("click", function(e) {
         e.preventDefault();
         const filename = document.getElementById('filename');
         const filedelete = document.getElementById('file-delete');
         filename.remove();
         filedelete.remove();
         $("#ftd").append("<input type='file' name='file'>");
     });
})
var ckeditor_config = {
        height: 300,
        enterMode : CKEDITOR.ENTER_BR.CKEDITOR,
        shiftEnterMode: CKEDITOR.ENTER_P,
        filebrowserUploadUrl:''
        }
</script>
<title>게시글수정</title>
	<div id="wrap">
		<div id="content1">
			<h1>게시글수정</h1>
            <div id="path">
                <a id="home" href="${path}">
                    <img src="${path}/resources/images/qna/neo_bg_path_home.png" alt="">
                    홈
                </a>
                >
                <a href="${path}/qna/list">
                    의사소통
                </a>
                >
                <strong>게시글수정</strong>
            </div>
        </div>
        <form action="${path}/qna/modify" method="post" enctype="multipart/form-data">
	        <div id="content2">
	        	<input type="hidden" name="pageNum" value="<c:out value='${criteria.pageNum}'/>">
				<input type="hidden" name="amount" value="<c:out value='${criteria.amount}'/>">
				<input type="hidden" name="bno" value="<c:out  value='${get.bno}'/>">
				<input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>
                <input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>
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
	                            ${get.ptype}
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
	                            <c:choose>
	                                <c:when test="${get.regdate } == ${get.updatedate }">
	                                    <fmt:formatDate pattern="YY-MM-dd hh:mm" value="${get.regdate}"/>
	                                </c:when>
	                                <c:otherwise>
	                                    <fmt:formatDate pattern="YY-MM-dd hh:mm" value="${get.updatedate}"/>
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
            		<button type="submit" data-oper='modify' id="modify_btn" class="read_button" >수정</button>
					<button type="submit" data-oper='remove' id="remove_btn" class="read_button" >삭제</button>
					<button type="submit" data-oper="list" id="list_btn" class="read_button">목록</button>
        		</div>
	        </div>
	    </form>
    </div>
<script>
    CKEDITOR.replace("contentbox",ckeditor_config)
</script>
<%@include file="../includes/footer.jsp" %>