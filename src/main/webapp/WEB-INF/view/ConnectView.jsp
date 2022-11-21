<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<body>
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<div class="jumbotron" align="center">
			<form id="connect" novalidate>
				<div class="form-group">
					<label for="machineconnect" class="form-label">Insert the machine's ID:</label><br>
					<c:choose>
						<c:when test="${machine_id != null}">
							<input type="text" id="machineconnect" class="form-control w-25 machineconnect" value="${machine_id}" disabled><br>
							<input type="submit" id="conn" value="Disconnect" class="btn btn-primary"> 
						</c:when>
						<c:otherwise>
							<input type="text" id="machineconnect" class="form-control w-25 machineconnect"><br>
							<input type="submit" id="conn" value="Connect" class="btn btn-primary"> 
						</c:otherwise>
					</c:choose>
				</div>
			</form>
		</div><br>
		<div align="center">
			<span id="status"></span>
		</div>
		<script>
			$(document).ready(function () {
				$("#connect").submit(function(event) {
					event.preventDefault();
					var submitVal= $("#conn").val();
					console.log(submitVal);
					
					var ID=$("#machineconnect").val();
					
					
					if(submitVal === "Connect") {
						if(validateConnection(ID)) {
			 				
				 			var connectData = {
				 					idMachine: ID 
				 			}
				 				
				 			$.ajax({
								type: 'POST', 
								url: './User/Connect',
								contentType: 'application/json',
								dataType: 'text',
								data: JSON.stringify(connectData),
								success: function (data,textSatus, jqXHR) {
									var res = JSON.parse(data);
									if(res.type == "1")  {
										$("#machineconnect").prop( "disabled", true );
										$('#status').css('color','green');
										$('#status').html(res.message);
										$('#conn').val("Disconnect");
									} else if(res.type == "0") {
										$('#status').css('color','red');
										$('#status').html(res.message);
									} else if(res.type == "-1") {
										$('#status').css('color','grey');
										$('#status').html(res.message);
									} else if(res.type == "-2") {
										$('#status').css('color','red');
										$('#status').html(res.message);
									}
								},
							}) 
						}
					} else if(submitVal === "Disconnect") {
						if(validateConnection(ID)) {
			 				
				 				
				 			$.ajax({
								type: 'POST', 
								url: './User/Disconnect',
								contentType: 'application/json',
								dataType: 'text',
								success: function (data,textSatus, jqXHR) {
									var res = JSON.parse(data);
									if(res.type == "1")  {
										$("#machineconnect").prop( "disabled", false );
										$('#status').css('color','red');
										$('#status').html(res.message);
										$('#conn').val("Connect");
									} else if(res.type == "0") {
										$('#status').css('color','red');
										$('#status').html(res.message);
									} 
								},
							}) 
						}
					}	
				})
				
					
				
				function validateConnection($conn) {
	 				var connectionRegEx = /^[0-9]+$/;
	 				return connectionRegEx.test($conn);
	 			}
				
				
			})
		</script>
</body>
