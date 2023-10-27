<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<style>
.t_red {
	color: red;
}

.page-header {
	margin: 40px 0px 0px;
	border: 1px;
	background-color: #570df6 !important;
	text-align: center;
	color: white;
	border-top-right-radius: 20px;
	border-top-left-radius: 20px;
	padding: 5px;
}

.panel-body {
	padding: 6px 0 0 0px !important;
}

.form-control {
	width: 100%;
	resize: none;
	outline: none;
	border: none;
	font-size: 20px;
	background-color: #d9d9d9cc !important;
	height: 40px;
}

.btn {
	border: none;
	background-color: #570df6;
	color: white;
	font-size: 18px;
}
</style>

<title>Register Page</title>

<div style="margin: 5%">

	<div class="col-lg-12" style="padding: 0px">
		<h1 class="page-header">Board Register</h1>
	</div>

	<!-- row -->

	<div class="row">
		<div class="col-lg-12">

			<!-- panel heading -->
			<div class="panel-body">
				<strong><span class="t_red">*</span> 표시는 필수입력 항목입니다.</strong><br>
				<form name="frr" role="form" action="/board/register" id='form'
					enctype="application/json" method="post"
					onReset="return Returnform()">
					<div style="padding: 5px 10px; padding-bottom: 20px;">
						<div style="margin-top: 10px">

							<!-- 제목 입력 -->
							<div class="form-group" style="margin-bottom: 10px">
								<h3>
									Title<span class="t_red">*</span>
								</h3>
								<input name="title" id="title" class="form-control"
									maxlength='30' style="height: 40px !important;"
									placeholder="제목을 입력해 주세요 (최대 30 글자까지 적으실 수 있습니다.)">
							</div>

							<!-- 내용 입력 -->
							<div class="form-group">
								<h3>
									Text area<span class="t_red">*</span>
								</h3>
								<textarea name="detail" id="detail" rows="3"
									class="form-control"
									placeholder="내용을 입력해 주세요 (최대 400 글자까지 적으실 수 있습니다.)"
									maxlength="400" wrap="hard"></textarea>
							</div>

							<!-- 파일 업로드 -->
							<div class="form-group">
								<h3>Attachment</h3>
								<div style="margin-bottom: 5px;">
									<strong>파일은 3개까지 첨부할 수 있습니다 <span class="t_red">*</span></strong><br>
									<strong>한개 파일의 최대 크기는 2097Kbyte 입니다. <span
										class="t_red">*</span></strong><br> <strong>파일의 최대 크기는
										104857Kbyte 입니다. <span class="t_red">*</span>
									</strong>
								</div>

								<input class="form-control" id="upload-name"
									style="border-radius: 0px 4px 4px 0px !important; width: 88%; display: inline;"
									placeholder="첨부 파일" readonly> <label for="file"
									style="display: inline; padding: 14px 10px 11px 10px; border-radius: 4px; background: #570df6; color: white;">파일찾기</label>
								<input type='file' name='files' id="file" style="display: none;"
									multiple>
							</div>
						</div>
						<div style="margin-top: 10px; float: right;">
							<button type="button" class="btn btn-sm btn-primary" id='submit'>Submit
							</button>
							<button type="reset" class="btn btn-sm btn-primary">Reset
							</button>
							<button type="button" onclick="location='list'"
								class="btn btn-sm btn-primary">Return Page</button>
						</div>
					</div>
				</form>

			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- row -->
<script src="https://code.jquery.com/jquery-3.3.1.js"
	integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/js/checkform.js"></script>
<script type="text/javascript">
	len = $("input[type='file']").get(0).files.length;

	// 게시판에 첨부될 파일 업로드
	function postFile(a) {
		$.ajax({
			url : "/upload",
			type : 'POST',
			dataType : 'json',
			processData : false,// 파일 전송 시 Query String 형태로 변환되면 안되기 때문에 Flase를 사용 
			contentType : false, // Default 값이 application/x-www-form-urlencoded; charset=UTF-8인데 보내기전에 인코딩해서 보내기 때문에 False를 줘서 multipart/form-data 형식으로 변경해 준다
			data : a,
			succcess : function() {
				console.log("요청 성공!");

			},
			error : function() {
				alert("전송요류");
				console.error("전송오류");
			}

		})

	}

	function postRegister(b) {
		$.ajax({
			type : 'POST',
			url : "/register",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(b),
			success : function() {
				console.log("등록");
				location.replace('/list');
			},
			error : function() {
				console.error("요청이 성공하지 못했습니다");
			}
		});
	}

	// 게시물 등록 및 첨부 파일이 존재 시 파일도 업로드
	$('#submit').on("click", function() {
		if (Checkform(0) == 1) {
			if (Checklen() == 1) {

				var formm = {
					title : frr.title.value,
					detail : frr.detail.value
				}

				var formData = new FormData();

				var inputFile = $("input[type='file']");

				var files = inputFile[0].files;

				for (var i = 0; i < files.length; i++) {
					formData.append("uploadFile", files[i]);
				}

				if (len > 0) {
					$.ajax({
						type : 'POST',
						url : "/register",
						contentType : "application/json; charset=utf-8",
						data : JSON.stringify(formm),
						success : function() {
							postFile(formData);
							location.replace("/list");
						},
						error : function() {
							console.error("요청이 성공하지 못했습니다");
						}
					});
				} else {
					postRegister(formm);
				}

			}

		} else {
			return;
		}

	})

	// 첨부 파일이 업로드할 파일 이름들을 보여줌
	$('#file').on('change', function() {
		var len = $("input[type='file']").get(0).files.length;
		var str = "";
		for (var i = 0; i < len; i++) {
			str += $("input[type='file']").get(0).files[i].name;
			if (i != (len - 1)) {
				str += ", "
			}
		}
		$("#upload-name").val(str);

	});

	// 리셋 버튼을 눌렀을 경우 전부 리셋하고 제목에 포커스가 간다
	function Returnform() {
		alert("리셋합니다.")
		frr.title.focus();
	};

	var sizes = 0;
	// 파일은 총 3개까지 업로드가 가능하기 때문에 3개가 넘어갈 경수 alert을 뛰
	function Checklen() {
		len = $("input[type='file']").get(0).files.length;
		for (var i = 0; i < len; i++) {
			if ($("input[type='file']").get(0).files[i].size > 10485756) {
				alert("1개 파일의 최대 사이즈를 넘겼습니다.")
				return 0;
			}
			sizes = sizes + $("input[type='file']").get(0).files[i].size;
		}

		if (sizes > 104857560) {
			alert("최대 업로드 사이즈를 넘겼습니다.")
			return 0;
		}

		if (len > 3) {
			alert("3개까지 첨부가 가능합니다.");
			return 0;
		}
		return 1;
	}
</script>

