using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InfobridgeSolution_Task
{
    public partial class CRUD : System.Web.UI.Page
    {
        private SqlDataAdapter SqlDA;
        string strConnectionString = ConfigurationManager.ConnectionStrings["strConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                BindGrid();
                reset();
            }
        }
        void BindGrid()
        {
            try
            {
                SqlConnection con = new SqlConnection(strConnectionString);
                SqlCommand cmd = new SqlCommand("sp_select", con);
                SqlDA = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                SqlDA.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch(Exception ex)
            {
                
            }
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            try
            {
                //getting length of uploaded file  
                int length = fileuploadEmpImage.PostedFile.ContentLength;
                //create a byte array to store the binary image data  
                byte[] imgbyte = new byte[length];
                //store the currently selected file in memeory  
                HttpPostedFile img = fileuploadEmpImage.PostedFile;
                //set the binary data  
                img.InputStream.Read(imgbyte, 0, length);

                SqlConnection con = new SqlConnection(strConnectionString);
                SqlCommand cmd = new SqlCommand("sp_insert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", Name.Text);
                cmd.Parameters.AddWithValue("@DateOfBirth", DOB.Text);
                cmd.Parameters.AddWithValue("@Sex", RadioButtonList1.Text);
                cmd.Parameters.AddWithValue("@phone", Phone.Text);
                cmd.Parameters.AddWithValue("@Address", Address.Text);
                cmd.Parameters.AddWithValue("@Photo", SqlDbType.Image).Value = imgbyte;

                cmd.Connection = con;
                SqlDA = new SqlDataAdapter(cmd);
                DataSet dt = new DataSet();
                SqlDA.Fill(dt);
                cmd.Dispose();
                BindGrid();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('" + dt.Tables[0].Rows[0][0].ToString() + "');", true);
                reset();
            }
            catch (Exception ex)
            {

            }
        }
        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            this.BindGrid();
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void update(object sender, GridViewUpdateEventArgs e)
        {
            try
            {

                GridViewRow row = GridView1.Rows[e.RowIndex];
                int Id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
                string Name = (row.FindControl("txtName") as TextBox).Text;
                string date = (row.FindControl("txtDateOfBirth") as TextBox).Text.Trim();
                string sex = (row.FindControl("RadioButtonList2") as RadioButtonList).Text.Trim();
                string Phone = (row.FindControl("txtPhone") as TextBox).Text.Trim();
                string Address = (row.FindControl("txtAddress") as TextBox).Text.Trim();
                FileUpload Photo = (row.FindControl("txtFileUpload") as FileUpload);

                //FileUpload fu = (FileUpload)row.FindControl("fileuploadEmpImage");

                if(Photo.HasFile)
                {
                    //getting length of uploaded file  
                    int length = Photo.PostedFile.ContentLength;
                    //create a byte array to store the binary image data  
                    byte[] imgbyte = new byte[length];
                    //store the currently selected file in memeory  
                    HttpPostedFile img = Photo.PostedFile;
                    //set the binary data  
                    img.InputStream.Read(imgbyte, 0, length);

                    SqlConnection con1 = new SqlConnection(strConnectionString);
                    SqlCommand cmd1 = new SqlCommand("sp_gridphoto", con1);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.AddWithValue("@Id", Id);
                    cmd1.Parameters.AddWithValue("@Photo", SqlDbType.Image).Value = imgbyte;

                    cmd1.Connection = con1;
                    con1.Open();
                    cmd1.ExecuteNonQuery();
                    con1.Close();
                    BindGrid();
                    
                }

                SqlConnection con = new SqlConnection(strConnectionString);
                SqlCommand cmd = new SqlCommand("sp_update", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", Id);
                cmd.Parameters.AddWithValue("@Name", Name);
                cmd.Parameters.AddWithValue("@DateOfBirth", date);
                cmd.Parameters.AddWithValue("@sex", sex);
                cmd.Parameters.AddWithValue("@phone", Phone);
                cmd.Parameters.AddWithValue("@Address", Address);

                cmd.Connection = con;
                con.Open();
                SqlDA = new SqlDataAdapter(cmd);
                DataSet dt = new DataSet();
                SqlDA.Fill(dt);
                cmd.Dispose();
                con.Close();
                GridView1.EditIndex = -1;
                BindGrid();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('" + dt.Tables[0].Rows[0][0].ToString() + "');", true);

            }
            catch (Exception ex)
            {

            }
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string constr = strConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("sp_delete"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Connection = con;
                    con.Open();
                    SqlDA = new SqlDataAdapter(cmd);
                    DataSet dt = new DataSet();
                    SqlDA.Fill(dt);
                    cmd.Dispose();
                    con.Close();
                    BindGrid();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('" + dt.Tables[0].Rows[0][0].ToString() + "');", true);

                }
            }
            this.BindGrid();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            this.BindGrid();

        }
        public void reset()
        {
            Name.Text = "";
            DOB.Text = "";
            RadioButtonList1.Text = null;
            RadioButtonList1.Text = "";
            Phone.Text = "";
            Address.Text = "";
            fileuploadEmpImage=null;
        }

    }
}