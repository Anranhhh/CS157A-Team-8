<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
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
    	background-attachment: fixed;
    	background-size: cover;
    	background-position: center;
    	background-repeat: no-repeat;   	
    }
    
    .container {
    	background-color: white;
    	border-radius: 0.8rem;
    	box-shadow: 0 0.9rem 1.8rem rgba(0,0,0, 0.9);
    	height: 500px;
    	max-width: 800px;
    	overflow: hidden;
    	position: relative;
    	width: 100%;
    }
    
    .container_form {
    	height: 100%;
    	position: absolute;
    	top: 0;
    	transition: all 0.6s ease-in-out;
    }
    
    .container_login {
    	left: 0;
    	width: 50%;
    	z-index: 2;
    }
    
    .container.right-panel-active .container_login {
    	transform: translateX(100%);
    }
    
    .container_signup {
    	left: 0;
    	opcity: 0;
    	width: 50%;
    	z-index: 1;
    }
    
    .container.right-panel-active .container_signup {
    	animation: show 0.6s;
    	opacity: 1;
    	transform: translateX(100%);
    	z-index: 5;
    }
    
    .container_overlay {
    	height: 100%;
    	left: 50%;
    	overflow: hidden;
    	position: absolute;
    	top: 0;
    	transition: transform 0.6s ease-in-out;
    	width: 50%;
    	z-index: 100;
    }
    
    .container.right-panel-active .container_overlay {
    	transform: translateX(-100%);
    } 
    
    .overlay {
    	background-color: var(--lightblue);
    	background: url("materials/table2.jpg");
    	background-attachment: fixed;
    	background-position: center;
    	background-repeat: no-repeat;
    	background-size: cover;
    	height: 100%;
    	left: 0;
    	position: absolute;
    	transform: translateX(0);
    	transition: transform 0.6s ease-in-out;
    	width: 200%;
    	z-index: 1;
    }
    
    .overlay_panel {
    	align-items: center;
    	display: flex;
    	flex-direction: column;
    	height: 100%;
    	justify-content: center;
    	position: absolute;
    	text-align: center;
    	top: 0;
    	transform: translateX(0);
    	transition: transform 0.6s ease-in-out;
    	width: 50%;
    }
    
    .overlay-left {
    	transform: translateX(-20%);
    }
    
    .container.right-panel-active .overlay-left {
		transform: translateX(0);
		
		z-index: 5;
    	opacity: 1;
    } 
    
    .overlay-right {
    	right: 50%;
    	transform: translateX(0);
    }
    
    .container.right-panel-active .overlay-right {
    	transform: translateX(20%);
    	
    	z-index: 1;
    	opacity: 0;
    }
    
    /* Show left panel when not active */
	.container:not(.right-panel-active) .overlay-left {
    	z-index: 1;
    	opacity: 0;
	}

	.container:not(.right-panel-active) .overlay-right {
    	z-index: 100;
    	opacity: 1;
	}
    
    .button {
    	background: linear-gradient(to right, rgb(225, 238, 195), rgb(240, 80, 83));
    	border-radius: 20px;
    	border: 0;
    	cursor: pointer;
    	color: white;
    	font-family: "Times New Roman", Times, serif;
    	font-size: 1.2rem;
    	font-weight: bold;
    	letter-spacing: 0.05rem;
    	padding: 0.8rem 2rem;
    	transition: transform 80ms ease-in;
    }
    
    .button:hover {
    	background: linear-gradient(to right, rgb(101, 78, 163), rgb(234, 175, 200));
    }
    
    .form > .button {
    	margin-top: 1.5rem;
    }
    
    .button:active {
    	transform: scale(0.95);
    }
    
    .button:focus {
    	outline: none;
    }
    
    .form {
    	background: linear-gradient(to right, rgb(170, 75, 107), rgb(107, 107, 131), rgb(59, 141, 153));
    	display: flex;
    	align-items: center;
    	justify-content: center;
    	flex-direction: column;
    	padding: 0 2rem;
    	height: 100%;
    	text-align: center;
    	color: white;
    }
    
    .input {
    	background-color: #fff;
    	border: none;
    	padding: 0.9rem 0.9rem;
    	margin: 0.5rem 0;
    	width: 70%;
    }
    
    /*@keyframes show{
    	0%,
    	49.99%{
    		opacity: 0;
    		z-index: 1;
    	}
    	
    	50%,
    	100%{
    		opacity: 1;
    		z-index: 5;
    	}
    }*/
    
    </style>
</head>

<body>
	<div class="container right-panel-active">
		<div class="container_form container_login">
		<form action="userLogin.jsp" method="post" class="form" id="loginForm">
			<h2 class="form_title">Log In</h2>
			<input type="text" placeholder="username" name="username" class="input"><br>
			<input type="password" placeholder="password" name="pwd" class="input"><br>
			<button type="submit" class="button">Log In Now</button>
		</form>
		</div>
		
		
		<div class="container_form container_signup">
		<form action="userSignup.jsp" method="post" class="form" id="signupForm">
			<h2 class="form_title">Register</h2>
			<input type="text" placeholder="username" name="username" class="input"><br>
			<input type="password" placeholder="password" name="pwd" class="input"><br>
			<input type="text" placeholder="email" name="email" class="input"><br>
			<button type="submit" value="Login" class="button">Sign Up Now</button>
		</form>
		</div>
		
		<div class="container_overlay">
			<div class="overlay">
				<div class="overlay_panel overlay-right">
					<button class="button" id="signup">Don't have an account?<br>Click to Register</button>
				</div>
				
				<div class="overlay_panel overlay-left">
					<button class="button" id="login">Already have an account?<br>Click to Log In</button>
				</div>
			</div>
		</div>
	
	</div>
	
	<script>
	
	const loginBtn = document.getElementById("login");
	const signupBtn = document.getElementById("signup");
	const loginform = document.getElementById("loginForm");
	const signupform = document.getElementById("signupForm");
	const container = document.querySelector(".container");
	
	loginBtn.addEventListener("click", ()=>{
		container.classList.remove("right-panel-active")
	})
	
	signupBtn.addEventListener("click", ()=>{
		container.classList.add("right-panel-active")
	})
	
	</script>
	

</body>
</html>
