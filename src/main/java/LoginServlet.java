import java.io.IOException;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.*;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public LoginServlet() {
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
		//doGet(request, response);
		
		String db = "Dishbase";
		String user = "root";
		String dbpassword = "CS157A_SJSU";
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
        try {
        	
        	// Connect to MySql database
			Class.forName("com.mysql.jdbc.Driver");
			java.sql.Connection con;
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Dishbase?autoReconnect=true&useSSL=false",user, dbpassword);
			//Setting up a session
			HttpSession session;

			// Get user entered info
			String username = request.getParameter("username");
			String password = request.getParameter("pwd");
			
			// Check if user entered info match database
			PreparedStatement ps = con.prepareStatement("SELECT user_id FROM users WHERE username=? AND password=?");
			ps.setString(1, username);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery(); // return some result
			
			// If rs.next() = true -> user entered info matches database
			if (rs.next()) {
				//Create a session
				session = request.getSession(true);
				session.setAttribute("username", username);
				session.setAttribute("password", password);
				session.setAttribute("userId", rs.getInt("user_id"));
				out.println("<a href='homepage.jsp'>Welcome Back!!!</a>");
			}
			else {
				out.println("Sorry, we can't find your account information.");
				out.println("Please check the information you entered");
				
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
