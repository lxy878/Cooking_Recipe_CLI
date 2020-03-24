class CookingRecipeCli::Cli
    BASIC_URL = "https://food52.com"

    def call
        puts "\n\nWelcome to Cooking Recipe Cli!".cyan.bold
        print "\nFetching the recipe list .".magenta
        scrape_list
        puts "\n"
        loop do
            puts "\n1. Display a list of recipes".cyan
            puts "2. Display a list of authors".cyan
            puts "OR 'q' to quit the program".cyan
            puts "ENTER a number or 'q':".green
            n = gets.chomp
            case n
            when '1'
                self.all_recipes
            when '2'
                self.recipes_by_author
            when 'q'
                break
            else
                puts "Invalid Input!".red.bold
            end
        end
    end
    
    def all_recipes
        recipes = self.list_recipes
        loop do
            puts "\nENTER 'r' to return the previous menu or ENTER any key to the top menu:".green
            input = gets.chomp
            break if input != 'r'
            self.list_recipes(recipes)
        end
    end

    def recipes_by_author
        recipes = self.list_authors
        list_recipes(recipes)
        loop do
            puts "\nENTER 'r' to return the previous menu or ENTER any key to the top menu:".green
            input = gets.chomp
            break if input != 'r'
            self.list_recipes(recipes)
        end 

    end

    def list_recipes(recipes_array=CookingRecipeCli::Recipe.all)
        recipes = recipes_array.sort{ |a, b| a.name <=> b.name }
        puts "\nRecipe List:".cyan
        recipes.each_with_index {|recipe, index| puts "#{index+1}. #{recipe.name} by #{recipe.author.name}".cyan}
        choose_recipe(recipes)
        recipes
    end

    def choose_recipe(recipes)
        puts "ENTER a recipe number to see detail:".green
        input = gets.chomp
        index = input.to_i - 1
        if index<0 or index>=recipes.length
            puts "Invalid Input!\n".red.bold
            return choose_recipe(recipes)
        end
        self.dispaly_detail(self.scrape_detail(recipes[index]))
    end

    def list_authors
        authors = CookingRecipeCli::Author.all.sort{|a, b| a.name <=> b.name}
        puts "\nAuthor List:".cyan
        authors.each_with_index {|author, index| puts "#{index+1}. #{author.name}".cyan}
        choose_author(authors)
    end

    def choose_author(authors)
        puts "ENTER a author number to show the author's recipes".green
        input = gets.chomp
        index = input.to_i - 1
        if index<0 or index>=authors.length
            puts "Invalid Input!\n".red.bold
            return choose_author(authors)
        end
        authors[index].recipes
    end

    def scrape_list
        url  = BASIC_URL+"/recipes/search?o=newest&tag=test-kitchen-approved"
        CookingRecipeCli::Scraper.scrape_recipe_list(url)
    end

    def scrape_detail(recipe)
        url = BASIC_URL+recipe.detail_url
        CookingRecipeCli::Scraper.scrape_details(url, recipe)
    end

    def dispaly_detail(recipe)
        puts "\nThe Recipe of #{recipe.name} by #{recipe.author.name}:".blue.bold
        puts "\nIngredients:\n".magenta
        recipe.ingredients.each do |ingred|
            puts "#{ingred}".cyan
        end
        puts "\nDirections:".magenta
        recipe.directions.each do |direction|
            puts "\n#{direction}".cyan
        end
        puts "\nEND.....".cyan
    end
end