<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<head>
<meta charset="ISO-8859-1">
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
	<title>Coffee Project</title>
	<style>	
		body {
		  /* fallback for old browsers */
		  background: #accbee;
		
		  /* Chrome 10-25, Safari 5.1-6 */
		  background: -webkit-linear-gradient(to right, rgba(172, 203, 238, 0.5), rgba(0, 231, 240, 0.5));
		
		  /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
		  background: linear-gradient(to right, rgba(172, 203, 238, 0.5), rgba(0, 231, 240, 0.5));
		  
		  margin-bottom: 190px;	  
	    }
	
		html { 
			position: relative;
	  		min-height: 100%;
	  		padding-bottom:190px; 
	  	}
	</style>
</head>

<body>
	<div class="jumbotron" align="center">
		  <h1 class="display-4">Welcome Guest!</h1>
		  <p class="lead">Insert your email and password to access</p>
		  <hr class="my-4">
		  <form id="form1" novalidate>
			  <div class="form-group">
			    <label for="email" class="form-label">Email address</label>
			    <input type="email" class="form-control w-25 email" id="email" aria-describedby="emailHelp" placeholder="Enter email" required>
			    <div class="invalid-feedback">You must enter a valid email!</div>
			  </div>
			  <div class="form-group">
			    <label for="psw" class="form-label">Password</label>
			    <input type="password" class="form-control w-25 psw" id="psw" placeholder="Password" required>
			    <div class="invalid-feedback">You must enter a valid password (minimum 6 character,at least 1 uppercase,1 lowercase and 1 number)!</div>
			  </div>
			  <br>
			  <button type="submit" class="btn btn-primary">Submit</button>
		   </form>		
	</div>
	<br>
	<div align="center">
		<span id="errorlogin" style='color:red'></span>
	</div>
	<jsp:include page="/parts/footer.jsp"></jsp:include>
	<script>
		//Lo script deve essere inserito dentro ready
		$(document).ready(function () {
			
			
			$("#email").keyup(function() {
				var email = $("#email").val();
				
				if(!validateEmail(email)) {
					$(".email").addClass('is-invalid');
				} else {
					$(".email").removeClass('is-invalid');
					$(".email").addClass('is-valid');
				}
			})
			
			$("#psw").keyup(function() {
				var psw = $("#psw").val();
				
				if(!validatePassword(psw)) {
					$(".psw").addClass('is-invalid');
				} else {
					$(".psw").removeClass('is-invalid');
					$(".psw").addClass('is-valid');
				}
			})
			
			
			$("#form1").submit(function(event) {
				event.preventDefault();
				
				$(".email").removeClass('is-valid');
				$(".psw").removeClass('is-valid');
				
				if(validateLoginForm()) {
					
					var loginData = {
							email: $("#email").val(),
							password: $("#psw").val()
					}
														
					$.ajax({
						type: 'POST', 
						url: './LoginController',
						contentType: 'application/json',
						dataType: 'text',
						data: JSON.stringify(loginData),
						success: function (data,textSatus, jqXHR) {
							var res = JSON.parse(data);
							if(res.success == true)  {
								window.location= res.address;
							} else {
								$('#errorlogin').html(res.message);
							}
						},
					}) 
					
				}		
			})
			
			//Validazione form
			function validateLoginForm() {
			
				var email = $("#email").val();
				var psw = $("#psw").val();
				
				
				if(!validateEmail(email) && !validatePassword(psw)) {
					return false;
				} else if(!validatePassword(psw)) {
					return false;
				} else if(!validateEmail(email)) {
					return false;
				} else { 
					return true; 
				}
			
			}
			
			function validateEmail($email) {
				var emailReg = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;
				return emailReg.test( $email );
			}
			
			function validatePassword($password) {
				var passwReg = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
				return passwReg.test( $password );
			}
		})		
		
	</script>
</body>
</head>