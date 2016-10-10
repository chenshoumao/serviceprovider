<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MgtMember.aspx.cs" Inherits="MgtMember" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridViewMember" runat="server" AutoGenerateColumns="false" Width="400"
                DataKeyNames="UserName" OnRowDataBound="GridViewMember_RowDataBound" OnRowCreated="GridViewMember_RowCreated">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            UserName
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("UserName") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Email
                        </HeaderTemplate>
                        <ItemTemplate>
                            <%# Eval("Email") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            IsUser
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LabelIsUser" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Button ID="ButtonOpt" runat="server" Text="设置" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
