<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>SignUp/LogIn</title>
    <style>
    
    body {
    	align-items: center;
    	display:grid;
    	height: 100vh;
    	place-items: center;
    	background-image: url("materials/signPage.jpg");
    	background-size: cover;
    	background-position: center;
    	
    }
    
    .container {
    	background-color: white;
    	border-radius: 0.8rem;
    	box-shadow: 0 0.5rem 1.8rem rgba(0,0,0, 0.9);
    	height: 500px;
    	width: 800px;
    	overflow: hidden;
    	position: relative;
    }
    
    .container_login {
    	left: 0;
    	width: 50%;
    	z-index: 2;
    }
    
    .button {
    	background-color: white;
    }
    
    .button:hover {
    	background-color: #7FB5CD;
    }
        
        
    </style>
</head>
<body>
	<div class="container right-panel-active">
		<div class="container_form container_login">
		<form action="LoginServlet" method="post" class="form" id="loginForm">
			<h2 class="form_title">Log In</h2>
			<input type="text" placeholder="username" name="username" class="input"><br>
			<input type="text" placeholder="password" name="pwd" class="input"><br>
			<button type="submit" class="button">Log In Now</button>
		</form>
		</div>
		
		
		<div class="container_form container_signup">
		<form action="#" class="form" id="signupForm">
			<h2 class="form_title">Register</h2>
			<input type="text" placeholder="username" class="input"><br>
			<input type="password" placeholder="password" class="input"><br>
			<input type="text" placeholder="email" class="input"><br>
			<button type="submit" value="Login" class="button">Sign Up Now</button>
		</form>
		</div>
		
		<div class="container_overlay">
			<div class="overlay">
				<div class="overlay_panel overlay-right">
					<p>Don't have an account?</p>
					<a href="createUser.jsp">Register</a>
				</div>
				
				<div class="overlay_panel overlay-left">
					<p>Already have an account?</p>
					<a href="createUser.jsp">Log In</a>
				</div>
			</div>
		</div>
	
	</div>

</body>
</html>
