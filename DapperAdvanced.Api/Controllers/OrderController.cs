using DapperAdvanced.Data.Models;
using DapperAdvanced.Data.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace DapperAdvanced.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly IOrderRepository _orderRepo;
        public OrderController(IOrderRepository orderRepo)
        {
            _orderRepo = orderRepo;
        }

        [HttpPost]
        public async Task<IActionResult> CreateOrder()
        {
           try
           {
                var orderDetails = new List<OrderDetail>
                {
                    new OrderDetail{ ProductId=new Guid("A36692C8-004E-43D3-9C36-27B62FDDC1BA"),Price=200,Quantity=1},
                    new OrderDetail{ ProductId=new Guid("53E525E7-3FD6-4258-8D40-448DD75FCB57"),Price=200,Quantity=2}
                };
                await _orderRepo.CreateOrder(orderDetails);
                return CreatedAtAction(nameof(CreateOrder), "Successfull created");
           }
           catch (Exception ex)
           {
               
                return StatusCode(StatusCodes.Status500InternalServerError, "Something went wrong!");
           }
           
        }

    }
}
