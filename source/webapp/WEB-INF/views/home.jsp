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
    <link rel="stylesheet" href="${path}/resources/css/home/style.css">
    <link rel="stylesheet" href="${path}/resources/css/home/contents.css">
    <link rel="stylesheet" href="${path}/resources/css/home/footer.css">
    <link rel="stylesheet" href="${path}/resources/css/home/header.css">
    <link rel="stylesheet" href="${path}/resources/css/home/popup.css">
    <script src="${path}/resources/js/jquery.js"></script>
    <script>
    $(function(){
    	var logoutmsg = '<c:out value="${logoutmsg}"/>';
    	if(logoutmsg=="logout"){
    		alert("로그아웃 되었습니다.")
    	}
    	if(logoutmsg==""){
    		return;
    	}
    })
    </script>
    <title>나이스 홈</title>
</head>
<body>
    <div id="popup">
        <div id="header">
            <div id="arrow"></div>
            <div id="text">시.도교육청 상담센터안내</div>
            <div id="xbox" onclick="popupClose()" class="xbox"></div>
        </div>
        <div id="body">
            <div id="schoolImg">
                <img src="${path}/resources/images/home/spr_sm_pop_visual_call.png" alt="전화">
            </div>
            <div id="popContent">
                <div id="headerTbl">
                    <table>
                        <tr>
                            <th id="th1">
                                <span>시·도교육청</span>
                            </th>
                            <th id="th2">
                                <span>서비스 구분</span>
                            </th>
                            <th id="th3">
                                <span>문의전화</span>
                            </th>
                        </tr>
                    </table>
                </div>
                <div id="mainTbl">
                    <table>
                        <tr class="trOdd">
                            <td id="td1"><span>서울특별시교육청 학생서비스 상담센터</span></td>
                            <td id="td2"><span>대국민서비스</span></td>
                            <td><span>02-1396 (ARS #)</span></td>
                        </tr>
                        <tr>
                            <td><span>부산광역시교육청 학생서비스 상담센터</span></td>
                            <td><span>대국민서비스</span></td>
                            <td><span>051-1396(금 08:00~17:00)</span></td>
                        </tr>
                        <tr class="trOdd">
                            <td><span>대구광역시교육청 학생서비스 상담센터</span></td>
                            <td><span>대국민서비스</span></td>
                            <td><span>053-231-0284</span></td>
                        </tr>
                        <tr>
                            <td><span>인천광역시교육청 학생서비스 상담센터</span></td>
                            <td><span>대국민서비스</span></td>
                            <td><span>032-4208-114(ARS 2)</span></td>
                        </tr>
                        <tr class="trOdd">
                            <td><span>인천광역시교육청 학생서비스 상담센터</span></td>
                            <td><span>검정고시</span></td>
                            <td><span>032-4208-313~317,425(수,금 8:30~17:30)</span></td>
                        </tr>
                        <tr>
                            <td><span>광주광역시교육청 학생서비스 상담센터</span></td>
                            <td><span>학생·학부모서비스</span></td>
                            <td><span>062-380-4783,4785</span></td>
                        </tr>
                        <tr class="trOdd">
                            <td><span>광주광역시교육청 학생서비스 상담센터</span></td>
                            <td><span>검정고시</span></td>
                            <td><span>062-380-4328</span></td>
                        </tr>
                        <tr>
                            <td><span>광주광역시교육청 학생서비스 상담센터</span></td>
                            <td><span>홈에듀민원(제증명발급)</span></td>
                            <td><span>062-380-4123</span></td>
                        </tr>
                        <tr class="trOdd">
                            <td><span>대전광역시교육청 학생서비스 상담센터</span></td>
                            <td><span>대국민서비스</span></td>
                            <td><span>042-865-9302(금 08:30~17:30)</span></td>
                        </tr>
                        <tr>
                            <td><span>울산광역시교육청 학생서비스 상담센터</span></td>
                            <td><span>대국민서비스</span></td>
                            <td><span>052-220-1991(08:00~17:00)</span></td>
                        </tr>
                        <tr class="trOdd">
                            <td><span>세종특별자치시교육청 학생서비스 상담센터</span></td>
                            <td><span>대국민서비스</span></td>
                            <td><span>044-902-1389</span></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <header>
        <div id="linebox">
            <div id="inner-header">
                <div id="logo1">
                    <a href="${path}">
                        <img src="${path}/resources/images/home/neis_logo.png" alt="로고">
                    </a>
                </div>
                <div id="menu">
                    <div id="smbox1">
                        <select name="hrefSelect" id="hrefSelect">
                            <option value="https://www.sen.go.kr">서울특별시교육청</option>
                            <option value="https://www.pen.go.kr">부산광역시교육청</option>
                            <option value="https://www.dge.go.kr">대구광역시교육청</option>
                            <option value="https://www.ice.go.kr">인천광역시교육청</option>
                            <option value="https://www.gen.go.kr">광주광역시교육청</option>
                            <option value="https://www.dje.go.kr">대전광역시교육청</option>
                            <option value="https://www.use.go.kr">울산광역시교육청</option>
                        </select>
                        <a onclick="hrefGo()" id="hrefAnker">
                            <button>이동</button>
                        </a>
                    </div>
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
	                                	<img src="${path}/resources/images/home/neo_icon_login.png" alt="">
	                                	<span>로그인</span>
                                	</a>
                            	</c:otherwise>
                            </c:choose>
                        </li>
                        <li id="line">
                        	<c:choose>
	                            <c:when test="${not empty auth}">
	                                <a id="a4" href="${path}/member/modify">
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
        <nav id="nav">
            <ul>
                <li>
                	<a id="navhover1" href="${path}/time/timetbl">
                		<div id="div">시간표</div>
                	</a>
                </li>
                <li><a id="navhover2" href="#"><div class="section">출석부</div></a></li>
                <li>
                	<c:choose>
						<c:when test="${auth.memcheck eq '1'}">
							<a id="navhover3" href="${path}/record/list">
                				<div class="section">생활기록부</div>
                			</a>
						</c:when>
						<c:otherwise>
							<a id="navhover3" href="${path}/record/get">
                				<div class="section">생활기록부</div>
                			</a>
						</c:otherwise>
					</c:choose>
                </li>
                <li><a id="navhover4" href="#"><div class="section">성적</div></a></li>
                <li><a id="navhover5" href="#"><div class="section">성적표</div></a></li>
                <li><a id="navhover6" href="${path}/qna/list"><div class="section">게시판</div></a></li>
            </ul>
        </nav>   
    </header>
    <div id="wrap">
        <div id="cont1">
            <div id="box1">
                <div id="dung">
                    <a id=dung1 href="#">
                        <img id="dimg1" src="${path}/resources/images/home/stsVisualbox_01.png" alt="생활기록부">
                    </a>
                    <a id=dung2 href="#">
                        <img id="dimg2" src="${path}/resources/images/home/stsVisualbox_02.png" alt="성적표">
                    </a>
                    <a id=dung3 href="#">
                        <img id="dimg3" src="${path}/resources/images/home/stsVisualbox_03.png" alt="오답표">
                    </a>
                    <a id=dung4 href="#">
                        <img id="dimg4" src="${path}/resources/images/home/stsVisualbox_04.png" alt="소속변경">
                    </a>
                    <a id=dung5 href="#">
                        <img id="dimg5" src="${path}/resources/images/home/stsVisualbox_05.png" alt="학사일정">
                    </a>
                    <a id=dung6 href="#">
                        <img id="dimg6" src="${path}/resources/images/home/stsVisualbox_06.png" alt="식단표">
                    </a>
                </div>
            </div>
        </div>
        <div id="cont2">
            <div id="box2">
                <div id="inbox2">
                    <div id="notice">
                        <div id="tab-btn">
                            <img src="${path}/resources/images/home/neo_sm_title_04.png" alt="">
                            <a href="${path}/board/list">
                                <img id="more" src="${path}/resources/images/home/neo_btn_more.png" alt="">
                            </a>
                        </div>
                        <div id="tab-cont">
                            <ul>
                                <li>
                                    <a href="#">
                                        <img src="${path}/resources/images/home/neo_notice_EDU_A00.png" alt="">
                                        <span class="textOver">만 14세 미만 학생서비스 로그인 관련 안내</span>
                                        <span>2023.02.17</span>
                                    </a>
                                </li>
                               <li>
                                    <a href="#">
                                        <img src="${path}/resources/images/home/neo_notice_EDU_A00.png" alt="">
                                        <span class="textOver">나이스 학생, 학부모서비스 간편인증, 디지털원패스 이용안내</span>
                                        <span>2022.09.16</span>
                                    </a>
                                </li>
                               <li>
                                    <a href="#">
                                        <img src="${path}/resources/images/home/neo_notice_EDU_A00.png" alt="">
                                        <span class="textOver">시도교육청 나이스 상담센터 전화번호(2023.04.24)</span>
                                        <span>2022.02.07</span>
                                    </a>
                                </li>
                               <li>
                                    <a href="#">
                                        <img src="${path}/resources/images/home/neo_notice_EDU_A00.png" alt="">
                                        <span class="textOver">[나이스 대국민서비스 플러그인 제거에 따른 화면 변경사항 안내]</span>
                                        <span>2019.07.18</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div id="gallery" class="slideshow-container">
                        <div id="gallery1" class="mySlides fade">
                            <a href="#">
                                <img id="banner1" src="${path}/resources/images/home/KERIS학생기록부조회_배너.png" alt="">
                            </a>
                            <div id="large">
                                졸업학교 정보조회
                            </div>
                            <div id="small">
                                초,중학교 졸업생<br>
                                기간:2023.3.2 ~ 5.31.<br>
                                학년:중, 고등학교 1학년
                            </div>
                            <a href="#">
                                <img id="banner2" src="${path}/resources/images/home/neo_btn_go.png" alt="">
                            </a>
                        </div>
                        <div id="gallery2" class="mySlides fade">
                            <a href="https://e-voucher.kosaf.go.kr">
                                <img id="banner1" src="${path}/resources/images/home/배너_나이스 154x126.jpg" alt="">
                            </a>
                            <div id="large">
                                2023 교육급여 바우처
                            </div>
                            <div id="small">
                                자세한 사항은 [클릭]
                            </div>
                            <a href="https://e-voucher.kosaf.go.kr">
                                <img id="banner2" src="${path}/resources/images/home/neo_btn_go.png" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="cont3">
            <div id="box3">
                <ul>
                    <li id="first">
                        <a href="https://stu.dge.go.kr/edusys.jsp?page=sts_m41310">
                            <img id="img1" src="${path}/resources/images/home/sts_sm_btn_sevice_01.png" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="javascript:popupOpen()">
                            <img id="img2" src="${path}/resources/images/home/sts_sm_btn_sevice_03.png" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="https://stu.dge.go.kr/edusys.jsp?page=sts_m41600">
                            <img id="img3" src="${path}/resources/images/home/sts_sm_btn_sevice_05.png" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="https://as2.neis.go.kr/client/main.do">
                            <img id="img4" src="${path}/resources/images/home/sts_sm_btn_sevice_06.png" alt="">
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <footer>
        <div id="inner-footer">
            <div id="logo2">
                <a id="a1" href="https://www.moe.go.kr">
                    <img src="${path}/resources/images/home/neo_f_btn_moe.png" alt="">
                </a>
                <a id="a2" href="https://www.keris.or.kr">
                    <img src="${path}/resources/images/home/neo_f_btn_keris.png" alt="">
                </a>
            </div>
            <div id="copyright">
                <ul>
                    <li id="line1">
                        <a href="https://www.neis.go.kr/pas_mms_nv10_001.do?returnDomain=D10&returnBiz=STS&returnPage=sts_m40000">
                            이용약관
                        </a>
                    </li>
                    <li id="line2">
                        <a id="a3" href="#" onclick="mmsGo()">
                            개인정보처리방침
                        </a>
                    </li>
                    <li id="line3">
                        <a href="https://www.neis.go.kr/pas_mms_nv11_001.do?returnDomain=D10&returnBiz=STS&returnPage=sts_m40000">
                            이메일 무단수집거부
                        </a>
                    </li>
                    <li id="line4">
                        <a href="https://www.neis.go.kr/pas_mms_nv12_001.do?returnDomain=D10&returnBiz=STS&returnPage=sts_m40000">
                            저작권보호정책
                        </a>
                    </li>
                    <li id="line5">
                        <a href="https://as2.neis.go.kr/client/main.do">
                            원격지원서비스
                        </a>
                    </li>
                    <li id="line6">
                        <a id="a4" href="https://stu.dge.go.kr/edusys.jsp?page=sts_m41700">
                            사이트맵
                        </a>
                    </li>
                </ul>
                <p>COPYRIGHT (C) MINISTRY OF EDUCATION. ALL RIGHTS RESERVED.</p>
            </div>
            <div id="logo3">
                <a href="http://wa.or.kr/board/list.asp?search=total&SearchString=%B3%AA%C0%CC%BD%BA&BoardID=0006">
                    <img src="${path}/resources/images/home/neo_f_btn_kiwac.jpg" alt="">
                </a>
            </div>
        </div>
    </footer>
    <script src="${path}/resources/js/home.js"></script>
</body>
</html>