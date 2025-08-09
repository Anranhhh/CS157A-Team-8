<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, javax.sql.*" %>

<%
    String recipeIdStr = request.getParameter("recipeId");
    int recipeId = 0;
	// make sure that there is a recipe_id being returned from previous page
    if (recipeIdStr != null) {
        try {
            recipeId = Integer.parseInt(recipeIdStr);
        } catch (NumberFormatException e) {
            out.println("<h2>Invalid recipe ID</h2>");
            return;
        }
    } else {
        out.println("<h2>No recipe ID provided</h2>");
        return;
    }

    String recipeName = "";
    String difficulty = "";
    List<String> cuisines = new ArrayList<>();
    int cookingTime = 0;
    List<String> tags = new ArrayList<>();
    List<String[]> ingredients = new ArrayList<>();
    List<String> steps = new ArrayList<>();

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
 	// database login information
    String db = "Dishbase";
    String dbUser = "root";
    String dbPassword = "CS157A_SJSU";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, dbUser, dbPassword);

     	// get recipe title and cooking time
        ps = con.prepareStatement("SELECT title, cooking_time FROM recipes WHERE recipe_id = ?");
        ps.setInt(1, recipeId);
        rs = ps.executeQuery();
        if (rs.next()) {
            recipeName = rs.getString("title");
            cookingTime = rs.getInt("cooking_time");
        }
        rs.close();
        ps.close();

        // get cuisine tags
        ps = con.prepareStatement("SELECT t.name FROM tags t JOIN have h ON t.tag_id = h.tag_id WHERE h.recipe_id = ? AND t.category = 'cuisine'");
		ps.setInt(1, recipeId);
		rs = ps.executeQuery();
		while (rs.next()) {
		    cuisines.add(rs.getString("name"));
		}
        rs.close();
        ps.close();

        // get difficulty tag
        ps = con.prepareStatement("SELECT t.name FROM tags t JOIN have h ON t.tag_id = h.tag_id WHERE h.recipe_id = ? AND t.category = 'difficulty'");
        ps.setInt(1, recipeId);
        rs = ps.executeQuery();
        if (rs.next()) {
            difficulty = rs.getString("name");
        }
        rs.close();
        ps.close();


        // get dietary restriction tags
        ps = con.prepareStatement("SELECT t.name FROM tags t JOIN have h ON t.tag_id = h.tag_id WHERE h.recipe_id = ? AND t.category = 'restriction'");
        ps.setInt(1, recipeId);
        rs = ps.executeQuery();
        while (rs.next()) {
            tags.add(rs.getString("name"));
        }
        rs.close();
        ps.close();

        // get ingredients
        ps = con.prepareStatement("SELECT i.name, c.quantity FROM ingredients i JOIN contains c ON i.ingredient_id = c.ingredient_id WHERE c.recipe_id = ?");
        ps.setInt(1, recipeId);
        rs = ps.executeQuery();
        while (rs.next()) {
            ingredients.add(new String[]{rs.getString("name"), rs.getString("quantity")});
        }
        rs.close();
        ps.close();

        // get recipe steps
        ps = con.prepareStatement("SELECT description FROM recipeSteps WHERE recipe_id = ? ORDER BY step_number ASC");
        ps.setInt(1, recipeId);
        rs = ps.executeQuery();
        while (rs.next()) {
            steps.add(rs.getString("description"));
        }
        rs.close();
        ps.close();

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>Error loading recipe data</h3>");
        return;
    } finally {
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= recipeName %> - Recipe Information</title>
    <style>
		body {
		    font-family: Arial, sans-serif;
		    background-image: url("materials/icon_background.jpg");
		    background-size: cover;
		    background-position: center;
		    background-repeat: no-repeat;
		    background-attachment: fixed;
		    padding: 2rem;
		    min-height: 100vh;
		}
        .container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            max-width: 900px;
            margin: auto;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 0.5rem;
        }

        .sub-info, .tags {
            text-align: center;
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .tags span {
            background-color: #e2e2e2;
            color: #333;
            padding: 5px 10px;
            margin: 3px;
            display: inline-block;
            border-radius: 15px;
            font-size: 0.95rem;
        }

        h3 {
            margin-top: 1.5rem;
            border-bottom: 2px solid #ccc;
            padding-bottom: 0.3rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 0.5rem;
        }

        table th, table td {
            padding: 0.7rem;
            border: 1px solid #ccc;
            text-align: left;
        }

        .step-list {
            margin-top: 0.5rem;
        }

        .step {
            margin-bottom: 0.8rem;
            padding-left: 1rem;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }

        .button-group button {
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .back-btn { background-color: #3498db; color: white; }
        .review-btn { background-color: #3498db; color: white; }
        .view-btn { background-color: #3498db; color: white; }
        .save-btn { background-color: #3498db; color: white; }
        .home-btn { background-color: #3498db; color: white; }

        .button-group button:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
<div class="container">
    <h1><%= recipeName %></h1>

    <div class="sub-info">
        <strong>Cuisine:</strong>
		<%= String.join(", ", cuisines) %> |
        <strong>Difficulty:</strong> <%= difficulty %> |
        <strong>Cooking Time:</strong> <%= cookingTime %> minutes
    </div>

    <div class="tags">
        <% for (String tag : tags) { %>
            <span><%= tag %></span>
        <% } %>
    </div>

    <h3>Ingredients</h3>
    <table>
        <tr>
            <th>Ingredient</th>
            <th>Quantity</th>
        </tr>
        <% for (String[] ingredient : ingredients) { %>
            <tr>
                <td><%= ingredient[0] %></td>
                <td><%= ingredient[1] %></td>
            </tr>
        <% } %>
    </table>

    <h3>Steps</h3>
    <div class="step-list">
        <% for (int i = 0; i < steps.size(); i++) { %>
            <div class="step"><strong>Step <%= i + 1 %>:</strong> <%= steps.get(i) %></div>
        <% } %>
    </div>

    <div class="button-group">
        <button class="back-btn" onclick="history.back()">Back</button>
        <button class="review-btn" onclick="location.href='addReview.jsp?recipe_id=<%= recipeId %>'">Add Review</button>
        <button class="view-btn" onclick="location.href='viewReviews.jsp?recipe_id=<%= recipeId %>'">View Reviews</button>
        <button class="save-btn" onclick="location.href='saveRecipe.jsp?recipe_id=<%= recipeId %>'">Save Recipe</button>
        <button class="home-btn" onclick="location.href='homepage.jsp'">Homepage</button>
    </div>
</div>
</body>
</html>
