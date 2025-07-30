import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/addReview")
public class ReviewServlet extends HttpServlet {

    //JDBC Connection Information
    String url    = "jdbc:mysql://localhost:3306/Dishbase?serverTimezone=UTC";
    String dbUser = "root";
    String dbPass = "CS157A_SJSU";

    //On submit
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        //Get the current user info
        HttpSession session = req.getSession(false);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("MySQL driver not found on classpath", e);
        }

        /*
        * OBTAINING AND VALIDATING USER INPUT
        */

        //Validate user is currently logged on before making a review
        if (session == null || session.getAttribute("username") == null) {
            //Redirect user to log in
            out.println("<a href='userLogin.jsp'>Please log in</a>");
            return;
        }

        //Obtain the user_id of currently logged in user
        Object userIdObj = session.getAttribute("userId");
        //Check if it is a valid value
        if (userIdObj == null) {
            throw new ServletException("userId not found");
        }

        //Obtain the user's review and rating and recipe_id
        String recipeData = req.getParameter("recipe_id");
        String reviewText = req.getParameter("review_text");
        String ratingData = req.getParameter("rating");
        int rating; //Using for input validation
        int recipe = Integer.parseInt(recipeData);

        //Allows for optional comments but converting to null
        if (reviewText != null) {
            reviewText = reviewText.trim();     //Removes leading and trailing whitespace
            if (reviewText.isEmpty()) {
                reviewText = null;
            }
        }

        //Alert user to select a rating if no input
        if (ratingData.isEmpty()) {
            req.setAttribute("error", "Please select a rating (1–10).");
            req.getRequestDispatcher("/addReview.jsp")
                    .forward(req, resp);
            return;
        }

        //Confirm the user inputted a valid rating
        try {
            rating = Integer.parseInt(ratingData);
            if (rating < 1 || rating > 10) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid rating value.");
            req.getRequestDispatcher("/addReview.jsp")
                    .forward(req, resp);
            return;
        }

        /*
        * STORE DATA INTO THE DATABASE
        */
        String sql = "INSERT INTO reviews (rating, review_text) VALUES (?, ?)";
        String commentSql = "INSERT INTO commentOn (recipe_id, review_id) VALUES (?, ?)";
        String writeSql = "INSERT INTO `write` (user_id, review_id) VALUES (?, ?)";


        try (
                //Open JDBC using try w/ resources to auto-close
                Connection conn = DriverManager.getConnection(url, dbUser, dbPass);
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                PreparedStatement psComment = conn.prepareStatement(commentSql);
                PreparedStatement psWrite = conn.prepareStatement(writeSql);
        ) {
            //Reviews table
            //Setting first ? to rating
            ps.setInt(1, rating);
            //Setting second ? to reviewText when comment exists
            if (reviewText != null) {
                ps.setString(2, reviewText);
            } else {
                //Setting second ? to null when comment is not inputted
                ps.setNull(2, java.sql.Types.VARCHAR);
            }

            //Insert into review table
            ps.executeUpdate();

            //CommentsOn Table
            //Populate recipe_Id column
            psComment.setInt(1, recipe);
            //Find current review_Id
            int reviewId;
            try(ResultSet keys = ps.getGeneratedKeys()){
                if (keys.next()) {
                    reviewId = keys.getInt(1);
                }
                else {
                    throw new ServletException("Failed to get generated keys");
                }
            }
            psComment.setInt(2, reviewId);

            //Insert into commentOn Table
            psComment.executeUpdate();

            //Write table
            int userId = (int) session.getAttribute("userId");
            //Populate the tuple
            psWrite.setInt(1, userId);
            psWrite.setInt(2, reviewId);
            //Insert into write table
            psWrite.executeUpdate();

        } catch (SQLException e) {
            throw new ServletException("Error saving review", e);
        }

        //Redirect the user to the viewReviews
        resp.sendRedirect(req.getContextPath() + "/viewReviews?recipe_id=" + recipe);
    }
}
