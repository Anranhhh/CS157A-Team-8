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
        }

        header {
            background-color: #3498db;
            color: white;
            padding: 1rem 2rem;
            text-align: center;
        }

        main {
            padding: 2rem;
            max-width: 1000px;
            margin: auto;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 2rem;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .button-column {
            flex: 1;
            min-width: 300px;
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
            margin-top: 2rem;
        }
    </style>
</head>
<body>

<header>
    <h1>Welcome to DishBase</h1>
    <p>Recipes tailored to you.</p>
</header>

<main>
    <h2>Please select a feature to get started.</h2>
    <div class="button-container">
        <!-- Left: User Login Section -->
        <div class="button-column">
            <div class="column-title">User Login</div>
            <button class="feature-button" onclick="location.href='createUser.jsp'">New User</button>
            <button class="feature-button" onclick="location.href='userLogin.jsp'">Existing User</button>
        </div>

        <!-- Right: Recipe Features Section -->
        <div class="button-column">
            <div class="column-title">Recipe Features</div>
            <button class="feature-button" onclick="location.href='addRecipe.jsp'">Add a Recipe</button>
            <button class="feature-button" onclick="location.href='browseRecipes.jsp'">Browse Recipes</button>
            <button class="feature-button" onclick="location.href='recommendations.jsp'">Recipe Recommendations</button>
            <button class="feature-button" onclick="location.href='mealPlanner.jsp'">Meal Planner</button>
        </div>
    </div>
</main>

<footer>
    Giovanni Hsieh, Jiaqiao Han, Sumi Yi — CS157A Team 8 Summer 2025
</footer>

</body>
</html>