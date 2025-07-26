import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MsqlJdbcInsert {
	public static void main(String[] args) throws Exception {
		// Connection to MySql
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Dishbase?serverTimezone=UTC", "root", "CS157A_SJSU");
		
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
		
		// Close connection
		statement.close();
		connection.close();
		
	}

}
