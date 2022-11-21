<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
<%
		response.addHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0"); 
		response.addHeader("Pragma", "no-cache"); 
		response.addDateHeader ("Expires", 0);
%>  
<meta charset="ISO-8859-1">
<title>Coffe Project</title>
<style>
	body {
	  /* fallback for old browsers */
	  background: #accbee;
	
	  /* Chrome 10-25, Safari 5.1-6 */
	  background: -webkit-linear-gradient(to right, rgba(172, 203, 238, 0.5), rgba(0, 231, 240, 0.5));
	
	  /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
	  background: linear-gradient(to right, rgba(172, 203, 238, 0.5), rgba(0, 231, 240, 0.5));
	  
	  margin-bottom: 190px;
	  
	  background: url(style/bg.jpg) no-repeat center center fixed; 
  	  -webkit-background-size: cover;
  	  -moz-background-size: cover;
      -o-background-size: cover;
      background-size: cover;
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
	  <h1 class="display-4">Welcome to Coffe Project!</h1>
	  <p class="lead">You can order your favorite beverage from here!</p>
	  <hr class="my-4">
	  <p>Please login or register to access to our services.</p>
	  <p class="lead">
	    <a class="btn btn-primary btn-lg" href="./Login" role="button">Login</a>
	    <a class="btn btn-primary btn-lg" href="./Registration" role="button">Register</a>
	  </p>
	</div>
	<jsp:include page="parts/footer.jsp"></jsp:include>
</body>
</html>