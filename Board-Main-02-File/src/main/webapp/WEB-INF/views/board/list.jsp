<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>List Page</title>

<!-- JQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	
</script>


<style>
th {
	text-align: center !important;
}

th, td {
	border: 1px solid black;
}

.pagination>.active>button {
	z-index: 3;
	color: #fff !important;
	cursor: default;
	background-color: #570df6 !important;
	border-color: #570df6 !important;
}

.pagination>li>a {
	border: none;
	background-color: white;
	color: 570df6;
	border: none;
}

#NEO {
	position: relative;
	float: left;
	padding: 6px 12px;
	margin-left: -1px;
	line-height: 1.42857143;
	color: #337ab7;
	text-decoration: none;
	background-color: #fff;
	border: 1px solid #ddd;
}

.click-btn {
	border: none;
	background-color: white;
	color: 570df6;
	border: none;
}

.Next {
	border: none !important;
	background-color: white;
	color: 570df6;
	border: none;
}

.Prev {
	border: none !important;
	background-color: white;
	color: 570df6;
	border: none;
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
</style>

</head>
<body>
	<div style="margin: 5%">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Board List</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row" id="changeLoc">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading" style="margin-bottom: 10px">
						Board List Page
						<button class="btn_N"
							style="float: right; border: none; background-color: #570df6; color: white; border-radius: 4px;">Register
							New Board</button>
					</div>


					<div
						style="float: right; padding-bottom: 5px; padding-right: 16px; font-weight: bold;">

						<div class="Total" style="display: inline;"></div>
						<button onclick="OnDelBtn()" style="border: none;">X</button>
					</div>


					<!-- /.panel-heading -->
					<div class="panel-body">
						<table class="table table-striped table-bordered table-hover"
							style="border-collapse: collapse; text-align: center;">
							<thead>
								<tr>
									<th>#번호</th>
									<th>제목</th>
									<th>첨부 파일</th>
									<th>작성일</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody class="ListPage">
							</tbody>

						</table>

						<!-- 모달 추가 -->
						<div id="myModal" class="modal fade" id="myModal" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-hidden="true">&times;</button>
										<h4 class="modal-title" id="myModalLabel">Modal title</h4>
									</div>
									<div class="modal-body">처리가 완료되었습니다.</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>


						<div style="text-align: center;">
							<ul class="pagination">
							</ul>
						</div>
						<!-- /.table-responsive -->
					</div>
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
	</div>
</body>
<script type="text/javascript" src="/resources/js/board.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				showList(1);
				var result = '<c:out value="${result}"/>';

				checkModal(result);

				history.replaceState({}, null, null)

				function checkModal(result) {

					if (result === '' || history.state) {
						return;
					}

					if (parseInt(result) > 0) {
						$(".modal-body").html(
								"게시글 " + parseInt(result) + " 번이 등록되었습니다,");
					}
					$("#myModal").modal("show");
				}
				;
				
				var actionForm = $("#actionForm");

				$(".paginate_button a").on(
						"click",
						function(e) {

							e.preventDefault();

							console.log('click');
							actionForm.find("input[name='pageNum']").val(
									$(this).attr("href"));
							actionForm.submit();

						});

				$(".btn_N").on("click", function() {
					console.log("등록 페이지 이동")
					location.href = 'register'
				});

			});
	// end $(document).ready

	var BoardPageUL = $(".ListPage");
	var BoardTotal = $(".Total");
	var BoardPaging = $(".pagination")
	showList(1);

	
	// 파일들 가져오기
	function getFile(a) {
		$.ajax({
			type : "GET",
			url : "/file/" + a + ".json",
			dataType : "JSON",
			async : false,
			success : function(list) {
				return c = list
			}
		});
		return c
	}

	function showList(page) {
		BoardService
				.getList(
						{
							page : page
						},
						function(list) {
							var str = "";
							var strr = "";
							DaTe = list.TableData.data
							if (list == null || list.length == 0) {

								BoardPageUL.html("");
								BoardTotal.html("");

								return;
							}
							// 총 게시물 개수 출력
							BoardTotal.html("총 게시물 개수는 : "
									+ list.ListData.total + "")

							// 테이블 출력
							for (var i = 0, len = DaTe.length || 0; i < len; i++) {

								str += "<tr>"
								str += "<td>" + DaTe[i].bno + "</td>";
								str += "<td><a href='detail/" + DaTe[i].bno +"'>"
										+ DaTe[i].title + "</a></td>";
								str += "<td style='padding: 0px; vertical-align:middle;'>";
								data = getFile(DaTe[i].bno)
								
								// 첨부파일 이미지 만큼 이미지 그리기
								for (var b = 0; data.length > b; b++) {
									str += "<img src='/resources/img/Chumbu.png' style='height: 36px; width: 34px;'>"
								}
								str += "</td>";

								str += "<td>"
										+ BoardService
												.displayTime(DaTe[i].createDate)
										+ "</td>";
								str += "<td>"
										+ BoardService
												.displayTime(DaTe[i].changeDate)
										+ "</td>";
								str += "</tr>";
							}

							BoardPageUL.html(str);

							var startPa = (list.ListData.pageDTO.startPage);
							var endPa = (list.ListData.pageDTO.endPage);
							
							// Prev True일 경우 버튼 추가
							if ((list.ListData.pageDTO.prev) == true) {
								strr += "<li class=paginate_button previous>";
								strr += "<button class='Prev'>Prev</a></li>";
							}
							
							// 페이지 개수 만큼 버튼 추가
							for (var i = startPa; i <= endPa; i++) {
								var tf = (list.ListData.pageDTO.cri.pageNum == i ? "'paginate_button active'"
										: "paginate_button");
								strr += "<li class="+ tf +">";
								strr += "<button id="+ i +" class='click-btn'>"
										+ i + "</button></li>";
							}
							
							// Next True일 경우 버튼 추가
							if ((list.ListData.pageDTO.next) == true) {
								strr += "<li class='paginate_button next' style='float:right'>";
								strr += "<button class='Next'>Next</button></li>"
							}

							BoardPaging.html(strr);

							$(".click-btn").on("click", function(e) {
								a = e.target.id;
								showList(a)

							});
							$(".Next").on("click", function() {
								a = endPa + 1;
								showList(a)

							});
							$(".Prev").on("click", function() {
								a = startPa - 1;
								showList(a)

							});
						});

	};
	
	// 게시물 데이터 전부 삭제
	function OnDelBtn() {
		$.ajax({
			type : 'DELETE',
			url : "list"
		}).done(function() {
			console.log("모든 데이터가 삭제 되었습니다.");
			showList(1);
		})
	}
</script>


</html>