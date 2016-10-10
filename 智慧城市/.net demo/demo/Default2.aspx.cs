using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Insus.NET;
public partial class Default2 : System.Web.UI.Page
{
    InsusJsUtility objJs = new InsusJsUtility();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ButtonReg_Click(object sender, EventArgs e)
    {
        try
        {
            objJs.JsAlert("6666666");
            //   objMember.UserName = this.TextBoxUserName.Text.Trim();
            //   objMember.Email = this.TextBoxEmail.Text.Trim();           
            //   objMember.Insert();

            //objJs.JsAlert("恭喜您，成功注册为本站会员。");
        }
        catch (Exception ex)
        {
            Console.Write(ex.Message);
        }
    }
}