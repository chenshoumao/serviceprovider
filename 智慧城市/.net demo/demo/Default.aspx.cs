using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Insus.NET;
using System.Net;

public partial class _Default : System.Web.UI.Page
{
    Member objMember = new Member();
    InsusJsUtility objJs = new InsusJsUtility();
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonReg_Click(object sender, EventArgs e)
    {
        try
        {
           Console.Write("6666666");
         //   objMember.UserName = this.TextBoxUserName.Text.Trim();
         //   objMember.Email = this.TextBoxEmail.Text.Trim();           
         //   objMember.Insert();
           
            objJs.JsAlert("恭喜您，成功注册为本站会员。");
        }
        catch (Exception ex)
        {
            objJs.JsAlert(ex.Message);
        }
    }
    public void GetHTTPResponseHeaders(object sender, EventArgs e)
    {
        string result = "";
        foreach (var item in Request.Headers.AllKeys)
        {
            result = string.Format("<p>{0}:{1}</p>", item, Request.Headers[item]);

            Response.Write(result);
        }

        Dictionary<string, string> HeaderList = new Dictionary<string, string>();
        string Url = "http://10.161.2.67/LoginFirst/index.jsp";
        WebRequest WebRequestObject = HttpWebRequest.Create(Url);
        WebResponse ResponseObject = WebRequestObject.GetResponse();

        objJs.JsAlert("iv-user" + "," + Request.QueryString["iv-user"]);

        foreach (string HeaderKey in ResponseObject.Headers)
        {
           
            objJs.JsAlert(HeaderKey + "," +ResponseObject.Headers[HeaderKey]);
            HeaderList.Add(HeaderKey, ResponseObject.Headers[HeaderKey]);
        }

        ResponseObject.Close();
      
        //return HeaderList;
    }

}
