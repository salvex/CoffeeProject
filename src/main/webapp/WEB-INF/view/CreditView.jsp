<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<body>
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
		<div class="jumbotron" align="center">
			<form id="payment" novalidate>
				<div class="form-group">
					<label for="name" class="form-label">Name:</label><br>
					<input type="text" id="name" class="form-control w-25 name" required><br>
					<div class="invalid-feedback">Name not valid!</div>
				</div>
				<div class="form-group">
					<label for="cardnumber" class="form-label">Card Number:</label><br>
					<input type="text" id="cardnumber" class="form-control w-25 cardnumber" required><br>
					<div class="invalid-feedback">Your credit card is not valid!</div>
				</div>
				<div class="form-group">
					<label for="expiration" class="form-label">Expiration (mm/yy):</label><br>
					<input type="text" id="expiration" class="form-control w-25 expiration" required><br>
					<div class="invalid-feedback">Your expiration date is not valid!</div>
				</div>
				<div class="form-group">
					<label for="seccode" class="form-label">Security code</label><br>
					<input type="text" id="seccode" class="form-control w-25 seccode" required><br>
					<div class="invalid-feedback">Your security code is not valid!</div>
				</div>
				<div class="form-group">
					<label for="amount" class="form-label">Amount </label><br>
					<input type="text" id="amount" class="form-control w-25 amount" required><br>
					<div class="invalid-feedback">Your amount is not valid!</div>
				</div>
				<button type="submit" class="btn btn-primary">Submit</button> 
			</form>
		</div><br>
		<div align="center">
			<span id="result"></span>
		</div>
	 	<script>
	 		$(document).ready(function () {
	 			
	 			$("#name").keyup(function() {
					var name = $("#name").val();
					
					if(!validateName(name)) {
						$(".name").addClass('is-invalid');
					} else {
						$(".name").removeClass('is-invalid');
						$(".name").addClass('is-valid');
					}
				})
				
				$("#cardnumber").keyup(function() {
					var cardnumber = $("#cardnumber").val();
					
					if(!validateCreditCard(cardnumber)) {
						$(".cardnumber").addClass('is-invalid');
					} else {
						$(".cardnumber").removeClass('is-invalid');
						$(".cardnumber").addClass('is-valid');
					}
				})
				
				$("#expiration").keyup(function() {
					var expiration = $("#expiration").val();
					
					if(!validateExpirationDate(expiration)) {
						$(".expiration").addClass('is-invalid');
					} else {
						$(".expiration").removeClass('is-invalid');
						$(".expiration").addClass('is-valid');
					}
				})
				
				$("#seccode").keyup(function() {
					var seccode = $("#seccode").val();
					
					if(!validateSecurityCode(seccode)) {
						$(".seccode").addClass('is-invalid');
					} else {
						$(".seccode").removeClass('is-invalid');
						$(".seccode").addClass('is-valid');
					}
				})
				
				$("#amount").keyup(function() {
					var amount = $("#amount").val();
					
					if(!validateCreditAmount(amount)) {
						$(".amount").addClass('is-invalid');
					} else {
						$(".amount").removeClass('is-invalid');
						$(".amountOk").addClass('is-valid');
					}
				})
				
				
	 		
	 			$("#payment").submit(function(event) {
	 				
	 				event.preventDefault();
	 				
	 				
		 			
		 			if(validatePaymentForm()) {
		 				
		 				var creditData = {
		 						amount: $("#amount").val() 
		 				}
		 				
		 				$.ajax({
							type: 'POST', 
							url: './User/Credit',
							contentType: 'application/json',
							dataType: 'text',
							data: JSON.stringify(creditData),
							success: function (data,textSatus, jqXHR) {
								var res = JSON.parse(data);
								if(res.success == true)  {
									$('#result').css('color','green');
									$('#result').html(res.message);
								} else {
									$('#result').css('color','red');
									$('#result').html(res.message);
								}
							},
						}) 
		 			}
		 			
	 			})
	 			
	 			
	 			function validatePaymentForm() {
	 				
	 				var name = $("#name").val();
	 				var expDate = $("#expiration").val();
	 				var secCode = $("#seccode").val();
	 				var cardnum = $("#cardnumber").val();
	 				var amount = $("#amount").val();
	 				
	 				if(!validateCreditCard(cardnum) && !validateExpirationDate(expDate) && !validateSecurityCode(secCode) && !validateCreditAmount(amount) && !validateName(name)) {
	 					$("#namecheck").hide();
	 					$("#cardcheck").show();
			 			$("#expcheck").show();
			 			$("#seccheck").show();
			 			$("#amountcheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum) && !validateExpirationDate(expDate) && !validateSecurityCode(secCode) && !validateCreditAmount(amount)) {
	 					$("#cardcheck").show();
			 			$("#expcheck").show();
			 			$("#seccheck").show();
			 			$("#amountcheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum) && !validateExpirationDate(expDate) && !validateSecurityCode(secCode) && !validateName(name)) {
	 					$("#cardcheck").show();
			 			$("#expcheck").show();
			 			$("#seccheck").show();
			 			$("#namecheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum) && !validateExpirationDate(expDate) && !validateSecurityCode(secCode)) {
	 					$("#cardcheck").show();
			 			$("#expcheck").show();
			 			$("#seccheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum) && !validateExpirationDate(expDate) && !validateName(name)) {
	 					$("#cardcheck").show();
			 			$("#expcheck").show();
			 			$("#namecheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum) && !validateExpirationDate(expDate) && !validateCreditAmount(amount)) {
	 					$("#cardcheck").show();
			 			$("#expcheck").show();
			 			$("#amountcheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum) && !validateExpirationDate(expDate)) {
	 					$("#cardcheck").show();
			 			$("#expcheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum) && !validateSecurityCode(secCode)) {
	 					$("#cardcheck").show();
			 			$("#seccheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum) && !validateName(name)) {
	 					$("#cardcheck").show();
			 			$("#namecheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum) && !validateCreditAmount(amount)) {
	 					$("#cardcheck").show();
			 			$("#amountcheck").show();
			 			return false;
	 				} else if(!validateCreditCard(cardnum)) {
	 					$("#cardcheck").show();
	 					return false;
	 				} else if(!validateExpirationDate(expDate)) {
	 					$("#expcheck").show();
	 					return false;
	 				} else if(!validateSecurityCode(secCode)) {
	 					$("#seccheck").show();
	 					return false;
	 				} else if(!validateName(name)) {
	 					$("#namecheck").show();
	 					return false;
	 				} else if(!validateCreditAmount(amount)) {
	 					$("#amountcheck").show();
	 					return false;
	 				} else {
	 					return true;
	 				}
	
	 			}
	 			
	 			function validateCreditCard($creditcard) {
	 				var visaRegEx = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
	 				var mastercardRegEx = /^(?:5[1-5][0-9]{14})$/;
	 				if(visaRegEx.test($creditcard)) { 
	 					return true;
	 				} else if(mastercardRegEx.test($creditcard)) {
	 					return true;
	 				} else {
	 					return false;
	 				}
	 			}
	 			
	 			function validateExpirationDate($expdate) {
	 				var expRegEx = /^(0[1-9]|1[0-2])\/?([0-9]{2})$/;
	 				return expRegEx.test($expdate);
	 			}
	 			
	 			function validateSecurityCode($seccode) {
	 				var secRegEx = /^[0-9]{3}$/;
	 				return secRegEx.test($seccode);
	 			}
	 			
	 			function validateCreditAmount($credit) {
	 				var creditRegEx = /^[0-9]+$/;
	 				return creditRegEx.test($credit);
	 			}
	 			
	 			function validateName($name) {
					var nameReg = /^[A-Za-z]+$/;
					return nameReg.test($name);
				}
	 		})
	 	</script>
</body>
