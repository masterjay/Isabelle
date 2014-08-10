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

public partial class Mooncake2014_conn_AddMessage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Join();
        }
    }
    protected void Join()
    {
        try
        {
            string ReturnValue = "";
            string strID = "";
            string IP = "";
            string strSurname = Request.Form["surname"];
            string strBlessing = Request.Form["blessing"];
            string strName = Request.Form["name"];
            string strMobile = Request.Form["mobile"];
            string strEmail = Request.Form["email"];
            string strAddress = Request.Form["address"];
            string strIsRequirement = Request.Form["isrequirement"];
            string strRequirementQty = Request.Form["requirementqty"];
            string strIsNeedContact = Request.Form["isneedcontact"];

            IP = "[" + Request.ServerVariables["REMOTE_ADDR"] + "]";
            if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != "")
                IP += "[" + Request.ServerVariables["HTTP_X_FORWARDED_FOR"] + "]";

            ConnectionStringSettings connSettings = ConfigurationManager.ConnectionStrings["ConnString"];
            SqlConnection conn = new SqlConnection(connSettings.ConnectionString);
            using (conn)
            {
                SqlCommand cmd = new SqlCommand("sp_InsertBlessing", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter parm_Surname = new SqlParameter("@Surname", SqlDbType.NVarChar, 20);
                SqlParameter parm_Blessing = new SqlParameter("@Blessing", SqlDbType.NVarChar, 200);
                SqlParameter parm_Name = new SqlParameter("@Name", SqlDbType.NVarChar, 50);
                SqlParameter parm_Mobile = new SqlParameter("@Mobile", SqlDbType.VarChar, 20);
                SqlParameter parm_Email = new SqlParameter("@Email", SqlDbType.VarChar, 60);
                SqlParameter parm_Address = new SqlParameter("@Address", SqlDbType.NVarChar, 100);
                SqlParameter parm_IsRequirement = new SqlParameter("@IsRequirement", SqlDbType.NVarChar, 1);
                SqlParameter parm_RequirementQty = new SqlParameter("@RequirementQty", SqlDbType.NVarChar, 10);
                SqlParameter parm_IsNeedContact = new SqlParameter("@IsNeedContact", SqlDbType.NVarChar, 1);
                SqlParameter parm_IP = new SqlParameter("@IP", SqlDbType.VarChar, 40);

                parm_Surname.Value = strSurname;
                parm_Blessing.Value = strBlessing.Replace(Environment.NewLine, "<br />");
                parm_Name.Value = strName;
                parm_Mobile.Value = strMobile;
                parm_Email.Value = strEmail;
                parm_Address.Value = strAddress;
                parm_IsRequirement.Value = strIsRequirement;
                parm_RequirementQty.Value = strRequirementQty;
                parm_IsNeedContact.Value = strIsNeedContact;
                parm_IP.Value = IP.Replace("[]", "");

                cmd.Parameters.Add(parm_Surname);
                cmd.Parameters.Add(parm_Blessing);
                cmd.Parameters.Add(parm_Name);
                cmd.Parameters.Add(parm_Mobile);
                cmd.Parameters.Add(parm_Email);
                cmd.Parameters.Add(parm_Address);
                cmd.Parameters.Add(parm_IsRequirement);
                cmd.Parameters.Add(parm_RequirementQty);
                cmd.Parameters.Add(parm_IsNeedContact);
                cmd.Parameters.Add(parm_IP);
                conn.Open();

                SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                while (myReader.Read())
                {
                    ReturnValue = myReader["Result"].ToString();
                    strID = myReader["ID"].ToString();
                }
                myReader.Close();
                cmd.Dispose();
            }
         //   Response.Write(ReturnValue);
            
            if (ReturnValue == "Y")
                XMLTag("true", "", strID);
            else
                XMLTag("false", "資料新增失敗!!請稍後重新再試!", "");
        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
    }
    protected void XMLTag(string strResult, string strAlert, string strData)
    {
        //Buffer and output as XML.
        Response.ContentType = "text/xml";
        Response.Charset = "UTF8";

        string strXML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
        strXML += "<output>\n";
        strXML += "  <result>" + strResult + "</result>\n";
        strXML += "  <alert>" + strAlert + "</alert>\n";
        strXML += "  <id>" + strData + "</id>\n";
        strXML += "</output>";
        Response.Write(strXML);
    }
}