<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<script type="text/javascript" src='jquery-3.6.0.min.js'></script>
	<title>User Panel</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" rel="stylesheet" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
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
	    
	    .navbar .navbar-nav .nav-link {
		  	color: #000000;
		    font-size: 1.1em;
		}
		.navbar .navbar-nav .nav-link:hover {
		    color: #808080;
		}
		.navbar {
		    border-bottom: 5px solid #515354;
		}
 	</style>
</head>
<body>
	
	<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #97EDEF">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="#">
	    	<span class="navbar-text">
	      	 Welcome! ${user.name}
	      </span>
	      <img src="https://i.postimg.cc/N0S3Mzxj/icons8-coffee-32.png">
	    </a>
	     <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapse" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    		<span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="navbar-collapse collapse" id="collapse">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link" href="#" id="infoBox">Info</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#" id="creditBox">Credit</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#" id="connectBox">Connect</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href='./Logout'>Logout</a>
	        </li>
	      </ul>
	    </div>
	  </div>
	</nav>
	 <!--  <nav>
	 <div align="center"> Welcome! ${user.name}</div>
		<a href='./Logout'>Logout</a>
		<a href="#" id="infoBox">Info</a>
		<a href="#" id="creditBox">Credit</a>
		<a href="#" id="connectBox">Connect</a>
	</nav>-->
	<div id="container"></div>
	<jsp:include page="/parts/footer.jsp"></jsp:include>
	<script>
		$(document).ready(function () {
			$("#infoBox").on("click", function (){
				$.ajax({
					type: 'GET',
					url: './User/Info',
					success: function(res) {
						$('#container').html(res);
					}
				})
			})
			
			$("#creditBox").on("click", function (){
				$.ajax({
					type: 'GET',
					url: './User/Credit',
					success: function(res) {
						$('#container').html(res);
					}
				})
			})
			
			$("#connectBox").on("click", function (){
				$.ajax({
					type: 'GET',
					url: './User/Connect',
					success: function(res) {
						$('#container').html(res);
					}
				})
			})	
		})
	</script>
</body>
</html>