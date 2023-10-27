var a = 0;

// 빈칸이 들어갈 경우 에러가 나기 때문에 공백 확인
function Checkform(a) {
	
	if (a == 0 ){
		title = $("#title").val();
		detail = $("#detail").val();
	} else if(a == 1){
		title = $("#title2").val();
		detail = $("#detail2").val();
	}
	

	if (title == "" & detail == "") {
		alert("제목과 내용을 적어주세요");

		return 0;
	}

	else if (title == "" || title == "&nbsp") {
		alert("제목을 적어주세요.");

		return 0;
	} else if (detail == "") {
		alert("내용을 적어주세요");

		return 0;
	}

	title = title.trim();
	detail = detail.trim();

	if (title == "" || detail == "") {
		alert("공백 문자는 허용하지 않습니다.")
		return 0;
	}

	return 1;
};