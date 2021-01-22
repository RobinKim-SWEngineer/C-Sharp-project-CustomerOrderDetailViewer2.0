using CustomerOrderDetailViewer2._0.Repository;
using System;
using System.Data;
using System.Linq;

namespace CustomerOrderDetailViewer2._0.Controll
{
    class Launcher
    {
        private bool _shouldProgramRun;

        public Launcher()
        {
            _shouldProgramRun = true;
        }

        public void StartViewer()
        {
            while (_shouldProgramRun)
            {
                AskUserTo("\n Choose operation : 1 - Show All || 2 - Upsert Customer Order || 3 - Delete Customer Order || 4 - Exit");

                Excute(Convert.ToInt32(GetUserInput()));
            }
        }

        private void AskUserTo(string request)
        {
            Console.WriteLine(request);
            Console.Write(" > ");
        }

        private string GetUserInput()
        {
            var userInput = Console.ReadLine();
            return userInput;
        }

        private void Excute(int operation)
        {
            switch (operation)
            {
                case 1 :
                    ShowAll();
                    return;

                case 2 :
                    Upsert();
                    return;

                case 3 :
                    Delete();
                    return;

                case 4 :
                    _shouldProgramRun = !_shouldProgramRun;
                    Console.WriteLine("Program ends");
                    return;
            }
        }

        private void ShowAll()
        {
            var customerGetListCommand = new CustomerGetListCommand();
            var itemGetListCommand = new ItemGetListCommand();
            var customerOrderDetailGetListCommand = new CustomerOrderDetailGetListCommand();

            try
            {
                var customerModels = customerGetListCommand.GetList();
                var itemModels = itemGetListCommand.GetList();
                var customerOrderDetailModels = customerOrderDetailGetListCommand.GetList();

                if (customerModels.Any() && itemModels.Any() && customerOrderDetailModels.Any())
                {
                    Console.WriteLine("\nAll Customer Order Details:\n");
                    foreach (var eachRow in customerOrderDetailModels)
                    {
                        Console.WriteLine($" {eachRow.CustomerOrderId}: Fullname: {eachRow.FirstName} {eachRow.LastName} (Id: {eachRow.CustomerId}) - purchased {eachRow.Description} for {eachRow.Price} (Id: {eachRow.ItemId})");
                    }

                    Console.WriteLine("\nAll Customers:\n");
                    foreach (var eachRow in customerModels)
                    {
                        Console.WriteLine($" {eachRow.CustomerId}: First Name: {eachRow.FirstName} {eachRow.LastName}, Age: {eachRow.Age}");
                    }

                    Console.WriteLine("\nAll Items:\n");
                    foreach (var eachRow in itemModels)
                    {
                        Console.WriteLine($" {eachRow.ItemId}: Description: {eachRow.Description}, Price: {eachRow.Price}");
                    }
                }
            }
            catch (Exception exception)
            {
                Console.WriteLine($"Faild: {exception.Message}");
            }
        }
        private void Upsert()
        {
            CustomerOrderUpsertCommand customerOrderUpsertCommand = new CustomerOrderUpsertCommand();

            AskUserTo("\n   Choose update or insert");
            var userChoice = GetUserInput();

            AskUserTo($"\n   Enter CustomerOrderId to {userChoice}");         
            var customerOrderId = GetUserInput();

            AskUserTo($"\n   [You`re doing {userChoice}] Enter Id of customer");
            var customerId = GetUserInput();
            
            AskUserTo($"\n   [You`re doing {userChoice}] Enter Id of item");
            var itemId = GetUserInput();

            AskUserTo($"\n   [You`re doing {userChoice}] Enter Id of user");
            var userId = GetUserInput();

            try
            {
                customerOrderUpsertCommand.Upsert(Convert.ToInt32(customerOrderId), Convert.ToInt32(customerId), Convert.ToInt32(itemId), userId);
                Console.WriteLine($"\n* {userChoice}'ng {customerOrderId} is excuted * \n");
            }
            catch (Exception exception)
            {
                Console.WriteLine($"Faild: {exception.Message}");
            }
        }

        private void Delete()
        {
            var customerOrderDeleteCommand = new CustomerOrderDeleteCommand();

            AskUserTo("\n   Enter CustomerOrderId to delete");
            var customerOrderIdToDelete = GetUserInput();

            AskUserTo("\n   Enter User Id");
            var userId = GetUserInput();

            try
            {
                customerOrderDeleteCommand.Delete(Convert.ToInt32(customerOrderIdToDelete), userId);
                Console.WriteLine($"\n* Deleting {customerOrderIdToDelete} is excuted * \n");
            }
            catch (Exception exception)
            {
                Console.WriteLine($"Faild: {exception.Message}");
            }
        }
    }
}
