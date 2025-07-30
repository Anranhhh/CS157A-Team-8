<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<%
    String kw = request.getParameter("kw");
    StringBuilder searchResults = new StringBuilder();

    if (kw != null && !kw.trim().isEmpty()) {
        String db = "Dishbase";
        String dbUser = "root";
        String dbPassword = "CS157A_SJSU";

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, dbUser, dbPassword);
             PreparedStatement ps = con.prepareStatement(
                 "SELECT r.recipe_id, r.title, r.cooking_time " +
                 "FROM recipes r " +
                 "WHERE r.title LIKE ?")
        ) {
            String compare = "%" + kw + "%";
            ps.setString(1, compare);

            try (ResultSet rs = ps.executeQuery()) {
                boolean hasResults = false;
                searchResults.append("<p><strong>Click on the recipe name to view detailed recipe information and other features.</strong></p>");
                searchResults.append("<table style='width:100%; border-collapse: collapse;'>")
                             .append("<thead>")
                             .append("<tr>")
                             .append("<th style='border: 1px solid #ccc; padding: 8px;'>Recipe ID</th>")
                             .append("<th style='border: 1px solid #ccc; padding: 8px;'>Recipe Name</th>")
                             .append("</tr>")
                             .append("</thead>")
                             .append("<tbody>");

                while (rs.next()) {
                    hasResults = true;
                    int id = rs.getInt("recipe_id");
                    String title = rs.getString("title");

                    searchResults.append("<tr>")
                                 .append("<td style='border: 1px solid #ccc; padding: 8px;'>").append(id).append("</td>")
                                 .append("<td style='border: 1px solid #ccc; padding: 8px;'>")
                                 .append("<a href='viewRecipe.jsp?recipeId=").append(id).append("'>")
                                 .append(title).append("</a>")
                                 .append("</td>")
                                 .append("</tr>");
                }

                searchResults.append("</tbody></table>");

                if (!hasResults) {
                    searchResults.setLength(0); // Clear the prompt/table
                    searchResults.append("<div class='empty-msg'>No recipes found.</div>");
                }
            }

        } catch (SQLException e) {
            searchResults.append("<div class='empty-msg'>Server error – please try again later.</div>");
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>BrowseRecipes</title>
    <style>
        body {
            font-family: "Times New Roman", Times, serif;
            background: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
    		flex-direction: column;
    		min-height: 100vh;
        }

        header {
            color: white;
            padding: 1rem 2rem;
            text-align: center;
            height: 100px;            
            position: relative;
        }

        header::before {
        	content: "";
    		position: absolute;
    		top: 0; left: 0;
    		width: 100%;
    		height: 100%;
    		background-image: url("materials/table1.jpg");
    		background-size: cover;
    		background-position: center;
    		opacity: 0.8;
    		z-index: -1;
        }

        main {
            padding: 2rem;
            width: 1000px;
            margin: auto;
            background-color: rgba(255,255,255,0.9);
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            flex: 1;
        }

        h2 {
            text-align: center;
            margin-bottom: 2rem;
        }

        .container {
            padding: 2rem;
            width: 1000px;
            margin: auto;
            background-color: rgba(255,255,255,0.9);
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            flex: 1;
        }

        .form {
    		display: flex;
    		align-items: center;
    		justify-content: center;
    		padding: 1rem 2rem;
    		text-align: center;
    		color: white;
   		}

   		.input {
   			background-color: #fff;
    		padding: 0.9rem 0.9rem;
    		margin: 0.5rem 0;
    		border: 3px solid #ccc;
    		border-radius: 30px;
    		width: 60%;
    		font-family: "Times New Roman", Times, serif;
    		font-size: 1rem;
   		}

   		.icon {
   			background-image: url("materials/logo.png");
   			width: 65px;
   			height: 65px;
   			background-position: center;
   			background-repeat: no-repeat;
   			background-size: cover;
   		}

   		.button {
    		background: linear-gradient(to right, rgb(0, 90, 167), rgb(255, 253, 228));
    		border-radius: 30px;
    		border: 0;
    		cursor: pointer;
    		color: white;
    		font-family: "Times New Roman", Times, serif;
    		font-size: 1.2rem;
    		font-weight: bold;
    		letter-spacing: 0.05rem;
    		padding: 0.8rem 1.2rem;
    		transition: transform 80ms ease-in;
    	}

    	.button:hover {
    		background: linear-gradient(to right, rgb(101, 78, 163), rgb(234, 175, 200));
    	}

  		.button:active {
    		transform: scale(0.95);
    	}

    	.button:focus {
    		outline: none;
    	}

    	#searchResults {
   			max-height: 400px;
    		overflow-y: auto;
    		border-top: 1px solid #ddd;
    		padding-top: 1rem;
    	}

    	.result-item {
    		margin: 0.5rem 0;
    	}

    	.empty-msg {
    		text-align: center;
    		color: #888;
    	}
    </style>
</head>

<body>

<header>
    <h1>Welcome to DishBase</h1>
    <p>Recipes tailored to you.</p>
</header>

<main>
    <div class="main-input">
    	<form action="browseRecipes.jsp" method="get" class="form" id="browse">
    		<span class="icon"></span>
    		<input type="text" name="kw" id="searchInput" class="input"
    			   placeholder="Enter any recipe name, ingredient, or diet to start browsing"
    			   value="<%= kw != null ? kw : "" %>"/>
    		<button type="submit" class="button">Search</button>
    	</form>
    </div>

    <div id="searchResults">
        <%= kw == null ? "<div class='empty-msg'>Type a keyword and press Search to see results.</div>" : searchResults.toString() %>
    </div>
</main>

<div style="text-align: center; padding: 2rem;">
    <form action="homepage.jsp" method="get">
        <button type="submit" class="button">Return to Homepage</button>
    </form>
</div>

</body>
</html>
