
class CookingRecipeCli::CLI
    BASIC_URL = "https://food52.com"
    def call
        scrape_list
        n = ""
        while n != "exit"
            puts "choose a number"
            n = gets.chomp
            case n
            when '1'
                list_recipes
            when '2'
                # list_authors
            when 'exit'
                
            else
                puts "Invalid Input!"
            end
        end
        # list_recipes_by(author)
    end

    def scrape_list
        url  = BASIC_URL+"/recipes/search?o=newest&tag=test-kitchen-approved"
        CookingRecipeCli::Scraper.scrape_recipe_list(url)
    end

    def list_recipes_by_author
        puts "author name"
        author_name = gets.chomp
        recipes = CookingRecipeCli::Recipe.find_by_author(author_name).sort {|a, b| a.name<=>b.name}
        recipes.each_with_index {|recipe, index| puts "#{index+1}. #{recipe.name} by #{recipe.author.name}"}
    end

    def scrape_detail(recipe)
        url = BASIC_URL+recipe.detail_url 
        CookingRecipeCli::Scraper.scrape_details(url, recipe)
        recipe
    end

    def dispaly_detail(recipe)
        puts "detail"
    end

    def list_recipes
        recipes = CookingRecipeCli::Recipe.all.sort{ |a, b| a.name <=> b.name }
        recipes.each_with_index {|recipe, index| puts "#{index+1}. #{recipe.name} by #{recipe.author.name}"}
        choose_recipe(recipes)
    end

    def choose_recipe(recipes)
        input = ""
        puts "Enter a recipe number to see detail or enter 'return' to the previous menu"
        input = gets.chomp
        return if input == 'return'
        index = input.to_i - 1
        if index<0 or index>=recipes.length
            puts "Invalid Input!"
            choose_recipe(recipes)
        end
        self.dispaly_detail(self.scrape_detail(recipes[index]))
    end

    def list_authors
        authors = CookingRecipeCli::Author.all.sort{|a, b| a.name <=> b.name}
        authors.each_with_index {|author, index| puts "#{index+1}. #{author.name}"}
    end
end