using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace InfobridgeSolution_Task
{
    /// <summary>
    /// Summary description for EmployeeImageHandler
    /// </summary>
    public class EmployeeImageHandler : IHttpHandler
    {
        string strConnectionString = ConfigurationManager.ConnectionStrings["strConnectionString"].ConnectionString;

        public void ProcessRequest(HttpContext context)
        {
            string imageid = context.Request.QueryString["Id"];
            SqlConnection con = new SqlConnection(strConnectionString);
            con.Open();
            SqlCommand command = new SqlCommand("select Photo from adduser where Id=" + imageid, con);
            SqlDataReader dr = command.ExecuteReader();
            dr.Read();
            context.Response.BinaryWrite((Byte[])dr[0]);
            con.Close();
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}