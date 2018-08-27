/*TOOLTIP JS , HOVER JS */
var popupX = (window.screen.width / 2) - (500 / 2);
var popupY= (window.screen.height /2) - (400 / 2);
var id='<%=loginid%>';
$(document).ready(function() {
	$("#buttonloginid").html('ID : '+id);
	
	$('[data-toggle="tootlip"]').tooltip();

	$(".tessssst").hover(function() {
		$(this).css("box-shadow", "4px 8px 20px grey");
	}, function() {
		$(this).css("box-shadow", "4px 4px 7px grey");
	});
	
	$(".h-describe").hover(function() {
		$(this).css("background-color", "#ed8151");
		$("#describe").attr("src", "/resources/img/hover_describe.png");
	}, function() {
		$(this).css("background-color", "white");
		$("#describe").attr("src", "/resources/img/img_describe.png");
	});
	$(".h-task").hover(function() {
		$(this).css("background-color", "#ed8151");
		$("#task").attr("src", " /resources/img/hover_task.png");
	}, function() {
		$(this).css("background-color", "white");
		$("#task").attr("src", " /resources/img/img_task.png");
	});
	$(".h-user").hover(function() {
		$(this).css("background-color", "#ed8151");
		$("#user").attr("src", " /resources/img/hover_user.png");
	}, function() {
		$(this).css("background-color", "white");
		$("#user").attr("src", " /resources/img/img_user.png");
	});
	$(".h-board").hover(function() {
		$(this).css("background-color", "#ed8151");
		$("#board").attr("src", " /resources/img/hover_board.png");
	}, function() {
		$(this).css("background-color", "white");
		$("#board").attr("src", " /resources/img/img_board.png");
	});
	$(".h-settings").hover(function() {
		$(this).css("background-color", "#ed8151");
		$("#settings").attr("src", " /resources/img/hover_settings.png");
	}, function() {
		$(this).css("background-color", "white");
		$("#settings").attr("src", " /resources/img/img_settings.png");
	});
	$(".h-logout").hover(function() {
		$(this).css("background-color", "#ed8151");
		$("#logout").attr("src", " /resources/img/hover_logout.png");
	}, function() {
		$(this).css("background-color", "white");
		$("#logout").attr("src", " /resources/img/img_logout.png");
	});
	$(".h-projectadd").hover(function() {
		$(this).css("background-color", "#ed8151");
		$("#projectadd").attr("src", " /resources/img/hover_projectadd.png");
	}, function() {
		$(this).css("background-color", "white");
		$("#projectadd").attr("src", " /resources/img/img_projectadd.png");
	});
	
	/* 내가 참가하는 모든 프로젝트를 검색*/
	$.ajax({
		type : 'GET',
		url : '/projectjoin/' + id,
		success : function(response) {
			alert(response);
			/*
			response는 map 형태로 날라옴
			프로젝트 결과 값 = map ( KEY = "projectList", "projectJoinList" )
			프로젝트에 소속되어있는 정보들
			projectJoinList{
				pcode;
			 	uid;
			 	ppermission;
			 	pinvite;
			}
			프로젝트들의 정보
			projectList{
				pcode;
				ptitle;
				psubtitle;
				psdate;
				pedate;	
			}
			pcode별로 프로젝트 list 나열하고, 프로젝트별 title, subtitle, psdate, pedate 설정하기
			 */
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/* /내가 참가하는 모든 프로젝트를 검색*/
});

$(function() {
	$("#newproject").click(function() {
		window.open("/project/create","", "height=400, width=600, left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY); 
	});
	$("#newtask").click(function() {
		location.href = '/privatetask/create';
	});
});





	/* 프로젝트에 초대받은사람 수락할때  
	 * projectjoin_SQL 다시알아보기★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	 */
	/*var param = {
		'pcode' : '현재 PCODE',
		'uid' : '현재 수락할 ID',
		'ppermission' : 'MEMBER',
		'pinvite' : 1
	};
	$.ajax({
		type : 'PUT',
		url : 'projectjoin',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (response == 1) {
				alert('초대 수락 완료!');
			} else {
				alert('Server or Client ERROR, 초대 수락  실패!');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});*/
	/*/프로젝트에 초대받은사람 수락할때 */
