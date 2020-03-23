class CookingRecipeCli::Scraper 
    def self.scrape_recipe_list(url)
        doc = open(url)
        doc = Nokogiri::HTML(URI.open(url)).css("div.recipe-results")
        recipes = doc.css('div.card.collectable-tile.js-collectable-tile')
        recipes.each do |recipe|
            recipe_name = recipe.css("h3 a").text
            href = recipe.css('h3 a').attribute("href").value
            author_name = recipe.css("div.meta a.username").text 
            CookingRecipeCli::Recipe.new(recipe_name, author_name, href)
        end
        # puts CookingRecipeCli::Recipe.all[0].author.name
        # next page
    end

    def self.scrape_details(url, recipe)
        return if recipe.ingredients.empty? and recipe.directions.empty?
        context = Nokogiri::HTML(open(url))
        # ingredients
        ingreds =context.css('div.recipe__list.recipe__list--ingredients ul li')
        ingred_array = ingreds.collect do |ingred|
            ingred.text.gsub(/\n/, " ").strip   
        end
        # directions
        directions = context.css('div.recipe__list.recipe__list--steps ol li')
        direction_array = directions.collect do |dir|
            dir.text.strip
        end

        array = direction_array[0]
    end

end
