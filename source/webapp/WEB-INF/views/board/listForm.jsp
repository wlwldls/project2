<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/board/list.css">
<title>공지사항</title>
<script>
	$(function(){
		$("#write_btn").on("click", function(e){
			self.location = "${path}/board/register";
		});
		let result = '<c:out value="${result}"/>'
			checkModal(result);
			history.replaceState({}, null, null);
			function checkModal(result){
				if(result === "" || history.state){
					return;
				}
				if(parseInt(result) > 0){
					result = parseInt(result) + "번이 등록되었습니다."
				}else{
					result="처리가 완료 되었습니다."
				}
				alert(result);
			}
		$(".get").on("click", function(e) {
		    e.preventDefault();

		    var bno = $(this).attr("href");

		    var form = $("<form></form>");
		    let type = $('select[name=type]').val()
		    let keyword = $('input[name=keyword]').val()
		    form.attr("method", "get");
		    form.attr("action", "${path}/board/get");

		    var input1 = $("<input>")
		      .attr("type", "hidden")
		      .attr("name", "bno")
		      .val(bno);
		    
		    var input2 = $("<input>")
		      .attr("type", "hidden")
		      .attr("name", "pageNum")
		      .val("<c:out value='${pageDTO.criteria.pageNum}'/>");
		    
		    var input3 = $("<input>")
		      .attr("type", "hidden")
		      .attr("name", "amount")
		      .val("<c:out value='${pageDTO.criteria.amount}'/>");
		    form.append("<input type='hidden' name='type' value='" + type + "'>");
		    form.append("<input type='hidden' name='keyword' value='" + keyword + "'>")
		    form.append(input1);
		    form.append(input2);
		    form.append(input3);
		    form.appendTo("body");
		    form.submit();
		});
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			let form = $('<form></form>');
			let type = $('select[name=type]').val()
		    let keyword = $('input[name=keyword]').val()
			form.attr("method", "get");
			form.attr("action", "${path}/board/list");
			form.append("<input type='hidden' name='pageNum' value='" + $(this).attr("href") + "'>");
			form.append("<input type='hidden' name='amount' value='" + <c:out value="${pageDTO.criteria.amount}"/> + "'>");
			form.append("<input type='hidden' name='type' value='" + type + "'>");
		    form.append("<input type='hidden' name='keyword' value='" + keyword + "'>")
			form.appendTo('body');
			form.submit();
		});
		var list = new Array();
		<c:forEach items="${list}" var="list">
			list.push(<c:out value="${list.bno}"/>);
		</c:forEach>
		$.getJSON("${path}/board/getAttachListOnList", {list: list}, function(data){
			let keys = Object.keys(data);
			$(keys).each(function(i, bno){
				let attach = data[bno];
				console.log(attach)
				let html = "";
				if(attach[0] != null){
					html ="<img src='${path}/resources/images/board/list/ico_attach.png'/>";
					$("#"+bno).append(html);
				}
			});
		});
		var list = new Array();
		<c:forEach items="${list}" var="list">
			list.push(<c:out value="${list.bno}"/>);
		</c:forEach>
		if(list.length == 0){
			return;
		}
		let searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			}
			if(!serchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});
	})
</script>
	<div id="wrap">
		<div id="content1">
			<h1>공지사항</h1>
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
                <strong>공지사항</strong>
            </div>
        </div>
        <div id="content2">
        	<div class="searchform">
            	<form action="${path}/board/list" id="searchForm">
            		<select name="type" class="select-style">
            			<option value="T" <c:out value="${pageDTO.criteria.type eq 'T' ? 'selected' : '' }"/>>제목</option>
            			<option value="C" <c:out value="${pageDTO.criteria.type eq 'C' ? 'selected' : '' }"/>>내용</option>
            			<option value="W" <c:out value="${pageDTO.criteria.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
            			<option value="TC" <c:out value="${pageDTO.criteria.type eq 'TC' ? 'selected' : '' }"/>>제목+내용</option>
            		</select>
            		<input type="text" class="select-style" name="keyword" value="<c:out value="${pageDTO.criteria.keyword }"/>"/>
            		<input type="hidden" name="pageNum" value="<c:out value="${pageDTO.criteria.pageNum }"/>"/>
            		<input type="hidden" name="amount" value="<c:out value="${pageDTO.criteria.amount }"/>"/>
            		<button class="button">검색</button>
            	</form>
            </div>
            <table>
                <thead>
                    <th id="bno">번호</th>
                    <th id="title">제목</th>
                    <th id="writer">첨부파일</th>
                    <th id="regdate">작성일</th>
                </thead>
				<c:forEach items="${list}" var="list" varStatus="status">
					<tr>
						<td><c:out value="${list.bno}"/></td>
						<td>
							<a class="get" href='<c:out value="${list.bno}"/>'>
								<c:choose>
                                	<c:when test="${list.impcheck== '1'}">
                                    	<img src="${path}/resources/images/board/icon_point.gif" alt="">
                                    	<c:out value="${list.title}"/>
                                	</c:when>
                               		<c:otherwise>
                                    	<c:out value="${list.title}"/>
                                	</c:otherwise>
                            	</c:choose>
							</a>
						</td>
						<td id='<c:out value="${list.bno}"/>'></td>
						<td>
							<c:choose>
								<c:when test="${list.regdate} == ${list.updatedate}">
									<fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/>
								</c:when>
								<c:otherwise>
									<fmt:formatDate value="${list.updatedate}" pattern="yyyy-MM-dd"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div class="board_page">
				<ul class="pagination">
					<c:if test="${pageDTO.prev}">
						<li class="paginate_button previous">
							<a href="${pageDTO.startPage-1}"><img id="pre" src="${path}/resources/images/board/list/btnpre.gif" alt=""></a>
						</li>
					</c:if>
					<c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
						<li class="paginate_button ${pageDTO.criteria.pageNum==num ? 'active_list' : ''}">
							<a id="num" href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageDTO.next}">
						<li class="paginate_button next">
							<a href="${pageDTO.endPage+1}"><img id="next" src="${path}/resources/images/board/list/btnnext.gif" alt=""></a>
						</li>
					</c:if>
				</ul>
				<c:choose>
					<c:when test="${auth.userid eq 'admin1234'}">
						<div class="board_bottom">
							<button class="write_btn" id="write_btn">글쓰기</button>
						</div>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
			</div>
		</div>
    </div>
<%@include file="../includes/footer.jsp" %>