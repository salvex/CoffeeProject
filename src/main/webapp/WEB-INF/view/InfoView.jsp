<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<body>

	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<div class='jumbotron' align='center'>
		<form id='form2' novalidate>
			<div class="form-group">
				<label for="name" class="form-label">Name:</label><br>
				<input type="text" id="name" class="form-control w-25 name" placeholder="${user.name}"><br>
			</div>
			<div class="form-group">
				<label for="surname" class="form-label">Surname:</label><br>
				<input type="text" id="surname" class="form-control w-25 surname" placeholder="${user.surname}"><br>
				<h5 id='namecheck' style="color: red;">Your name or surname is not valid!</h5>
			</div>
			<div class="form-group">
				<label for="email" class="form-label">Email:</label><br>
				<input type="email" id="email" class="form-control w-25 email" placeholder="${user.email}"><br>
				<h5 id='emailcheck' style="color: red;">You must enter a valid email!</h5>
			</div>
			<div class="form-group" class="form-label">
				<label for="numph">Number Phone:</label><br>
				<input type="text" id="numph" class="form-control w-25 numph" placeholder="${user.phone}"><br>
				<h5 id='numcheck' style="color: red;">You must enter a valid number phone!</h5>
			</div>
			<div class="form-group" class="form-label">
				<label for="credit">Credit amount:</label><br>
				<input type="text" id="credit" class="form-control w-25 credit"  placeholder="${user.wallet}"><br>
			</div>
			<div id='errorupdate'  style="color: red;"></div>
		</form>
	</div>
	<script>
	$(document).ready(function () {
		
		$("#emailcheck").hide();
		$("#paswvalid").hide();
		$("#paswcheck").hide();
		$("#numcheck").hide();
		$("#namecheck").hide();
		
		$("#name").prop( "disabled", true );
		$("#surname ").prop( "disabled", true );
		$("#email").prop( "disabled", true );
		$("#numph").prop( "disabled", true );
		$("#credit").prop( "disabled", true );
		$("#psw1").prop( "disabled", true );
		$("#psw2").prop( "disabled", true );
		
		
		//Validazione form
		function validateUserForm() {
		
			var email = $("#email").val();
			var psw1 = $("#psw1").val();
			var psw2 = $("#psw2").val();
			var num = $("#numph").val();
			var name = $("#name").val();
			var surname = $("#surname").val();
			
			if(!validateEmail(email) && !validatePassword(psw1) && !validatePhone(num) && (psw1 != psw2)) {
				$("#emailcheck").show();
				$("#paswcheck").show();
				$("#numcheck").show();
				$("#paswcheck").show();
				return false;
			} else if(!validateEmail(email) && !validatePassword(psw1) && (psw1 != psw2) ) {
				$("#emailcheck").show();
				$("#paswvalid").show();
				$("#paswcheck").show();
				return false;
			} else if(!validateEmail(email) && !validatePhone(num) && (psw1 != psw2) ) {
				$("#emailcheck").show();
				$("#numcheck").show();
				$("#paswcheck").show();
				return false; 
			} else if(!validatePassword(psw1) && !validatePhone(num) && (psw1 != psw2)){
				$("#paswvalid").show();
				$("#numcheck").show();
				$("#paswcheck").show();
				return false; 
			} else if(!validateEmail(email) && !validatePassword(psw1) ) {
				$("#emailcheck").show();
				$("#paswvalid").show();
				return false;
			} else if(!validateEmail(email) && !validatePhone(num) ) {
				$("#emailcheck").show();
				$("#numcheck").show();
				return false; 
			} else if(!validatePassword(psw1) && !validatePhone(num) ){
				$("#paswvalid").show();
				$("#numcheck").show();
				return false; 
			} else if(!validatePassword(psw1) && (psw1 != psw2) ){
				$("#paswvalid").show();
				$("#paswcheck").show();
				return false; 
			} else if(!validateEmail(email) && (psw1 != psw2) ){
				$("#emailcheck").show();
				$("#paswcheck").show();
				return false; 
			} else if(!validatePhone(num) && (psw1 != psw2) ){
				$("#numcheck").show();
				$("#paswcheck").show();
				return false; 
			} else if(!validatePassword(psw1)) {
				$("#paswvalid").show();
				return false;
			} else if(!validateEmail(email)) {
				$("#emailcheck").show();
				return false;
			} else if(!validatePhone(num)) {
				$("#numcheck").show();
				return false;
			} else if(psw1 != psw2) {
				$("#paswcheck").show();
				return false;
			} else if(!validateName(name) || !validateName(surname)) { 
				$("#namecheck").show();
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
			var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
			return emailReg.test( $email );
		}
		
		function validatePassword($password) {
			var passwReg = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;
			return passwReg.test( $password );
		}
		
	})
	</script>
</body>
