<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add a Recipe</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            padding: 2rem;
        }

        form {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            max-width: 800px;
            margin: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-top: 1.5rem;
            font-weight: bold;
        }

        input[type="text"],
        textarea,
        select {
            width: 100%;
            padding: 0.5rem;
            margin-top: 0.5rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        table th, table td {
            padding: 0.5rem;
            border: 1px solid #ccc;
            text-align: left;
        }

        .steps-container {
            margin-top: 1rem;
        }

        .step-row {
            margin-bottom: 0.5rem;
        }

        .step-input {
            width: 100%;
        }

        .add-row-btn {
            margin-top: 0.5rem;
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            background-color: #2ecc71;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .button-row {
            margin-top: 2rem;
            display: flex;
            justify-content: space-between;
        }

        .submit-btn, .back-btn {
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .submit-btn {
            background-color: #3498db;
            color: white;
        }

        .back-btn {
            background-color: #bbb;
            color: white;
        }
    </style>
    <script>
        function addIngredientRow() {
            const table = document.getElementById("ingredientTable");
            const row = table.insertRow(-1);
            row.innerHTML = `
                <td><input type="text" name="ingredientName" required></td>
                <td><input type="text" name="ingredientQty"></td>
            `;
        }

        function addStepRow() {
            const container = document.getElementById("stepsContainer");
            const row = document.createElement("div");
            row.className = "step-row";
            row.innerHTML = `<input type="text" name="steps" class="step-input" required>`;
            container.appendChild(row);
        }
    </script>
</head>
<body>
    <h1 style="text-align:center;">Add a New Recipe</h1>
    <form action="submitRecipe.jsp" method="post">
        <label>Recipe Name:</label>
        <input type="text" name="recipeName" required />

        <label>Ingredients:</label>
        <table id="ingredientTable">
            <tr>
                <th>Ingredient Name</th>
                <th>Quantity</th>
            </tr>
            <tr>
                <td><input type="text" name="ingredientName" required></td>
                <td><input type="text" name="ingredientQty"></td>
            </tr>
        </table>
        <button type="button" class="add-row-btn" onclick="addIngredientRow()">Add Ingredient</button>

        <label>Recipe Steps:</label>
        <div id="stepsContainer" class="steps-container">
            <div class="step-row">
                <input type="text" name="steps" class="step-input" required>
            </div>
        </div>
        <button type="button" class="add-row-btn" onclick="addStepRow()">Add Step</button>

        <label>Cooking Time (in minutes):</label>
        <input type="text" name="cookingTime" required />

        <label>Type of Cuisine:</label>
        <select name="cuisine" required>
            <option value="japanese">Japanese</option>
            <option value="american">American</option>
            <option value="mexican">Mexican</option>
            <option value="italian">Italian</option>
        </select>

        <label>Difficulty:</label>
        <select name="difficulty" required>
            <option value="easy">Easy</option>
            <option value="medium">Medium</option>
            <option value="hard">Hard</option>
        </select>

        <label>Tags:</label>
        <div>
            <input type="checkbox" name="tag" value="vegetarian" /> Vegetarian<br/>
            <input type="checkbox" name="tag" value="vegan" /> Vegan<br/>
            <input type="checkbox" name="tag" value="lactose free" /> Lactose Free<br/>
            <input type="checkbox" name="tag" value="healthy" /> Healthy<br/>
            <input type="checkbox" name="tag" value="allergies" /> Allergies<br/>
            <input type="checkbox" name="tag" value="gluten-free" /> Gluten-Free<br/>
        </div>

        <div class="button-row">
            <button type="button" class="back-btn" onclick="location.href='homepage.jsp'">Back to Homepage</button>
            <button type="submit" class="submit-btn">Submit Recipe</button>
        </div>
    </form>
</body>
</html>