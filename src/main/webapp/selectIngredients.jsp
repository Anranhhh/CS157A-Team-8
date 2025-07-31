
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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
      body {
        display: flex;
        align-items: flex-start;
        justify-content: center;
        font-family: 'Poppins', sans-serif;
        padding-top: 2rem;
        background-color: #d3e2ec;
      }

      /* Home button in top right */
      .home-btn {
        position: absolute;
        top: 1rem;
        right: 1rem;
        background: linear-gradient(135deg, #a8d5e2, #8bbecf);
        color: white;
        border: none;
        border-radius: 20px;
        padding: 0.5rem 1rem;
        font-size: 0.9rem;
        font-weight: 600;
        cursor: pointer;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        transition: transform 0.2s, box-shadow 0.2s;
      }

      .home-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 14px rgba(0,0,0,0.15);
      }

      .selection-card {
        max-height: 90vh;
        overflow-y: auto;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 0 12px rgba(173,216,230,0.6);
        padding: 2rem;
        width: 90%;
        max-width: 1000px;
        box-sizing: border-box;
      }

      h1 {
        margin-top: 0;
        font-size: 2rem;
        text-align: center;
      }
    </style>
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
  <!-- Home Button -->
  <button class="home-btn" onclick="location.href='homepage.jsp'">
    Home
  </button>

  <!-- Ingredient selection box-->
  <div class="selection-card">
    <!-- Prompt -->
    <h1>Select your ingredients</h1> <br>
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
  </div>
  </body>
</html>