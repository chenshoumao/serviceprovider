<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            用户名：<asp:TextBox ID="TextBoxUserName" runat="server"></asp:TextBox>
            <br />
            邮&nbsp;&nbsp;&nbsp;&nbsp;箱：<asp:TextBox ID="TextBoxEmail" runat="server" Width="300"></asp:TextBox>
            <br />

            <asp:Button ID="ButtonReg" runat="server" Text="注册" OnClick="GetHTTPResponseHeaders" />
        </div>
    </form>
</body>
</html>
