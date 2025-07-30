<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
String kw = request.getParameter("kw");
StringBuilder searchResults = new StringBuilder();

if (kw != null && !kw.trim().isEmpty()) {
    String db = "RecipeProject";
    String user = "root";
    String pw   = "Hjq2004121";

    try (Connection con = DriverManager.getConnection(
             "jdbc:mysql://localhost:3306/" + db + "?useSSL=false", user, pw);
         PreparedStatement ps = con.prepareStatement(
             "SELECT recipe_id, title " +
             "FROM   recipes " +
             "WHERE  title LIKE ?")) {

        ps.setString(1, "%" + kw + "%");

        try (ResultSet rs = ps.executeQuery()) {
            boolean hasRows = false;
            searchResults.append("<p><strong>Click on a recipe name to view details.</strong></p>")
                         .append("<table style='width:100%; border-collapse:collapse;'>")
                         .append("<thead><tr>")
                         .append("<th style='border:1px solid #ccc;padding:8px;'>Recipe&nbsp;ID</th>")
                         .append("<th style='border:1px solid #ccc;padding:8px;'>Recipe&nbsp;Name</th>")
                         .append("</tr></thead><tbody>");

            while (rs.next()) {
                hasRows = true;
                int    id    = rs.getInt("recipe_id");
                String title = rs.getString("title");

                searchResults.append("<tr>")
                             .append("<td style='border:1px solid #ccc;padding:8px;'>")
                             .append(id)
                             .append("</td><td style='border:1px solid #ccc;padding:8px;'>")
                             .append("<a href='viewRecipe.jsp?recipeId=")
                             .append(id)
                             .append("'>")
                             .append(title)
                             .append("</a></td></tr>");
            }

            searchResults.append("</tbody></table>");

            if (!hasRows) {
                searchResults.setLength(0);                       
                searchResults.append("<div class='empty-msg'>No recipes found.</div>");
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
        searchResults.append("<div class='empty-msg'>Server error – please try again later.</div>");
    }

} else {
    searchResults.append("<div class='empty-msg'>Please enter a keyword.</div>");
}
%><%= searchResults.toString() %>
