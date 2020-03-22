class CookingRecipeCli::Recipe
    attr_accessor :ingredients, :directions
    attr_reader :author, :name, :detail_url
    @@all = []
    def initialize(name, author, detail_url)
        @name = author
        author= 
        @detail_url = detail_url
        @ingredients = []
        @directions = []
        save
    end

    def add_attributes(attributes)
        
    end

    def self.all
        @@all
    end

    def save
        Recipe.all << self
    end

    def self.find_by_author(author)
        recipes = Author.all.find_all {|author| author.name == author}
    end
    
end