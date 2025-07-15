<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    String recipeName = request.getParameter("recipeName");
    String cookingTime = request.getParameter("cookingTime");
    String cuisine = request.getParameter("cuisine");
    String difficulty = request.getParameter("difficulty");

    String[] ingredientNames = request.getParameterValues("ingredientName");
    String[] ingredientQtys = request.getParameterValues("ingredientQty");
    String[] steps = request.getParameterValues("steps");
    String[] selectedTags = request.getParameterValues("tag"); // 0 to many can be selected

    // need to get userID later
    int userId = 1;

    Connection conn = null;
    PreparedStatement ps = null; // using prepared statement because it makes it easier to keep track

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Dishbase", "root", "CS157A_SJSU");

        // insert data into recipe table
        String insertRecipeSQL = "INSERT INTO recipes (title, cooking_time) VALUES (?, ?)";
        ps = conn.prepareStatement(insertRecipeSQL, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, recipeName);
        ps.setInt(2, Integer.parseInt(cookingTime));
        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        int recipeId = -1;
        if (rs.next()) {
            recipeId = rs.getInt(1);
        }
        rs.close();
        ps.close();

        // insert data into upload relationship table
        String uploadSQL = "INSERT INTO upload (user_id, recipe_id) VALUES (?, ?)";
        ps = conn.prepareStatement(uploadSQL);
        ps.setInt(1, userId);
        ps.setInt(2, recipeId);
        ps.executeUpdate();
        ps.close();

        // insert data into ingredients table if they aren't in the database already
        for (int i = 0; i < ingredientNames.length; i++) {
            String ingredientName = ingredientNames[i].trim();
            String qty = ingredientQtys[i].trim();

            int ingredientId = -1;
            String checkIng = "SELECT ingredient_id FROM Ingredients WHERE name = ?";
            ps = conn.prepareStatement(checkIng);
            ps.setString(1, ingredientName);
            rs = ps.executeQuery();
            if (rs.next()) {
                ingredientId = rs.getInt(1);
            } else {
                rs.close();
                ps.close();
                String insertIng = "INSERT INTO Ingredients (name) VALUES (?)";
                ps = conn.prepareStatement(insertIng, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, ingredientName);
                ps.executeUpdate();
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    ingredientId = rs.getInt(1);
                }
            }
            rs.close();
            ps.close();

            // insert into contains relationship table
            String containsSQL = "INSERT INTO contains (recipe_id, ingredient_id, quantity, calories) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(containsSQL);
            ps.setInt(1, recipeId);
            ps.setInt(2, ingredientId);
            ps.setString(3, qty);
            ps.setInt(4, 50); // calculate calories later?
            ps.executeUpdate();
            ps.close();
        }

        // insert into recipe steps weak entity set table
        for (int i = 0; i < steps.length; i++) {
            String step = steps[i].trim();
            String stepSQL = "INSERT INTO recipeSteps (recipe_id, step_number, description) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(stepSQL);
            ps.setInt(1, recipeId);
            ps.setInt(2, i + 1); // need to add one bc steps start at 1
            ps.setString(3, step);
            ps.executeUpdate();
            ps.close();
        }

        // insert tags section into tags table, this is complicated bc have to check if tag exists first
        // cuisine and difficulty are easiest
        String[] specialTags = { cuisine, difficulty };
        String[] categories = { "Cuisine", "Difficulty" };

        for (int i = 0; i < specialTags.length; i++) {
            ps = conn.prepareStatement("SELECT tag_id FROM tags WHERE name = ? AND category = ?");
            ps.setString(1, specialTags[i]);
            ps.setString(2, categories[i]);
            rs = ps.executeQuery();
            if (rs.next()) {
                int tagId = rs.getInt(1);
                rs.close();
                ps.close();

                ps = conn.prepareStatement("INSERT INTO have (recipe_id, tag_id) VALUES (?, ?)");
                ps.setInt(1, recipeId);
                ps.setInt(2, tagId);
                ps.executeUpdate();
                ps.close();
            } else {
                rs.close();
                ps.close();
            }
        }

        // Link optional tags user has selected
        if (selectedTags != null) {
            for (String tag : selectedTags) {
                ps = conn.prepareStatement("SELECT tag_id FROM tags WHERE name = ?");
                ps.setString(1, tag);
                rs = ps.executeQuery();
                if (rs.next()) {
                    int tagId = rs.getInt(1);
                    rs.close();
                    ps.close();

                    ps = conn.prepareStatement("INSERT INTO have (recipe_id, tag_id) VALUES (?, ?)");
                    ps.setInt(1, recipeId);
                    ps.setInt(2, tagId);
                    ps.executeUpdate();
                    ps.close();
                } else {
                    rs.close();
                    ps.close();
                }
            }
        }

        out.println("<p>Recipe added successfully!</p>");
        out.println("<a href='homepage.jsp'>Back to homepage</a>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
