<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<head>
    <title>Add a review</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
    </style>
</head>
<body>
    <h1> Add a review</h1>
    <form action="addReview" method="post">
        <%-- Grab the current recipe_id --%>
        <input type="hidden" name="recipe_id" value="${param.recipeId}" />

        <div style="margin-top:1em;">
            <label for="comment">Your review:</label><br/>
            <textarea
                    id="comment"    <%-- id used to identify the specific element --%>
                    name="review_text"  <%-- name used for the browser/server to exchange data --%>
                    rows="5"
                    cols="60"
                    placeholder="Write your thoughts here…"
            ></textarea>
        </div>

        <div style="margin-top:1em;">
            <%-- Recipe Rating Section--%>
            <label for="rating">Recipe Rating: </label>
            <select id="rating" name="rating" required>
                <option value="">— select —</option>
                <% for (int i = 1; i <= 10; i++) { %>
                <option value="<%= i %>"><%= i %></option>
                <% } %>
            </select>

            <%-- Submit--%>

            <button type="submit">Submit</button>
        </div>
    </form>
</body>
