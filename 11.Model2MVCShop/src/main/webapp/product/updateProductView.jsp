<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

	<title>상품 정보 수정</title>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   	<link href="/css/animate.min.css" rel="stylesheet">
   	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   	
   	<!-- jQuery UI datepicker 사용 CSS-->
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<!-- jQuery UI datepicker 사용 JS-->
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 50px;
        }
    </style>
    
    <script type="text/javascript">
    	
    
    	$( function() {
    		$("#datepicker").datepicker({dateFormat: 'yy-mm-dd'});
        	$( "#datepicker" ).datepicker();
        	
        	$( "button.btn.btn-primary" ).on("click" , function() {
				fncUpdateProduct();
			});
        	
        	$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
        } );
	
		function fncUpdateProduct() {
			var name = $("input[name = 'prodName']").val();
			var detail = $("input[name = 'prodDetail']").val();
			var manuDate = $("input[name = 'manuDate']").val();
			var price = $("input[name = 'price']").val();
			
			if(name == null || name.length<1){
				alert("상품명은 반드시 입력하여야 합니다.");
				return;
			}
			if(detail == null || detail.length<1){
				alert("상품상세정보는 반드시 입력하여야 합니다.");
				return;
			}
			if(manuDate == null || manuDate.length<1){
				alert("제조일자는 반드시 입력하셔야 합니다.");
				return;
			}
			if(price == null || price.length<1){
				alert("가격은 반드시 입력하셔야 합니다.");
				return;
			}
			
			$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();
		}
	
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<!-- ToolBar -->
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		
		<div class="page-header text-center">
	    	<h3 class=" text-info">상품정보수정</h3>
	    </div>
   	

		<form class="form-horizontal">
			<input type="hidden" name="prodNo" value=${product.prodNo } />
			<input type="hidden" name="menu" value="ok" />
			
			<div class="form-group">
		    	<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName }" placeholder="변경 상품명" >
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodName }" placeholder="변경 상세정보" >
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    	<div class="col-sm-4" style="position: relative;">
		      		<input type="text" class="form-control" id="datepicker" name="manuDate" value="${product.manuDate }" readonly>
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가 격</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="price" name="price" value="${product.price }" placeholder="변경 가격" >
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="fileName" name="fileName" value="../../images/empty.GIF" placeholder="변경 이미지" >
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<div class="col-sm-offset-4  col-sm-4 text-center">
		      		<button type="button" class="btn btn-primary"  >수 &nbsp;정</button>
			  		<a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
		    	</div>
		  	</div>
	
		</form>
	</div>

</body>
</html>