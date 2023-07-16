namespace DapperAdvanced.Data.Models
{
    public class Book
    {
        public Guid Id { get; set; }
        public string? Title { get; set; }
        public string? Author { get; set; }
        public int Year { get; set; }
        
        public List<OrderDetail>? OrderDetails { get; set; }
        public List<GenreVm>? Genres { get; set; }
    }
}
