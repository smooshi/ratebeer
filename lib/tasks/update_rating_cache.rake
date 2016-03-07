desc "Update rating cache"
task :update_rating_cache => :environment do
    puts "Updating rating cache"
        Rails.cache.write("beer top 3", Beer.top(3))
        Rails.cache.write("brewery top 3", Brewery.top(3))
        Rails.cache.write("user top 3", User.mostActive(3)) if cache_does_not_contain_data_or_it_is_too_old
        Rails.cache.write("style top 3", Style.top(3)) if cache_does_not_contain_data_or_it_is_too_old
end