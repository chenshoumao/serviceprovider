using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Insus.NET;

public partial class MgtMember : System.Web.UI.Page
{
    Member objMember = new Member();
    InsusJsUtility objJs = new InsusJsUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Data_Binding();
        }
    }

    private void Data_Binding()
    {
        this.GridViewMember.DataSource = objMember.GetAll();
        this.GridViewMember.DataBind();
    }
    protected void GridViewMember_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;

        var drv = e.Row.DataItem as DataRowView;

        if (e.Row.FindControl("LabelIsUser") != null && e.Row.FindControl("ButtonOpt") != null)
        {
            var lbl = e.Row.FindControl("LabelIsUser") as Label;
            var btn = e.Row.FindControl("ButtonOpt") as Button;

            //lbl.Text = (bool)drv["IsUser"] ? "Y" : "N";
            if ((bool)drv["IsUser"])
            {
                lbl.Text = "Y";
                btn.Text = "取消";
            }
            else
            { 
                lbl.Text = "N";
                btn.Text = "设置";
            }
        }
    }
    protected void GridViewMember_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;
        if (e.Row.FindControl("ButtonOpt") != null)
        {
            var OptButton = e.Row.FindControl("ButtonOpt") as Button;
            OptButton.Click += new EventHandler (OptButton_Click);
        }
    }
    private void OptButton_Click(object sender, EventArgs e)
    {
        var Button = sender as Button;      
        GridViewRow gvr = (GridViewRow)Button.Parent.Parent;
        objMember.UserName =GridViewMember.DataKeys[gvr.RowIndex].Value.ToString();  
        var label = (Label)this.GridViewMember.Rows[gvr.RowIndex].FindControl("LabelIsUser");
        switch (label.Text)
        {
            case "Y":
                objMember.IsUser = false;
                break;
            case "N":
                objMember.IsUser = true;
                break;
        }
        try
        {
            objMember.Update();
            Data_Binding();
            objJs.JsAlert("成功设置权限。");
        }
        catch (Exception ex)
        {
            objJs.JsAlert(ex.Message);
        }
    }
}

