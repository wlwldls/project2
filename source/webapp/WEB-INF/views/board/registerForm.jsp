<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/board/register.css">
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
			url: '/uploadFileAjax',
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
				str += "		<img src='${path}/display?filename="+fileCallPath+"'>";
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
				str += "		<img src='${path}/resources/images/board/list/ico_attach.png'/>";
				str += "	</div>";
				str += "</li>"
			}
		});
		uploadUL.append(str);
	}
	$(".uploadResult").on("click", "li button", function(e){
		let targetFile = $(this).data("file");
		let type = $(this).data("type");
		let targetLi = $(this).parent().closest("li");
		let attach = {filename: targetFile, type: type};
		$.ajax({
			type: 'delete',
			url: '/deleteFile',
			data: JSON.stringify(attach),
			contentType : "application/json; charcet=utf-8",
			success: function(result){
				alert(result);
				targetLi.remove();
			}
		});
	});
	$("#submit_btn").on("click", function(e){
		e.preventDefault();
		let formObj = $(".register_form");
		let str = "";
		$(".uploadResult ul li").each(function(i, listItem){
			let liObj = $(listItem);
			str += "<input type='hidden' name='attachList["+i+"].filename' value='"+liObj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+liObj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+liObj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+liObj.data("type")+"'>";
		});
		if ($('input[id=impcheck]').is(":checked")) {
		    $('input[name=impcheck]').val('1');
		} else {
		    $('input[name=impcheck]').val('0');
		}
		formObj.append(str).submit();
	});
	$("#reset_btn").on("click", function(){
		self.location = "${path}/board/list";
	})
});
var ckeditor_config = {
       height: 300,
       enterMode : CKEDITOR.ENTER_BR.CKEDITOR,
       shiftEnterMode: CKEDITOR.ENTER_P,
       filebrowserUploadUrl:''
   }
</script>
<title>공지사항작성</title>
	<div id="wrap">
		<div id="content1">
			<h1>공지사항작성</h1>
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
                <strong>공지사항작성</strong>
            </div>
        </div>
        <form class="register_form" method="post" action="${path}/board/register" enctype="multipart/form-data">
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
								<input type="file" name="uploadFile" id="uploadFile" class="file-input" multiple/>
								<div class="uploadResult">
									<ul></ul>
								</div>
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