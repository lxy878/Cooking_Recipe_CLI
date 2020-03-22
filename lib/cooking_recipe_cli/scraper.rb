require 'open-uri'
require 'nokogiri'

class CookingRecipeCli::Scraper 
    @basic_url = "https://food52.com/"
    def self.scrape_recipe_list(url)
        doc = Nokogiri::HTML(open(url)).css("div.recipe-results")
        recipes = doc.css('div.card.collectable-tile.js-collectable-tile')
        a = recipes.first
        title = a.css("h3 a").text
        href = a.css('h3 a').attribute("href").value
        author = a.css("div.meta a.username").text 
    end

    def self.scrape_detail(detail_url_array)
        
        url = @basic_url+detail_url_array[0]

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
