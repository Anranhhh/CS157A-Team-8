<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    String db = "Dishbase";
    String dbUser = "root";
    String dbPassword = "CS157A_SJSU";
    String username = request.getParameter("username");
    String password = request.getParameter("pwd");
    String email = request.getParameter("email");

    if (username != null && password != null && email != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, dbUser, dbPassword);

            PreparedStatement checkUser = con.prepareStatement("SELECT * FROM users WHERE username=?");
            checkUser.setString(1, username);
            ResultSet rs = checkUser.executeQuery();

            if (rs.next()) {
%>
                <p>Username already taken. <a href="createUser.jsp">Try again</a></p>
<%
            } else {
                PreparedStatement insertUser = con.prepareStatement(
                    "INSERT INTO users(username, password, email) VALUES (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
                );
                insertUser.setString(1, username);
                insertUser.setString(2, password);
                insertUser.setString(3, email);

                int rows = insertUser.executeUpdate();

                if (rows == 1) {
                    ResultSet keys = insertUser.getGeneratedKeys();
                    if (keys.next()) {
                        int userId = keys.getInt(1);
                        session.setAttribute("userId", userId);
                        session.setAttribute("username", username);
                        response.sendRedirect("homepage.jsp");
                    }
                } else {
                    out.println("Error: Could not create account.");
                }
            }
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    } else {
        response.sendRedirect("createUser.jsp");
    }
%>