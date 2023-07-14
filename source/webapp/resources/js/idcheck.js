function pValue(){
	document.getElementById("userid").value = opener.document.allInfo.userid.value;
}
$(function(){
		$("#idchkbtn").on("click", function(e){
			e.preventDefault();
			if(isValid()){
		    	$("#checkForm").attr("action", "/project/check/idcheck");
		    	$("#checkForm").submit();
			}
		});
		function isValid(){
			var id = document.getElementById("userid").value;
			let reg = /^[a-z]+[a-z0-9]{5,19}$/g;

			if(id==""){
				alert("아이디를 입력하세요.");
				return false;
			}
			if(false === reg.test(id)){
				alert("아이디 구성방법과 일치하지않습니다.")
				return false;
			}
			return true;
		}
	})
