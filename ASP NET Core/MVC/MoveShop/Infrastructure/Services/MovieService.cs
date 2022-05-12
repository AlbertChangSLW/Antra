using ApplicationCore.Contracts.Services;
using ApplicationCore.Models;
using Infrastructure.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Services
{
    public class MovieService : IMovieService
    {
        public List<MovieCardModel> GetTop30GrossingMovies()
        {
            var movieRepo = new MovieRepository();
            var movies = movieRepo.GetTop30GrossingMovies();
            var MovieCards = new List<MovieCardModel>();

            foreach (var movie in movies)
            {
                MovieCards.Add(new MovieCardModel
                {
                    Id = movie.Id,
                    Title = movie.Title,
                    PosterUrl = movie.PosterUrl,
                }
                );
                
            }
            return MovieCards;
        }
    }
}
