import java.io.IOException;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;



/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/testservlet")
public class recipeBrowseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public recipeBrowseServlet() {
        // TODO Auto-generated constructor stub
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String kw = request.getParameter("kw"); 
		//response.setContentType("application/json;charset=utf-8");
		response.setContentType("text/html");
		
		String db = "RecipeProject";
		String user = "root";
		String dbpassword = "Hjq2004121";
		PrintWriter out = response.getWriter();
		
		try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/RecipeProject?autoReconnect=true&useSSL=false",user, dbpassword);
				PreparedStatement ps = con.prepareStatement(
						"SELECT r.recipe_id, r.title, r.cooking_time " +
					             "FROM   recipes r " +
					             "WHERE  r.title LIKE ? ")
		   
		){
			String compare = "%" + kw + "%";
			ps.setString(1, compare);
            
            
            try (ResultSet rs = ps.executeQuery()) {
            	StringBuilder html = new StringBuilder();
                while (rs.next()) {
                    int    id    = rs.getInt("recipe_id");
                    String title = rs.getString("title");
                    int    time  = rs.getInt("cooking_time");

                    html.append("<div class='result-item'>")
                    .append("<a href='viewRecipe.jsp?recipeId=")   // ★ parameter name = recipeId
                    .append(id).append("'>")
                    .append(title).append("</a>")
                    .append(" — ").append(time).append(" min")
                    .append("</div>");
                }
                if (html.length() == 0)
                    html.append("<div class='empty-msg'>No recipes found.</div>");

                out.print(html.toString());
                
                
            }
			
		} catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(500);
            out.print("<div class='empty-msg'>Server error</div>");
        }
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
