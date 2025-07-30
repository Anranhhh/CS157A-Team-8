<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    		height: 100%;
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
    	
    	#searchResults{
   		 max-height:400px;              /* scroll if many results */
    		overflow-y:auto;
    		border-top:1px solid #ddd;
    		padding-top:1rem;
		}

    	
        
    </style>
</head>

<body>

<header>
    <h1>Welcome to DishBase</h1>
    <p>Recipes tailored to you.</p>
</header>

<main>
<container>
    <div class="main-input">
    	<form action="searching.jsp" method="post" class="form" id="browse">
    		<span class="icon"></span>
    		<input type="text" id="searchInput" class="input" placeholder="Enter any recipe name, ingredient, or diet to start browsing"/>
    		<button type="submit" value="search" class="button">Search</button>
    	</form>
    </div>
    
    <div id="searchResults">
    	<div class="empty-msg">Type a keyword and press Search to see results.</div>
    </div>
</container>
</main>

<script>
document.getElementById('browse').addEventListener('submit', async e => {
    e.preventDefault();

    const kw = document.getElementById('searchInput').value.trim();
    if (!kw) return;

    const box = document.getElementById('searchResults');
    box.innerHTML = '<div class="empty-msg">Searching…</div>';

    try {
        const resp = await fetch('searching.jsp?kw=' + encodeURIComponent(kw));
        if (!resp.ok) throw new Error();

        const html = await resp.text(); 
        box.innerHTML = html;        

    } catch (err) {
        console.error(err);
        box.innerHTML =
          '<div class="empty-msg">Server error – please try again later.</div>';
    }
});
</script>



</body>
</html>
