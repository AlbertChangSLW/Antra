using ApplicationCore.Contracts.Repositories;
using ApplicationCore.Entities;
using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Repositories
{
    public class MovieRepository : Repository<Movie>, IMovieRepository
    {
        public MovieRepository(MovieShopDbContext dbContext) : base(dbContext)
        {
        }

        public List<Movie> GetTop30GrossingMovies()
        {
            var movies = _dbContext.Movies.OrderByDescending(x => x.Revenue).Take(30).ToList();
            return movies;
        }

        public override Movie GetById(int id)
        {
            var movie = _dbContext.Movies.Include(x => x.MovieGenre).ThenInclude(x => x.Genre).Include(x => x.MovieCast).ThenInclude(x =>x.Cast)
                .Include(x => x.Trailer).Include(x => x.Review).FirstOrDefault(x => x.Id == id);

            return movie;
        }
    }
}
