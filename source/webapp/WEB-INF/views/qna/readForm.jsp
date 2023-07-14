<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${path}/resources/css/qna/read.css">
<script src="${path}/resources/js/ReplyService.js"></script>
<script>
$(function(){
	class ReplyService{
		static add(reply, callback, error){
			$.ajax({
				type:"post",
				url:"${path}/replies/new",
				data: JSON.stringify(reply),
				contentType: "application/json; charset=utf-8",
				success:function(result, status, xhr){
					if(callback){
						callback(status)
					}
				},
				error:function(xhr, status, er){
					if(error){
						error(xhr.status + ' ' + status);
					}
				}
			});
		}
		static getList(param, callback, error){
			let bno = param.bno
			$.getJSON("${path}/replies/pages/" + bno, function(data){
				if(callback){
					console.log(data);
					callback(data);
				}
				var items = data;
			}).fail(function(xhr, status, err){
				if(error){
					error(xhr.status + ' ' + status);
				}
			});
		}
		static displayTime(timeValue) {
			let today= new Date();
			let gap = today.getTime()-timeValue;
			let dateObj = new Date(timeValue);
			let str="";
			if(gap < (1000 * 60 * 60 * 24)) {
				let hh = dateObj.getHours();
				let mi = dateObj.getMinutes();
				let ss = dateObj.getSeconds();
				return [ (hh>9 ? '': '0') + hh, ':', (mi >9 ? '':'0') +mi, ':', (ss>9 ? '' : '0')+ss].join('');
			} else {
				let yy=dateObj.getFullYear();
				let mm=dateObj.getMonth() +1; //getMonth is zero-based
				let dd=dateObj.getDate();
				return[ yy, '/', (mm>9 ? '':'0') +mm, '/', (dd>9 ?'':'0')+dd ].join('');
			}
		}
		static get(rno, callback, error){
			$.get("${path}/replies/get/" + rno, function(result){
				if(callback){
					console.log(result);
					callback(result);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
		}
		static modify(reply, callback, error){
			$.ajax({
				type:"patch",
				url:"${path}/replies/update",
				data: JSON.stringify(reply),
				contentType: "application/json; charset=utf-8",
				success:function(updateResult, status, xhr){
					if(callback){
						callback(updateResult)
					}
				},
				error:function(xhr, status, er){
					if(error){
						error(xhr.status + ' ' + status);
					}
				}
			});
		}
		static remove(rno, callback, error){
			$.ajax({
				type:"delete",
				url:"${path}/replies/delete/" + rno,
				contentType: "application/json; charset=utf-8",
				success:function(deleteResult, status, xhr){
					if(callback){
						callback(deleteResult)
					}
				},
				error:function(xhr, status, er){
					if(error){
						error(xhr.status + ' ' + status);
					}
				}
			});
		}
		static getListWithPaging(param, callback, error){
			let bno = param.bno;
			let page = param.page;
			$.getJSON("${path}/replies/pages/" + bno + "/" + page, function(data){
				if(callback){
					console.log(data);
					callback(data.replyCnt, data.list);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error(xhr.status + ' ' + status);
				}
			});
		}
	}
	const operForm = $("#operForm");
	$("#list_btn").on("click", function(e) {
		operForm.find("#bno").remove();
		operForm.attr("action","${path}/qna/list");
		operForm.submit();
	});
	$("#modify_btn").on("click", function(e) {
		operForm.attr("action","${path}/qna/modify").submit();
	});
	$("#addReplyBtn").on("click", function(){
		$("#reply").val("");
		$("#modalModBtn").hide();
		$("#modalRegisterBtn").show();
		$("#modalCloseBtn").show();
		$(".modal").modal("show");
	})
	$("#modalRegisterBtn").on("click", function(){
		var reply = {
			reply: $("input[name=reply]").val(),
			replyer: $("#replyer").val(),
			bno: $("#bno").val()
		};
		ReplyService.add(reply,
			function(result){
				alert(result);
				$(".modal").modal("hide");
				getReplyListWithPaging(pageNum);
		},
		function(error){
			alert(error);
		});
	});
	getReplyList();
	function getReplyList(){
		ReplyService.getList({bno:'<c:out value="${get.bno}"/>'},
			function(list){
				console.log("list: " + list);
				showReplyList(list);
			},
			function(error){
				alert(error);
		});
	}
	function showReplyList(list){
		let str = "";
		let replyUL = $(".reply");
		if(list == null || list.length == 0){
			replyUL.html(str);
			return;
		}
		for (var i = 0, len = list.length || 0; i < len; i++){
			str += "<li>";
			str += "	<div id='replybox'>";
			str += "		<div class='header'><strong class='primary-font'>" + list[i].replyer+"</strong>";
			str += "			<small class='pull-right text-muted'>("+ReplyService.displayTime(list[i].regdate)+")</small>";
			str += "		</div>";
			str += "		<div data-rno='" + list[i].rno +"' id='replycont' data-replyer='" + list[i].replyer + "'>";
			str += "			<span id='modify' class='primary-font' style='cursor: pointer'>"+list[i].reply+"</span>";
			if("${auth.userid}" === list[i].replyer || "${auth.userid}" === "admin1234"){
				str += "		<button id='remove' type='button' class='close' data-rno='" + list[i].rno+"'>";
				str += "			<span>x</span></button>";
			}
			str += "		</div>";
			str += "	</div>";
			str += "</li>";
		}
		replyUL.html(str);
	}
	$(".reply").on("click", "li #modify", function(e){
		let replyer = $(this).parent().closest('div').data("replyer");
		let rno = $(this).parent().closest('div').data("rno");
		let auth = "${auth.userid}";
		if(auth !== replyer){
			return;
		}
		ReplyService.get(rno,
			function(reply){
				$("#reply").val(reply.reply);
				$("#replyer").val(reply.replyer);
				$(".modal").data("rno", reply.rno);
				$("#modalRegisterBtn").hide();
				$("#modalModBtn").show();
				$(".modal").modal("show");
		});
	});
	$("#modalModBtn").on("click", function(){
		var reply = {
			reply: $("input[name=reply]").val(),
			rno: $(".modal").data("rno")
		};
		ReplyService.modify(reply,
			function(result){
				alert(result);
				$(".modal").modal("hide");
				getReplyListWithPaging(pageNum);
		},
		function(error){
			alert(error);
		});
	});
	$(".reply").on("click", "li #remove", function(){
		let rno = $(this).data("rno");
		ReplyService.remove(rno,
			function(result){
				alert(result);
				getReplyListWithPaging(pageNum);
		},
		function(error){
			alert(error);
		});
	});
	let pageNum = 1;
	let replyPageFooter = $(".panel-footer");
	
	getReplyListWithPaging(pageNum);
	function getReplyListWithPaging(pageNum){
		ReplyService.getListWithPaging(
			{bno:'<c:out value="${get.bno}"/>', page: pageNum},
			function(replyCnt, list){
				console.log("list: " + list);
				showReplyList(list);
				showReplyPaging(replyCnt);
			},
			function(error){
				alert(error);
		});
	}
	function showReplyPaging(replyCnt){
		let endNum = Math.ceil(pageNum / 10.0) * 10;
		let startNum = endNum - 9;
		let prev = startNum !=1;
		let next = false;
		let str = "";
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		str += "<ul class='pagination'>";
		if(prev){
			str += "<li class='paginate_button'><a href='"+(startNum -1)+"'><img src='${path}/resources/images/list/btnpre.gif' id='pre'></a></li>'";
		}
		for(let i = startNum; i <= endNum; i++){
			let active = pageNum == i? "active_list":"";
			str += "<li class='paginate_button "+active+"'><a href='"+i+"' id='num'>"+i+"</a></li>";
		}
		if(next){
			str += "<li class='paginate_button'><a href='"+(endNum +1) + "'><img src='${path}/resources/images/list/btnnext.gif' id='next'></a></li>";
		}
		str += "</ul><div>";
		console.log(str);
		replyPageFooter.html(str);
	}
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		let targetPageNum = $(this).attr("href");
		console.log("targetPageNum: " + targetPageNum);
		pageNum = targetPageNum;
		getReplyListWithPaging(pageNum);
	});
})
</script>
<title>게시글확인</title>
	<div id="wrap">
		<div id="content1">
			<h1>게시글확인</h1>
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
                <strong>게시글확인</strong>
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
                        	<c:choose>
                                <c:when test="${get.filename ne '파일없음'}">
                                    <a href="${path}/fileDownload?fileName=${get.filename}">${get.filename}</a>
                                </c:when>
                                <c:otherwise>
                                    ${get.filename}
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="register_submit">
            <button class="register_submit_button" id="list_btn">목록</button>
            <c:if test="${auth.userid eq get.writer || auth.userid eq 'admin1234'}">
                <button class="register_submit_button" id='modify_btn'>수정</button>
            </c:if>
            <form id='operForm' action="${path}/qna/modify" method="get">
                <input type='hidden' id='bno' name='bno' value='<c:out value="${get.bno}"/>'>
				<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'>
                <input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'>
                <input type='hidden' name='type' value='<c:out value="${criteria.type}"/>'>
                <input type='hidden' name='keyword' value='<c:out value="${criteria.keyword}"/>'>
            </form>
        </div>
        <div class="read_reply">
			<c:if test="${not empty auth }">
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">댓글 작성</button>
			</c:if>
		</div>
		<div id="replytitle">
			<span>댓글 목록</span>
		</div>
		<div class="reply_list">
			<ul class="reply"></ul>
			<div class="panel-footer"></div>
		</div>
		<div class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">REPLY MODAL</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>Reply</label>
							<input class="form-control" id="reply" name="reply">
						</div>
						<div class="form-group">
							<label>Replyer</label>
							<input class="form-control" id='replyer' name='replyer' value="${auth.userid}" readonly="readonly">
						</div>
					</div>
					<div class="modal-footer">
						<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
						<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
						<button id="modalCloseBtn" type="button" class="btn btn-info">Close</button>
					</div>
				</div>
			</div>
		</div>
    </div>
<%@include file="../includes/footer.jsp" %>