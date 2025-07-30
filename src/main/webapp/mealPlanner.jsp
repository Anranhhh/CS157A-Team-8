<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
	// Database information
	String db = "Dishbase";
	String dbUser = "root";
	String dbPassword = "CS157A_SJSU";
    // Check if there is a user logged in
    Integer userId = (Integer) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");

    if (userId == null || username == null) {
%>
    <html>
    <head>
        <title>Login Required</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                margin-top: 100px;
            }
            h1 {
                color: red;
            }
            button {
                margin-top: 30px;
                padding: 10px 20px;
                font-size: 16px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <h1>Please log in to access the Meal Planner</h1>
        <form action="userLogin.jsp">
            <button type="submit">Go to Login</button>
        </form>
        <form action="homepage.jsp" style="margin-top: 50px;">
            <button type="submit">Home</button>
        </form>
    </body>
    </html>
<%
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Meal Planner</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 40px;
        }
        h1, h2 {
            margin: 10px 0;
        }
        form {
            margin-bottom: 30px;
            display: inline-block;
            text-align: left;
        }
        input[type="submit"], .button-link, .home-button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .error {
            color: red;
        }
        table {
            margin: 0 auto;
            width: 50%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .footer {
            margin-top: 60px;
        }
    </style>
</head>
<body>

<h1>Welcome, <%= username %>!</h1>
<h2>Meal Planner</h2>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    List<Integer> selectedRecipeIds = new ArrayList<>();
    boolean hasSavedRecipes = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, dbUser, dbPassword);

        // Display saved recipes as checkboxes
        ps = con.prepareStatement("SELECT r.recipe_id, r.title FROM save s JOIN recipes r ON s.recipe_id = r.recipe_id WHERE s.user_id = ?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        StringBuilder formBuilder = new StringBuilder();
        formBuilder.append("<form method='post' action='mealPlanner.jsp'>");
        formBuilder.append("<h3>Select Saved Recipes:</h3>");

        while (rs.next()) {
            hasSavedRecipes = true;
            int recipeId = rs.getInt("recipe_id");
            String title = rs.getString("title");
            formBuilder.append("<input type='checkbox' name='recipeIds' value='" + recipeId + "'> " + title + "<br>");
        }

        if (hasSavedRecipes) {
            formBuilder.append("<br><input type='submit' value='Generate Shopping List'>");
            formBuilder.append("</form>");
            out.println(formBuilder.toString());
        } else {
            out.println("<p>You haven't saved any recipes yet. Please save recipes through the recipe browse.</p>");
            out.println("<a href='browseRecipes.jsp' class='button-link'>Browse Recipes</a>");
        }

        rs.close();
        ps.close();

        // Handle selected recipe IDs from POST
        String[] selected = request.getParameterValues("recipeIds");
        if (selected != null) {
            for (String id : selected) {
                try {
                    selectedRecipeIds.add(Integer.parseInt(id));
                } catch (NumberFormatException ignored) {}
            }
        }

        if (!selectedRecipeIds.isEmpty()) {
            // Build dynamic IN clause
            String placeholders = String.join(",", Collections.nCopies(selectedRecipeIds.size(), "?"));
            String query = "SELECT DISTINCT i.name " +
                           "FROM contains c " +
                           "JOIN ingredients i ON c.ingredient_id = i.ingredient_id " +
                           "WHERE c.recipe_id IN (" + placeholders + ") " +
                           "ORDER BY i.name";

            ps = con.prepareStatement(query);
            for (int i = 0; i < selectedRecipeIds.size(); i++) {
                ps.setInt(i + 1, selectedRecipeIds.get(i));
            }

            rs = ps.executeQuery();

            out.println("<h3>Shopping List</h3>");
            out.println("<table>");
            out.println("<tr><th>Ingredient</th></tr>");
            while (rs.next()) {
                String ingredient = rs.getString("name");
                out.println("<tr><td>" + ingredient + "</td></tr>");
            }
            out.println("</table>");
        }

    } catch (Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (ps != null) try { ps.close(); } catch (Exception ignored) {}
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>

<!-- Home Button -->
<div class="footer">
    <form action="homepage.jsp">
        <input type="submit" class="home-button" value="Return to Homepage">
    </form>
</div>

</body>
</html>
