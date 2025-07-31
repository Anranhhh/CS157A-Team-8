import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MsqlJdbcInsert {
	public static void main(String[] args) throws Exception {
	// Database information
	String db = "Dishbase";
    	String dbUser = "root";
    	String dbPassword = "CS157A_SJSU";
	// Connection to MySql
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, dbUser, dbPassword);
	
	// insert statement
	String insertSql = "INSERT INTO tags (name, category) VALUES (?, ?)";
	Statement statement = connection.createStatement();

	// list of cuisine tags
        String[] cuisineTags = {
            "Japanese", "American", "Mexican", "Italian", "Chinese", "Indian",
            "French", "Thai", "Mediterranean", "Korean", "Vietnamese", "Spanish",
            "Greek", "Middle Eastern", "Caribbean"
        };
        // insert every tag in the list with the cuisine category
        for (String tag : cuisineTags) {
            String insertSQL = "INSERT INTO tags (name, category) VALUES ('" + tag + "', 'cuisine')";
            statement.execute(insertSQL);
        }

        // list of difficulty tags
        String[] difficultyTags = {"Easy", "Medium", "Hard"};
        // insert every tag in the list with the difficulty category
        for (String tag : difficultyTags) {
            String insertSQL = "INSERT INTO tags (name, category) VALUES ('" + tag + "', 'difficulty')";
            statement.execute(insertSQL);
        }

        // list of dietary restriction tags
        String[] restrictionTags = {
            "Vegetarian", "Vegan", "Lactose-Free", "Healthy", "Nut Free",
            "Gluten-Free", "Peanut-Free", "Egg Free", "Soy Free",
            "Low Carb", "Low Sodium", "Sugar-Free", "Keto"
        };
        // insert every tag in the list with restriction category
        for (String tag : restrictionTags) {
            String insertSQL = "INSERT INTO tags (name, category) VALUES ('" + tag + "', 'restriction')";
            statement.execute(insertSQL);
        }
		
        // username array to use in for loop
        String[] usernames = {
            "user1", "user2", "user3", "user4", "user5",
            "user6", "user7", "user8", "user9", "user10"
        };

        // Insert test users
        for (String username : usernames) {
            String password = "password";
            String email = username + "@gmail.com";
            String insertUserSQL = "INSERT INTO users (username, password, email) VALUES ('" + username + "', '" + password + "', '" + email + "')";
            statement.execute(insertUserSQL);
        }
        
        // Insert data for recipes table: recipes(recipe_id, title, cooking time)
        String[] recipes_titles = {
    		"Grilled Cheese Sandwich",
    	    "Grilled Chicken Salad",
    	    "Beef and Pork Tacos",
    	    "Spicy Asian Ramen Noodles",
    	    "Strawberry Matcha Latte",
    	    "Baked Chicken Katsu",
    	    "Chicken Alfredo",
    	    "Baked Salmon",
    	    "Vegetable Stir Fry",
    	    "Beef Bulgogi"
    	};
        
    	int[] recipes_cookingTimes = {10, 35, 15, 15, 10, 60, 15, 50, 40, 90};

	    for (int i = 0; i < recipes_titles.length; i++) {
	        String insertRecipeSQL = "INSERT INTO recipes (title, cooking_time) VALUES ('"
	            + recipes_titles[i].replace("'", "''") + "', " + recipes_cookingTimes[i] + ")";
	        statement.executeUpdate(insertRecipeSQL);
	    }
    	
	    // Insert data for have table: have(recipe_id, tag_id)
	    int[] have_recipeIds = {
    	    5, 6, 1, 2, 8, 3, 7, 4, 9, 4,
    	    2, 8, 10, 1, 3, 4, 5, 7, 2, 8,
    	    9, 6, 10, 1, 4, 5, 9, 9, 2, 3,
    	    2, 8, 9, 10, 2, 3, 5, 8, 9, 9,
    	    10, 2, 8, 9, 2, 8, 9
    	};

    	int[] have_tagIds = {
    	    1, 1, 2, 2, 2, 3, 4, 5, 5, 8,
    	    9, 9, 10, 16, 16, 16, 16, 16, 17, 17,
    	    17, 18, 18, 19, 19, 19, 19, 20, 21, 21,
    	    22, 22, 22, 22, 24, 24, 24, 24, 25, 25,
    	    30, 30, 30, 31, 31, 31
    	};

    	for (int i = 0; i < have_recipeIds.length; i++) {
    	    String insertHaveSQL = "INSERT INTO have (recipe_id, tag_id) VALUES (" + have_recipeIds[i] + ", " + have_tagIds[i] + ")";
    	    statement.executeUpdate(insertHaveSQL);
    	}
    	
    	// Insert data for contains table: contains(recipe_id, ingredient_id, quantity)
    	int[] contains_recipeIds = {
		    1,1,1,
		    2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
		    3,3,3,3,3,3,3,3,
		    4,4,4,4,4,4,4,4,4,4,
		    5,5,5,5,5,5,5,
		    6,6,6,6,6,6,6,6,
		    7,7,7,7,7,7,
		    8,8,8,8,8,8,8,8,
		    9,9,9,9,9,9,9,9,9,9,9,9,9,
		    10,10,10,10,10,10,10,10,10,10,10
		};

		int[] contains_ingredientIds = {
		    1,2,3,
		    4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
		    20,21,22,23,24,25,26,27,
		    28,29,30,31,32,33,34,35,36,37,
		    14,38,39,40,41,42,43,
		    4,18,19,44,45,46,47,48,
		    4,42,49,50,51,52,
		    2,11,18,19,53,54,55,56,
		    18,22,43,54,56,57,58,59,60,61,62,63,
		    14,19,29,37,54,62,64,65,66,67,68,69
		};

		String[] contains_quantities = {
		    "0.5 cup", "1 tbsp", "2 slices",
		    "1 lb", "6 cups", "3/4 cup", "3/4 cup", "3/4 cup", "1/4 cup", "1", "3 tbsp", "2 tbsp", "3 tbsp", "2 tbsp", "1/2 tsp", "1 1/2 tsp", "2/3 cup", "to taste", "to taste",
		    "1 lb", "1 lb", "1", "1.25 oz", "10 oz", "10 oz", "8 oz", "8",
		    "3 tbsp", "2 tbsp", "1 1/2 tbsp", "1 tbsp", "2 tsp", "1 tsp", "3 tbsp", "6 oz", "2 tbsp", "2",
		    "2 tsp", "1 cup", "1 cup", "2 tsp", "3 tbsp", "3/4 cup", "1 tbsp",
		    "2 lb", "to taste", "to taste", "1 1/4 cups", "1 1/2 tbsp", "1/4 cup", "2", "1 bottle",
		    "1 lb", "1/3 cup", "1 lb", "16 oz", "10 oz", "4.5 oz",
		    "3 tbsp", "2 tsp", "to taste", "to taste", "1 1/2 lbs", "4 cloves", "4 slices", "4 tbsp",
		    "to taste", "1/4 cup", "2 1/2 tbsp", "1 1/2 cloves", "4 tbsp", "2 tsp", "1 small head", "3/4 cup", "1/2 cup", "1/2 cup", "2 tbsp", "2 tbsp",
		    "3 tbsp", "1/8 tsp", "1 tbsp", "2", "3 cloves", "1/3 cup", "1/4", "2 tbsp", "1/4 tsp", "1/4 tsp", "1 1/2 lbs", "1 tsp"
		};

		for (int i = 0; i < contains_recipeIds.length; i++) {
		    String insertContainsSQL = "INSERT INTO contains (recipe_id, ingredient_id, quantity) VALUES ("
		        + contains_recipeIds[i] + ", "
		        + contains_ingredientIds[i] + ", '"
		        + contains_quantities[i].replace("'", "''") + "')";
		    statement.executeUpdate(insertContainsSQL);
		}
		
		// Insert into ingredients table: ingredients(ingredient_id, name)
		int[] ingredients_ingredientIds = {
		    1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
		    11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
		    21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
		    31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
		    41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
		    51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
		    61, 62, 63, 64, 65, 66, 67, 68, 69
		};

		String[] ingredients_ingredientNames = {
		    "Shredded Cheese", "Butter", "Bread", "Chicken Breast", "Romaine Lettuce", "Cherry Tomato", "Corn", "Cucumber", "Red Onion", "Avocado",
		    "Lemon Juice", "Dijon Mustard", "Red Wine Vinegar", "Sugar", "Dried Oregano", "Dried Parsley", "Olive Oil", "Salt", "Pepper", "Ground Beef",
		    "Spicy Pork Sausage", "Onion", "Taco Seasoning Mix", "Diced Tomatoes", "Green Chiles", "Tomato Sauce", "Corn Tortillas", "Low Sodium Soy Sauce", "Sesame Oil", "Brown Sugar",
		    "Rice Vinegar", "Chili Garlic Sauce", "Grated Fresh Ginger", "Peanut Butter", "Ramen Noodles", "Chopped Peanuts", "Green Onions", "Frozen Strawberries", "Ice Cubes", "Matcha Powder",
		    "Hot water", "Milk", "Water", "Panko", "Oil", "Flour", "Egg", "Tonkatsu Sauce", "Fettuccine Pasta", "Alfredo Pasta Sauce",
		    "Mixed Vegetables", "Sliced Mushrooms", "Salmon Fillet", "Garlic", "Lemon Slices", "Vegetable Oil", "Ginger", "Broccoli", "Carrots", "Snow Peas",
		    "Green Beans", "Soy Sauce", "Corn Starch", "Yellow Onion", "Toasted Sesame Seeds", "Korean Red Pepper Flakes", "Fresh Ginger", "Beef Sirloin Steak", "Honey"
		};

		for (int i = 0; i < ingredients_ingredientIds.length; i++) {
		    String insertIngredientSQL = "INSERT INTO ingredients (ingredient_id, name) VALUES ("
		        + ingredients_ingredientIds[i] + ", '"
		        + ingredients_ingredientNames[i].replace("'", "''") + "')";
		    statement.executeUpdate(insertIngredientSQL);
		}
		
		// Insert into upload table: upload(user_id, recipe_id)
		int[] upload_userIds = {1, 1, 2, 3, 4, 5, 6, 7, 8, 9};
		int[] upload_recipeIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

		for (int i = 0; i < upload_userIds.length; i++) {
		    String insertUploadSQL = "INSERT INTO upload (user_id, recipe_id) VALUES ("
		        + upload_userIds[i] + ", "
		        + upload_recipeIds[i] + ")";
		    statement.executeUpdate(insertUploadSQL);
		}
		
		// Insert into recipeSteps table: recipeSteps(recipe_id, step_number, description)
		int[] recipeSteps_recipeIds = {
		    1,1,1,1,1,1,
		    2,2,2,2,2,2,2,2,2,
		    3,3,3,3,3,3,3,
		    4,4,4,4,4,4,4,
		    5,5,5,5,5,5,
		    6,6,6,6,6,6,6,6,6,6,
		    7,7,7,7,
		    8,8,8,8,
		    9,9,9,9,9,
		    10,10,10,10
		};

		int[] recipeSteps_stepNumbers = {
		    1,2,3,4,5,6,
		    1,2,3,4,5,6,7,8,9,
		    1,2,3,4,5,6,7,
		    1,2,3,4,5,6,7,
		    1,2,3,4,5,6,
		    1,2,3,4,5,6,7,8,9,10,
		    1,2,3,4,
		    1,2,3,4,
		    1,2,3,4,5,
		    1,2,3,4
		};

		String[] recipeSteps_descriptions = {
		    "Spread butter on one side of each slice of bread.",
		    "Put first slice of bread butter side down on pan.",
		    "Sprinkle shredded cheese on top.",
		    "Put second slice of bread butter side up on top.",
		    "Heat pan on medium low heat.",
		    "Cook for 3-4 minutes or until golden brown, then flip and cook another 3-4 minutes or until golden brown.",
		    
		    "Place all dressing ingredients in a medium bowl and whisk until thoroughly mixed.",
		    "Save half of the dressing in a container for later use.",
		    "Add chicken breasts to remaining dressing to marinate for 1-8 hours.",
		    "Preheat grill to medium high heat and place chicken on grill.",
		    "Cook for 5-6 minutes per side or until chicken is browned and cooked through.",
		    "Let chicken cool for 5 minutes, then slice into strips.",
		    "Place lettuce in a large bowl and drizzle half of the saved dressing over the lettuce.",
		    "Put chicken, tomatoes, corn, cucumber, red onion, and avocado on top of the lettuce.",
		    "Drizzle the rest of the dressing on top and enjoy.",
		    
		    "Heat large pan to medium high heat.",
		    "Cook and stir beef, sausage, and diced onion for 5-7 minutes or until meat is browned and crumbly.",
		    "Drain and discard grease in pan.",
		    "Stir in taco seasoning until meat is well coated.",
		    "Add diced tomatoes and tomato sauce, simmer to heat through.",
		    "Warm tortillas on pan for 30 seconds each.",
		    "Spoon filling onto tortillas.",
		    
		    "Whisk soy sauce, sesame oil, brown sugar, rice vinegar, chili garlic sauce, and ginger together in a small bowl.",
		    "Add peanut butter, whisking until well combined and set aside.",
		    "Thinly slice green onions diagonally.",
		    "Bring 4 cups of water to boil in a pot, add ramen noodles to boiling water. Cook for 4-5 minutes or until noodles are tender.",
		    "Drain noodles, reserving some of the noodle water in case you need to thin out the sauce later.",
		    "Pour sauce over ramen noodles, tossing until well coated.",
		    "Garnish with peanuts and green onion and enjoy.",
		    
		    "Start by making strawberry puree. Add sugar and water to frozen strawberries in a blender. If using fresh strawberries, don't need to add sugar and water. Blend until smooth.",
		    "Pour half of the puree into a glass. Add 1 cup of ice cubes on top of the puree.",
		    "Add matcha powder to a small bowl, and gently add hot water. Whisk using a bamboo matcha whisk until the surface of the tea has many small bubbles and a thick froth.",
		    "Slowly pour milk in a thin stream directly on the ice cubes. Pouring slowly prevents the strawberry puree and milk from mixing.",
		    "Slowly pour a thin stream of the matcha to create matcha layer.",
		    "Mix before drinking and enjoy.",
		    
		    "Preheat oven to 400°F.",
		    "Combine panko and 1 tbsp oil in a frying pan. Toast the panko over medium heat, until golden brown. Transfer to prep tray to cool.",
		    "Butterfly chicken breast using Japanese cutting technique. With a knife, score the chicken breast lengthwise along the top center line, cutting about halfway through the thickness of the breat.",
		    "Season both sides of the cutlets with salt and pepper.",
		    "In a prep tray, whisk together eggs and 1/2 tbsp oil. In another prep tray place 1/4 cup flour. Bring the toasted panko in the third tray.",
		    "Start by dredging chicken cutlet in flour and shaking off any excess.",
		    "Dip the floured chicken into the egg mixture and coat well on both sides.",
		    "Coat the chicken with toasted panko, press firmly to ensure adhesion.",
		    "Put the breaded chicken cutlets on a wire rack placed on a rimmed baking sheet. Bake at 400°F for 25-30 minutes. Internal chicken of chicken should reach 165°F.",
		    "Cut cutlets into 3/4 inch slices and serve with tonkatsu sauce.",
		    
		    "Fill a large pot with lightly salted water and bring to boil.",
		    "Cook fettuccine at boil until tender yet firm to the bite or about 8 min.",
		    "While pasta is cooking, placed cubed cooked chicken, Alfredo sauce, frozen vegetables, mushrooms, and milk in a large saucepan over medium low heat. Cook and stir until chicken is heated through and vegetables are tender.",
		    "Serve warm Alfredo and chicken sauce over cooked noodles and enjoy.",
		    
		    "Rest salmon for 20-30 minutes to come to room temperature. Pat with paper towels.",
		    "Line a baking tray with aluminum foil. Place fillet on top, skin side down.",
		    "Melt butter and stir in minced garlic and lemon juice. Spoon mixture over the flesh of the salmon fillet.",
		    "Bake at 400°F for 12-15 minutes depending on thickness of salmon and desired doneness.",
		    
		    "Place 2 tbsp vegetable oil, crushed garlic, 1 tsp chopped fresh ginger root, and corn starch in a large bowl, mix well.",
		    "Add broccoli, snow peas, and green beans. Toss lightly to coat.",
		    "Heat remaining 2 tbsp vegetable oil in a large skillet or wok over medium heat. Add vegetable mixture and cook for 2 minutes, stirring constantly to prevent burning.",
		    "Stir in water and soy sauce. Add onion, salt, and remaining 1 tsp ginger. Cook and stir until vegetables are tender but crisp. Serve and enjoy.",
		    
		    "Whisk soy sauce, green onions, yellow onion, sugar, garlic, sesame seeds, sesame oil, red pepper flakes, ginger, and pepper together in a large bowl.",
		    "Add steak slices and toss to evenly coat. Cover the bowl with plastic wrap and marinate in the refrigerator for 1 hour to 1 day.",
		    "Heat wok or large skillet over medium heat. Working in batches, cook and stir steak and marinade together in the hot skillet, adding honey to caramelize the steak, until steak is cooked through, about 5 minutes.",
		    "Garnish bulgogi with green onions."
		};

		for (int i = 0; i < recipeSteps_recipeIds.length; i++) {
		    String insertRecipeStepSQL = "INSERT INTO recipeSteps (recipe_id, step_number, description) VALUES ("
		        + recipeSteps_recipeIds[i] + ", "
		        + recipeSteps_stepNumbers[i] + ", '"
		        + recipeSteps_descriptions[i].replace("'", "''") + "')";
		    statement.executeUpdate(insertRecipeStepSQL);
		}

		// Insert into save table: save(user_id, recipe_id)
		int[] save_userIds = {1, 4, 3, 4, 5, 2, 2, 1, 1, 2, 5};
		int[] save_recipeIds = {2, 2, 3, 3, 3, 4, 5, 6, 7, 9, 10};
		
		for (int i = 0; i < save_userIds.length; i++) {
		    String insertSaveSQL = "INSERT INTO save (user_id, recipe_id) VALUES ("
		        + save_userIds[i] + ", "
		        + save_recipeIds[i] + ")";
		    statement.executeUpdate(insertSaveSQL);
		}

		// Close connection
		statement.close();
		connection.close();
		
	}

}
