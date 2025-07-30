<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    // Get the recipe ID from the request
    String recipeIdParam = request.getParameter("recipe_id");
    int recipeId = -1;
    String recipeName = "Unknown";
    List<Map<String, Object>> reviews = new ArrayList<>();

    if (recipeIdParam != null) {
        try {
            recipeId = Integer.parseInt(recipeIdParam);

            // Database credentials
            String DATABASE = "jdbc:mysql://localhost:3306/Dishbase?serverTimezone=UTC";
            String DB_USER = "root";
            String DB_PASSWORD = "CS157A_SJSU";

            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DATABASE, DB_USER, DB_PASSWORD)) {
                // Get recipe name
                String queryName = "SELECT title FROM recipes WHERE recipe_id = ?";
                try (PreparedStatement ps = con.prepareStatement(queryName)) {
                    ps.setInt(1, recipeId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            recipeName = rs.getString("title");
                        }
                    }
                }

                // Get reviews
                String queryReview = "SELECT c.recipe_id, r.review_id, u.username, r.review_text, r.rating " +
                        "FROM commentOn AS c " +
                        "JOIN reviews AS r USING (review_id) " +
                        "JOIN `write` AS w USING (review_id) " +
                        "JOIN users AS u USING (user_id) " +
                        "WHERE c.recipe_id = ? " +
                        "ORDER BY r.review_id DESC";

                try (PreparedStatement psReview = con.prepareStatement(queryReview)) {
                    psReview.setInt(1, recipeId);
                    try (ResultSet rsReview = psReview.executeQuery()) {
                        while (rsReview.next()) {
                            Map<String, Object> review = new HashMap<>();
                            review.put("username", rsReview.getString("username"));
                            review.put("text", rsReview.getString("review_text"));
                            review.put("rating", rsReview.getInt("rating"));
                            reviews.add(review);
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
<html>
<head>
    <title><%= recipeName %> – Reviews</title>
</head>
<body>
<h1><%= recipeName %> – Reviews</h1>

<%
    if (reviews == null || reviews.isEmpty()) {
%>
<p>No reviews yet. Be the first to
    <a href="addReview.jsp?recipe_id=<%= recipeId %>">add one</a>!
</p>
<%
} else {
    for (Map<String, Object> rev : reviews) {
        String user = (String) rev.get("username");
        int rating = (Integer) rev.get("rating");
        String text = (String) rev.get("text");
%>
<div class="review">
    <strong><%= user %></strong> rated it <%= rating %>/10
    <p><%= text %></p>
</div>
<%
        }
    }
%>

<br>
<form action="homepage.jsp">
    <button type="submit">Home</button>
</form>
</body>
</html>