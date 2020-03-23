class CookingRecipeCli::Recipe
    attr_reader :author, :name, :detail_url, :ingredients, :directions
    @@all = []
    def initialize(name, author_name, detail_url)
        @name = author
        author=(author_name)
        @detail_url = detail_url
        @ingredients = []
        @directions = []
        save
    end

    def add_ingredients(ingred_array)
        @ingredients = ingred_array
    end

    def author=(author_name)
        @author = CookingRecipeCli::Author.find_or_create_by(author_name)
        @author.add_recipe(self) if !@author.nil?
    end

    def add_directions(direction_array)
        @directions = direction_array
    end
    def self.all
        @@all
    end

    def save
        Recipe.all << self
    end

    def self.find_by_recipe(recipe_name)
        self.all.find{|recipe| recipe.name == recipe_name}
    end

    def self.find_by_author(author_name)
        author = CookingRecipeCli::Author.all.find {|author| author.name == author_name}
        recipes = author.recipes
    end
    
end