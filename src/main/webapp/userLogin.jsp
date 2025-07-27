<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    String db = "Dishbase";
    String dbUser = "root";
    String dbPassword = "CS157A_SJSU";
    String username = request.getParameter("username");
    String password = request.getParameter("pwd");

    if (username != null && password != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, dbUser, dbPassword);

            PreparedStatement ps = con.prepareStatement("SELECT user_id FROM users WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                session.setAttribute("userId", userId);
                session.setAttribute("username", username);
                response.sendRedirect("homepage.jsp"); // redirect to homepage
            } else {
%>
                <p>Invalid credentials. <a href="createUser.jsp">Try again</a></p>
<%
            }
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    } else {
        response.sendRedirect("createUser.jsp");
    }
%>