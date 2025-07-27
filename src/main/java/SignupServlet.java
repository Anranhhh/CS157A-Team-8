import java.io.IOException;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public SignupServlet() {
        // TODO Auto-generated constructor stub
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String db = "RecipeProject";
		String user = "root";
		String dbpassword = "root";
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
        try {
        	
        	// Connect to MySql database
			Class.forName("com.mysql.jdbc.Driver");
			java.sql.Connection con;
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/RecipeProject?autoReconnect=true&useSSL=false",user, dbpassword);
            
			// Get user entered info
			String username = request.getParameter("username");
			String password = request.getParameter("pwd");
			String email = request.getParameter("email");
			
			// Check if user entered info match database
			PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=?");
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery(); // return some result
			
			// If rs.next() = true -> user entered info matches database
			if (rs.next()) {
				out.print("Sorry, the username was taken. Please try again.");
			}
			else {
				String inserSQL = "Insert INTO users(username, password, email) Values(?,?,?)";
				PreparedStatement insert = con.prepareStatement(inserSQL, Statement.RETURN_GENERATED_KEYS);
				insert.setString(1, username);
				insert.setString(2, password);
				insert.setString(3, email);
				
				int rows = insert.executeUpdate();
                if (rows == 1) {
                    // fetch the auto-generated userID
                    try (ResultSet keys = insert.getGeneratedKeys()) {
                        if (keys.next()) {
                            int newID = keys.getInt(1);
                            out.printf("Welcome, %s! Your userID is %d.<br>", username, newID);
                            out.printf("Now, you can go back log in and enjoy!!!<br>");
                            out.println("<a href='createUser.jsp'>Click to log in</a>");
                        }
                    }
                } else {
                    out.println("Unexpected error — please try again.");
                }
			}
            
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
