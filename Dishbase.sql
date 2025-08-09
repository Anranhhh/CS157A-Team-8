-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: localhost    Database: Dishbase
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `commentOn`
--

DROP TABLE IF EXISTS `commentOn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentOn` (
  `recipe_id` int NOT NULL,
  `review_id` int NOT NULL,
  PRIMARY KEY (`recipe_id`,`review_id`),
  KEY `review_id` (`review_id`),
  CONSTRAINT `commenton_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`),
  CONSTRAINT `commenton_ibfk_2` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentOn`
--

LOCK TABLES `commentOn` WRITE;
/*!40000 ALTER TABLE `commentOn` DISABLE KEYS */;
INSERT INTO `commentOn` VALUES (4,1),(6,2),(5,3),(6,4),(9,5),(1,6),(2,7),(5,8),(8,9),(4,10),(3,11),(10,12),(10,13);
/*!40000 ALTER TABLE `commentOn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contains`
--

DROP TABLE IF EXISTS `contains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contains` (
  `recipe_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  `quantity` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`recipe_id`,`ingredient_id`),
  KEY `ingredient_id` (`ingredient_id`),
  CONSTRAINT `contains_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`),
  CONSTRAINT `contains_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contains`
--

LOCK TABLES `contains` WRITE;
/*!40000 ALTER TABLE `contains` DISABLE KEYS */;
INSERT INTO `contains` VALUES (1,1,'0.5 cup'),(1,2,'1 tbsp'),(1,3,'2 slices'),(2,4,'1 lb'),(2,5,'6 cups'),(2,6,'3/4 cup'),(2,7,'3/4 cup'),(2,8,'3/4 cup'),(2,9,'1/4 cup'),(2,10,'1'),(2,11,'3 tbsp'),(2,12,'2 tbsp'),(2,13,'3 tbsp'),(2,14,'2 tbsp'),(2,15,'1/2 tsp'),(2,16,'1 1/2 tsp'),(2,17,'2/3 cup'),(2,18,'to taste'),(2,19,'to taste'),(3,20,'1 lb'),(3,21,'1 lb'),(3,22,'1'),(3,23,'1.25 oz'),(3,24,'10 oz'),(3,25,'10 oz'),(3,26,'8 oz'),(3,27,'8'),(4,28,'3 tbsp'),(4,29,'2 tbsp'),(4,30,'1 1/2 tbsp'),(4,31,'1 tbsp'),(4,32,'2 tsp'),(4,33,'1 tsp'),(4,34,'3 tbsp'),(4,35,'6 oz'),(4,36,'2 tbsp'),(4,37,'2'),(5,14,'2 tsp'),(5,38,'1 cup'),(5,39,'1 cup'),(5,40,'2 tsp'),(5,41,'3 tbsp'),(5,42,'3/4 cup'),(5,43,'1 tbsp'),(6,4,'2 lb'),(6,18,'to taste'),(6,19,'to taste'),(6,44,'1 1/4 cups'),(6,45,'1 1/2 tbsp'),(6,46,'1/4 cup'),(6,47,'2'),(6,48,'1 bottle'),(7,4,'1 lb'),(7,42,'1/3 cup'),(7,49,'1 lb'),(7,50,'16 oz'),(7,51,'10 oz'),(7,52,'4.5 oz'),(8,2,'3 tbsp'),(8,11,'2 tsp'),(8,18,'to taste'),(8,19,'to taste'),(8,53,'1 1/2 lbs'),(8,54,'4 cloves'),(8,55,'4 slices'),(9,18,'to taste'),(9,22,'1/4 cup'),(9,43,'2 1/2 tbsp'),(9,54,'1 1/2 cloves'),(9,56,'4 tbsp'),(9,57,'2 tsp'),(9,58,'1 small head'),(9,59,'3/4 cup'),(9,60,'1/2 cup'),(9,61,'1/2 cup'),(9,62,'2 tbsp'),(9,63,'2 tbsp'),(10,14,'3 tbsp'),(10,19,'1/8 tsp'),(10,29,'1 tbsp'),(10,37,'2'),(10,54,'3 cloves'),(10,62,'1/3 cup'),(10,64,'1/4'),(10,65,'2 tbsp'),(10,66,'1/4 tsp'),(10,67,'1/4 tsp'),(10,68,'1 1/2 lbs'),(10,69,'1 tsp');
/*!40000 ALTER TABLE `contains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `have`
--

DROP TABLE IF EXISTS `have`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `have` (
  `recipe_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`recipe_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `have_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`),
  CONSTRAINT `have_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `have`
--

LOCK TABLES `have` WRITE;
/*!40000 ALTER TABLE `have` DISABLE KEYS */;
INSERT INTO `have` VALUES (5,1),(6,1),(1,2),(2,2),(8,2),(3,3),(7,4),(4,5),(9,5),(4,8),(2,9),(8,9),(10,10),(1,16),(3,16),(4,16),(5,16),(7,16),(2,17),(8,17),(9,17),(6,18),(10,18),(1,19),(4,19),(5,19),(9,19),(9,20),(2,21),(3,21),(2,22),(8,22),(9,22),(10,22),(2,24),(3,24),(5,24),(8,24),(9,24),(9,25),(10,25),(2,30),(8,30),(9,30),(2,31),(8,31),(9,31);
/*!40000 ALTER TABLE `have` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `ingredient_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'Shredded Cheese'),(2,'Butter'),(3,'Bread'),(4,'Chicken Breast'),(5,'Romaine Lettuce'),(6,'Cherry Tomato'),(7,'Corn'),(8,'Cucumber'),(9,'Red Onion'),(10,'Avocado'),(11,'Lemon Juice'),(12,'Dijon Mustard'),(13,'Red Wine Vinegar'),(14,'Sugar'),(15,'Dried Oregano'),(16,'Dried Parsley'),(17,'Olive Oil'),(18,'Salt'),(19,'Pepper'),(20,'Ground Beef'),(21,'Spicy Pork Sausage'),(22,'Onion'),(23,'Taco Seasoning Mix'),(24,'Diced Tomatoes'),(25,'Green Chiles'),(26,'Tomato Sauce'),(27,'Corn Tortillas'),(28,'Low Sodium Soy Sauce'),(29,'Sesame Oil'),(30,'Brown Sugar'),(31,'Rice Vinegar'),(32,'Chili Garlic Sauce'),(33,'Grated Fresh Ginger'),(34,'Peanut Butter'),(35,'Ramen Noodles'),(36,'Chopped Peanuts'),(37,'Green Onions'),(38,'Frozen Strawberries'),(39,'Ice Cubes'),(40,'Matcha Powder'),(41,'Hot water'),(42,'Milk'),(43,'Water'),(44,'Panko'),(45,'Oil'),(46,'Flour'),(47,'Egg'),(48,'Tonkatsu Sauce'),(49,'Fettuccine Pasta'),(50,'Alfredo Pasta Sauce'),(51,'Mixed Vegetables'),(52,'Sliced Mushrooms'),(53,'Salmon Fillet'),(54,'Garlic'),(55,'Lemon Slices'),(56,'Vegetable Oil'),(57,'Ginger'),(58,'Broccoli'),(59,'Carrots'),(60,'Snow Peas'),(61,'Green Beans'),(62,'Soy Sauce'),(63,'Corn Starch'),(64,'Yellow Onion'),(65,'Toasted Sesame Seeds'),(66,'Korean Red Pepper Flakes'),(67,'Fresh Ginger'),(68,'Beef Sirloin Steak'),(69,'Honey');
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipes` (
  `recipe_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `cooking_time` int DEFAULT NULL,
  PRIMARY KEY (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
INSERT INTO `recipes` VALUES (1,'Grilled Cheese Sandwich',10),(2,'Grilled Chicken Salad',35),(3,'Beef and Pork Tacos',15),(4,'Spicy Asian Ramen Noodles',15),(5,'Strawberry Matcha Latte',10),(6,'Baked Chicken Katsu',60),(7,'Chicken Alfredo',15),(8,'Baked Salmon',50),(9,'Vegetable Stir Fry',40),(10,'Beef Bulgogi',90);
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipeSteps`
--

DROP TABLE IF EXISTS `recipeSteps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipeSteps` (
  `recipe_id` int NOT NULL,
  `step_number` int NOT NULL,
  `description` text,
  PRIMARY KEY (`recipe_id`,`step_number`),
  CONSTRAINT `recipesteps_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `Recipes` (`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipeSteps`
--

LOCK TABLES `recipeSteps` WRITE;
/*!40000 ALTER TABLE `recipeSteps` DISABLE KEYS */;
INSERT INTO `recipeSteps` VALUES (1,1,'Spread butter on one side of each slice of bread.'),(1,2,'Put first slice of bread butter side down on pan.'),(1,3,'Sprinkle shredded cheese on top.'),(1,4,'Put second slice of bread butter side up on top.'),(1,5,'Heat pan on medium low heat.'),(1,6,'Cook for 3-4 minutes or until golden brown, then flip and cook another 3-4 minutes or until golden brown.'),(2,1,'Place all dressing ingredients in a medium bowl and whisk until thoroughly mixed.'),(2,2,'Save half of the dressing in a container for later use.'),(2,3,'Add chicken breasts to remaining dressing to marinate for 1-8 hours.'),(2,4,'Preheat grill to medium high heat and place chicken on grill.'),(2,5,'Cook for 5-6 minutes per side or until chicken is browned and cooked through.'),(2,6,'Let chicken cool for 5 minutes, then slice into strips.'),(2,7,'Place lettuce in a large bowl and drizzle half of the saved dressing over the lettuce.'),(2,8,'Put chicken, tomatoes, corn, cucumber, red onion, and avocado on top of the lettuce.'),(2,9,'Drizzle the rest of the dressing on top and enjoy.'),(3,1,'Heat large pan to medium high heat.'),(3,2,'Cook and stir beef, sausage, and diced onion for 5-7 minutes or until meat is browned and crumbly.'),(3,3,'Drain and discard grease in pan.'),(3,4,'Stir in taco seasoning until meat is well coated.'),(3,5,'Add diced tomatoes and tomato sauce, simmer to heat through.'),(3,6,'Warm tortillas on pan for 30 seconds each.'),(3,7,'Spoon filling onto tortillas.'),(4,1,'Whisk soy sauce, sesame oil, brown sugar, rice vinegar, chili garlic sauce, and ginger together in a small bowl.'),(4,2,'Add peanut butter, whisking until well combined and set aside.'),(4,3,'Thinly slice green onions diagonally.'),(4,4,'Bring 4 cups of water to boil in a pot, add ramen noodles to boiling water. Cook for 4-5 minutes or until noodles are tender.'),(4,5,'Drain noodles, reserving some of the noodle water in case you need to thin out the sauce later.'),(4,6,'Pour sauce over ramen noodles, tossing until well coated.'),(4,7,'Garnish with peanuts and green onion and enjoy.'),(5,1,'Start by making strawberry puree. Add sugar and water to frozen strawberries in a blender. If using fresh strawberries, don\'t need to add sugar and water. Blend until smooth.'),(5,2,'Pour half of the puree into a glass. Add 1 cup of ice cubes on top of the puree.'),(5,3,'Add matcha powder to a small bowl, and gently add hot water. Whisk using a bamboo matcha whisk until the surface of the tea has many small bubbles and a thick froth.'),(5,4,'Slowly pour milk in a thin stream directly on the ice cubes. Pouring slowly prevents the strawberry puree and milk from mixing.'),(5,5,'Slowly pour a thin stream of the matcha to create matcha layer.'),(5,6,'Mix before drinking and enjoy.'),(6,1,'Preheat oven to 400°F.'),(6,2,'Combine panko and 1 tbsp oil in a frying pan. Toast the panko over medium heat, until golden brown. Transfer to prep tray to cool.'),(6,3,'Butterfly chicken breast using Japanese cutting technique. With a knife, score the chicken breast lengthwise along the top center line, cutting about halfway through the thickness of the breat.'),(6,4,'Season both sides of the cutlets with salt and pepper.'),(6,5,'In a prep tray, whisk together eggs and 1/2 tbsp oil. In another prep tray place 1/4 cup flour. Bring the toasted panko in the third tray.'),(6,6,'Start by dredging chicken cutlet in flour and shaking off any excess.'),(6,7,'Dip the floured chicken into the egg mixture and coat well on both sides.'),(6,8,'Coat the chicken with toasted panko, press firmly to ensure adhesion.'),(6,9,'Put the breaded chicken cutlets on a wire rack placed on a rimmed baking sheet. Bake at 400°F for 25-30 minutes. Internal chicken of chicken should reach 165°F.'),(6,10,'Cut cutlets into 3/4 inch slices and serve with tonkatsu sauce.'),(7,1,'Fill a large pot with lightly salted water and bring to boil.'),(7,2,'Cook fettuccine at boil until tender yet firm to the bite or about 8 min.'),(7,3,'While pasta is cooking, placed cubed cooked chicken, Alfredo sauce, frozen vegetables, mushrooms, and milk in a large saucepan over medium low heat. Cook and stir until chicken is heated through and vegetables are tender.'),(7,4,'Serve warm Alfredo and chicken sauce over cooked noodles and enjoy.'),(8,1,'Rest salmon for 20-30 minutes to come to room temperature. Pat with paper towels.'),(8,2,'Line a baking tray with aluminum foil. Place fillet on top, skin side down.'),(8,3,'Melt butter and stir in minced garlic and lemon juice. Spoon mixture over the flesh of the salmon fillet.'),(8,4,'Bake at 400°F for 12-15 minutes depending on thickness of salmon and desired doneness.'),(9,1,'Place 2 tbsp vegetable oil, crushed garlic, 1 tsp chopped fresh ginger root, and corn starch in a large bowl, mix well.'),(9,2,'Add broccoli, snow peas, and green beans. Toss lightly to coat.'),(9,3,'Heat remaining 2 tbsp vegetable oil in a large skillet or wok over medium heat. Add vegetable mixture and cook for 2 minutes, stirring constantly to prevent burning.'),(9,4,'Stir in water and soy sauce. Add onion, salt, and remaining 1 tsp ginger. Cook and stir until vegetables are tender but crisp. Serve and enjoy.'),(10,1,'Whisk soy sauce, green onions, yellow onion, sugar, garlic, sesame seeds, sesame oil, red pepper flakes, ginger, and pepper together in a large bowl.'),(10,2,'Add steak slices and toss to evenly coat. Cover the bowl with plastic wrap and marinate in the refrigerator for 1 hour to 1 day.'),(10,3,'Heat wok or large skillet over medium heat. Working in batches, cook and stir steak and marinade together in the hot skillet, adding honey to caramelize the steak, until steak is cooked through, about 5 minutes.'),(10,4,'Garnish bulgogi with green onions.');
/*!40000 ALTER TABLE `recipeSteps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `rating` int DEFAULT NULL,
  `review_text` text,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,7,'Overall a good recipe, I recommend adding some chicken or whatever protein if you aren\'t vegetarian.'),(2,9,'Loved the recipe! I was looking for a katsu recipe that didn\'t require deep frying and this baked katsu recipe tasted great!'),(3,8,'Lowkey better than the matcha lattes from cafes and it\'s a fraction of the price. Would definitely recommend. I also substituted the milk with lactose free milk.'),(4,4,'I prefer deep frying my katsu, the baked katsu just doesn\'t hit the same.'),(5,8,'Great recipe, I replaced some vegetables with ones that are in season and it still tasted great. Also, very healthy.'),(6,1,'imagine not knowing how to make a grilled cheese sandwich and you\'re looking up the recipe smh.'),(7,1,'using a recipe to make a salad is diabolical. just put lettuce and whatever you want and you\'re done. stop wasting time.'),(8,1,'overhyped drink. just drink coffee for caffeine smh.'),(9,10,'best recipe on the website. I definitely didn\'t upload this recipe.'),(10,1,'I\'d rather just eat shin ramen, easier to make, just need to pour hot water and it tastes better.'),(11,1,'I\'d rather just go down the street to the taco truck and buy tacos for $2.'),(12,1,'too much work.'),(13,9,'I loved the recipe! I cooked some rice on the side and it was a great pairing.');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `save`
--

DROP TABLE IF EXISTS `save`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `save` (
  `user_id` int NOT NULL,
  `recipe_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`recipe_id`),
  KEY `recipe_id` (`recipe_id`),
  CONSTRAINT `save_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `save_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `save`
--

LOCK TABLES `save` WRITE;
/*!40000 ALTER TABLE `save` DISABLE KEYS */;
INSERT INTO `save` VALUES (1,2),(4,2),(3,3),(4,3),(5,3),(8,3),(2,4),(2,5),(1,6),(1,7),(2,9),(5,10);
/*!40000 ALTER TABLE `save` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Japanese','cuisine'),(2,'American','cuisine'),(3,'Mexican','cuisine'),(4,'Italian','cuisine'),(5,'Chinese','cuisine'),(6,'Indian','cuisine'),(7,'French','cuisine'),(8,'Thai','cuisine'),(9,'Mediterranean','cuisine'),(10,'Korean','cuisine'),(11,'Vietnamese','cuisine'),(12,'Spanish','cuisine'),(13,'Greek','cuisine'),(14,'Middle Eastern','cuisine'),(15,'Caribbean','cuisine'),(16,'Easy','difficulty'),(17,'Medium','difficulty'),(18,'Hard','difficulty'),(19,'Vegetarian','restriction'),(20,'Vegan','restriction'),(21,'Lactose-Free','restriction'),(22,'Healthy','restriction'),(23,'Nut Free','restriction'),(24,'Gluten-Free','restriction'),(25,'Peanut-Free','restriction'),(26,'Egg Free','restriction'),(27,'Soy Free','restriction'),(28,'Low Carb','restriction'),(29,'Low Sodium','restriction'),(30,'Sugar-Free','restriction'),(31,'Keto','restriction');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload`
--

DROP TABLE IF EXISTS `upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upload` (
  `user_id` int NOT NULL,
  `recipe_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`recipe_id`),
  KEY `recipe_id` (`recipe_id`),
  CONSTRAINT `upload_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `upload_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload`
--

LOCK TABLES `upload` WRITE;
/*!40000 ALTER TABLE `upload` DISABLE KEYS */;
INSERT INTO `upload` VALUES (1,1),(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10);
/*!40000 ALTER TABLE `upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user1','password','user1@gmail.com'),(2,'user2','password','user2@gmail.com'),(3,'user3','password','user3@gmail.com'),(4,'user4','password','user4@gmail.com'),(5,'user5','password','user5@gmail.com'),(6,'user6','password','user6@gmail.com'),(7,'user7','password','user7@gmail.com'),(8,'user8','password','user8@gmail.com'),(9,'user9','password','user9@gmail.com'),(10,'user10','password','user10@gmail.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `writes`
--

DROP TABLE IF EXISTS `writes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `writes` (
  `user_id` int NOT NULL,
  `review_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`review_id`),
  KEY `review_id` (`review_id`),
  CONSTRAINT `writes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `writes_ibfk_2` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `writes`
--

LOCK TABLES `writes` WRITE;
/*!40000 ALTER TABLE `writes` DISABLE KEYS */;
INSERT INTO `writes` VALUES (1,1),(1,2),(3,3),(4,4),(4,5),(7,6),(7,7),(7,8),(7,9),(7,10),(7,11),(7,12),(8,13);
/*!40000 ALTER TABLE `writes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-09 12:36:21
