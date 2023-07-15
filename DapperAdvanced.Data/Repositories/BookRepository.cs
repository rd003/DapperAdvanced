using System.Data;
using DapperAdvanced.Data.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using Dapper;
using System.Data.Common;

namespace DapperAdvanced.Data.Repositories
{
    public interface IBookRepository
    {
        Task AddBooks(IEnumerable<Book> books);
        Task<IEnumerable<Book>> GetBooks();
        Task<(string, string)> GetBookDetail(Guid id);
        Task<(IEnumerable<Genre>, IEnumerable<Book>)> GetMultiple();
    }

    public class BookRepository : IBookRepository
    {
        private readonly IConfiguration _config;

        public BookRepository(IConfiguration config)
        {
           _config = config;
        }

        public async Task AddBooks(IEnumerable<Book> books)
        {
            using IDbConnection connection = new SqlConnection(_config.GetConnectionString("default"));
            var parameters = new DynamicParameters();
            parameters.Add("@typBook", ToDataTable(books), DbType.Object, ParameterDirection.Input);
            await connection.ExecuteAsync("sp_AddBooks", parameters, commandType: CommandType.StoredProcedure);
        }

        private DataTable ToDataTable(IEnumerable<Book> books)
        {
            var table = new DataTable();
            table.Columns.Add("Title", typeof(string));
            table.Columns.Add("Author", typeof(string));
            table.Columns.Add("Year", typeof(int));
            foreach(var book in books)
            {
                table.Rows.Add(book.Title, book.Author, book.Year);
            }
            return table;
        }

         public async Task<IEnumerable<Book>> GetBooks()
         {
            using IDbConnection connection = new SqlConnection(_config.GetConnectionString("default"));
            var books = await connection.QueryAsync<Book>("select * from dbo.book");
            return books;
         }


         public async Task<(string,string)> GetBookDetail(Guid id)
         {
            using IDbConnection connection = new SqlConnection(_config.GetConnectionString("default"));
            var parameters = new DynamicParameters();
            parameters.Add("@Id", id, DbType.Guid);
            parameters.Add("@Title", dbType: DbType.String, direction: ParameterDirection.Output,size:100);
            parameters.Add("@Author", dbType: DbType.String, direction: ParameterDirection.Output,size:100);
            
            await connection.QueryAsync("uspGetBookDetail", parameters,commandType: CommandType.StoredProcedure);
            var title = parameters.Get<string>("@Title");
            var author = parameters.Get<string>("@Author");
            return (title, author);
         } 
         
         public async Task<(IEnumerable<Genre>,IEnumerable<Book>)> GetMultiple()
         {
            using IDbConnection connection = new SqlConnection(_config.GetConnectionString("default"));
            string query = @"select * from dbo.genre
                             select * from dbo.book";
            using SqlMapper.GridReader multi = await connection.QueryMultipleAsync(query, commandType: CommandType.Text);
            var genres = multi.Read<Genre>().ToList();
            var books = multi.Read<Book>().ToList();
            return (genres, books);
         }
    }
}
