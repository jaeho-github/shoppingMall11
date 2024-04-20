<!-- ��ǰ�����ȸ -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri= "http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

	<title>��ǰ �����ȸ</title>

	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   
   	<!-- jQuery UI toolTip ��� CSS-->
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<!-- jQuery UI toolTip ��� JS-->
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>


	<script type = "text/javascript">
	
		function fncGetList(currentPage) {
			var menu = "${menu}";
	
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct/"+menu).submit();	
		
		}
			
		$(function () {
			
			var menu = "${menu}";
			
			$(document).tooltip();
			
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
			
			$( "td:nth-child(2)" ).on("click" , function() {
				var prodNo = $(this).next().val();
				
				self.location ="/product/getProduct/"+prodNo+"/"+menu;
			});
			
			$("li.previous").on("click", function() {
				
				if ($(this).attr("class") == "previous disabled") {
					return;
				} else {
					$("#currentPage").val(${ resultPage.beginUnitPage-1})
					$("form").attr("method" , "POST").attr("action" , "/product/listProduct/"+menu).submit();
				}
			})
			
			$("li.next").on("click", function() {
				
				if ($(this).attr("class") == "next disabled") {
					return;
				} else {
					$("#currentPage").val(${resultPage.endUnitPage+1})
					$("form").attr("method" , "POST").attr("action" , "/product/listProduct/"+menu).submit();
				}
			})
			
			//==> userId LINK Event End User ���� ���ϼ� �ֵ��� 
			$( "td:nth-child(2)" ).css("color" , "red");
			
			
			$(  "td:nth-child(6) > i" ).on("click" , function() {
				
				// ���⿡ ���ڿ� ó�� ����� �ϴ� ���� : ������ ���� ���ڰ� �ƴϰ� ���ڿ��̶�.
				
				var prodNo = $(this).next().val()
				
				$.ajax( 
						{
							url : "/app/product/getProduct/"+prodNo+"/"+menu ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
		
								//Debug...
								//alert(status);
								//Debug...
								//alert("JSONData : \n"+JSONData);
								
								var displayValue = "<h6>"
															+"��ǰ�� : "+JSONData.product.prodName+"<br/>"
															+"������ : "+JSONData.product.prodDetail+"<br/>"
															+"��  �� : "+JSONData.product.price+"<br/>"
															+"����� : "+JSONData.product.regDateString+"<br/>"
															+"</h6>";
								//Debug...									
								//alert(displayValue);
								$("h6").remove();
								$( "#"+prodNo ).html(displayValue);
							}
					});
				
			});
			
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
		})

	</script>

</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>${(!empty menu && menu eq 'search') ? '��ǰ ��ȸ���' : '��ǰ ����'  }</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">����</th>
            <th align="left">�����</th>
            <th align="left">�������</th>
            <th align="left">��������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : ��ǰ���� Ȯ��">${product.prodName}</td>
			  	<input type = "hidden" value = "${product.prodNo }"/>
			  <td align="left">${product.price}</td>
			  <td align="left">${product.regDate}</td>
			  <c:if test = "${product.proTranCode == null}">
				<td align="left">�Ǹ���</td>
			  </c:if>	
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  		<input type="hidden" value="${product.prodNo}">
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>
</html>