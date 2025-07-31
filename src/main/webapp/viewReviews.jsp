<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    // Grab recipe information
    String recipeIdParam = request.getParameter("recipe_id");
    int recipeId = -1;
    String recipeName = "Unknown";
    //Storing the reviews
    List<Map<String, Object>> reviews = new ArrayList<>();

    //Validate recipeId
    if (recipeIdParam != null) {
        try {
            recipeId = Integer.parseInt(recipeIdParam);
            //DATABASE INFORMATION
            String DATABASE = "jdbc:mysql://localhost:3306/Dishbase?serverTimezone=UTC";
            String DB_USER = "root";
            String DB_PASSWORD = "CS157A_SJSU";
            Class.forName("com.mysql.cj.jdbc.Driver");

            //Find the recipe name for the corresponding recipeId
            try (Connection con = DriverManager.getConnection(DATABASE, DB_USER, DB_PASSWORD)) {
                String qn = "SELECT title FROM recipes WHERE recipe_id = ?";
                try (PreparedStatement ps = con.prepareStatement(qn)) {
                    ps.setInt(1, recipeId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) recipeName = rs.getString("title");
                    }
                }

                //Setting up the table for the query
                String qr =
                        "SELECT u.username, r.review_text, r.rating " +
                                "FROM commentOn c " +
                                "JOIN reviews r USING (review_id) " +
                                "JOIN `writes` w USING (review_id) " +
                                "JOIN users u USING (user_id) " +
                                "WHERE c.recipe_id = ? " +
                                "ORDER BY r.review_id DESC";

                //Grab all the reviews for that recipeId
                try (PreparedStatement ps = con.prepareStatement(qr)) {
                    ps.setInt(1, recipeId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Map<String,Object> m = new HashMap<>();
                            m.put("username", rs.getString("username"));
                            m.put("text",     rs.getString("review_text"));
                            m.put("rating",   rs.getInt("rating"));
                            reviews.add(m);
                        }
                    }
                }
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error loading reviews: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p style='color:red;'>No recipe ID specified.</p>");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= recipeName %> – Reviews</title>

    <!-- Font from Google -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            align-items: flex-start;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            padding-top: 2rem;
            background-color: #d3e2ec;
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

        .reviews-card {
            max-height: 90vh;
            overflow-y: auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(173,216,230,0.6);
            padding: 2rem;
            width: 90%;
            max-width: 1000px;
            box-sizing: border-box;
        }
        .reviews-card h1 {
            margin: 0 0 1.5rem;
            font-size: 2rem;
            color: #1f2235;
            text-align: center;
        }

        .review-item {
            background: #f9fcff;
            border: 1px solid #e0f2fa;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
        }
        .review-item:last-child {
            margin-bottom: 0;
        }

        .review-header {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
        }
        .review-header .username {
            font-weight: 600;
            font-size: 1.1rem;
            color: #1f2235;
        }
        .review-header .rating-pill {
            margin-left: auto;
            background: #a8d5e2;
            color: #fff;
            padding: 0.3rem 0.8rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.9rem;
            white-space: nowrap;
        }

        .review-text {
            margin: 0;
            line-height: 1.5;
            color: #333;
            white-space: pre-wrap;
            word-break: break-word;
        }

        .no-reviews {
            text-align: center;
            color: #555;
            font-size: 1rem;
        }
        .no-reviews a {
            color: #1f2235;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<!-- Home Button -->
<button class="home-btn" onclick="location.href='homepage.jsp'">
    Home
</button>

<!-- White review box-->
<div class="reviews-card">
    <h1> <%= recipeName %> – Reviews</h1>

    <%

        if (reviews.isEmpty()) {
    %>
    <p class="no-reviews">
        No reviews yet. Be the first to
        <a href="addReview.jsp?recipe_id=<%=recipeId%>">add one</a>!
    </p>
    <%
    } else {
        for (Map<String,Object> rev : reviews) {
            String user   = (String) rev.get("username");
            int    rating = (Integer) rev.get("rating");
            String text   = (String) rev.get("text");
    %>
    <div class="review-item">
        <div class="review-header">
            <span class="username"><%= user %></span>
            <span class="rating-pill"><%= rating %>/10</span>
        </div>
        <p class="review-text"><%= text %></p>
    </div>
    <%
            }
        }
    %>
</div>
</body>
</html>
