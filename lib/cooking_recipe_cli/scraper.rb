class CookingRecipeCli::Scraper 
    def self.scrape_recipe_list(url)

        doc = Nokogiri::HTML(URI.open(url)).css("div.recipe-results")
        recipes = doc.css('div.card.collectable-tile.js-collectable-tile')
        recipes.each do |recipe|
            recipe_name = recipe.css("h3 a").attribute("title").value
            detail_url = recipe.css('h3 a').attribute("href").value
            author_name = recipe.css("h3 div.meta a.username").text 
            CookingRecipeCli::Recipe.new(recipe_name, author_name, detail_url)
        end
        
        # check if there is a next page
        return if doc.at_css('a.next_page').nil?

        print '.'.magenta
        next_href = doc.css('a.next_page').attribute('href').value
        next_page_url = "https://food52.com"+next_href
        self.scrape_recipe_list(next_page_url)

    end

    def self.scrape_details(url, recipe)
        return recipe unless recipe.ingredients.empty? and recipe.directions.empty?
        context = Nokogiri::HTML(URI.open(url))

        # ingredients
        ingreds = context.css('div.recipe__list.recipe__list--ingredients ul li')
        ingred_array = ingreds.collect do |ingred|
            ingred.text.gsub(/\n/, " ").strip   
        end
        recipe.add_ingredients(ingred_array)

        # directions
        directions = context.css('div.recipe__list.recipe__list--steps ol li')
        direction_array = directions.collect do |dir|
            dir.text.strip
        end
        recipe.add_directions(direction_array)
        
        recipe
    end

end
