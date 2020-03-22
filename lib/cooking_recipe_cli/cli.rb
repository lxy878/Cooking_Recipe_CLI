
class CookingRecipeCli::CLI

    def call
        puts "executing..."
        list_authors
    end

    def scrape(url)
        
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