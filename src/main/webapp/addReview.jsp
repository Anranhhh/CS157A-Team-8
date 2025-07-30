<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<head>
    <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap"
            rel="stylesheet"
    />
    <title>Add a review</title>
    <style>
        html, body {
            height: 100%;      /* ensure both fill full height */
            margin: 0;         /* remove default margins */
        }

        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            background-color: #cfdee8;
        }

        .review-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 80%;
            max-width: 450px;
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 0 10px 5px lightblue;
        }

        .rating-row {
            display: flex;
            align-items: center;
            width: 100%;
        }

        .rating-row button {
            margin-left: auto;
        }

        .save-btn {
            background: linear-gradient(135deg, #a8d5e2 0%, #8bbecf 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="review-card">
        <h1> Add a review</h1>
        <form action="addReview" method="post">
            <%-- Grab the current recipe_id --%>
            <input type="hidden" name="recipe_id" value="${param.recipe_id}" />

            <div>
                <label for="comment">Your review:</label>
                <br>
                <textarea
                        id="comment"    <%-- id used to identify the specific element --%>
                        name="review_text"  <%-- name used for the browser/server to exchange data --%>
                        rows="10"
                        cols="60"
                        placeholder="Write your thoughts here…"
                ></textarea>
                <br> <br>
            </div>


            <div class="rating-row">
                <%-- Recipe Rating Section--%>
                <label for="rating">Recipe Rating: </label>
                <select id="rating" name="rating" required>
                    <option value="">— select —</option>
                    <% for (int i = 1; i <= 10; i++) { %>
                    <option value="<%= i %>"><%= i %></option>
                    <% } %>
                </select>

                <%-- Submit--%>

                <button type="submit" class="save-btn">Submit</button>
            </div>
        </form>
    </div>
</body>
