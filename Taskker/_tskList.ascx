<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="_tskList.ascx.vb" Inherits="Taskker._tskList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
 <asp:Label ID="lblTitle" runat="server" Font-Size="X-Large" Text=""></asp:Label>  

 <asp:Repeater ID="rptTaskList"   runat="server"  >
              <HeaderTemplate>   
            </HeaderTemplate>
            <ItemTemplate>
          
 <div style=display:block;height:75px;>
                 <img id="Img1"  alt="" style=" padding: 2px;      margin-right: 5px;"  align=left  runat="server"
                 src='<%# cmdUserAvatar(Eval("TaskkerUserAvatar"))%>'   /> 

                <asp:Label ID="Label2" runat="server" ></asp:Label>

                <div ID='<%# Eval("TaskkerUniq") %>' 
                                   style="padding:0px;  padding-bottom:3px; padding-top:3px;  "> 
                         
   <a href='t.aspx?u=<%# Eval("TaskkerUserName") %>' class="cteLnk"><b> <%# Eval("TaskkerUserName") %></b></a>
     <a href='t.aspx?t=<%# Eval("TaskkerUniq") %>' class="cteLnk"><span> <%# Eval("TaskkerSubject") %></span> </a>
     <%--    <asp:Label ID="lblPriceAfterClientRabate" runat="server"  ForeColor=Orange 
                                         Text='<%#  cmdFormatPrice( Eval("TaskkerPrice"),  Eval("TaskkerCoin"), Eval("TaskkerHours"))   %>'></asp:Label>
     --%>
    <div style='text-align:justify; '>
    <asp:Label ID="Label1" runat="server" ForeColor="#222222" CssClass="cteLnk" 
       Text='<%# SrcLinks(Eval("TaskkerBody")) %>'></asp:Label>  

   <a href="t.aspx?t=<%# Eval("TaskkerUniq") %>"> <span style='font-size:11px; color:silver'> 
   <%--<%# cmdRelativeThis(Eval("TaskkerDate")) %>--%></span></a>
      <%-- <asp:Label ID="Label5" runat="server"  Text='<%# cmdCountComments(Eval("TaskkerUniq")) %>'></asp:Label>  --%>
        
   </div>
              </div></div>
            </ItemTemplate>
            <FooterTemplate>
            </FooterTemplate>
        </asp:Repeater>
