import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class MySqlJdbcCreateTable {

	public static void main(String[] args) throws Exception {
		// Connection to MySql
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Dishbase?serverTimezone=UTC", "root", "CS157A_SJSU");
		
		Statement statement = connection.createStatement();
		
		// users table
        statement.execute("CREATE TABLE users (" +
                "user_id INT NOT NULL AUTO_INCREMENT, " +
                "username VARCHAR(50) NOT NULL, " +
                "password VARCHAR(100) NOT NULL, " +
                "PRIMARY KEY (user_id))");

        // recipes table
        statement.execute("CREATE TABLE recipes (" +
                "recipe_id INT NOT NULL AUTO_INCREMENT, " +
                "title VARCHAR(100), " +
                "cooking_time INT, " +
                "PRIMARY KEY (recipe_id))");

        // ingredients table
        statement.execute("CREATE TABLE ingredients (" +
                "ingredient_id INT NOT NULL AUTO_INCREMENT, " +
                "name VARCHAR(100), " +
                "PRIMARY KEY (ingredient_id))");

        // tags table
        statement.execute("CREATE TABLE tags (" +
                "tag_id INT NOT NULL AUTO_INCREMENT, " +
                "name VARCHAR(50) NOT NULL, " +
                "category VARCHAR(50) NOT NULL, " +
                "PRIMARY KEY (tag_id))");

        // reviews table
        statement.execute("CREATE TABLE reviews (" +
                "review_id INT NOT NULL AUTO_INCREMENT, " +
                "rating INT, " +
                "review_text TEXT, " +
                "PRIMARY KEY (review_id))");

        // recipeSteps weak entity set table
        statement.execute("CREATE TABLE recipeSteps (" +
                "recipe_id INT NOT NULL, " +
                "step_number INT NOT NULL, " +
                "description TEXT, " +
                "PRIMARY KEY (recipe_id, step_number), " +
                "FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id))");

        // contains relationship
        statement.execute("CREATE TABLE contains (" +
                "recipe_id INT NOT NULL, " +
                "ingredient_id INT NOT NULL, " +
                "quantity VARCHAR(50), " +
                "calories INT, " +
                "PRIMARY KEY (recipe_id, ingredient_id), " +
                "FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id), " +
                "FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id))");

        // have relationship
        statement.execute("CREATE TABLE have (" +
                "recipe_id INT NOT NULL, " +
                "tag_id INT NOT NULL, " +
                "PRIMARY KEY (recipe_id, tag_id), " +
                "FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id), " +
                "FOREIGN KEY (tag_id) REFERENCES tags(tag_id))");

        // write relationship
        statement.execute("CREATE TABLE `write` (" +
                "user_id INT NOT NULL, " +
                "review_id INT NOT NULL, " +
                "PRIMARY KEY (user_id, review_id), " +
                "FOREIGN KEY (user_id) REFERENCES users(user_id), " +
                "FOREIGN KEY (review_id) REFERENCES reviews(review_id))");

        // commentOn relationship
        statement.execute("CREATE TABLE commentOn (" +
                "recipe_id INT NOT NULL, " +
                "review_id INT NOT NULL, " +
                "PRIMARY KEY (recipe_id, review_id), " +
                "FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id), " +
                "FOREIGN KEY (review_id) REFERENCES reviews(review_id))");

        // upload relationship
        statement.execute("CREATE TABLE upload (" +
                "user_id INT NOT NULL, " +
                "recipe_id INT NOT NULL, " +
                "PRIMARY KEY (user_id, recipe_id), " +
                "FOREIGN KEY (user_id) REFERENCES users(user_id), " +
                "FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id))");

        // save relationship
        statement.execute("CREATE TABLE save (" +
                "user_id INT NOT NULL, " +
                "recipe_id INT NOT NULL, " +
                "PRIMARY KEY (user_id, recipe_id), " +
                "FOREIGN KEY (user_id) REFERENCES users(user_id), " +
                "FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id))");

        // restrictions relationship
        statement.execute("CREATE TABLE restrictions (" +
                "user_id INT NOT NULL, " +
                "tag_id INT NOT NULL, " +
                "PRIMARY KEY (user_id, tag_id), " +
                "FOREIGN KEY (user_id) REFERENCES users(user_id), " +
                "FOREIGN KEY (tag_id) REFERENCES tags(tag_id))");
		
		statement.close();
		// Close connection
		connection.close();
	}
		
		
	}



