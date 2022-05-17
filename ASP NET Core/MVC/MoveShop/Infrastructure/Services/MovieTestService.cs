using ApplicationCore.Contracts.Repositories;
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
    public class MovieTestService : IMovieService
    {
        private readonly IMovieRepository _movieRepository;

        public MovieTestService(IMovieRepository movieRepository)
        {
            _movieRepository = movieRepository;
        }

        public MovieDetailsModel GetMovieDetails(int movieId)
        {
            throw new NotImplementedException();
        }

        public List<MovieCardModel> GetTop30GrossingMovies()
        {
            var movies = _movieRepository.GetTop30GrossingMovies().Take(6);
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
