<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../includes/header.jsp"%>
    <link rel="stylesheet" href="${path}/resources/css/signup/style.css">
    <link rel="stylesheet" href="${path}/resources/css/signup/contents.css">
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${path}/resources/js/modify.js"></script>
    <title>회원정보변경</title>
    <form id="allInfo" name="allInfo" action="${path}/member/modify" method="post">
        <div id="wrap">
            <div id="content1">
                <h1>회원정보변경</h1>
                <div id="path">
                    <a id="home" href="${path}">
                        <img src="${path}/resources/images/signup/neo_bg_path_home.png" alt="">
                        홈
                    </a>
                    >
                    <a href="${path}/member/login">
                        회원마당
                    </a>
                    >
                    <strong>회원정보변경</strong>
                </div>
            </div>
            <div id="content2">
                <img src="${path}/resources/images/signup/neo_step_member_agree2_01.png" alt="">
                <img src="${path}/resources/images/signup/neo_step_member_agree2_02.png" class="imgclass" alt="">
                <img src="${path}/resources/images/signup/neo_step_member_agree2_03_h.png" class="imgclass" alt="">
                <img src="${path}/resources/images/signup/neo_step_member_agree2_04.png" class="imgclass" alt="">
                <img src="${path}/resources/images/signup/neo_step_member_agree2_06.png" class="imgclass" alt="">
            </div>
            <div id="content3">
                <div id="c3top">
                    <h3>회원정보를 변경해 주세요.</h3>
                    <p>*필수입력항목입니다.</p>
                </div>
                <div id="name">
                    <div id="namelabel">
                        <p>이름*</p>
                    </div>
                    <input id="memberName" type="text" name="username" value="${auth.username}" readonly="readonly">
                </div>
                <div id="id">
                    <div id="idlabel">
                        <p>아이디*</p>
                    </div>
                    <input id="memberId" type="text" name="userid" value="${auth.userid}" onchange="idError()" onkeydown="inputidChk()" readonly="readonly">
                    <p>*아이디는 6자 이상, 20자 미만, 아이디 첫자는 영문자 구성, 영문자/숫자 조합만 가능합니다.</p>
                </div>
                <div id="pwd">
                    <div id="pwdlabel">
                        <p>비밀번호*</p>
                    </div>
                    <input id="memberPwd" type="password" name="userpwd" onchange="isError()"/>
                    <label id="pwdError" for="memberPwd"></label>
                    <p id="p1">*비밀번호는 9~20자 이내로 영문 대소문자, 숫자, 특수문자(',",_,\ 제외)를 모두 사용하여 구성하세요.</p>
                    <p id="p2">*아이디와 5자리 이상 동일한 문자 및 5자리 이상 연속된 문자(12345 혹은 abcde 등), 금칙어(./,:;)는 사용할 수 없습니다.</p>
                </div>
                <div id="pwdCheck">
                    <div id="pwdchcklabel">
                        <p>비밀번호 확인*</p>
                    </div>
                    <input id="memberPwdChck" type="password" name="chckPwd" onchange="isSame()">
                    <label id="pwdchkError" for="memberPwdChck"></label>
                </div>
                <div id="rrNum">
                    <div id="rrNumlabel">
                        <p>생년월일*</p>
                    </div>
                    <input id="memberBirthNum" type="text" name="rrnum" onchange="brthNumError()">
                    <label id="memberBirthNumError" for="memberBirthNum"></label>
                    <span>*8자리 숫자로 표기바랍니다.</span>
                </div>
                <div id="addr">
                    <div id="addrlabel">
                        <p>주소*</p>
                    </div>
                    <input type="text" id="sample6_postcode" name="addr1" class="postclass" placeholder="우편번호">
                    <input type="button" id="addrBtn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                    <input type="text" id="sample6_address" name="addr2" class="postclass" placeholder="주소"><br>
                    <input type="text" id="sample6_detailAddress" name="addr3" class="postclass" placeholder="상세주소">
                    <input type="text" id="sample6_extraAddress" name="addr4" class="postclass" placeholder="참고항목">
                </div>
            </div>
            <div id="content4">
                <div id="c4top">
                    <h3>추가 입력 항목</h3>
                </div>
                <div id="personalChk">
                    <div id="personalChklabel">
                        <p>
                            선택 개인정보<br>
                            수집·이용 동의
                        </p>
                    </div>
                    <label><input type="radio" class="radio-group1" name="agree" value="1" checked><span> 동의합니다. </span></label>
                    <label><input type="radio" class="radio-group1" name="agree" value="0"><span> 동의하지 않습니다.</span></label>
                </div>
                <div id="email">
                    <div id="emaillabel">
                        <p>이메일</p>
                    </div>
                    <input type='text' id="emailId" name="emailid"/>
                    <span>@</span>
                    <input type='text' id="emailname" name="emailname"/>
                    <select id="mail-select">
                        <option value="custom">-직접입력-</option>
                        <option value="naver.com">naver.com</option>
                        <option value="hanmail.com">hanmail.com</option>
                        <option value="gmail.com">gmail.com</option>
                    </select>
                </div>
                <div id="phoneNum">
                    <div id="phoneNumlabel">
                        <p>연락처</p>
                    </div>
                    <div id="mobilecont">
                        <select id="mobile1" name="mobile1">
                            <option value="custom">선택</option>
                            <option value="010">010</option>
                            <option value="011">011</option>
                            <option value="016">016</option>
                        </select>
                        -
                        <input type="text" id="mobile2" name="mobile2"/>
                        -
                        <input type="text" id="mobile3" name="mobile3"/>
                    </div>
                </div>
            </div>
            <div id="content5">
                <div id="c5top">
                    <h3>학생서비스 신청 항목</h3>
                </div>
                <div id="memberChk">
                    <div id="memberChklabel">
                        <p>구분*</p>
                    </div>
                    <label><input type="radio" class="radio-group2" name="memcheck" value="0"><span> 학생</span></label>
                    <label><input type="radio" class="radio-group2" name="memcheck" value="1"><span> 선생님</span></label>
                </div>
                <div id="school">
                    <div id="schoollabel">
                        <p>학교*</p>
                    </div>
                    <select id="schoolName" name="schoolname">
                        <option value="custom">-학교 선택-</option>
                        <option value="경북고등학교">경북고등학교</option>
                        <option value="경신고등학교">경신고등학교</option>
                        <option value="능인고등학교">능인고등학교</option>
                        <option value="대구과학고등학교">대구과학고등학교</option>
                        <option value="대구남산고등학교">대구남산고등학교</option>
                        <option value="대구농업마이스터고등학교">대구농업마이스터고등학교</option>
                        <option value="대구여자고등학교">대구여자고등학교</option>
                        <option value="대구중앙고등학교">대구중앙고등학교</option>
                        <option value="대구혜화여자고등학교">대구혜화여자고등학교</option>
                        <option value="대륜고등학교">대륜고등학교</option>
                        <option value="덕원고등학교">덕원고등학교</option>
                        <option value="동문고등학교">동문고등학교</option>
                        <option value="수성고등학교">수성고등학교</option>
                        <option value="시지고등학교">시지고등학교</option>
                        <option value="영남공업고등학교">영남공업고등학교</option>
                        <option value="오성고등학교">오성고등학교</option>
                        <option value="정화여자고등학교">정화여자고등학교</option>
                    </select>
                    <select id="grade" name="grade">
                        <option value="custom">-학년 선택-</option>
                        <option value="1">1학년</option>
                        <option value="2">2학년</option>
                        <option value="3">3학년</option>
                    </select>
                    <select id="class" name="classnum">
                        <option value="custom">-반 선택-</option>
                        <option value="1">1반</option>
                        <option value="2">2반</option>
                        <option value="3">3반</option>
                        <option value="4">4반</option>
                        <option value="5">5반</option>
                        <option value="6">6반</option>
                        <option value="7">7반</option>
                        <option value="8">8반</option>
                        <option value="9">9반</option>
                        <option value="10">10반</option>
                        <option value="11">11반</option>
                        <option value="12">12반</option>
                        <option value="13">13반</option>
                    </select>
                    <input type="text" id="stdNum" name="stdnum" onchange="stdNumError()" placeholder="번호"/>
                    <label id="stdNumError" for="stdNum"></label>
                    <p>*번호는 숫자만 가능합니다.</p>
                </div>
                <div id="singupDate">
                    <div id="singupDatelabel">
                        <p>신청일자*</p>
                    </div>
                    <input type="text" id="signupdate" value="" readonly>
                </div>
            </div>
            <div id="content6">
                <a href="#" id="allinfosubmit">
                    <img src="${path}/resources/images/signup/neo_btn_member_register.png" alt="">
                </a>
                <a href="${path}">
                    <img src="${path}/resources/images/signup/neo_btn_member_cancel.png" alt="">
                </a>
            </div>
        </div>
    </form>
<%@include file="../includes/footer.jsp" %>