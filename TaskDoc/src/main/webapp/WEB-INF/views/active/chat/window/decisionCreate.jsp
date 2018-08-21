<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
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
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close">
						<i class="fa fa-times"></i>
					</button>
					<h4 class="modal-title">투표를 진행해주세요!</h4>
				</div>

				<div class="modal-body">
					<div class="form-group">
						<label>의사결정 제목</label> <input id="decisionName" type="text"
							class="form-control"> <span class="help-block">제목을
							입력해주세요</span>
					</div>

					<div class="btn-group">
						<div>
							<label>투표를 할 공용업무를 선택해주세요</label> <select name="job">
								<option value="">1.설계</option>
								<option value="학생">2.구현</option>
								<option value="회사원">3.유지보수</option>
								<option value="기타">4.등등</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<br></br> <label>투표 항목</label>
						<button type="button" class="btn btn-default btn-icon"
							onclick="addIndex()">
							<i class="fa fa-times-circle"></i> 항목 추가하기
						</button>
						<div style="display: block" id="indexes"></div>
					</div>

					<div class="modal-footer">
						<input type="hidden" name="isEmpty">
						<button type="button" class="btn btn-success btn-icon"
							onclick="decisionOK()">
							<i class="fa fa-check"></i> 생성하기
						</button>
						<button type="button" class="btn btn-default btn-icon"
							onclick="decisionCancel()">
							<i class="fa fa-times-circle"></i> Cancel
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	var count = 0;
	
	//의사결정 항목을 담은 리스트들.
	var tlist = [];
	
	//의사결정 아이템 생성용 param
	var paramitem = [];
	

	function addIndex() {
		count++;
		//div tag
		var dtag = document.createElement("div");
		dtag.setAttribute('id', 'content' + count);
		dtag.setAttribute('style', 'display:flex');
	
		//input tag
		var itag = document.createElement("input");
		itag.setAttribute('type', 'text');
		itag.setAttribute('class', 'form-control');
		itag.setAttribute('id', 't' + count);

		//button tag
		var btag = document.createElement("button");
		btag.setAttribute('type', 'button');
		btag.setAttribute('id', 'b' + count);
		btag.setAttribute('class', 'btn btn-default btn-icon');
		btag.setAttribute('onclick', 'objdelete(this)');

		var element = document.createTextNode("삭제");
		btag.appendChild(element);

		dtag.appendChild(itag);
		dtag.appendChild(btag);

		$("#indexes").append(dtag);
		tlist.push('t' + count);

	}

	function objdelete(btn) {
		var divid = btn.id.substring(1, btn.id.length);
		document.getElementById("content" + divid).remove();
		tlist.splice(tlist.indexOf('t' + divid), 1);

	}
	
	function decisionOK(){
		//의사결정 생성후 return 값으로 의사결정 pk값이 날라온것 저장하는 변수
		var decisionCreatecode=null;
		/* 의사결정 생성*/
		//의사결정 생성용 param
		var param = {
			'dstitle' : $("#decisionName").val(),
			'crcode' : '1',
			'tcode' : '1'
		};
		
		$.ajax({
			type : 'POST',
			url : '/decision',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response>0) {
					alert('의사결정 생성 완료! ' + response);
					for (var i = 0; i < tlist.length; i++) {
						paramitem.push({
								'dsilist' : document.getElementById(tlist[i]).value,
								'dsisequence' : i,
								'dscode' : response
						});
					}
					/* 의사결정 아이템 생성
					항목이 하나일수도, 여러개일수도있기때문에 [{}] 형식으로 list형식으로 서버에 보내야된다
					 */
					$.ajax({
						type : 'POST',
						url : '/decisionitem',
						contentType : 'application/json',
						data : JSON.stringify(paramitem),
						success : function(response) {
							if (response != -1) {
								alert('의사결정 아이템 생성 완료! ' + response);
							} else if (response == -1) {
								alert('Server or Client ERROR, 의사결정 아이템 생성 실패');
							}
						},
						error : function(e) {
							alert("ERROR : " + e.statusText);
						}
					});
				} else {
					alert('Server or Client ERROR, 의사결정 생성 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/*/의사결정 생성 */
	}
</script>


<!-- <script type="text/javascript">
	/* 의사결정 삭제*/
	$.ajax({
		type : 'DELETE',
		url : 'decision/' + '삭제할 의사결정코드 DSCODE',
		success : function(response) {
			if (response == 1) {
				alert('의사결정 삭제 완료! ' + response);
			} else if (response == -1) {
				alert('Server or Client ERROR, 의사결정 삭제 실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/*/의사결정 삭제 */

	/* 의사결정 수정*/
	var param = {
		'tcode' : '어떤 공용업무로  의사결정을 이동할것인지 TCODE',
		'dstitle' : '의사결정 제목',
		'dsclose' : '0이면아직안끝남 1이면 끝남',
		'dscode' : '어떤의사결정 코드 수정할것인지'
	};
	$.ajax({
		type : 'PUT',
		url : 'decision',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (response == 1) {
				alert('의사결정 수정 완료! ' + response);
			} else if (response == -1) {
				alert('Server or Client ERROR, 의사결정 수정 실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/*/의사결정 수정 */

	/* 해당 채팅방 내의 모든 의사결정 리스트를 가져온다 */
	$.ajax({
		type : 'GET',
		url : 'decision/room/' + '해당 공용업무의  tcode',
		success : function(response) {
			if (response.length != 0) {
				alert('의사결정 리스트 불러오기 성공!');
			} else if (response.length == 0) {
				alert('Server or Client ERROR, 의사결정 리스트 불러오기  실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/*/해당 채팅방 내의 모든 의사결정 리스트를 가져온다 */


	/* 의사결정 아이템 수정*/
	var param = {
		'dsilist' : '의사결정 항목 이름을 변경할 새로운 이름',
		'dsicode' : '의사결정 항목을 변경할 의사결정 항목 DSICODE(항목번호가아닌 primary key)'
	};
	$.ajax({
		type : 'PUT',
		url : 'decisionitem',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (response == 1) {
				alert('의사결정 아이템 수정 완료! ' + response);
			} else if (response == -1) {
				alert('Server or Client ERROR, 의사결정 아이템 수정 실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/* /의사결정 아이템 수정*/

	/* 의사결정 아이템 삭제*/
	$.ajax({
		type : 'DELETE',
		url : 'decisionitem/'
				+ '의사결정 항목을 삭제할 의사결정 항목 DSICODE(항목번호가아닌 primary key)',
		success : function(response) {
			if (response == 1) {
				alert('의사결정 아이템 삭제 완료! ' + response);
			} else if (response == -1) {
				alert('Server or Client ERROR, 의사결정 아이템 삭제 실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/* /의사결정 아이템 삭제*/


	/* 의사결정 항목 선택하기*/
	var param = {
		'dsicode' : '의사결정 항목의 번호',
		'uid' : '내아이디'
	};
	$.ajax({
		type : 'POST',
		url : 'voter',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (response == 1) {
				alert('의사결정 항목 선택 완료! ' + response);
			} else if (response == -1) {
				alert('Server or Client ERROR, 의사결정 항목 선택 실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/*  / 의사결정 항목 선택하기*/

	/* 유저가 어떤 의사결정 항목을 선택했는지 리스트로뿌려라
	※헷갈리지말것※ 의사결정!코드!도 primary key,
				의사결정!항목코드!도 primary key!!
	 */
	$.ajax({
		type : 'GET',
		url : 'voter/' + '의사결정 항목코드(primary key임)',
		success : function(response) {
			if (response.length != -1) {
				alert('유저가 선택한 의사결정 항목 조회 완료! ' + response);
			} else if (response == -1) {
				alert('Server or Client ERROR, 유저가 선택한 의사결정 항목 조회 실패!');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/* 유저가 어떤 의사결정 항목을 선택했는지 리스트로뿌려라*/

	/* 의사결정 항목 선택한거 다른걸로 수정하기*/
	var param = {
		'oldVo' : {
			'dsicode' : '원래의 선택했던 의사결정 항목의 번호',
			'uid' : '내아이디'
		},
		'newVo' : {
			'dsicode' : '새로 선택한 의사결정 항목의 번호',
			'uid' : '내아이디'
		}
		
	};
	$.ajax({
		type : 'PUT',
		url : 'voter',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (response == 1) {
				alert('의사결정 항목 선택 한거 다른걸로 수정 완료! ' + response);
			} else if (response == -1) {
				alert('Server or Client ERROR, 의사결정 항목 선택 한거 다른걸로 수정 실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/*  /의사결정 항목 선택한거 다른걸로 수정하기*/
</script> -->
</html>