
class CookingRecipeCli::CLI
    BASIC_URL = "https://food52.com"
    def call
        print 'Fetching the recipe list .'
        scrape_list
        puts ''
        loop do
            puts "Welcome to cooking recipe cli!"
            puts "1. display a list of recipes"
            puts "2. display a list of authors"
            puts "ENTER 'exit' to quit the program"
            puts "Choose a number:"
            n = gets.chomp
            case n
            when '1'
                self.all_recipes
            when '2'
                self.recipes_by_author
            when 'exit'
                break
            else
                puts "Invalid Input!"
            end
        end
    end
    
    def all_recipes
        recipes = self.list_recipes
        loop do
            puts "\nENTER 'return' to the previous menu or ENTER any key to the top menu:"
            input = gets.chomp
            break if input != 'return'
            self.list_recipes(recipes)
        end
    end

    def recipes_by_author
        recipes = self.list_authors
        list_recipes(recipes)
        loop do
            puts "\nENTER 'return' to the previous menu or ENTER any key to the top menu:"
            input = gets.chomp
            break if input != 'return'
            self.list_recipes(recipes)
        end 

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
        puts "The recipe of #{recipe.name} by #{recipe.author.name}:"
        puts "\nIngredients:"
        recipe.ingredients.each do |ingred|
            puts "\t#{ingred}"
        end
        puts "\nDirections:"
        recipe.directions.each do |direction|
            puts "\n\t#{direction}"
        end
    end

    def list_recipes(recipes_array=CookingRecipeCli::Recipe.all)
        recipes = recipes_array.sort{ |a, b| a.name <=> b.name }
        recipes.each_with_index {|recipe, index| puts "#{index+1}. #{recipe.name} by #{recipe.author.name}"}
        choose_recipe(recipes)
        recipes
    end

    def choose_recipe(recipes)
        puts "ENTER a recipe number to see detail"
        input = gets.chomp
        index = input.to_i - 1
        if index<0 or index>=recipes.length
            puts "Invalid Input!"
            choose_recipe(recipes)
        end
        # binding.pry
        self.dispaly_detail(self.scrape_detail(recipes[index]))
    end

    def list_authors
        authors = CookingRecipeCli::Author.all.sort{|a, b| a.name <=> b.name}
        authors.each_with_index {|author, index| puts "#{index+1}. #{author.name}"}
        choose_author(authors)
    end

    def choose_author(authors)
        puts "ENTER a author number to show the author's recipes"
        input = gets.chomp
        index = input.to_i - 1
        if index<0 or index>=authors.length
            puts "Invalid Input!"
            choose_author(authors)
        end
        authors[index].recipes
    end
end