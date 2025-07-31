
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,java.util.*" %>
<%
  //DATABASE INFORMATION
  String DATABASE = "jdbc:mysql://localhost:3306/Dishbase?serverTimezone=UTC";
  String DB_USER = "root";
  String DB_PASSWORD = "CS157A_SJSU";
  //Load the driver
  Class.forName("com.mysql.cj.jdbc.Driver");
  //Store the ingredients
  List<Map<String, Object>> allIngredients = new ArrayList<>();

  //Open connection to the database
  try(Connection con = DriverManager.getConnection(DATABASE, DB_USER, DB_PASSWORD)) {
    //Prepare sql statement
    String sql = "SELECT ingredient_id, name FROM ingredients ORDER BY name";
    //Retrieve the table of ingredients
    try(PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
      //Continue for each valid row
      while(rs.next()) {
        //Stores each row's information
        Map<String, Object> row = new HashMap<>();
        row.put("id", rs.getInt("ingredient_id"));
        row.put("name", rs.getString("name"));
        allIngredients.add(row);
      }
    } catch (Exception e) {
      out.println("Error retrieving information");
    }
  } catch (Exception e) {
    out.println("Error connecting to database");
  }
%>

<html>
  <head>
    <title>Recipe Recommendations</title>
    <script>
      //Checks if user has selected ingredients from the list
      function validatePantryForm() {
        //Find any checked boxes
        const checked = document.querySelectorAll('input[name="pantry"]:checked');
        //Confirm user checked at least one box
        if(checked.length === 0) {
          //Cancel form submission if they have not checked at least one box
          alert("Please select at least one ingredient before continuing");
          return false;
        }
        return true;
      }
    </script>
  </head>
  <body>
  <h1>Select your ingredients</h1>
    <form action="recipeRec.jsp" method="get" onsubmit="return validatePantryForm()">
      <!-- Generate checkbox and label for each available ingredient -->
      <%
        for (Map<String,Object> ing : allIngredients) {
        int id   = (Integer) ing.get("id");
        String name = (String) ing.get("name");
      %>
        <label>
          <input type="checkbox" name="pantry" value="<%=id%>">
          <%=name%>
          </label><br>
      <%
        }
      %>
      <button type="submit">See Recipes</button>
    </form>

  </body>
</html>