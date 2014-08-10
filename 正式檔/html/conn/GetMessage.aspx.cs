using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class Mooncake2014_conn_GetMessage : System.Web.UI.Page
{
    string strID;
    protected void Page_Load(object sender, EventArgs e)
    {
     //   strID = Request.QueryString["id"];
        strID = Request.Form["id"];
     //   Response.Write("strID=" + strID);

        if (!IsPostBack)
        {
            if (strID != null)
                CreateDataList();
            else
                NoneXML(); 
        }
    }
    public void CreateDataList()
    {
        string strMessage = "";
        if (strID != "")
        {
            try
            {
                //Buffer and output as XML.
                Response.ContentType = "text/xml";
                Response.Charset = "UTF8";
                string strXML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
                strXML += "<message_list>\n";

                ConnectionStringSettings connSettings = ConfigurationManager.ConnectionStrings["ConnString"];
                SqlConnection conn = new SqlConnection(connSettings.ConnectionString);
                using (conn)
                {
                    SqlCommand cmd = new SqlCommand("sp_SelectBlessing", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@BlessingId", SqlDbType.VarChar, 36).Value = strID;
                    conn.Open();
                    SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    while (myReader.Read())
                    {
                        strMessage = myReader["Blessing"].ToString();
                        strMessage = strMessage.Replace("\"", "'");
                        strMessage = strMessage.Replace("<br />", Environment.NewLine);

                        strXML += "  <item id=\"" + myReader["BlessingID"].ToString() + "\" surname=\"" + myReader["Surname"].ToString() + "\" message=\"" + strMessage + "\" />\n";
                    }
                    myReader.Close();
                    cmd.Dispose();
                }

                strXML += "</message_list>";
                Response.Write(strXML);
            }
            catch (Exception ex)
            {
            //    Response.Write(ex.ToString());
                NoneXML();
            }
        }
        else
        {
            NoneXML();
        }
    }
    protected void NoneXML()
    {
        //Buffer and output as XML.
        Response.ContentType = "text/xml";
        Response.Charset = "UTF8";

        string strXML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
        strXML += "<message_list>\n";
        strXML += " <item>";
        strXML += " </item>\n";
        strXML += "</message_list>";
        Response.Write(strXML);
    }
}