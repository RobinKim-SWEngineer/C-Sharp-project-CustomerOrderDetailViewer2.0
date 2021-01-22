using CustomerOrderDetailViewer2._0.Model;
using System.Collections.Generic;
using System.Data.SqlClient;
using Dapper;
using System.Data;

namespace CustomerOrderDetailViewer2._0.Repository
{
    class ItemGetListCommand
    {
        private string _procName;
        private string _connectionString;

        public ItemGetListCommand()
        {
            _connectionString = DBInfo.ConnectionString;
            _procName = DBInfo.ItemGetListProc;
        }

        public IEnumerable<ItemModel> GetList()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var itemModels = connection.Query<ItemModel>(_procName, commandType: CommandType.StoredProcedure);

                return itemModels;
            }
        }
    }
}
