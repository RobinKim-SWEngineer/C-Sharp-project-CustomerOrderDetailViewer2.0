using Dapper;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

namespace CustomerOrderDetailViewer2._0.Repository
{
    class CustomerOrderUpsertCommand
    {
        private string _procName;
        private string _connectionString;
        public CustomerOrderUpsertCommand()
        {
            _procName = DBInfo.CustomerOrderUpsertProc;
            _connectionString = DBInfo.ConnectionString;
        }

        public void Upsert(int customerOrderId, int customerId, int itemid, string userId)
        {
            DataTable customerOrderType = CreateCustomerOrderTypeDataTable(customerOrderId, customerId, itemid);

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var procParameter = new { customerOrderType, userId = userId };
                connection.Query(_procName, procParameter, commandType: CommandType.StoredProcedure);
            }
        }

        private DataTable CreateCustomerOrderTypeDataTable(int customerOrderId, int customerId, int itemid)
        {
            DataTable customerOrderTypeDataTable = new DataTable();

            DataColumn CustomerOrderIdColumn = new DataColumn("CustomerOrderId", typeof(int));
            DataColumn CustomerIdColumn = new DataColumn("CustomerId", typeof(int));
            DataColumn ItemIdColumn = new DataColumn("ItemId", typeof(int));

            customerOrderTypeDataTable.Columns.Add(CustomerOrderIdColumn);
            customerOrderTypeDataTable.Columns.Add(CustomerIdColumn);
            customerOrderTypeDataTable.Columns.Add(ItemIdColumn);

            customerOrderTypeDataTable.Rows.Add(customerOrderId, customerId, itemid);

            return customerOrderTypeDataTable;
        }
    }
}
