using CustomerOrderDetailViewer2._0.Model;
using System.Collections.Generic;
using System.Data.SqlClient;
using Dapper;

namespace CustomerOrderDetailViewer2._0.Repository
{
    class CustomerOrderDetailGetListCommand
    {
        private string _cmdText;
        private string _connectionString;

        public CustomerOrderDetailGetListCommand()
        {
            _connectionString = DBInfo.ConnectionString;
            _cmdText = DBInfo.CustomerOrderDetailGetListCmd;
        }

        public IEnumerable<CustomerOrderDetailViewModel> GetList()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var customerOrderDetailViewModels = connection.Query<CustomerOrderDetailViewModel>(_cmdText);

                return customerOrderDetailViewModels;
            }
        }
    }
}
