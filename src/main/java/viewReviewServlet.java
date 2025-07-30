import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.xml.transform.Result;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/viewReviews")
public class viewReviewServlet extends HttpServlet {
    //Database information
    private static final String DATABASE = "jdbc:mysql://localhost:3306/Dishbase?serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "CS157A_SJSU";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Storing the reviews
        List<Map<String,Object>> reviews = new ArrayList<>();

        //Retrieve the recipeId
        String recipeIdparam = req.getParameter("recipe_id");
        int recipeId;

        //Validate the recipeId
        try{
            recipeId = Integer.parseInt(recipeIdparam);
        }catch(NumberFormatException e){
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid recipeId");
            return;
        }

        //Setting the query up
        String recipeName = "Unknown";
        String queryName = "SELECT title FROM recipes WHERE recipe_id = ?";
        String queryReview = "SELECT c.recipe_id, r.review_id, u.username, r.review_text, r.rating\n" +
                "FROM commentOn AS c\n" +
                "JOIN reviews AS r USING (review_id)\n" +
                "JOIN `write` AS w USING (review_id)\n" +
                "JOIN users AS u USING (user_id)\n" +
                "WHERE c.recipe_id = ?\n" +
                "ORDER BY r.review_id DESC;";

        //Query the recipe name
        try{
            //Connecting to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Querying the database
            try(Connection con = DriverManager.getConnection(DATABASE, DB_USER, DB_PASSWORD);
                PreparedStatement ps = con.prepareStatement(queryName);
                PreparedStatement psReview = con.prepareStatement(queryReview)) {
                //Grab the recipe name
                ps.setInt(1, recipeId);
                try(ResultSet rs = ps.executeQuery()){
                    if(rs.next()){
                        recipeName = rs.getString("title");
                    }
                }

                //Grab the reviews
                psReview.setInt(1, recipeId);
                try(ResultSet rsReview = psReview.executeQuery()){
                    //Keep adding storing while there exists another review in the table
                    while(rsReview.next()){
                        //Input
                        Map<String,Object> review = new HashMap<>();
                        review.put("username", rsReview.getString("username"));
                        review.put("text", rsReview.getString("review_text"));
                        review.put("rating", rsReview.getInt("rating"));
                        reviews.add(review);
                    }
                }
            }
        }catch(Exception e){
            throw new ServletException("Error retrieving information",e);
        }

        //Pass to the JSP
        req.setAttribute("recipe_id", recipeId);
        req.setAttribute("recipeName", recipeName);
        req.setAttribute("reviews", reviews);

        //Forward to the JSP to render in its webpage
        req.getRequestDispatcher("/viewReviews.jsp").forward(req, resp);

    }
}
