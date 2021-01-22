using System;
using System.Collections.Generic;
using System.Text;

namespace CustomerOrderDetailViewer2._0
{
    public struct DBInfo
    {
        public readonly static string ConnectionString
            = @"Data Source=DESKTOP-PT93TFM\SQLEXPRESS;Initial Catalog=CustomerOrderViewer2.0;Integrated Security=True";

        public readonly static string CustomerGetListProc = "Customer_GetList";

        public readonly static string ItemGetListProc = "Item_GetList";

        public readonly static string CustomerOrderDeleteProc = "CustomerOrder_Delete";

        public readonly static string CustomerOrderDetailGetListCmd
            = "SELECT CustomerOrderId, CustomerId, ItemId, FirstName, LastName, [Description], Price, ActivInd FROM CustomerOrderDetail WHERE ActivInd = CONVERT(BIT, 1)";
        
        public readonly static string CustomerOrderUpsertProc = "CustomerOrder_Upsert";
    }
}

