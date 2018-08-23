<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/method/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String pcode = request.getParameter("pcode");
%>

<script type="text/javascript">
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
</script>
</head>
<body>
	<div class="container">
		<div style="margin-top: 20px;">
			<div style="float: left; display: -webkit-inline-box;">
				<input type="text" class="form-control" style="margin-right: 10px;">
				<a class="btn btn-success" onclick="wefw">검색</a>
			</div>

			<div style="float: right">
				<a href='/methodBoardCreate' class="btn btn-success">글쓰기</a>
			</div>
		</div>
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th style="width: 50px;">번호</th>
					<th style="width: 400px;">제목</th>
					<th style="width: 150px;">작성자</th>
					<th style="width: 200px;">날짜</th>
					<th style="width: 100px;">관리</th>
				</tr>
			</thead>
			<tbody id="tbodys">

			</tbody>
		</table>

	</div>
	<script type="text/javascript">
		//게시판 목록 전체 받아오기
		$(document).ready(function() {
			$.ajax({
				type : 'GET',
				url : '/methodboard/all',
				success : function(response) {
						if (response.length > 0) {
							alert('게시판 목록 전체 받아오기 성공! ' + response);
							for(var i=0;i<response.length;i++){
								var trtag = document.createElement("tr");
								var td_idx=document.createElement("td");
								var idxele=document.createTextNode(i+1);
								trtag.appendChild(td_idx);
								td_idx.appendChild(idxele);
						
								var td_title=document.createElement("td");
								
								//a tag의 onclick 이기때문에 손모양 css적용해주었음
								td_title.setAttribute('style','cursor:pointer')
								var a_title=document.createElement("a");
								
								//onclick 이벤트 적용해줌
								a_title.setAttribute('onclick','boardcon('+response[i].mbcode+')');
								var titleele=document.createTextNode(response[i].mbtitle);
								trtag.appendChild(td_title);
								a_title.appendChild(titleele);
								td_title.appendChild(a_title);
						
								var td_uid=document.createElement("td");
								var uidele=document.createTextNode(response[i].uid);
								trtag.appendChild(td_uid);
								td_uid.appendChild(uidele);
						
								var td_date=document.createElement("td");
								var dateele=document.createTextNode(response[i].mbdate);
								trtag.appendChild(td_date);
								td_date.appendChild(dateele);
						
									if(response[i].uid=='<%=loginid%>') {
										var td_setting=document.createElement("td");
										var editiconele=document.createElement("img");
										editiconele.setAttribute('src','${pageContext.request.contextPath }/resources/img/img_boardsetting.png');
										editiconele.setAttribute('style','width:20px;height:20px; cursor:pointer');
										editiconele.setAttribute('onclick','boardEdit('+response[i].mbcode+')');
										
										var deliconele=document.createElement("img");
										deliconele.setAttribute('src','${pageContext.request.contextPath }/resources/img/img_boarddelete.png');
										deliconele.setAttribute('style','margin-left:20px;width:20px;height:20px;cursor:pointer');
										deliconele.setAttribute('onclick','boardDelete('+response[i].mbcode+')');
										
										td_setting.appendChild(editiconele);
										td_setting.appendChild(deliconele);
										trtag.appendChild(td_setting);
									}
									else{
										var td_setting=document.createElement("td");
										trtag.appendChild(td_setting);
									}
						
							$("#tbodys").append(trtag);
							}
					} else {
						alert('Server or Client ERROR, 게시판 목록 전체 받아오기 실패');
					}
					},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
		});
		
		// 게시판 목록 전체 받아오기
		function boardcon(code){
			location.href='/methodBoardView?mbcode='+code;
		}
		
		//게시판 삭제
		function boardDelete(code){
			if(confirm('게시글을 삭제 하시겠습니까?')==true){
			$.ajax({
				type : 'DELETE',
				url : '/methodboard/'+code,
			success : function(response) {
				if (response > 0) {
					alert('게시글 삭제 완료! ' + response);
					location.href = '/methodBoard';
				} else {
					alert('Server or Client ERROR, 게시글 삭제 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
			}
			else return;
		}
		
		//게시판 삭제
		function boardEdit(code){
			if(confirm('게시글을 수정 하시겠습니까?')==true){
				location.href='/methodBoardEdit?mbcode='+code;
			}
			else return;
		}
	</script>
</body>
</html>