<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<title>Coffee Project</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
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
	  <p class="lead"> Complete the fields in order to register yourself!</p>
	  <hr class="my-4">
	  	<form id='form2' novalidate>
	  		<div class="form-group">
			    <label for="name" class="form-label">Name</label>
			    <input type="text" class="form-control w-25 name" id="name" required>
			</div>
			<div class="form-group">
			    <label for="surname" class="form-label">Surname</label>
			    <input type="text" class="form-control w-25 surname" id="surname" required>
			    <div class="invalid-feedback">Your name or surname is not valid!</div>
			</div>
			<div class="form-group">
			    <label for="email" class="form-label">Email</label>
			    <input type="email" class="form-control w-25 email" id="email" aria-describedby="emailHelp" placeholder="Enter email" required>
			    <div class="invalid-feedback">You must enter a valid email!</div>
			</div>
			<div class="form-group">
			    <label for="numph" class="form-label">Number phone</label>
			    <input type="text" class="form-control w-25 numph" id="numph" required>
			    <div class="invalid-feedback">You must enter a valid number phone!</div>
			</div>
			<div class="form-group">
			    <label for="psw1" class="form-label">Password</label>
			    <input type="password" class="form-control w-25 psw1" id="psw1" placeholder="Password" required>
			    <div class="invalid-feedback">You must enter a valid password (minimum 6 character,at least 1 uppercase,1 lowercase and 1 number)!</div>
			</div>
			<div class="form-group">
			    <label for="psw2" class="form-label">Repeat password</label>
			    <input type="password" class="form-control w-25 psw2" id="psw2" placeholder="Repeat Password" required>
			    <div class="invalid-feedback">The passwords doesn't match!</div>
			</div>
			<br>
			<button type="submit" class="btn btn-primary">Submit</button>
			<br>			
			<br>
			<div align="center">
				<span id="errorreg" style='color:red'></span>
			</div>
		</form>
	</div>
	<div align='center'>
	</div>
	<jsp:include page="/parts/footer.jsp"></jsp:include>
	<script>
		//Lo script deve essere inserito dentro ready
		$(document).ready(function () {
			
			$("#name").keyup(function() {
				var name = $("#name").val();
				
				console.log(name);
				
				if(!validateName(name) ) {
					$(".name").addClass('is-invalid');
				} else {
					$(".name").removeClass('is-invalid');
					$(".name").addClass('is-valid');
				}
			})
			
			$("#surname").keyup(function() {
				var surname = $("#surname").val();
				
				if(!validateName(surname)) {
					$(".surname").addClass('is-invalid');
				} else {
					$(".surname").removeClass('is-invalid');
					$(".surname").addClass('is-valid');
				}
			})
			
			
			$("#email").keyup(function() {
				var email = $("#email").val();
				
				console.log(validateEmail(email));
				
				if(!validateEmail(email)) {
					$(".email").removeClass('is-valid');
					$(".email").addClass('is-invalid');
				} else {
					
					$(".email").removeClass('is-invalid');
					$(".email").addClass('is-valid');
				}
			})
			
			$("#numph").keyup(function() {
				var numph = $("#numph").val();
				
				if(!validatePhone(numph)) {
					$(".numph").addClass('is-invalid');
				} else {
					$(".numph").removeClass('is-invalid');
					$(".numph").addClass('is-valid');
				}
			})
			
			$("#psw1").keyup(function() {
				var psw = $("#psw1").val();
				
				if(!validatePassword(psw)) {
					$(".psw1").addClass('is-invalid');
				} else {
					$(".psw1").removeClass('is-invalid');
					$(".psw1").addClass('is-valid');
				}
			})
			
			$("#psw2").keyup(function() {
				var psw1 = $("#psw1").val();
				var psw2 = $("#psw2").val();
				
				if((psw1 != psw2)) {
					$(".psw2").addClass('is-invalid');
				} else {
					$(".psw2").removeClass('is-invalid');
					$(".psw2").addClass('is-valid');
				}
			})
			
			
			$("#form2").submit(function(event) {
				
				event.preventDefault();
				
				$(".email").removeClass('is-valid');
				$(".name").removeClass('is-valid');
				$(".surname").removeClass('is-valid');
				$(".numph").removeClass('is-valid');
				$(".psw1").removeClass('is-valid');
				$(".psw2").removeClass('is-valid');
				
				if(validateRegForm()) {
					
					var regData = {
							name: $("#name").val(),
							surname: $("#surname").val(),
							email: $("#email").val(),
							phone: $("#numph").val(),
							password: $("#psw1").val()
					}
					
														
					$.ajax({
						type: 'POST', 
						url: './RegController',
						contentType: 'application/json',
						dataType: 'text',
						data: JSON.stringify(regData),
						success: function (data,textSatus, jqXHR) {
							var res = JSON.parse(data);
							if(res.success == true)  {
								window.location= res.address;
							} else {
								$('#errorreg').html(res.message);
							}
						},
					}) 
					
				}
				
			})
			
			
			
			//Validazione form
			function validateRegForm() {
			
				var email = $("#email").val();
				var psw1 = $("#psw1").val();
				var psw2 = $("#psw2").val();
				var num = $("#numph").val();
				var name = $("#name").val();
				var surname = $("#surname").val();
				
				if(!validateEmail(email) && !validatePassword(psw1) && !validatePhone(num) && (psw1 != psw2)) {
			
					return false;
				} else if(!validateEmail(email) && !validatePassword(psw1) && (psw1 != psw2) ) {
				
					return false;
				} else if(!validateEmail(email) && !validatePhone(num) && (psw1 != psw2) ) {
		
					return false; 
				} else if(!validatePassword(psw1) && !validatePhone(num) && (psw1 != psw2)){
		
					return false; 
				} else if(!validateEmail(email) && !validatePassword(psw1) ) {
	
					return false;
				} else if(!validateEmail(email) && !validatePhone(num) ) {
		
					return false; 
				} else if(!validatePassword(psw1) && !validatePhone(num) ){
		
					return false; 
				} else if(!validatePassword(psw1) && (psw1 != psw2) ){
		
					return false; 
				} else if(!validateEmail(email) && (psw1 != psw2) ){
		
					return false; 
				} else if(!validatePhone(num) && (psw1 != psw2) ){
		
					return false; 
				} else if(!validatePassword(psw1)) {
		
					return false;
				} else if(!validateEmail(email)) {
					
					return false;
				} else if(!validatePhone(num)) {
				
					return false;
				} else if(psw1 != psw2) {
		
					return false;
				} else if(!validateName(name) || !validateName(surname)) { 
	
					return false; 
				} else {
					return true;
				}
			
			}
			
			function validateName($name) {
				var nameReg = /^[A-Za-z]+$/;
				return nameReg.test($name);
			}
			
			function validatePhone($phone) {
				var phoneReg = /^\d{10}$/;
				return phoneReg.test($phone);
			}
			
			function validateEmail($email) {
				var emailReg = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;
				return emailReg.test($email);
			}
			
			function validatePassword($password) {
				var passwReg = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
				return passwReg.test( $password );
			}
		})		
	</script>
</body>
</html>