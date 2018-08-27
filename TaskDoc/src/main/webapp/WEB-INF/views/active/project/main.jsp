<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/fix/header.jsp"%>
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
	<!--FRAME  -->
	<div id="frame">
	
		<!--MAIN HEADER  -->
		<%@include file="/WEB-INF/views/fix/main_header.jsp"%>
		<!--MAIN HEADER  -->
		
		<!--WRAPPER  -->
		<div id="wrapper">
		
			<!--SIDE BAR  -->
			<%@include file="/WEB-INF/views/fix/left_side.jsp"%>
			<!--SIDE BAR  -->
			
			<!--CONTENTWRAP  -->
			<div id="contentwrap">
	
				<!--PROJECT_WRAP -->				
				<div id="project_wrap">
				
					<!--PROJECT_LIST_WRAP / TOP(pinvite=1인 프로젝트)-->
					<div id="project_list_wrap_top">
					
						
						
					</div>
					<!--PROJECT_LIST_WRAP / TOP(pinvite=1인 프로젝트)-->
					
					<!--PROJECT_LIST_WRAP_BOTTOM / BOTTOM(pinvite=0인 프로젝트)-->
					<div class="project_list_wrap_bottom">
					

					</div>
					<!--PROJECT_LIST_WRAP / BOTTOM(pinvite=0인 프로젝트)-->
					
					</div>
					<!--PROJECT_WRAP -->
					
				</div>
				<!--PROJECT_WRAP -->				

			</div>
			<!--CONTENTWRAP  -->		
			
		</div>
		<!--FRAME  -->

		<!-- FOOTER -->
		<%@include file="/WEB-INF/views/fix/footer.jsp"%>
		<!-- FOOTER -->
	
</body>
</html>