$(function(){
	$("#loginbtn").on("click", function(e){
		e.preventDefault();
		if(isValid()){
			$("form").submit();
		}
	});
	function isValid(){
		const userid = $("#userid").val()
		const pw = $("#userpwd").val()
			
		if(userid.length===0 || userid==""){
			alert("아이디는 필수입니다.");
			$("#userid").focus();
			return false;
		}
		if(pw.length===0 || pw==""){
			alert("비밀번호는 필수입니다.");
			$("#userpwd").focus();
			return false;
		}
		return true;
	}
})
