using System.Data;
using System.Data.SqlClient;

namespace PostgradSystem
{
    public static class DbManager
    {
        private static readonly SqlConnection sqlCon;

        static DbManager()
        {
            sqlCon = new SqlConnection("Data Source=localhost;Initial Catalog=PostGradOffice;Integrated Security=True");
            sqlCon.Open();
        }

        public static DataTable CallProc(string procName, params SqlParameter[] allParameters)
        {
            DataTable data = new DataTable();
            using (var cmd = sqlCon.CreateCommand())
            {
                cmd.CommandText = procName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(allParameters);
                using (var adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(data);
                }
            }
            return data;
        }

        public static DataTable Query(string query)
        {
            DataTable data = new DataTable();
            using (var cmd = sqlCon.CreateCommand())
            {
                cmd.CommandText = query;
                using (var adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(data);
                }
            }
            return data;
        }
    }
}