namespace DapperAdvanced.Data.Models;

public class Genre
{  
    public int Id { get; set; }
    public string? Name { get; set; }
   // public List<Book> ? Books { get; set; }
}

public class GenreVm
{  
    public int GenreId { get; set; }
    public string? GenreName { get; set; }
}

// public class BookGenre
// {
//     public int Id { get; set; }
//     public Guid BookId { get; set; }
//     public int GenreId { get; set; }
//     public Book? Book { get; set; }
//     public Genre? Genre { get; set; }
// }