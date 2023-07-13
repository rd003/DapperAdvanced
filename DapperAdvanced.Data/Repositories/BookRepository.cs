using System.Data;
using DapperAdvanced.Data.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using Dapper;

namespace DapperAdvanced.Data.Repositories
{
    public interface IBookRepository
    {
        Task AddBooks(IEnumerable<Book> books);
        Task<IEnumerable<Book>> GetBooks();
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


    }
}
