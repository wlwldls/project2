<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/board/modify.css">
<script src="${path}/resources/ckeditor/ckeditor.js"></script>
<script>
$(function(){
	$("#uploadFile").on("change", function(e){
		let formData = new FormData();
		let inputFile = $("#uploadFile");
		let files = inputFile[0].files;
		for(let i = 0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		$.ajax({
			type: 'post',
			url: '${path}/uploadFileAjax',
			processData: false,
			contentType: false,
			data: formData,
			success: function(result){
				console.log(result);
				showUploadResult(result);
			}
		});
	});
	let regex = new RegExp("(.*)\.(exe|zip|alz)$");
	let maxSize = 5*1024*1024;
	function checkExtension(filename, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(filename)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	function showUploadResult(result){
		if(!result || result.length == 0){return;}
		let uploadUL = $(".uploadResult ul");
		let str = "";
		$(result).each(function(i, obj){
			if(obj.image){
				let fileCallPath = encodeURIComponent(obj.uploadpath+"\\s_"+obj.uuid+"_"+obj.filename);
				str += "<li data-path='"+obj.uploadpath+"'";
				str += "	data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'>";
				str += "	<div>";
				str += "		<span>"+obj.filename+"</span>";
				str += "		<button type='button' data-file=\'"+fileCallPath+"\' ";
				str += "			data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'>x</i></button><br>";
				//str += "		<img src='/display?filename="+fileCallPath+"'>";
				str += "	</div>";
				str += "</li>"
			}else{
				let fileCallPath = encodeURIComponent(obj.uploadpath+"\\"+obj.uuid+"_"+obj.filename);
				str += "<li data-path='"+obj.uploadpath+"'";
				str += "	data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'>";
				str += "	<div>";
				str += "		<span>"+obj.filename+"</span>";
				str += "		<button type='button' data-file=\'"+fileCallPath+"\'"
				str += "			data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'>x</i></button><br>";
				//str += "		<img src='/resources/images/list/ico_attach.png'/>";
				str += "	</div>";
				str += "</li>"
			}
		});
		uploadUL.append(str);
	}
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
				str += "		<button type='button' data-file=\'"+fileCallPath+"\' ";
				str += "			data-type='true' class='btn btn-warning btn-circle'><i class='fa fa-times'>x</i></button><br>";
				str += "		<img src='${path}/display?filename="+fileCallPath+"'>";
				str += "	</div>";
				str += "</li>"
			}else{
				let fileCallPath = encodeURIComponent(attach.uploadpath+"\\s_"+attach.uuid+"_"+attach.filename);
				str += "<li data-path='"+attach.uploadpath+"'";
				str += "	data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'>";
				str += "	<div>";
				str += "		<span>"+attach.filename+"</span>";
				str += "		<button type='button' data-file=\'"+fileCallPath+"\' ";
				str += "			data-type='false' class='btn btn-warning btn-circle'><i class='fa fa-times'>x</i></button><br>";
				str += "		<img src='${path}/resources/images/board/list/ico_attach.png'/>";
				str += "	</div>";
				str += "</li>"
			}
		});
		$(".uploadResult ul").html(str);
	});
	$(".uploadResult").on("click", "li button", function(e){
		let targetFile = $(this).data("file");
		let type = $(this).data("type");
		let targetLi = $(this).parent().closest("li");
		let attach = {filename: targetFile, type: type};
		$.ajax({
			type: 'delete',
			url: '${path}/deleteFile',
			data: JSON.stringify(attach),
			contentType : "application/json; charcet=utf-8",
			success: function(result){
				alert(result);
				targetLi.remove();
			}
		});
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
	var formObj = $("form");
	$('button').on("click", function(e){
		e.preventDefault();
		var operation = $(this).data("oper");
		let formObj = $(".modify_form");
		console.log(operation);
		if(operation === 'remove'){
			formObj.attr("action", "${path}/board/remove");
		}else if(operation === 'list'){
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			formObj.empty();
			formObj.attr("action", "${path}/board/list").attr("method", "get");
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(typeTag);
			formObj.append(keywordTag);
		}else if(operation === 'modify'){
			let str = "";
			$(".uploadResult ul li").each(function(i, listItem){
				let liObj = $(listItem);
				str += "<input type='hidden' name='attachList["+i+"].filename' value='"+liObj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+liObj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+liObj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+liObj.data("type")+"'>";
			});
			formObj.append(str).submit();
		}
		if ($('input[id=impcheck]').is(":checked")) {
		    $('input[name=impcheck]').val('1');
		} else {
		    $('input[name=impcheck]').val('0');
		}
		formObj.submit();
	});
})
var ckeditor_config = {
        height: 300,
        enterMode : CKEDITOR.ENTER_BR.CKEDITOR,
        shiftEnterMode: CKEDITOR.ENTER_P,
        filebrowserUploadUrl:''
        }
</script>
<title>공지사항수정</title>
	<div id="wrap">
		<div id="content1">
			<h1>공지사항수정</h1>
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
                <strong>공지사항수정</strong>
            </div>
        </div>
        <form class="modify_form" action="${path}/board/modify" method="post" enctype="multipart/form-data">
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
	                                중요
	                            </label>
	                        </th>
	                        <td id="itd">
	                            <input type="checkbox" id="impcheck">
	                            <input type="hidden" name="impcheck" />
	                        </td>
	                    </tr>
	                    <tr id="main1">
	                        <th id="writer">
	                            <label id="wlabel">
	                                작성자
	                            </label>
	                        </th>
	                        <td id="wtd">
	                            <input class="title_area" id="winput" maxlength="50" readonly="readonly" name="writer" value="${auth.userid}"/>
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
								<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple/>
								<div class="uploadResult">
									<ul></ul>
								</div>
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