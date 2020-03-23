class CookingRecipeCli::Author
    attr_reader :recipes, :name    
    @@all = []
    def initialize(name)
        @name = name
        @recipes = []
        save
    end
    
    def self.find_or_create_by(name)
        author = self.all.find{|author| author.name == name}
        if author.nil?
            author = self.new(name)
        end
        author
    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end

    def add_recipe(recipe)
        @recipes << recipe unless @recipes.include?(recipe)
    end

end