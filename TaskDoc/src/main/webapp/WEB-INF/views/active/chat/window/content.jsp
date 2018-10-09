<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String crmode=request.getParameter("crmode");
	String crcode=request.getParameter("crcode");
	String crclose=request.getParameter("crclose");
	String crcoderef=request.getParameter("crcoderef");
	
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
%>	

<script type="text/javascript">

$(function(){
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight;
	var popW = 600; 
	var popH = 350; 
	var posL=( screenW-popW ) / 2;   
	var posT=( screenH-popH ) / 2;    
	
	//채팅메뉴 누르면 나올 div(position=absolute)의 margin-top과 margin-right값을 설정해줘야한다.
	var prochatsetbtn=$("#chatsetbtn").css('height');
	var containermargin=$(".container").css('margin-left');
	
	//chatsetbtnmenu제어
	$("#chatsetbtnmenu").css('margin-top',parseInt(prochatsetbtn)).css('margin-right',parseInt(containermargin) + 15 + "px");
	stompClient.disconnect();
	
	//대화조회
	 $.ajax({
		type : 'GET',
		url : '/chatcontents/'+<%=crcode%>,
		success : function(response) {
			if (response.length>0) {

				
				alert('대화 조회 성공');
				for(var i=0;i<response.length;i++){
					if(response[i].crcode==<%=crcode%>){
						
						//채팅 내용 조회시 나는 오른쪾
						if(response[i].uid=='<%=loginid%>'){
							//일반 대화
							if(response[i].dmcode == 0 && response[i].dscode == 0 && response[i].crcoderef==0){
								$delist='<div style="background-color: yellow; width:100%;height:100px;">'
									    +'<div style="float:right; background-color: cornsilk; width:50%;border-radius:20px;">'
					   					+'<div><span>'+response[i].uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
					   					+'<div><span>'+response[i].ccontents+'</span></div><div><span>'+response[i].cdate+'</span></div></div></div>';
								
								$("#chatcontentdiv").append($delist);
							}
							//자료
							else if(response[i].dmcode!=0){
								$delist='<div style="background-color: yellow; width:100%;height:100px;">'
								    +'<div style="float:right; background-color: cornsilk; width:50%;border-radius:20px;">'
				   					+'<div><span>'+response[i].uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
				   					+'<div><span><a>[자료]</a></span></div><div><span><a style="cursor:pointer" onclick="fileDownload('+response[i].dmcode+')">제목 : '+response[i].ccontents+'</a></span></div><div><span>'+response[i].cdate+'</span></div></div></div>';
					   			/* $delist='<a style="cursor:pointer" onclick="fileDownload('+response[i].dmcode+')">'+response[i].uid+': <파일>'+response[i].ccontents+'('+response[i].cdate+')'+'</a></br>'; */
								$("#chatcontentdiv").append($delist);
								}
							//의사결정
							else if(response[i].dscode!=0){
								$delist='<div style="background-color: yellow; width:100%;height:100px;">'
							    +'<div style="float:right; background-color: cornsilk; width:50%;border-radius:20px;">'
			   					+'<div><span>'+response[i].uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
			   					+'<div><span><a>[투표]</a></span></div><div><span><a style="cursor:pointer"  onclick="selectDecision(\''+chatpermission+'\','+response[i].dscode+')">제목 : '+response[i].ccontents+'</a></span></div><div><span>'+response[i].cdate+'</span></div></div></div>';
								/* $delist='<a style="cursor:pointer" onclick="selectDecision(\''+chatpermission+'\','+response[i].dscode+')">'+response[i].uid+': <의사결정>'+response[i].ccontents+'('+response[i].cdate+')'+'</a></br>'; */
								$("#chatcontentdiv").append($delist);
								}
							//회의록
							else if(response[i].crcoderef!=0){
								$delist='<div style="background-color: yellow; width:100%;height:100px;">'
							    +'<div style="float:right; background-color: cornsilk; width:50%;border-radius:20px;">'
			  					+'<div><span>'+response[i].uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
			  					+'<div><span><a>[회의록]</a></span></div><div><span><a style="cursor:pointer"  onclick="goconference('+response[i].crcoderef+','+ 3 + ','+ 0 + ','+ <%=crcode%> + ')">제목 : '+response[i].ccontents+'</a></span></div><div><span>'+response[i].cdate+'</span></div></div></div>';
								
								<%-- $delist='<a style="cursor:pointer" onclick="goconference('+response[i].crcoderef+','+ 3 + ','+ 0 + ','+ <%=crcode%> + ')">'+response[i].uid+': <회의록>'+response[i].ccontents+'('+response[i].cdate+')'+'</a></br>'; --%>
								$("#chatcontentdiv").append($delist);										
								}
							}
						
						//ID다를때
						else{
							if(response[i].dmcode == 0 && response[i].dscode == 0 && response[i].crcoderef==0){
								$delist='<div style="background-color: yellow; width:100%;height:100px;">'
									    +'<div style="float:left; background-color: aliceblue; width:50%;border-radius:20px;">'
					   					+'<div><span>'+response[i].uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
					   					+'<div><span>'+response[i].ccontents+'</span></div><div><span>'+response[i].cdate+'</span></div></div></div>';
								
								$("#chatcontentdiv").append($delist);
							}
							//자료
							else if(response[i].dmcode!=0){
								$delist='<div style="background-color: yellow; width:100%;height:100px;">'
								    +'<div style="float:left; background-color: aliceblue; width:50%;border-radius:20px;">'
				   					+'<div><span>'+response[i].uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
				   					+'<div><span><a>[자료]</a></span></div><div><span><a style="cursor:pointer" onclick="fileDownload('+response[i].dmcode+')">제목 : '+response[i].ccontents+'</a></span></div><div><span>'+response[i].cdate+'</span></div></div></div>';
					   			/* $delist='<a style="cursor:pointer" onclick="fileDownload('+response[i].dmcode+')">'+response[i].uid+': <파일>'+response[i].ccontents+'('+response[i].cdate+')'+'</a></br>'; */
								$("#chatcontentdiv").append($delist);
								}
							//의사결정
							else if(response[i].dscode!=0){
								$delist='<div style="background-color: yellow; width:100%;height:100px;">'
							    +'<div style="float:left; background-color: aliceblue; width:50%;border-radius:20px;">'
			   					+'<div><span>'+response[i].uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
			   					+'<div><span><a>[투표]</a></span></div><div><span><a style="cursor:pointer"  onclick="selectDecision(\''+chatpermission+'\','+response[i].dscode+')">제목 : '+response[i].ccontents+'</a></span></div><div><span>'+response[i].cdate+'</span></div></div></div>';
								/* $delist='<a style="cursor:pointer" onclick="selectDecision(\''+chatpermission+'\','+response[i].dscode+')">'+response[i].uid+': <의사결정>'+response[i].ccontents+'('+response[i].cdate+')'+'</a></br>'; */
								$("#chatcontentdiv").append($delist);
								}
							//회의록
							else if(response[i].crcoderef!=0){
								$delist='<div style="background-color: yellow; width:100%;height:100px;">'
							    +'<div style="float:left; background-color: aliceblue; width:50%;border-radius:20px;">'
			  					+'<div><span>'+response[i].uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
			  					+'<div><span><a>[회의록]</a></span></div><div><span><a style="cursor:pointer"  onclick="goconference('+response[i].crcoderef+','+ 3 + ','+ 0 + ','+ <%=crcode%> + ')">제목 : '+response[i].ccontents+'</a></span></div><div><span>'+response[i].cdate+'</span></div></div></div>';
								
								<%-- $delist='<a style="cursor:pointer" onclick="goconference('+response[i].crcoderef+','+ 3 + ','+ 0 + ','+ <%=crcode%> + ')">'+response[i].uid+': <회의록>'+response[i].ccontents+'('+response[i].cdate+')'+'</a></br>'; --%>
								$("#chatcontentdiv").append($delist);										
								}
						}
					}else{
						alert('실패');
					}
					}
				}
			else{
				alert('Server or Client ERROR, 대화 조회 실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	
});
</script>

<!--채팅방 클릭시 나와야할 div들  -->
<div id="chatmenu" style="width:100%%; height:100%;">
	<div id="chatsetbtn" style="width:100%;height:5%; border:solid 1px blue;">
	<div id="chatsetbtnmenu" style="width:300px;height:500px; position: absolute; display:none;border:3px solid #ed8151;background-color:white; right:0px;overflow:auto; ">
	</div>
</div>
								
<div id="chatcontentdiv" style="width:100%;height:75%;border:solid 1px blue; overflow-y:scroll; background-color: #e0e0e0">
</div>				
	<div id="chatconinput" class="bts" style="width:100%;height:20%; border:solid 1px blue; display:-webkit-box;">
		<textarea id="chatcontent" class="form-control" style="width:95%;height:100%;font-size:17px; resize: none;"></textarea>
		<button id="chatbtn" type="button" onclick="chattest(0,0,0,<%=crcode %>)" style="font-size:18px;">테스트</button>
	</div>
</div>	 

<script>
   
var pageopen=true;
$(function(){
	
	//프로젝트톡, OWNER
	if(parseInt(<%=crmode%>)==1 &&chatpermission=="OWNER"){
		$setdiv='<img onclick="votercreate('+<%=crcode%>+')" src="${pageContext.request.contextPath }/resources/img/img_voter.png" data-toggle="tootlip" data-placement="bottom" title="의사 결정 생성"  style="height:100%;float:left;padding-right:30px;cursor:pointer;">'
		+'<img onclick="filecreate('+<%=crcode%>+')" src="${pageContext.request.contextPath }/resources/img/img_fileupload.png" data-toggle="tootlip" data-placement="bottom" title="자료 업로드" style="height:100%;float:left;padding-right:30px;cursor:pointer;">'
		+'<img onclick="conferencecreate('+<%=crcode%>+')" src="${pageContext.request.contextPath }/resources/img/img_conference.png"data-toggle="tootlip" data-placement="bottom" title="회의록 생성" style="height:100%;float:left;cursor:pointer;">'
		+'<img onclick="menubtn('+<%=crcode%>+','+ 1 +')" src="${pageContext.request.contextPath }/resources/img/img_chatmenubtn.png" data-toggle="tootlip" data-placement="left" title="메뉴" style="height:100%;float:right;cursor:pointer;">';
		$("#chatsetbtn").append($setdiv);
		
		$setmenudiv= '<div style="overflow:auto; width:100%;height:24%; border-bottom: 3px solid #ed8151;">자료<div id="dlist"></div></div>'
		+'<div style="overflow:auto; width:100%;height:24%; border-bottom: 3px solid #ed8151;">의사결정<div id="delist"></div></div>'
		+'<div style="overflow:auto; width:100%;height:24%; border-bottom: 3px solid #ed8151;">회의록<div id="clist"></div></div>'
		+'<div id="ulist"style="width:100%;height:24%; overflow:auto;">참여중인 회원<div id="userlist"> </div></div>'
		+'<div class="bts" style="width:100%;height:4%;"><button class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="chatclose()">닫기</button></div>';
		$("#chatsetbtnmenu").append($setmenudiv);
	}
	
	//프로젝트톡, MEMBER
	else if(parseInt(<%=crmode%>)==1 && chatpermission=="MEMBER"){
		$setdiv='<img onclick="filecreate('+<%=crcode%>+')" src="${pageContext.request.contextPath }/resources/img/img_fileupload.png"data-toggle="tootlip" data-placement="bottom" title="파일 업로드" style="height:100%;float:left;cursor:pointer;">'
		+'<img onclick="menubtn('+<%=crcode%>+','+ 1 +')" src="${pageContext.request.contextPath }/resources/img/img_chatmenubtn.png" data-toggle="tootlip" data-placement="left" title="메뉴" style="height:100%;float:right;cursor:pointer;">';
		$("#chatsetbtn").append($setdiv);
		
		$setmenudiv= '<div style="overflow:auto; width:100%;height:100px; border-bottom: 3px solid #ed8151;">자료<div id="dlist"></div></div>'
		+'<div style="overflow:auto; width:100%;height:24%; border-bottom: 3px solid #ed8151;">의사 결정<div id="delist"></div></div>'
		+'<div style="overflow:auto; width:100%;height:24%; border-bottom: 3px solid #ed8151;">회의록<div id="clist"></div></div>'
		+'<div id="ulist" style="width:100%;height:24%; overflow:auto;">참여중인 회원<div id="userlist"></div></div>'
		+'<div class="bts" style="width:100%;height:4%;"><button class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="chatclose()">닫기</button></div>';
		$("#chatsetbtnmenu").append($setmenudiv);
		
	}
	
	//개인톡
	else if(parseInt(<%=crmode%>)==2){
		$setdiv='<img onclick="filecreate('+<%=crcode%>+')" src="${pageContext.request.contextPath }/resources/img/img_fileupload.png" data-toggle="tootlip" data-placement="bottom" title="파일 업로드" style="height:100%;float:left;cursor:pointer;">'
		+'<img onclick="menubtn('+<%=crcode%>+','+ 2 +')" src="${pageContext.request.contextPath }/resources/img/img_chatmenubtn.png" data-toggle="tootlip" data-placement="left" title="메뉴" style="height:100%;float:right;cursor:pointer;">';
		$("#chatsetbtn").append($setdiv);
		
		$setmenudiv= '<div style="overflow:auto; width:100%; height: calc(500 / 3)px;border-bottom: 3px solid #ed8151;">자료<div id="dlist"></div></div><div id="ulist" >참여중인 회원 <div id="userlist">'
		+'</div></div><div class="bts"><button class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="chatout('+<%=crcode%>+')">나가기</button><button class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="chatclose()">닫기</button> </div>';
		$("#chatsetbtnmenu").append($setmenudiv);
	}
	
	//회의록, OWNER
	else if(parseInt(<%=crmode%>)==3 &&chatpermission=="OWNER"){
		$setdiv='<img id="votercr" onclick="votercreate('+<%=crcode%>+')" src="${pageContext.request.contextPath }/resources/img/img_voter.png" data-toggle="tootlip" data-placement="bottom" title="의사 결정 생성"  style="height:100%;float:left;padding-right:30px;cursor:pointer;">'
		+'<img id="filecr" onclick="filecreate('+<%=crcode%>+')" src="${pageContext.request.contextPath }/resources/img/img_fileupload.png" data-toggle="tootlip" data-placement="bottom" title="자료 업로드" style="height:100%;float:left;padding-right:30px;cursor:pointer;">'
		+'<img onclick="menubtn('+<%=crcode%>+','+ 3 +')" src="${pageContext.request.contextPath }/resources/img/img_chatmenubtn.png" data-toggle="tootlip" data-placement="left" title="메뉴" style="height:100%;float:right;cursor:pointer;">';
		$("#chatsetbtn").append($setdiv);
		
		$setmenudiv= '<div style="overflow:auto; width:100%;height:24%; border-bottom: 3px solid #ed8151;">자료<div id="dlist"></div></div>'
		+'<div style="overflow:auto; width:100%;height:24%; border-bottom: 3px solid #ed8151;">의사결정<div id="delist"></div></div>'
		+'<div id="ulist"style="width:100%;height:24%; overflow:auto;">참여중인 회원<div id="userlist"> </div></div>'
		+'<div class="bts" style="width:100%;height:4%;"><button class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="chatclose()">닫기</button>'
		+'<button id="confecl" class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="confeclose('+<%=crcode%>+')">회의록종료</button></div>';
		$("#chatsetbtnmenu").append($setmenudiv); 
		if(parseInt(<%=crclose%>)==1){
			alert('종료된 회의록입니다.');
			$("#votercr").remove();
			$("#filecr").remove();
			$("#confecl").attr('disabled',true);
			$("#chatsetbtnmenu").attr('disabled',true);
			$("#chatcontent").attr('disabled',true);
		}
	}
	
	//회의록, MEMBER
	else if(parseInt(<%=crmode%>)==3 && chatpermission=="MEMBER"){
		$setdiv='<img id="filecr" onclick="filecreate('+<%=crcode%>+')" src="${pageContext.request.contextPath }/resources/img/img_fileupload.png"data-toggle="tootlip" data-placement="bottom" title="파일 업로드" style="height:100%;float:left;cursor:pointer;">'
		+'<img onclick="menubtn('+<%=crcode%>+','+ 1 +')" src="${pageContext.request.contextPath }/resources/img/img_chatmenubtn.png" data-toggle="tootlip" data-placement="left" title="메뉴" style="height:100%;float:right;cursor:pointer;">';
		$("#chatsetbtn").append($setdiv);
		
		$setmenudiv= '<div style="overflow:auto; width:100%;height:100px; border-bottom: 3px solid #ed8151;">자료<div id="dlist"></div></div>'
		+'<div style="overflow:auto; width:100%;height:24%; border-bottom: 3px solid #ed8151;">의사 결정<div id="delist"></div></div>'
		+'<div id="ulist" style="width:100%;height:24%; overflow:auto;">참여중인 회원<div id="userlist"></div></div>'
		+'<div class="bts" style="width:100%;height:4%;"><button class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="chatclose()">닫기</button></div>';
		$("#chatsetbtnmenu").append($setmenudiv); 
		if(parseInt(<%=crclose%>)==1){
			alert('종료된 회의록입니다.');
				$("#filecr").remove();
				$("#chatsetbtnmenu").attr('disabled',true);
				$("#chatcontent").attr('disabled',true);
				$("#chatbtn").attr('disabled',true);
			}
		
	}
	
	//툴팁제어
	$('[data-toggle="tootlip"]').tooltip();
	var chatObj=new Object();
	var deciObj=new Object();
	var docuObj=new Object();
	
	var socket = new SockJS('/goStomp'); 
	
	stompClient = Stomp.over(socket);
	
	//채팅 append 여기서다함
    stompClient.connect({}, function() { //접속
         stompClient.subscribe('/project/'+pcode, function(msg) {
        	 var test=msg.body;
        	 var concat=JSON.parse(test);
        	  $("#chat"+concat.object.crcode).remove(); 
        	 alert(test);
        	 if(concat.message=="insert"){
	        	
        		 if(concat.type == "chatroomvo"){
		        	 alert(concat.type);
		        	 alert(concat.object);
		        	 chatObj.crcode= concat.object.crcode;
		        	 chatObj.crmode= concat.object.crmode;
		        	 chatObj.crclose= concat.object.crclose;
		        	 chatObj.crcoderef= concat.object.crcoderef;
					
	        		 alert('crcode : '+ chatObj.crcode);
	        		 alert('crmode : '+ chatObj.crmode);
	        		 alert('crclose : '+ chatObj.crclose);
	        		 alert('crcoderef : '+ chatObj.crcoderef);
	    		 }
	        	 
	        	 if(concat.type == "decisionvo"){
	        		 deciObj.dscode= concat.object.dscode;
	        		 deciObj.dsdate=concat.object.dsdate;
	        		 deciObj.dstitle=concat.object.dstitle;
	        		 deciObj.dsclose=concat.object.dsclose;
	        		 deciObj.crcode=concat.object.crcode;
	        		 deciObj.tcode=concat.object.tcode;
	        	 }
	        	 
	        	 if(concat.type=="documentvo"){
	        		 alert('자료올리고시포');
	        		 docuObj.dmcode=concat.object.dmcode;
	        		 docuObj.dmtitle=concat.object.dmtitle;
	        		 docuObj.dmcontents=concat.object.dmcontents;
	        		 docuObj.dmdate=concat.object.dmdate;
	        		 docuObj.crcode=concat.object.crcode;
	        		 docuObj.tcode=concat.object.tcode;
	        		 docuObj.uid=concat.object.uid;
	        	 }
	        	 
	        	 if(concat.type == "chatcontentsvo"){
	        			if(concat.object.uid=='<%=loginid%>'){
	        			 if(Object.keys(chatObj).length<=0 && Object.keys(deciObj).length<=0 && Object.keys(docuObj).length<=0){
		        			 alert('나능 프로젝틍 or 개인 일반대화 or 회의록 대화');
			        		 $("#croomSpan"+concat.object.crcode).append('<span id="chat'+concat.object.crcode+'">'+concat.object.uid+" : "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
			        		 /* $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" : "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>'); */
			        		 
			        		 $aaa='<div style="background-color: yellow; width:100%;height:100px;">'
						     +'<div style="float:right; background-color: cornsilk; width:50%;border-radius:20px;">'
				   			 +'<div><span>'+concat.object.uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
				   			 +'<div><span>'+concat.object.ccontents+'</span></div><div><span>'+concat.object.cdate+'</span></div></div></div>';
			        	 	 $("#chatcontentdiv").append($aaa);
			        	 	 
	        		 	}
	        			 //의사결정 링크
	        			 if(Object.keys(deciObj).length>0 && Object.keys(chatObj).length<=0 && Object.keys(docuObj).length<=0){
	        		 		 alert('나능 프로젝트 또는 회의록 의사결정 생성');
				        	 $("#croomSpan"+concat.object.crcode).append('<span id="chat'+concat.object.crcode+'">'+concat.object.uid+" : <프로젝트 or 개인 투표>"+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
				        	 /* $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" :<프로젝트 or 개인 투표> "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>'); */
				        	 
				        	 $aaa='<div style="background-color: yellow; width:100%;height:100px;">'
							 +'<div style="float:right; background-color: cornsilk; width:50%;border-radius:20px;">'
				   			 +'<div><span>'+concat.object.uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
				   			 +'<div><span><a>[투표]</a></span></div><div><span><a style="cursor:pointer"  onclick="selectDecision(\''+chatpermission+'\','+concat.object.dscode+')">제목 : '+concat.object.ccontents+'</a></span></div><div><span>'+concat.object.cdate+'</span></div></div></div>';
				        	 $("#chatcontentdiv").append($aaa);
				        	 deciObj=new Object();
	        		 	}
	        			 //회의록 링크
	        			 if(Object.keys(chatObj).length>0 && Object.keys(deciObj).length<=0 && Object.keys(docuObj).length<=0){
	        				 alert('나는 회의록 생성');
	 		        		$("#croomSpan"+concat.object.crcode).append('<span id="chat'+concat.object.crcode+'">'+concat.object.uid+" : <프로젝트 회의록>"+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
	 		        		/* $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" :<프로젝트 회의록> "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>'); */
	 		        		/* $aaa='<div><span>'+concat.object.uid+' : <a onclick="goconference('+chatObj.crcode+','+ chatObj.crmode+','+chatObj.crclose+','+chatObj.crcoderef+')">'+'<프로젝트 회의록>'+ concat.object.ccontents +'('+concat.object.cdate+')'+'</a></span></div>';
	 		        		$("#chatcontentdiv").append($aaa); */ 
	 		        		
	 		        		$delist='<div style="background-color: yellow; width:100%;height:100px;">'
							+'<div style="float:right; background-color: cornsilk; width:50%;border-radius:20px;">'
			  				+'<div><span>'+concat.object.uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
			  				+'<div><span><a>[회의록]</a></span></div><div><span><a style="cursor:pointer"  onclick="goconference('+chatObj.crcode+','+ chatObj.crmode + ','+ chatObj.crclose + ','+ chatObj.crcoderef + ')">제목 : '+concat.object.ccontents+'</a></span></div><div><span>'+concat.object.cdate+'</span></div></div></div>';
							$("#chatcontentdiv").append($delist);										
	 		        		
	 		        		chatObj=new Object();
	        			 }
	        			 
	        			 //자료 링크
	        			 if(Object.keys(chatObj).length<=0 && Object.keys(deciObj).length<=0 && Object.keys(docuObj).length>0){
	        				 alert('나는 자료 생성');
	 		        		$("#croomSpan"+concat.object.crcode).append('<span id="chat'+concat.object.crcode+'">'+concat.object.uid+" : <프로젝태 or 개인 자료>"+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
	 		        		/* $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" :<프로젝태 or 개인 자료> "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>'); */
	 		        		/* $aaa='<div><span>'+concat.object.uid+' : <a onclick="fileDownload('+ docuObj.dmcode +')">'+'<프로젝태 or 개인 자료>'+ concat.object.ccontents +'('+concat.object.cdate+')'+'</a></span></div>';
	 		        		$("#chatcontentdiv").append($aaa); */
	 		        		
	 		        		$delist='<div style="background-color: yellow; width:100%;height:100px;">'
							+'<div style="float:right; background-color: cornsilk; width:50%;border-radius:20px;">'
			   				+'<div><span>'+concat.object.uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
			   				+'<div><span><a>[자료]</a></span></div><div><span><a style="cursor:pointer" onclick="fileDownload('+docuObj.dmcode+')">제목 : '+concat.object.ccontents+'</a></span></div><div><span>'+concat.object.cdate+'</span></div></div></div>';
							$("#chatcontentdiv").append($delist);
	 		        		
	 		        		
	 		        		docuObj=new Object();
	        				 }
		        		 }else{
		        			 //다른아이디
		        			 if(Object.keys(chatObj).length<=0 && Object.keys(deciObj).length<=0 && Object.keys(docuObj).length<=0){
			        			 alert('나능 프로젝틍 or 개인 일반대화 or 회의록 대화');
				        		 $("#croomSpan"+concat.object.crcode).append('<span id="chat'+concat.object.crcode+'">'+concat.object.uid+" : "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
				        		/*  $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" : "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>'); */
				        		 
				        		 $aaa='<div style="background-color: yellow; width:100%;height:100px;">'
							     +'<div style="float:left; background-color: aliceblue; width:50%;border-radius:20px;">'
					   			 +'<div><span>'+concat.object.uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
					   			 +'<div><span>'+concat.object.ccontents+'</span></div><div><span>'+concat.object.cdate+'</span></div></div></div>';
				        	 	 $("#chatcontentdiv").append($aaa);
				        	 	 
		        		 	}
		        			 //의사결정 링크
		        			 if(Object.keys(deciObj).length>0 && Object.keys(chatObj).length<=0 && Object.keys(docuObj).length<=0){
		        		 		 alert('나능 프로젝트 또는 회의록 의사결정 생성');
					        	 $("#croomSpan"+concat.object.crcode).append('<span id="chat'+concat.object.crcode+'">'+concat.object.uid+" : <프로젝트 or 개인 투표>"+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
					        	/*  $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" :<프로젝트 or 개인 투표> "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>'); */
					        	 
					        	 $aaa='<div style="background-color: yellow; width:100%;height:100px;">'
								 +'<div style="float:left; background-color: aliceblue; width:50%;border-radius:20px;">'
					   			 +'<div><span>'+concat.object.uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
					   			 +'<div><span><a>[투표]</a></span></div><div><span><a style="cursor:pointer"  onclick="selectDecision(\''+chatpermission+'\','+concat.object.dscode+')">제목 : '+concat.object.ccontents+'</a></span></div><div><span>'+concat.object.cdate+'</span></div></div></div>';
					        	 $("#chatcontentdiv").append($aaa);
					        	 deciObj=new Object();
		        		 	}
		        			 //회의록 링크
		        			 if(Object.keys(chatObj).length>0 && Object.keys(deciObj).length<=0 && Object.keys(docuObj).length<=0){
		        				 alert('나는 회의록 생성');
		 		        		$("#croomSpan"+concat.object.crcode).append('<span id="chat'+concat.object.crcode+'">'+concat.object.uid+" : <프로젝트 회의록>"+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
		 		        		/* $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" :<프로젝트 회의록> "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>'); */
		 		        		/* $aaa='<div><span>'+concat.object.uid+' : <a onclick="goconference('+chatObj.crcode+','+ chatObj.crmode+','+chatObj.crclose+','+chatObj.crcoderef+')">'+'<프로젝트 회의록>'+ concat.object.ccontents +'('+concat.object.cdate+')'+'</a></span></div>';
		 		        		$("#chatcontentdiv").append($aaa); */ 
		 		        		
		 		        		$delist='<div style="background-color: yellow; width:100%;height:100px;">'
								+'<div style="float:left; background-color: aliceblue; width:50%;border-radius:20px;">'
				  				+'<div><span>'+concat.object.uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
				  				+'<div><span><a>[회의록]</a></span></div><div><span><a style="cursor:pointer"  onclick="goconference('+chatObj.crcode+','+ chatObj.crmode + ','+ chatObj.crclose + ','+ chatObj.crcoderef + ')">제목 : '+concat.object.ccontents+'</a></span></div><div><span>'+concat.object.cdate+'</span></div></div></div>';
								$("#chatcontentdiv").append($delist);										
		 		        		
		 		        		chatObj=new Object();
		        			 }
		        			 
		        			 //자료 링크
		        			 if(Object.keys(chatObj).length<=0 && Object.keys(deciObj).length<=0 && Object.keys(docuObj).length>0){
		        				 alert('나는 자료 생성');
		 		        		$("#croomSpan"+concat.object.crcode).append('<span id="chat'+concat.object.crcode+'">'+concat.object.uid+" : <프로젝태 or 개인 자료>"+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
		 		        		/* $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" :<프로젝태 or 개인 자료> "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>'); */
		 		        		/* $aaa='<div><span>'+concat.object.uid+' : <a onclick="fileDownload('+ docuObj.dmcode +')">'+'<프로젝태 or 개인 자료>'+ concat.object.ccontents +'('+concat.object.cdate+')'+'</a></span></div>';
		 		        		$("#chatcontentdiv").append($aaa); */
		 		        		
		 		        		$delist='<div style="background-color: yellow; width:100%;height:100px;">'
								+'<div style="float:left; background-color: aliceblue; width:50%;border-radius:20px;">'
				   				+'<div><span>'+concat.object.uid+'(이름,'+chatpermission+') : (상태메시지)</span></div>'
				   				+'<div><span><a>[자료]</a></span></div><div><span><a style="cursor:pointer" onclick="fileDownload('+docuObj.dmcode+')">제목 : '+concat.object.ccontents+'</a></span></div><div><span>'+concat.object.cdate+'</span></div></div></div>';
								$("#chatcontentdiv").append($delist);
		 		        		
		 		        		
		 		        		docuObj=new Object();
		        				 }
		        		 }
	        		 }
        	 }
        	 
        	 /*	종료!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
        	if(concat.message=="update"){
        		 alert('회의록종료');
        		 if(concat.type="chatroomvo"){
        			 gosetInterval();
        		 }
        	 } 
         });
	});
});
//메뉴버튼열기, param - crcode
function menubtn(code, crmode){
	if($("#chatsetbtnmenu").css("display") == "none"){
			$("#chatsetbtnmenu").show(1000);
			
			//메뉴열 때 delist의 하위 요소 모두 삭제
			$("#delist").empty();
			$("#dlist").empty();
			$("#userlist").empty();
			
			// 채팅방에 참여 중인 유저 리스트 
			var param = {
				'crcode' : code,
				'pcode' : pcode
			};
			
			//채팅방에 초대되어있는 유저
			$.ajax({
				type : 'POST',
				url : '/chatroomjoin/user',
				contentType : 'application/json',
				data : JSON.stringify(param),
				success : function(response) {
					if (response.length != -1) {
						for(var i=0;i<response.length;i++){
							$ulist='<div style="margin-bottom:3px;"><img src="${pageContext.request.contextPath }/resources/img/img_owner.png" style="width:32px;height:32px;">'
							+'<span style="font-size:20px;">' +response[i].uname+'('+response[i].uid + ')'+ '</span></div>';
							$("#userlist").append($ulist);
						}
					} else if (response.length == 0) {
						alert('Server or Client ERROR, 채팅방 유저 리스트 조회 실패');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
			
			//자료를 조회해 보자
			$.ajax({
				type : 'GET',
				url : '/document/room/'+code,
				success : function(response) {
					if (response.length>0) {
						alert('자료 조회 성공')
						for(var i=0;i<response.length;i++){
							$dlist='<div style="margin-bottom:3px;"><img src="${pageContext.request.contextPath }/resources/img/img_filetask.png" style="width:32px;height:32px;">'
							+'<span style="font-size:20px;cursor:pointer;" onclick="fileDownload('+response[i].dmcode+')">' +response[i].dmtitle+'('+response[i].uid + ')'+ '</span></div>';
							$("#dlist").append($dlist);
						}
					} else{
						alert('Server or Client ERROR, 자료가없습니다.');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
			
			if(crmode==1){
			//의사결정을 조회해 보자
			$.ajax({
				type : 'GET',
				url : '/decision/room/'+code,
				success : function(response) {
					if (response.length>0) {
						alert('의사 결정 조회 성공');
						for(var i=0;i<response.length;i++){
							$delist='<div style="margin-bottom:3px;"><img src="${pageContext.request.contextPath }/resources/img/img_vote.png" style="width:32px;height:32px;">'
							+'<span style="font-size:20px;cursor:pointer;" onclick="selectDecision(\''+chatpermission+'\','+response[i].dscode+')">'+response[i].dstitle+ '</span></div>';
							$("#delist").append($delist);
						}
					} else{
						alert('Server or Client ERROR, 의사 결정 조회 실패');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
			
			//회의록 조회
			$.ajax({
				type : 'GET',
				url : '/chatroom/room/'+code,
				success : function(response) {
					if (response.length>0) {
						alert('회의록 조회 성공');
						for(var i=0;i<response.length;i++){
							$delist='<div style="margin-bottom:3px;"><img src="${pageContext.request.contextPath }/resources/img/img_confe.png" style="width:32px;height:32px;">'
							+'<span style="font-size:20px;cursor:pointer;" onclick="goconference('+response[i].crcode+','+response[i].crmode+','+response[i].crclose+','+response[i].crcoderef+')">'+response[i].fctitle+ '</span></div>';
							$("#clist").append($delist);
						}
					} else{
						alert('Server or Client ERROR, 회의록 조회 실패');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
		}
			else if(crmode==3){
				//의사결정을 조회해 보자
				$.ajax({
					type : 'GET',
					url : '/decision/room/'+code,
					success : function(response) {
						if (response.length>0) {
							alert('의사 결정 조회 성공');
							for(var i=0;i<response.length;i++){
								$delist='<div style="margin-bottom:3px;"><img src="${pageContext.request.contextPath }/resources/img/img_vote.png" style="width:32px;height:32px;">'
								+'<span style="font-size:20px;cursor:pointer;" onclick="selectDecision(\''+chatpermission+'\','+response[i].dscode +')'+'">'+response[i].dstitle+ '</span></div>';
								$("#delist").append($delist);
							}
						} else{
							alert('Server or Client ERROR, 의사 결정 조회 실패');
						}
					},
					error : function(e) {
						alert("ERROR : " + e.statusText);
					}
				});
			}
	}
	else $("#chatsetbtnmenu").hide(1000);
} 
//의사결정생성 
function votercreate(code){
	if(confirm('투표를 생성하시겠습니까?')==true){
		window.open("/chat/decisionCreate?crcode="+code+"&pcode="+pcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
		}
	else return;
	}
//의사결정 조회
function selectDecision(chatpermission, dscode)
{
	// 의사결정 고르기(종료 여부는 페이지 들어가서 확인)
	window.open("/chat/decisionSelect?chatpermission="+chatpermission+"&dscode="+dscode, "", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
}	
//자료 업로드
function filecreate(code){
	var popH = 450; // 띄울창의 세로사이즈
	if(confirm('자료를 업로드 하시겠습니까?')==true){
		window.open("/chat/fileUpload?crcode="+code+"&pcode="+pcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
		}
	else return;
}
//자료 다운할 window
function fileDownload(code){
	window.open("/chat/fileDownload?dmcode="+code,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); }
//회의록생성
function conferencecreate(crcode){
	if(confirm('회의록을 만드시겠습니까?')==true){
		window.open("/chat/focusCreate?crcode="+crcode+"&pcode="+pcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
		}
	else return;
}
//회의록 입성 
function goconference(crcode,crmode,crclose,crcoderef)
	{
		if(confirm('회의록에 입장하시겠습니까?')==true){
			/* alert(crcode);
			alert(crmode);
			alert(crclose);
			alert(crcoderef); */
			$("#rightchatlist").load("/chat/content?crcode="+crcode+"&crmode="+crmode+"&crclose="+crclose+"&crcoderef="+crcoderef+"&pcode="+pcode);
		}else return;
	}
//회의록 종료
function confeclose(crcode){
		$.ajax({
			type : 'GET',
			url : '/chatroom/'+crcode,
			success : function(confe) {
				if (Object.keys(confe).length>0) {
					var param = {
							'fctitle' : confe.fctitle,
							'crclose' : 1,
							'tcode' : confe.tcode,
							'crcode' : confe.crcode
					};
					//수정
					$.ajax({
						type : 'PUT',
						url : '/chatroom',
						contentType : 'application/json',
						data : JSON.stringify(param),
						success : function(response) {
							if (response > 0) {
								alert('회의록 종료' + response);
								var closego={
										 'message' : 'update',
										 'type' : 'chatroomvo',
										 'object' :{
												 'fctitle' : confe.fctitle,
												 'crdate' : confe.crdate,
											 	 'crclose' : 1,
												 'tcode' : confe.tcode,
												 'crcoderef' : confe.crcoderef,
												 'crcode' : confe.crcode,
												 'crmode' : confe.crmode
											}
									 };
									stompClient.send('/app/project/'+pcode, {},JSON.stringify(closego));
							} else {
								alert('Server or Client ERROR, 회의록 종료 실패');
							}
						},
						error : function(e) {
							alert("ERROR : " + e.statusText);
						}
					});	
				}
				else{
					alert('Server or Client ERROR, 회의록 정보  조회 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		
	}
//채팅방나가기
function chatout(crcode){
	if(confirm('채팅방에서 나가시겠습니까?')==true){
		var param = {
			'pcode' : pcode,
			'crcode' : crcode,
			'uid' : id
		};
		$.ajax({
			type : 'DELETE',
			url : '/chatroomjoin',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response.length != -1) {
					alert('채팅방 나가기 성공!' + response);
					location.href="/project/chat/main?pcode="+ pcode;
				} else if (response.length == 0) {
					alert('Server or Client ERROR, 채팅방 나가기 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	}else return;
}
//채팅방 닫기
function chatclose(){
	pageopen=false;
	stompClient.disconnect();
	$("#chatmenu").remove();
	
}
//message : insert, type : chatcontents, object : ChatContentsVO
function chattest(dmcode,dscode,crcoderef,crcode,dstitle){
	if(crcode==parseInt(<%=crcode%>)){
		//채팅
		if(dmcode==0 && dscode==0){
			var param={
				 'message' : 'insert',
				 'type' : 'chatcontentsvo',
				 'object' :{
						 'crcode' : <%=crcode%>,
					 	 'uid' : id,
						 'ccontents' : $("#chatcontent").val(),
						 'dmcode' : dmcode,
						 'dscode' : dscode,
						 'crcoderef' : crcoderef
					 }
				 };
		}
		
		//의사결정
		if(dscode!=0 && dmcode==0){
			var param={
				 'message' : 'insert',
				 'type' : 'chatcontentsvo',
				 'object' :{
						 'crcode' : <%=crcode%>,
					 	 'uid' : id,
						 'ccontents' : dstitle,
						 'dmcode' : dmcode,
						 'dscode' : dscode,
						 'crcoderef' : crcoderef
					 }
				 };
		}
		//자료 올리깅 
		if(dscode==0 && dmcode!=0){
			var param={
				 'message' : 'insert',
				 'type' : 'chatcontentsvo',
				 'object' :{
						 'crcode' : <%=crcode%>,
					 	 'uid' : id,
						 'ccontents' : dstitle,
						 'dmcode' : dmcode,
						 'dscode' : dscode,
						 'crcoderef' : crcoderef
					 }
				 };
		}
		
		stompClient.send('/app/webproject/'+pcode, {},JSON.stringify(param));
	}
	
	//회의록 올리기
	 if(crcode!=<%=crcode%>){
		var param={
			 'message' : 'insert',
			 'type' : 'chatcontentsvo',
			 'object' :{
					 'crcode' : <%=crcode%>,
				 	 'uid' : id,
					 'ccontents' : dstitle,
					 'dmcode' : dmcode,
					 'dscode' : dscode,
					 'crcoderef' : crcoderef
				 }
			 };
		stompClient.send('/app/webproject/'+pcode, {},JSON.stringify(param));
		} 
}

 //서버 전송
 function decitest(dscode,dsdate,dstitle,dsclose,crcode,tcode){
		var param={
			 'message' : 'insert',
			 'type' : 'decisionvo',
			 'object' :{
					 'dscode' : dscode,
				 	 'dsdate' : dsdate,
					 'dstitle' : dstitle,
					 'dsclose' : dsclose,	
					 'crcode' : crcode,
					 'tcode' : tcode
				}
		 };
		stompClient.send('/app/webproject/'+pcode, {},JSON.stringify(param));
}
 //서버 전송
 function focutest(crcode,crdate,crmode,fctitle,crclose,tcode,crcoderef){
	var param={
			 'message' : 'insert',
			 'type' : 'chatroomvo',
			 'object' :{
					 'crcode' : crcode,
				 	 'crdate' : crdate,
					 'crmode' : crmode,
					 'fctitle' : fctitle,	
					 'crclose' : crclose,
					 'tcode' : tcode,
					 'crcoderef' : crcoderef
				}
		 };
	stompClient.send('/app/webproject/'+pcode, {},JSON.stringify(param));
} 
 
 //서버 전송
 function docutest(dmcode,dmtitle,dmcontents,dmdate,crcode,tcode,uid){
	 var param={
			 'message' : 'insert',
			 'type' : 'documentvo',
			 'object' :{
					 'dmcode' : dmcode,
				 	 'dmtitle' : dmtitle,
					 'dmcontents' : dmcontents,
					 'dmdate' : dmdate,	
					 'crcode' : crcode,
					 'tcode' : tcode,
					 'uid' : uid
				}
		 };
	stompClient.send('/app/webproject/'+pcode, {},JSON.stringify(param)); 
 }
 
 //회의록 종료 함수
 var i=0;
 function gosetInterval(){
	 	alert('회의록이 5초뒤 종료 되니 준비 해주시길 바랍니다.');
	 	a=setInterval(function() {
	 		i++;
	 		if(i==5){
		 		$("#votercr").remove();
				$("#filecr").remove();
				$("#confecl").attr('disabled',true);
				$("#chatbtn").attr('disabled',true);
				$("#chatcontent").attr('disabled',true);
			 	alert('회의록이 종료 됩니다.');
				clearInterval(a);
		 	}
	 	}, 1000);
}
</script>