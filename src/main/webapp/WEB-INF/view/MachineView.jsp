<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Machine View</title>
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
	<style>
		table, th, td {
		  border: 1px solid black;
		  border-collapse: collapse;
		}
		body {
		  /* fallback for old browsers */
		  background: #accbee;
		
		  /* Chrome 10-25, Safari 5.1-6 */
		  background: -webkit-linear-gradient(to right, rgba(172, 203, 238, 0.5), rgba(0, 231, 240, 0.5));
		
		  /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
		  background: linear-gradient(to right, rgba(172, 203, 238, 0.5), rgba(0, 231, 240, 0.5));
		  
		  margin-bottom: 190px;	  
	    }
	</style>
</head>
<body>
	<div class="jumbotron" align="center">
		<h1 class="display-4">Welcome to Machine View!</h1>
	  	<hr class="my-4">
	  	<p>Please order your products</p>
		  	<div id="machinetta" align="center">
			<table>
			<tr>
				<th>Machine ID</th>
				<th>Brand</th>
				<th>Status</th>
				<th>Products</th>
			</tr>
			<tr>
				<td>${machine.idMachine}</td>
				<td>${machine.brandName}</td>
				<td>
					<c:choose>
						<c:when test="${machine.isOccupied == 0 }">
							<span style="color: green">Free</span>
							<input type="hidden" id="mOccupation" name="mOccupation" value="${machine.isOccupied}">
							<input type="hidden" id="mID" name="mID" value="${machine.idMachine}">
						</c:when>
						<c:otherwise>
							<span style="color: red">Occupied</span>
							<input type="hidden" id="mOccupation" name="mOccupation" value="${machine.isOccupied}">
							<input type="hidden" id="mID" name="mID" value="${machine.idMachine}">
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<table>
						<tr>
							<th>Product ID</th>
							<th>Name</th>
							<th>Price</th>
							<th>Quantity</th>
						</tr>
						<c:forEach var="element" items="${machine.productListWithPrices}">
						<tr>
							<td>${element.key.id}</td>
							<td>${element.key.productName}</td>
							<td>${element.key.price}</td>
							<td>${element.value}</td>				
						</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
			</table>
		</div>
	</div>
	<br>
	<div id="machine" align="center">
		<form id="insertform" novalidate>
			<div class="form-group">
				<label for="productsel" class="form-label">Please insert the ID product:</label><br>
				<input type="text" id="productsel" class="form-control w-25 productsel" required><br>
				<div class="invalid-feedback">You must enter a valid input!</div>
			</div>
			<div class="form-group">
				<label for="sugarsel" class="form-label" >Please insert the sugar quantity:</label><br>
				<input type="text" id="sugarsel" class="form-control w-25 sugarsel" required><br>
				<div class="invalid-feedback">You must enter a number between 0 and 5!</div>
			</div>
			<input type="submit" value="Send" class="btn btn-primary">
		</form>
	</div>
	<br>
	<div align="center">
		<span id="container"></span>
	</div>
	<jsp:include page="/parts/footer.jsp"></jsp:include>
	<script>
		$(document).ready(function () {
			
			$("#machine").hide();
			
			if($("#mOccupation").val() == 1) {
				$("#machine").show();
				$("#productcheck").hide();
				$("#sugarcheck").hide();
			} else {
				$("#insertform").hide();
			}
			
			$("#productsel").keyup(function() {
				var sel = $("#productsel").val();
				
				if(!validateSelection(sel)) {
					$(".productsel").addClass('is-invalid');
				} else {
					$(".productsel").removeClass('is-invalid');
					$(".productsel").addClass('is-valid');
				}
			})
			
			$("#sugarsel").keyup(function() {
				var sel = $("#sugarsel").val();
				
				if(!validateSugar(sel)) {
					$(".sugarsel").addClass('is-invalid');
				} else {
					$(".sugarsel").removeClass('is-invalid');
					$(".sugarsel").addClass('is-valid');
				}
			})
			
			
			
			
			$("#insertform").submit(function (event) {
				event.preventDefault();
				
				if(validateInsert()) {			
					var insertData = {
							selection: $("#productsel").val(),
							idMachine: $("#mID").val()
					}
					
					$.ajax({
						type: 'POST',
						url: './Machine/Buy',
						contentType: 'application/json',
						dataType: 'text',
						data: JSON.stringify(insertData),
						success: function (data, textStatus, jqXHR) {
							var res = JSON.parse(data);
							if(res.type == "-2") {
								$('#container').css('color','grey');
								$('#container').html(res.message);
							} else if(res.type == "-1") {
								$('#container').css('color','red');
								$('#container').html(res.message);
							} else if(res.type == "0") {
								$('#container').css('color','red');
								$('#container').html(res.message);
							} else if(res.type == "1") {
								$('#container').css('color','green');
								$('#container').html(res.message);
							}
						}
					})
				}				
			})
			
			
		
			
			function validateInsert() {
				var sel = $("#productsel").val();
				var sugar = $("#sugarsel").val();
				
				if(!validateSelection(sel) && !vvalidateSugar(sugar)) {
					$("#productcheck").show();
					$("#sugarcheck").show();
					return false;
				} else if(!validateSelection(sel)) {
					$("#productcheck").show();
					return false;
				} else if(!validateSugar(sugar)) {
					$("#sugarcheck").show();
					return false;
				} else {
					return true;
				}
			}
			
			
			function validateSelection($sel) {
 				var selectionRegEx = /^[0-9]+$/;
 				return selectionRegEx.test($sel);
 			}
			
			function validateSugar($sugar) {
 				var sugarRegEx = /^[0-5]{1}$/;
 				return sugarRegEx.test($sugar);
 			}
			
		})
		
		setInterval(function(){
			var updateData = {
					idMachine: $("#mID").val(),
					isOccupied: $("#mOccupation").val()
			}

			$.ajax({
				type: 'POST',
				url: './Machine/Update',
				contentType: 'application/json',
				dataType: 'text',
				data: JSON.stringify(updateData),
				success: function (data,textSatus, jqXHR) {
					location.reload();
				},
			});
		}, 10000)
			
		
	</script>
</body>
</html>