namespace DapperAdvanced.Data.Models;

public class Order
{
    public int Id { get; set; }
    public DateTime OrderDate { get; set; }

    // newly added properties
    public string? CustomerName { get; set; }
    public string? PhoneNumber { get; set; }
    
    // for loading related entity
    
    public ICollection<OrderDetail>? OrderDetails { get; set; }

}