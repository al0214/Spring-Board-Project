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
			<h1 class="page-header">Board Detail</h1>
		</div>
	</div>
	<!-- row -->

	<div class="col-lg-12" id="detailPage" style="padding: 0px !important;">

		<!-- panel heading -->
		<div class="panel-body">

			<div style="padding: 0px !important;">
				<div style="margin-top: 10px">
					<div class="form-group" style="margin-bottom: 10px">
						<h3 style="margin-top: 10px">Bno</h3>
						<input class="form-control" id='bno' readonly></input>

						<h3>Title</h3>
						<input name="title" id="title" class="form-control" readonly />

						<h3>Content</h3>
						<textarea name="detail" id="detail" rows="3" class="form-control"
							style="height: 75px;"
							placeholder="내용을 입력해 주세요 (최대 400 글자까지 적으실 수 있습니다.)"
							maxlength="400" wrap="hard" readonly></textarea>

						<h3>작성 일자</h3>
						<div name="createDate" class="form-control" id='creDate'></div>

						<h3>수정 일자</h3>
						<div name="changeDate" class="form-control" id='chanDate'></div>

						<h3 id='attach-02'>첨부 파일</h3>
						<ul id='attach'></ul>
					</div>
				</div>
				<div style="float: right; padding-top: 15px;">
					<button onclick="location.replace('/modify/${bno}')"
						class="btn btn-sm btn-primary">Modify</button>
					<button onclick="location.replace('/list')"
						class="btn btn-sm btn-primary">Return Page</button>
				</div>
			</div>
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- row -->
<script type="text/javascript" src="/resources/js/board.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// Detail&Modify 페이지 호출
		// 데이터 불러옴
		PageData(0);

	});

	var a = 0;

	function PageData(a) {
		creDate = "";
		chanDate = "";
		files = "";

		$
				.ajax({
					type : 'GET',
					url : "/detail/${bno}.json",
					dataType : "json",
					success : function(list) {

						board = list.board;
						file = list.getfiles

						// "<a href='download?serverName="+ data[b].serverName+ "'>

						creDate += "<div>"
								+ BoardService.displayTime(board.createDate)
								+ "</div>";
						chanDate += "<div>"
								+ BoardService.displayTime(board.changeDate)
								+ "</div>";

						if (file.length == 0) {
							$("#attach-02").attr("style", "display:none;");
						} else if (file.length != 0) {
							$("#attach-02").removeAttr("style");
						}

						for (var i = 0; i < file.length; i++) {
							files += "<li><a href='/download?serverName="
									+ file[i].serverName + "'>"
									+ file[i].clientName + "</a></li>";
						}
						;
						if (a == 0) {
							$("#bno").attr('value', board.bno);
							$("#title").attr('value', board.title);
							$("#detail").html(board.detail);
							$("#creDate").html(creDate);
							$("#chanDate").html(chanDate);
							$("#attach").html(files);
						} else {
							alert("잘못된 접근 입니다.");
						}

					},
					error : function() {
						console.error("error");
					}
				});
	}

	var b = 0;

	//  테이블 수정 요청 
	function updateData() {
		var formm = {
			bno : $("#bno").val(),
			title : frr.title.value,
			detail : frr.detail.value
		}

		$.ajax({
			type : 'PUT',
			url : "/modify/update",
			data : JSON.stringify(formm),
			contentType : "application/json; charset=utf-8",
			success : function() {
				console.log("수정");
				location.replace('/list');
			},
			error : function() {
				alert("요청이 성공하지 못했습니다");
			}
		})
	};

	// 	 테이블 삭제 요청 
	function removeData() {
		$.ajax({
			type : 'DELETE',
			url : "/modify/delete/" + $("#bno").val(),
			contentType : "application/json; charset=utf-8",
			success : function() {
				console.log($("#bno").val() + "번이 삭제되었습니다");
				location.replace('/list');
			},
			error : function() {
				alert("요청이 성공하지 못했습니다");
			}
		})
	};
</script>

