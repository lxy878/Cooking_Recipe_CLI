class CookingRecipeCli::Author
    attr_accessor :name    
    @@all = []
    def initialize(name)
        @name = name
        @recipes = []
        save
    end

    def save
        Author.all << self
    end

    def self.all
        @all
    end

    def add_recipe(recipe)
        @recipes << recipes if @recipes.include?(recipe)
    end

end