
class CookingRecipeCli::CLI
    BASIC_URL = "https://food52.com"
    def call
        # puts "executing..."
        scrape_list
        # list_recipes
        # list_authors
        # list_recipes_by(author)
    end

    def scrape_list
        url  = BASIC_URL+"/recipes/search?o=newest&tag=test-kitchen-approved"
        CookingRecipeCli::Scraper.scrape_recipe_list(url)
    end

    def list_recipes_by_author
        puts "author name"
        author_name = gets.chomp
        recipes = CookingRecipeCli::Recipe.find_by_author(author_name).sort {|a, b| a<=>b}
        recipes.each_with_index {|recipe, index| puts "#{index+1}. #{recipe.name} by #{recipe.author.name}"}
    end

    def scrape_detail
        puts "recipe"
        recipe_name = gets.chomp
        recipe = CookingRecipeCli::Recipe.find_by_recipe(recipe_name)
        url = RASIC_URL+recipe.detail_url 
        CookingRecipeCli::Scraper.scrape_details(url, recipe)
        recipe
    end

    def dispaly_detail(recipe)

    end

    def list_recipes
        recipes = CookingRecipeCli::Recipe.all.sort{ |a, b| a <=> b }
        recipes.each_with_index {|recipe, index| puts "#{index+1}. #{recipe.name} by #{recipe.author.name}"}
    end

    def list_authors
        authors = CookingRecipeCli::Author.all.sort{|a, b| a <=> b}
        authors.each_with_index {|author, index| puts "#{index+1}. #{author.name}"}
    end
end