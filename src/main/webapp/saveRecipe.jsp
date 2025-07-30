<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    response.setContentType("text/html;charset=UTF-8");

    // get userId from session
    Integer userId = (Integer) session.getAttribute("userId");
	
    // if user is not logged in, directs them to login page
    if (userId == null) {
        out.println("<div style='text-align:center; margin-top:100px;'>");
        out.println("<h1 style='color:red;'>You must be logged in to save a recipe.</h1>");
        out.println("<form action='userLogin.jsp' style='margin-top:30px;'>");
        out.println("  <button type='submit' style='padding:10px 20px; font-size:16px; background-color:#4CAF50; color:white; border:none; border-radius:5px; cursor:pointer;'>Login</button>");
        out.println("</form>");
        out.println("</div>");
        return;
    }
	
    // check for recipe_id from previous page
    String recipeIdStr = request.getParameter("recipe_id");
    if (recipeIdStr == null || recipeIdStr.isEmpty()) {
        out.println("<h2 style='color:red; text-align:center;'>Missing recipe ID.</h2>");
        return;
    }
	
    // database login information
    String db = "Dishbase";
    String dbUser = "root";
    String dbPassword = "CS157A_SJSU";

    Connection con = null;
    PreparedStatement ps = null;

    try {
        int recipeId = Integer.parseInt(recipeIdStr);
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, dbUser, dbPassword);
		
        // sql for inserting into save table
        ps = con.prepareStatement("INSERT INTO save (user_id, recipe_id) VALUES (?, ?)");
        ps.setInt(1, userId);
        ps.setInt(2, recipeId);
        ps.executeUpdate();

        out.println("<div style='text-align:center; margin-top:100px;'>");
        out.println("<h1 style='color:green;'>Recipe added successfully!</h1>");
        out.println("<form action='homepage.jsp' style='margin-top:30px;'>");
        out.println("  <button type='submit' style='padding:10px 20px; font-size:16px; background-color:#4CAF50; color:white; border:none; border-radius:5px; cursor:pointer;'>Go to Homepage</button>");
        out.println("</form>");
        out.println("</div>");

    } catch (Exception e) {
        out.println("<div style='text-align:center; margin-top:100px;'>");
        out.println("<h1 style='color:red;'>Error saving recipe.</h1>");
        out.println("<p>" + e.getMessage() + "</p>");
        out.println("</div>");
    } finally {
        if (ps != null) try { ps.close(); } catch (Exception ignored) {}
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>
