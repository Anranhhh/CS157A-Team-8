<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title><%= request.getAttribute("recipeName") %> – Reviews</title>
</head>
<body>
<h1><%= request.getAttribute("recipeName") %> – Reviews</h1>

<%
    // Grabbing the reviews from the servlet
    List<Map<String, Object>> reviews = (List<Map<String, Object>>) request.getAttribute("reviews");

    //Placeholder message for when there are no reviews
    if (reviews == null || reviews.isEmpty()) {
%>
        <p>No reviews yet. Be the first to <a href="<%=request.getContextPath()%>/addReview?recipe_id=<%=request.getAttribute("recipeId")%>">add one</a>!</p>
<%
    } else {
        for (Map<String, Object> rev : reviews) {
            String user   = (String) rev.get("username");
            int rating    = (Integer) rev.get("rating");
            String text   = (String) rev.get("text");
%>
            <div class="review">
            <strong><%= user %></strong> rated it <%= rating %>/10
            <p><%= text %></p>
            </div>
<%
        }
    }
%>

</body>
</html>
