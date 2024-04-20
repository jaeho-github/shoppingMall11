<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>



<html>
<head>
	<title>��ǰ���</title>
	
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
   	
   	<!-- jQuery UI datepicker ��� CSS-->
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<!-- jQuery UI datepicker ��� JS-->
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 50px;
        }
    </style>
	
	<script type="text/javascript">
	
	$(function () {
		$("#datepicker").datepicker({dateFormat: 'yy-mm-dd'});
    	$( "#datepicker" ).datepicker();
		
    	$( "button.btn.btn-primary" ).on("click" , function() {
			fncAddProduct();
		});
		
		$("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
		});
		
		
	})
	
	function fncAddProduct() {
		
		var name = $("input[name = 'prodName']").val();
		var detail = $("input[name = 'prodDetail']").val();
		var manuDate = $("input[name = 'manuDate']").val();
		var price = $("input[name = 'price']").val();
		
		if(name == null || name.length<1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(price == null || price.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();
	}
	
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<!-- ToolBar -->
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		
		<div class="page-header text-center">
	    	<h3 class=" text-info">��ǰ ���</h3>
	    </div>
	    
	    <div class ="row">

		<form class="form-horizontal" enctype = "multipart/form-data" >
			
			<div class="col-md-12 text-left">
		    	<label class="control-label text-primary">
		    		<img src="/images/ct_icon_red.gif" width="5" height="5" align="absmiddle"/> ǥ�õ� ���� �ݵ�� �Է�
		    	</label>
		    </div>
			
			<div class="form-group">
		    	<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label"> <img src="/images/ct_icon_red.gif" width="5" height="5" align="absmiddle"/> �� ǰ �� </label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="prodName" name="prodName" placeholder="��ǰ��" >
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label"> <img src="/images/ct_icon_red.gif" width="5" height="5" align="absmiddle"/> ��ǰ������ </label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="��ǰ ������" >
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label"> <img src="/images/ct_icon_red.gif" width="5" height="5" align="absmiddle"/> �������� </label>
		    	<div class="col-sm-4" style="position: relative;">
		      		<input type="text" class="form-control" id="datepicker" name="manuDate" placeholder = "��ǰ ��������" readonly>
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="price" class="col-sm-offset-1 col-sm-3 control-label"> <img src="/images/ct_icon_red.gif" width="5" height="5" align="absmiddle"/> �� �� </label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="price" name="price" placeholder="��ǰ ����" >
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		    	<div class="col-sm-4">
		      		<input type="file" id="imageFile" name="imageFile" multiple>
		    	</div>
		  	</div>
		  	
		  	<div class="form-group">
		    	<div class="col-sm-offset-4  col-sm-4 text-center">
		      		<button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			  		<a class="btn btn-primary btn" href="#" role="button">�� &nbsp;��</a>
		    	</div>
		  	</div>
	
		</form>
		</div>
	</div>
</body>
</html>