function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            console.log(data)
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraAddr !== ''){
                extraAddr = ' (' + extraAddr + ')';
            }
            // 조합된 참고항목을 해당 필드에 넣는다.
            document.getElementById("sample6_extraAddress").value = extraAddr;
                
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
$(function(){	
	$(document).ready(function(){
		$('select[id=mail-select]').change(function() {
			if($(this).val()=="custom"){
				$('#emailname').val("");
				$("#emailname").attr("readonly", false);
			} else {
				$('#emailname').val($(this).val());
				$("#emailname").attr("readonly", true);
			}
		});
	});
});
$(document).ready(function(){
    $("input:radio[name=agree]").click(function(){
        if($("input[name=agree]:checked").val() == "1"){
            $("input:text[id=emailId]").attr("disabled",false);
            $("input:text[id=emailname]").attr("disabled",false);
            $("select[id=mail-select]").attr("disabled",false);
            $("select[id=mobile1]").attr("disabled",false);
            $("input:text[id=mobile2]").attr("disabled",false);
            $("input:text[id=mobile3]").attr("disabled",false);
        }else if($("input[name=agree]:checked").val() == "0"){
            alert('동의하지 않으실 경우 서비스 불편 시 지원을 위한 연락을 받으실 수 없습니다. 계속하시겠습니까?')
            $("input:text[id=emailId]").attr("disabled",true);
            $("input:text[id=emailname]").attr("disabled",true);
            $("select[id=mail-select]").attr("disabled",true);
            $("select[id=mobile1]").attr("disabled",true);
            $("input:text[id=mobile2]").attr("disabled",true);
            $("input:text[id=mobile3]").attr("disabled",true);
        }
    });
});
$(document).ready(function(){
    $("input:radio[name=memcheck]").click(function(){
        if($("input[name=memcheck]:checked").val() == "0"){
            $("input:text[id=stdNum]").attr("readonly",false);
        }else if($("input[name=memcheck]:checked").val() == "1"){
            $("input:text[id=stdNum]").attr("readonly", true);
        }
    });
});
$(function(){
    var date = new Date()
    month = '' + (date.getMonth() + 1) , 
    day = '' + date.getDate(), 
    year = date.getFullYear();
    
    if (month.length < 2) month = '0' + month; 
    if (day.length < 2) day = '0' + day; 
    
    var myVal=$("#signupdate").val(year+'.'+month+'.'+day)
})
function isError(){
    var pwd = document.getElementById("memberPwd").value;
    let reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,19}$/;
    if(false === reg.test(pwd)){
        document.getElementById('pwdError').innerHTML="비밀번호 구성방법과 일치하지않습니다."
        document.getElementById('pwdError').style.color='red';
        return false;
    }else{
        document.getElementById('pwdError').innerHTML=""
        return true;
    }
}
function isSame(){
    var pwd = document.getElementById("memberPwd").value;
    var pwdchk = document.getElementById("memberPwdChck").value;
    if(pwd === pwdchk){
        document.getElementById('pwdchkError').innerHTML=""
        return true;
    }else{
        document.getElementById('pwdchkError').innerHTML="비밀번호가 일치하지않습니다."
        document.getElementById('pwdchkError').style.color='red';
        return false;
    }
}
function brthNumError(){
    var brthNum = document.getElementById("memberBirthNum").value;
    let reg = /^[0-9]+$/;
    if(false===reg.test(brthNum) || brthNum.length != 8){
        document.getElementById('memberBirthNumError').innerHTML="구성법과 일치하지않습니다."
        document.getElementById('memberBirthNumError').style.color='red';
        return false;
    }else{
        document.getElementById('memberBirthNumError').innerHTML=""
        return true;
    }
}
function stdNumError(){
    var stdNum = document.getElementById("class").value;
    let reg = /^[0-9]+$/;
    if(false===reg.test(stdNum)){
        document.getElementById('stdNumError').innerHTML="구성법과 일치하지않습니다."
        document.getElementById('stdNumError').style.color='red';
        return false;
    }else{
        document.getElementById('stdNumError').innerHTML=""
        return true;
    }
}
$(function(){
	$("#mobile2").on("input", function(e){
		let phone2 = $(this).val()
		if(phone2.length === 4){
			$("#mobile3").focus();
		}
	});
	$("#mobile3").on("input", function(e){
		let phone3 = $(this).val()
		if(phone3.length === 4){
			$(".radio-group2").focus();
		}
	});
	$("#allinfosubmit").on("click", function(e){
		e.preventDefault();
		if(isValid()){
			$("input:text[id=emailId]").attr("disabled",false);
            $("input:text[id=emailname]").attr("disabled",false);
            $("select[id=mail-select]").attr("disabled",false);
            $("select[id=mobile1]").attr("disabled",false);
            $("input:text[id=mobile2]").attr("disabled",false);
            $("input:text[id=mobile3]").attr("disabled",false);
            alert("회원정보가 변경되었습니다.");
            $("#allInfo").submit();
		}
	})
	function isValid(){
        var idchk = $('input[name=idchk]').val();
        var pwd = $('input[name=userpwd]').val();
        var chckpwd = $('input[name=chckPwd]').val();
        var rrNum = $('input[name=rrnum]').val();
        var post = $('input[class=postclass]').val();
        var memCheck = $('input:radio[name=memcheck]');
        var memCheck1 = $('input:radio[name=memcheck]:checked').val();
        var schoolName = $('select[name=schoolname]').val();
        var grade = $('select[name=grade]').val();
        var classNum = $('select[name=classnum]').val();
        var stdNum = $('input[name=stdnum]').val();
        
        let idreg = /^[a-z]+[a-z0-9]{5,19}$/g;
        
        if(pwd.length==0 || pwd==""){
            alert("비밀번호는 필수입니다.");
            $("#memberPwd").focus();
            return false;
        }
        let pwdreg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,19}$/;
        if(false === pwdreg.test(pwd)){
            alert("비밀번호 구성방법과 일치하지않습니다.")
            $("#memberPwd").focus();
            return false;
        }
        if(chckpwd.length==0 || chckpwd==""){
            alert("비밀번호 확인은 필수입니다.");
            $("#memberPwdChck").focus();
            return false;
        }
        if(pwd != chckpwd){
        alert("비밀번호가 일치하지않습니다.")
        $("#memberPwdChck").focus();
        return false;
        }
        if(rrNum.length==0 || rrNum==""){
            alert("생년월일은 필수입니다.");
            $("#memberBirthNum").focus();
            return false;
        }
        if(post.length==0 || post==""){
            alert("주소는 필수입니다.");
            $("#addrBtn").focus();
            return false;
        }
        if(memCheck.is(':checked')===false){
            alert("구분은 필수입니다.");
            $("#student").focus();
            return false;
        }
        if(schoolName=="custom" || schoolName==""){
            alert("학교 선택은 필수입니다.");
            $("#schoolName").focus();
            return false;
        }
        if(grade=="custom" || grade==""){
            alert("학년 선택은 필수입니다.");
            $("#grade").focus();
            return false;
        }
        if(classNum=="custom" || classNum==""){
            alert("반 선택은 필수입니다.");
            $("#class").focus();
            return false;
        }
        if(memCheck1==0){
            if(stdNum.length==0 || stdNum==""){
                alert("번호는 필수입니다.")
                $("#stdNum").focus();
                return false;
            }
        }
		return true;
	}
})
