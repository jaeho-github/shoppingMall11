<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// �α��ν� Forward  /////////////////////////////////////// -->
 <c:if test="${ ! empty user }">
 	<jsp:forward page="main.jsp"/>
 </c:if>
 <!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
   	
   	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= ȸ�������� ȭ���̵� =============
		$( function() {
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#' ]:contains('ȸ������')").on("click" , function() {
				self.location = "/user/addUser"
			});
			
			$("a[href='#' ]:contains('�� �� ��')").on("click" , function() {
				self.location = "/user/login"
			});
			
			$(".dropdown-menu a").on("click" , function() {
				if ($(this).text().trim() == '�� ǰ �� ��')
				{
					self.location = "#";
				}else
				{
					alert("�α��� �� ��밡���� ����Դϴ�.");
					self.location = "/user/login"	
				}
				
			});
			
		});
		
		
	</script>
	
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-inverse navbar-fixed-top">
	
		<div class="container">
		       
			<a class="navbar-brand" href="#">Model2 MVC Shop</a>
			
			<!-- toolBar Button Start //////////////////////// -->
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </button>
			</div>
			<!-- toolBar Button End //////////////////////// -->
			
		    <!--  dropdown hover Start -->
			<div 	class="collapse navbar-collapse" id="target" 
		       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
		         
		         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
		             <ul class="nav navbar-nav">
		             
		              <!--  ȸ������ DrowDown -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >ȸ������</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">����������ȸ</a></li>
		                         
	
		                         <li><a href="#">ȸ��������ȸ</a></li>
	
		                         
		                         <li class="divider"></li>
		                         <li><a href="#">etc...</a></li>
		                     </ul>
		                 </li>
		                 
		              <!-- �ǸŻ�ǰ���� DrowDown  -->
		               <c:if test="${sessionScope.user.role == 'admin'}">
			              <li class="dropdown">
			                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			                         <span >�ǸŻ�ǰ����</span>
			                         <span class="caret"></span>
			                     </a>
			                     <ul class="dropdown-menu">
			                         <li><a href="#">�ǸŻ�ǰ���</a></li>
			                         <li><a href="#">�ǸŻ�ǰ����</a></li>
			                         <li class="divider"></li>
			                         <li><a href="#">etc..</a></li>
			                     </ul>
			                </li>
		                 </c:if>
		                 
		              <!-- ���Ű��� DrowDown -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >��ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�� ǰ �� ��</a></li>
		                         
	
		                         <li><a href="#">�����̷���ȸ</a></li>
	
		                         
		                         <li><a href="#">�ֱٺ���ǰ</a></li>
		                         <li class="divider"></li>
		                         <li><a href="#">etc..</a></li>
		                     </ul>
		                 </li>
		                 
		                 <li><a href="#">etc...</a></li>
		             </ul>
		             
			</div>
			<!-- dropdown hover END -->	       
		    
		</div>
	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- �ٴܷ��̾ƿ�  Start /////////////////////////////////////-->
		<div class="row">

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-12">
				<div class="jumbotron">
			  		<h1>Model2 MVC Shop</h1>
			  		<p>�α��� �� ��밡��...</p>
			  		<p>�α��� �� �˻��� �����մϴ�.</p>
			  		<p>ȸ������ �ϼ���.</p>
			  		
			  		<div class="text-center">
			  			<a class="btn btn-info btn-lg" href="#" role="button">ȸ������</a>
			  			<a class="btn btn-info btn-lg" href="#" role="button">�� �� ��</a>
			  		</div>
			  	
			  	</div>
	        </div>
	   	 	<!--  Main end /////////////////////////////////////-->   		
	 	 	
		</div>
		<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->
		
	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>

</html>