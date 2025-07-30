<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String errorMessage = null;
    boolean submitted = "POST".equalsIgnoreCase(request.getMethod());

    if (submitted) {
        String url = "jdbc:mysql://localhost:3306/Dishbase?serverTimezone=UTC";
        String dbUser = "root";
        String dbPass = "CS157A_SJSU";

        if (session == null || session.getAttribute("username") == null) {
            errorMessage = "Please <a href='userLogin.jsp'>log in</a> before submitting a review.";
        } else {
            Object userIdObj = session.getAttribute("userId");
            if (userIdObj == null) {
                throw new ServletException("userId not found");
            }

            String recipeData = request.getParameter("recipe_id");
            String reviewText = request.getParameter("review_text");
            String ratingData = request.getParameter("rating");
            int rating;
            int recipe = Integer.parseInt(recipeData);

            if (reviewText != null) {
                reviewText = reviewText.trim();
                if (reviewText.isEmpty()) {
                    reviewText = null;
                }
            }

            if (ratingData == null || ratingData.isEmpty()) {
                errorMessage = "Please select a rating (1–10).";
            } else {
                try {
                    rating = Integer.parseInt(ratingData);
                    if (rating < 1 || rating > 10) {
                        throw new NumberFormatException();
                    }

                    Class.forName("com.mysql.cj.jdbc.Driver");

                    String sql = "INSERT INTO reviews (rating, review_text) VALUES (?, ?)";
                    String commentSql = "INSERT INTO commentOn (recipe_id, review_id) VALUES (?, ?)";
                    String writeSql = "INSERT INTO `write` (user_id, review_id) VALUES (?, ?)";

                    try (
                            Connection conn = DriverManager.getConnection(url, dbUser, dbPass);
                            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                            PreparedStatement psComment = conn.prepareStatement(commentSql);
                            PreparedStatement psWrite = conn.prepareStatement(writeSql);
                    ) {
                        ps.setInt(1, rating);
                        if (reviewText != null) {
                            ps.setString(2, reviewText);
                        } else {
                            ps.setNull(2, java.sql.Types.VARCHAR);
                        }

                        ps.executeUpdate();

                        int reviewId;
                        try (ResultSet keys = ps.getGeneratedKeys()) {
                            if (keys.next()) {
                                reviewId = keys.getInt(1);
                            } else {
                                throw new ServletException("Failed to get generated review ID.");
                            }
                        }

                        psComment.setInt(1, recipe);
                        psComment.setInt(2, reviewId);
                        psComment.executeUpdate();

                        int userId = (int) userIdObj;
                        psWrite.setInt(1, userId);
                        psWrite.setInt(2, reviewId);
                        psWrite.executeUpdate();

                        // Redirect after successful insert
                        response.sendRedirect("viewReviews.jsp?recipe_id=" + recipe);
                        return;

                    } catch (SQLException e) {
                        errorMessage = "Error saving review: " + e.getMessage();
                    }

                } catch (NumberFormatException e) {
                    errorMessage = "Invalid rating value.";
                } catch (ClassNotFoundException e) {
                    errorMessage = "JDBC Driver not found.";
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add a review</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            background-color: #cfdee8;
        }
        .review-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 80%;
            max-width: 450px;
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 0 10px 5px lightblue;
        }
        .rating-row {
            display: flex;
            align-items: center;
            width: 100%;
        }
        .rating-row button {
            margin-left: auto;
        }
        .save-btn {
            background: linear-gradient(135deg, #a8d5e2 0%, #8bbecf 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="review-card">
    <h1>Add a review</h1>

    <% if (errorMessage != null) { %>
    <div class="error"><%= errorMessage %></div>
    <% } %>

    <form method="post">
        <input type="hidden" name="recipe_id" value="<%= request.getParameter("recipe_id") %>" />

        <div>
            <label for="comment">Your review:</label><br>
            <textarea
                    id="comment"
                    name="review_text"
                    rows="10"
                    cols="60"
                    placeholder="Write your thoughts here…"
            ></textarea><br><br>
        </div>

        <div class="rating-row">
            <label for="rating">Recipe Rating:</label>
            <select id="rating" name="rating" required>
                <option value="">— select —</option>
                <% for (int i = 1; i <= 10; i++) { %>
                <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>
            <button type="submit" class="save-btn">Submit</button>
        </div>
    </form>
</div>
</body>
</html>