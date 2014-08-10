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

public partial class Mooncake2014_conn_GetMessageList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CreateDataList();
        }
    }
    public void CreateDataList()
    {
        string strMessage = "";

        //Buffer and output as XML.
        Response.ContentType = "text/xml";
  //      Response.Charset = "UTF8";
        string strItem = "";
        string strXML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
        strXML += "<message_list>\n";
        Response.Write(strXML);

        ConnectionStringSettings connSettings = ConfigurationManager.ConnectionStrings["ConnString"];
        SqlConnection conn = new SqlConnection(connSettings.ConnectionString);
        using (conn)
        {
            SqlCommand cmd = new SqlCommand("sp_SelectBlessingList", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();
            SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (myReader.Read())
            {
                strMessage = myReader["Blessing"].ToString();
                strMessage = strMessage.Replace("\"", "＂");
                strMessage = strMessage.Replace(">", "＞");
                strMessage = strMessage.Replace("<", "＜");
                strMessage = strMessage.Replace("&", "＆");
                
         //       strMessage = strMessage.Replace("<br />", "");

           //     strItem += "  <item id=\"" + myReader["BlessingID"].ToString() + "\" surname=\"" + myReader["Surname"].ToString() + "\" message=\"" + strMessage + "\" />\n";

               //    Response.Write(myReader["BlessingID"].ToString() + "<br />");
                //    Response.Write(myReader["Surname"].ToString() + "<br />");
                //      Response.Write(strMessage + "<br />");

          //      Response.Write("   <name><![CDATA[" + myReader["Surname"].ToString() + "]]></name>\n");
         //       Response.Write("   <message><![CDATA[" + strMessage + "]]></message>\n");


                Response.Write("  <item id=\"" + myReader["BlessingID"].ToString() + "\" surname=\"" + myReader["Surname"].ToString() + "\" message=\"" + strMessage + "\" />\n");

          //      Response.Flush();
            }
            myReader.Close();
            cmd.Dispose();
        }

 //       Response.Write(strItem);
        Response.Write("</message_list>");

   //     strXML += strItem + "</message_list>";
   //     Response.Write(strXML);
    }
}