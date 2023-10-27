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

.panel-body {
	padding: 6px 0 0 0px !important;
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
	font-size: 20px;
}
</style>

<title>Detail Page</title>

<div style="margin: 5%">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Modify</h1>
		</div>
	</div>
	<!-- row -->

	<div class="col-lg-12" id="modifyPage" style="padding: 0px;">

		<!-- panel heading -->
		<div class="panel-body">
			<strong><span class="t_red">*</span> 표시는 필수입력 항목입니다.</strong>


			<form name="frr" role="form" onSubmit="return Checkform()"
				accept-charset="utf-8">
				<div style="padding: 0px;">
					<div style="margin-top: 10px">
						<div class="form-group" style="margin-bottom: 10px">
							<h3>Bno</h3>
							<input class="form-control" id='bno2'></input>
						</div>
						<div class="form-group" style="margin-bottom: 10px">
							<h3>
								Title<span class="t_red">*</span>
							</h3>
							<input name="title" id="title2" class="form-control" />
						</div>
						<div class="form-group">
							<h3>
								Text area<span class="t_red">*</span>
							</h3>
							<textarea name="detail" id="detail2" rows="3"
								class="form-control" style="height: 75px;"
								placeholder="내용을 입력해 주세요 (최대 400 글자까지 적으실 수 있습니다.)"
								maxlength="400" wrap="hard"></textarea>
						</div>
						<div class="form-group">
							<h3>Attachment</h3>
							<div style="margin-bottom: 5px;">
								<strong>파일은 3개까지 첨부할 수 있습니다 <span class="t_red">*</span></strong>
							</div>

							<div id="attachment"></div>

						</div>

					</div>
					<div id="but" style="margin-top: 10px; float: right;">
						<button type="button" onclick="return updateData()"
							class="btn btn-sm btn-primary">Modify</button>
						<button type="button" onclick="return removeData()"
							class="btn btn-sm btn-primary">Remove</button>

						<button type="button" data-oper='list'
							class="btn btn-sm btn-primary" id=""
							onclick="location.href = '/detail/${bno}'">Return Page</button>
					</div>
				</div>
			</form>

		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- row -->
<script type="text/javascript" src="/resources/js/board.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 데이터 불러옴
		PageData(0);

	});

	filesArray = [];
	var a = 0;

	// 페이지를 구성할 데이터를 불러와 화면을 구성
	function PageData(a) {
		creDate = "";
		chanDate = "";
		files = "";
		var tub = "";
		$
				.ajax({
					type : 'GET',
					url : "/detail/${bno}.json",
					dataType : "json",
					success : function(list) {
						board = list.board;
						file = list.getfiles

						tub += "<div class='filebox-new'>"
						tub += "<input class='form-control' id='upload-name' style='border-radius: 0px 4px 4px 0px !important; width: 88%; display: inline; margin-bottom:5px;' placeholder='첨부 파일을 입력해 주세요' readonly>";
						tub += "<label for='file' id='fileSearch' style='padding: 14px 10px 11px 10px; border-radius: 4px; background: #570df6; color: white;'>파일 찾기</label>";
						tub += "<input type='file' name='file' id='file' style='display: none;'>";
						tub += "</div>"

						for (var i = 0; i < file.length; i++) {
							tub += "<input class='form-control' id='upload-name-"
									+ file[i].fileBno
									+ "' style='border-radius: 0px 4px 4px 0px !important; width: 88%; display: inline; margin-bottom:5px;' placeholder='첨부 파일' value='"
									+ file[i].clientName + "'readonly>";
							tub += "<label id ='upload-name-"
									+ file[i].fileBno
									+ "'onclick='OnDelBtn("
									+ file[i].fileBno
									+ ")' style='padding: 14px 10px 11px 10px; border-radius: 4px; background: #570df6; color: white;'>파일 삭제</label>"
						}
						;

						if (a == 0) {
							$("#bno2").last().attr('value', board.bno);
							$("#title2").attr('value', board.title);
							$("#detail2").html(board.detail);
							$("#attachment").html(tub);
						} else {
							alert("잘못된 접근 입니다.");
						}

					}

				})
	}

	var b = 0;

	// 파일 전송
	function postFile(a) {
		$.ajax({
			url : "/upload/file",
			type : 'POST',
			dataType : 'json',
			processData : false,
			contentType : false,
			data : a
		});
		console.log("파일 등록 성공");
		location.replace("/list");
	}

	//  테이블 수정 요청 
	function updateData() {
		var formm = {
			"bno" : $("#bno2").val(),
			"title" : $("#title2").val(),
			"detail" : $("#detail2").val()
		}

		var formData = new FormData();
		formData.append("bno", $("#bno2").val())
		for (var i = 0; i < filesArray.length; i++) {
			formData.append("uploadFile", filesArray[i]);
		}
		;
		$.ajax({
			type : 'PUT',
			url : "/modify/update",
			data : JSON.stringify(formm),
			contentType : "application/json; charset=utf-8",
			success : function() {
				console.log("수정");
				postFile(formData, $("#bno2").val());
			},
			error : function() {
				console.error("요청이 성공하지 못했습니다")
			}
		})
	};

	// 	 테이블 삭제 요청 
	function removeData() {
		$.ajax({
			type : 'DELETE',
			url : "/modify/delete/" + $("#bno2").val(),
			contentType : "application/json; charset=utf-8",
			success : function() {
				console.log($("#bno").val() + "번이 삭제되었습니다");
				location.replace('/list');
			},
			error : function() {
				console.error("요청이 성공하지 못했습니다");
			}
		});
	};

	// 실제 파일을 삭제
	function OnDelBtn(a) {
		$.ajax({
			type : 'DELETE',
			url : "/file/remove/" + a,
			contentType : "application/json; charset=utf-8",
			success : function() {
				console.log(a + "번이 삭제되었습니다");
			},
			error : function() {
				console.error("요청이 성공하지 못했습니다");
			}
		})
		$("#upload-name-" + a).remove();
		$("#upload-name-" + a).remove();

	}

	// 실제 파일이 아닌 Modify 페이지의 파일 데이터를 삭제
	function OnDelFile(a) {
		deleteIndex = a - 1;
		filesArray.splice(deleteIndex, 1);
		$("#upload-new-name-" + a).remove();
		$("#upload-new-name-" + a).remove();
	}

	$(document)
			.on(
					'change',
					'#file',
					function() {
						const filename = $(this).get(0).files[0].name;
						$("#upload-name").get(0).value = filename;

						// 현재 첨부파일의 개수 가져오기
						const total = $("#attachment").children("input").length

						// 3개보다 작으면 데이터를 추가 한다.
						if (total < 3) {
							filesArray.push($("#file").get(0).files[0])
							newFile = "<input class='form-control' id='upload-new-name-"
									+ filesArray.length
									+ "' style='border-radius: 0px 4px 4px 0px !important; width: 88%; display: inline; margin-bottom:5px;' placeholder='첨부 파일' value='"
									+ $("#file").get(0).files[0].name
									+ "'readonly>";
							newFile += "<label id ='upload-new-name-"
									+ filesArray.length
									+ "'onclick='OnDelFile("
									+ filesArray.length
									+ ")' style='padding: 14px 10px 11px 10px; border-radius: 4px; background: #570df6; color: white;'>파일 삭제</label>"
							$("#attachment").append(newFile)
							$("#upload-name").get(0).value = ""
						}

					});
</script>

