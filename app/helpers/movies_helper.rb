module MoviesHelper
    def total_gross(movie)
        if movie.flop?
            'Flop'
        else
            number_to_currency(movie.total_gross, precision: 0)
        end
        
    end

    def year_of(movie)
       movie.released_on.year
    end

    def average_stars(movie)
        if movie.average_stars.zero?
          content_tag(:strong, "No reviews")
        else
          # pluralize(number_with_precision(movie.average_stars, precision: 1) , "star")
          "*" * movie.average_stars.round 
        end
    end

    def display_reviews(movie)
      if movie.has_review?
          link_to pluralize(movie.reviews.size, "review"), movie_reviews_path(movie)

     end   
    end
end
