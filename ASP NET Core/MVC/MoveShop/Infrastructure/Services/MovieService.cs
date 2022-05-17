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
    public class MovieService : IMovieService
    {
        private readonly IMovieRepository _movieRepository;
        public MovieService(IMovieRepository movieRepository)
        {
            _movieRepository = movieRepository;
        }

        public MovieDetailsModel GetMovieDetails(int movieId)
        {
            var movie = _movieRepository.GetById(movieId);
            var movieDetails = new MovieDetailsModel()
            {
                Id = movie.Id,
                Budget = movie.Budget,
                Overview = movie.Overview, 
                Price = movie.Price,
                PosterUrl = movie.PosterUrl,
                Revenue = movie.Revenue,
                ReleaseDate = movie.ReleaseDate,
                Tagline = movie.Tagline,
                Title = movie.Title,
                RunTime = movie.RunTime,
                BackdropUrl = movie.BackdropUrl,
                ImdbUrl = movie.ImdbUrl,
                TmdbUrl = movie.TmdbUrl,
            };
            
            foreach(var trailer in movie.Trailer )
            {
                movieDetails.Trailers.Add(new TrailerModel { Id = trailer.Id, Name = trailer.Name, TrailerUrl = trailer.TrailerUrl});
            }

            foreach(var genre in movie.MovieGenre)
            {
                movieDetails.Genres.Add(new GenreModel { Id = genre.GenreId, Name = genre.Genre.Name });
            }

            foreach(var cast in movie.MovieCast)
            {
                movieDetails.Casts.Add(new CastModel { Id = cast.CastId, Name = cast.Cast.Name, Character = cast.Character, ProfilePath = cast.Cast.ProfilePath });
            }

            int counts = 0;
            decimal sum = 0;
            foreach(var review in movie.Review)
            {
                sum = sum + review.Rating;
                counts++;
            }
            movieDetails.Rating = Math.Round((decimal)sum / counts, 2);

            return movieDetails;
        }

        public List<MovieCardModel> GetTop30GrossingMovies()
        {
            var movies = _movieRepository.GetTop30GrossingMovies();
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
