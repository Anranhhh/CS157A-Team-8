<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
String kw = request.getParameter("kw");
StringBuilder searchResults = new StringBuilder();

if (kw != null && !kw.trim().isEmpty()) {
    String db = "Dishbase";
    String user = "root";
    String pw   = "CS157A_SJSU";

    try (Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/" + db + "?useSSL=false", user, pw);
        PreparedStatement ps = con.prepareStatement(
            "SELECT DISTINCT r.recipe_id, r.title " +
            "FROM recipes r " +
            "LEFT JOIN contains ri ON r.recipe_id = ri.recipe_id " +
            "LEFT JOIN ingredients i ON ri.ingredient_id = i.ingredient_id " +
            "LEFT JOIN have rt ON r.recipe_id = rt.recipe_id " +
            "LEFT JOIN tags t ON rt.tag_id = t.tag_id " +
            "WHERE r.title LIKE ? OR i.name LIKE ? OR t.name LIKE ?")) {

    	String keyword = "%" + kw + "%";
        ps.setString(1, keyword);
        ps.setString(2, keyword);
        ps.setString(3, keyword);

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
