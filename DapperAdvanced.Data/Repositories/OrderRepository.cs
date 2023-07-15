using System.Data;
using Dapper;
using DapperAdvanced.Data.Models;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace DapperAdvanced.Data.Repositories;

public interface IOrderRepository
{
    Task CreateOrder(IEnumerable<OrderDetail> OrderDetails);
    Task<IEnumerable<OrderDetail>> OrderDetail();
}

public class OrderRepository : IOrderRepository
{
    private readonly IConfiguration _config;
    public OrderRepository(IConfiguration config)
    {
        _config = config;
    }

    public async Task CreateOrder(IEnumerable<OrderDetail> OrderDetails)
    {
       using IDbConnection connection = new SqlConnection(_config.GetConnectionString("default"));
        connection.Open();
        using IDbTransaction transaction = connection.BeginTransaction();
        try
        {
                 // generating order
                var orderParam = new { OrderDate = DateTime.Now };
                string orderQuery = @"insert into dbo.[order](OrderDate) values  (@orderDate); select SCOPE_IDENTITY();";
                var orderId = await connection.ExecuteScalarAsync<int>(orderQuery, orderParam,transaction, commandType: CommandType.Text);
                 
               //  throw new Exception("Could not saved order details");

                // saving order details
                foreach (var orderDetail in OrderDetails)
                {
                    var orderDetailParm = new
                    {
                        OrderId = orderId,
                        ProductId = orderDetail.ProductId,
                        Price = orderDetail.Price,
                        Quantity = orderDetail.Quantity
                    };
                    string orderDetailQuery = @"insert into dbo.[OrderDetail] 
                                   (OrderId,ProductId,Price,Quantity) 
                                   values(@OrderId,@ProductId,@Price,@Quantity)
                                       ";
                    await connection.ExecuteAsync(orderDetailQuery, orderDetailParm,transaction, commandType: CommandType.Text);
                }
                transaction.Commit();
        }
        catch(Exception ex)
        {
               transaction.Rollback();
               throw;
        }        
                
    }
    

    public async Task<IEnumerable<OrderDetail>> OrderDetail()
    {
        using IDbConnection connection = new SqlConnection(_config.GetConnectionString("default"));
        var sql = @"select *
 from  OrderDetail od join [order] o
on od.OrderId = o.Id
join book b on od.ProductId=b.Id
                    ";
        var orderDetail = await connection.QueryAsync<OrderDetail, Order, Book, OrderDetail>
        (sql, (orderDetail, order, book) =>
        {
            orderDetail.Order = order;
            orderDetail.Book = book;
            return orderDetail;
        });

        // var sql=@"select od.*,o.*
        //             from  OrderDetail od join [order] o
        //             on od.OrderId = o.Id";
        // var orderDetail = await connection.QueryAsync<OrderDetail, Order, OrderDetail>(sql, (orderDetail, order) => { orderDetail.Order = order; return orderDetail; });

        return orderDetail;
    }

}