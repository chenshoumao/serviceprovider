<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%
            int loop1, loop2;
            NameValueCollection coll;

            // Load Header collection into NameValueCollection object.
            coll = Request.Headers; 
            // Put the names of all keys into a string array.
            String[] arr1 = coll.AllKeys;
          /*  for (loop1 = 0; loop1 < arr1.Length; loop1++)
            {
                Response.Write("Key: " + arr1[loop1] + "<br>");
                // Get all values under this key.
                String[] arr2 = coll.GetValues(arr1[loop1]);
                for (loop2 = 0; loop2 < arr2.Length; loop2++)
                {
                    Response.Write("Value " + loop2 + ": " + Server.HtmlEncode(arr2[loop2]) + "<br>");
                }
            }   */
           
          //用户名
            Response.Write("iv-user " + ": " + Server.HtmlEncode(coll.GetValues("iv-user")[0]) + "<br>");
          //获取webseal的服务器名称
            Response.Write("iv_server_name " + ": " + Server.HtmlEncode(coll.GetValues("iv_server_name")[0]) + "<br>");
          //获取客户端请求的IP 
            Response.Write("iv-remote-address " + ": " + Server.HtmlEncode(coll.GetValues("iv-remote-address")[0]) + "<br>");
         %>
    </div>
    </form>
</body>
</html>
