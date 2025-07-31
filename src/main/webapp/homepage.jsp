<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>DishBase - Homepage</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
    		flex-direction: column;
    		min-height: 100vh;
        }

        header {
            color: white;
            padding: 1rem 2rem;
            text-align: center;
            height: 100px;            
        }
        
        header::before {
        	content: "";
    		position: absolute;
    		top: 0; left: 0;
    		width: 100%;
    		height: 100%;
    		background-image: url("materials/HMPGbackground.jpg");
    		background-size: cover;
    		background-position: center;
    		opacity: 0.8;
    		z-index: -1;
        }

        main {
            padding: 2rem;
            max-width: 1500px;
            margin: auto;
            background-color: rgba(255,255,255,0.9);
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            flex: 1;
        }

        h2 {
            text-align: center;
            margin-bottom: 2rem;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .button-column {
            flex: 1;
            min-width: 300px;
            padding-left: 60px;
            padding-right: 60px;
        }

        .column-title {
            font-weight: bold;
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .feature-button {
            display: block;
            width: 100%;
            margin: 0.75rem 0;
            padding: 1rem;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .feature-button:hover {
            background-color: #2c80b4;
        }

        footer {
            text-align: center;
            padding: 1rem;
            background: #eee;
            font-size: 0.9rem;
            position: buttom;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
	<%
	    // get username to display
	    String username = (String) session.getAttribute("username");
	%>
<header>
    <h1>Welcome to DishBase</h1>
    <p>Recipes tailored to you.</p>
</header>

<main>
    <h2>Please select a feature to get started.</h2>
    <div class="button-container">
        <div class="button-column">
            <div class="column-title">Currently Logged in as: <%= username %></div>
            <button class="feature-button" onclick="location.href='addRecipe.jsp'">Add a Recipe</button>
            <button class="feature-button" onclick="location.href='browseRecipes.jsp'">Browse Recipes</button>
            <button class="feature-button" onclick="location.href='mealPlanner.jsp'">Meal Planner</button>
 	    <button class="feature-button" onclick="location.href='userLogin.jsp'">Login</button>
        </div>
    </div>
</main>

<footer>
    Giovanni Hsieh, Jiaqiao Han, Sumi Yi — CS157A Team 8 Summer 2025
</footer>

</body>
</html>
