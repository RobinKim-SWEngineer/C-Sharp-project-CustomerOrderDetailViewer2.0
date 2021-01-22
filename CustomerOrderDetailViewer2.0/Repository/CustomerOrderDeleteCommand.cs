using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;
using Dapper;

namespace CustomerOrderDetailViewer2._0.Repository
{
    class CustomerOrderDeleteCommand
    {
        private string _procName;
        private string _connectionString;
        public CustomerOrderDeleteCommand()
        {
            _procName = DBInfo.CustomerOrderDeleteProc;
            _connectionString = DBInfo.ConnectionString;
        }

        public void Delete(int customerOrderId, string userId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var procParameter = new { CustomerOrderId = customerOrderId, UserId = userId };
                connection.Query(_procName, procParameter, commandType: CommandType.StoredProcedure);
            }
        }
    }
}
