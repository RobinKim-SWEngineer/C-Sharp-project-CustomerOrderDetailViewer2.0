using CustomerOrderDetailViewer2._0.Model;
using System.Collections.Generic;
using System.Data.SqlClient;
using Dapper;
using System.Data;

namespace CustomerOrderDetailViewer2._0.Repository
{
    class CustomerGetListCommand
    {
        private string _procName;
        private string _connectionString;
        
        public CustomerGetListCommand()
        {
            _connectionString = DBInfo.ConnectionString;
            _procName = DBInfo.CustomerGetListProc;
        }

        public IEnumerable<CustomerModel> GetList()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var customerModels = connection.Query<CustomerModel>(_procName, commandType: CommandType.StoredProcedure);

                return customerModels;
            }
        }
    }
}
