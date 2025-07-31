<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
<%!
    //Constants
    private static final double MATCH_PERCENTAGE = 0.5;     //Set at 50%
    private static final String url = "jdbc:mysql://localhost:3306/Dishbase?serverTimezone=UTC";
    private static final String usr = "root";
    private static final String pw = "CS157A_SJSU";
%>
<%
    //Obtain user selections
    String[] pantryIds = request.getParameterValues("pantry");
    //Amount of ingredients they selected
    int userCount = pantryIds.length;
    //Setting the minimum number of matched ingredients
    int minMatch = (int)Math.ceil(pantryIds.length * MATCH_PERCENTAGE);
    //Only exception is when there is 1 ingredient selected
    if(userCount == 1) {
        minMatch = 1;
    }

    //Build the IN-clause
    String inClause = "(" + String.join(",", pantryIds) + ")";

    //Connect to database
    Class.forName("com.mysql.cj.jdbc.Driver");
    //Store the matched recipes
    List<Map<String,Object>> recipes = new ArrayList<>();

    //Setting up SQL statement
    String sql =
            "SELECT r.recipe_id, r.title, COUNT(*) AS matched_count " +
                    "FROM recipes r " +
                    "JOIN contains c ON r.recipe_id = c.recipe_id " +
                    "WHERE c.ingredient_id IN " + inClause + " " +
                    "GROUP BY r.recipe_id, r.title " +
                    "HAVING matched_count >= ? " +
                    "ORDER BY matched_count DESC";

    //Executing query
    try(Connection conn = DriverManager.getConnection(url, usr, pw);
        PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, minMatch);

        try (ResultSet rs = ps.executeQuery()) {
            //Add the recipes to the list
            while (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("id", rs.getInt("recipe_id"));
                m.put("title", rs.getString("title"));
                m.put("match", rs.getInt("matched_count"));
                recipes.add(m);
            }
        }
    }
%>
<html>
<head>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <title>Recipe Recommendations</title>
    <style>
        body {
            display: flex;
            align-items: flex-start;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            padding-top: 2rem;
            background-color: #d3e2ec;
        }

        .recc-card {
            max-height: 90vh;
            overflow-y: auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(173,216,230,0.6);
            padding: 2rem;
            width: 90%;
            max-width: 1000px;
            box-sizing: border-box;
            text-align: center;
        }
        /* Home button in top right */
        .home-btn {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: linear-gradient(135deg, #a8d5e2, #8bbecf);
            color: white;
            border: none;
            border-radius: 20px;
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .home-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(0,0,0,0.15);
        }
    </style>
</head>
<body>

<!-- Home Button -->
<button class="home-btn" onclick="location.href='homepage.jsp'">
    Home
</button>
<%
    if (recipes.isEmpty()) {
%>
<p>No matches—try selecting more ingredients.</p>
<%
} else {
%>

<div class="recc-card">
    <h1>Recommended Recipes</h1>
    <%
    for (Map<String,Object> rec : recipes) {
%>
    <a href="viewRecipe.jsp?recipeId=<%=rec.get("id")%>">
        <%= rec.get("title") %>
    </a>
    &nbsp;(<%= rec.get("match") %> of <%= userCount %>) <br>
<%
        }
    }
%>
</div>
</body>
</html>
