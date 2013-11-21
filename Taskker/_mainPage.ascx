<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="_mainPage.ascx.vb" Inherits="Taskker._mainPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/_addNewTask.ascx" TagPrefix="uc1" TagName="_addNewTask" %>

<asp:Label ID="lblInfo" runat="server"></asp:Label>
<div class="units-row">
    <div class="unit-40" >
        <uc1:_addNewTask runat="server" ID="_addNewTask" />
    </div>
    <div class="unit-60" style="padding:10px;padding-top:0px" ><asp:Label ID="lblHome"  runat="server" Text=""></asp:Label>


        <%--<asp:RadioButtonList ID="rlTsksList" runat="server">
            <asp:ListItem Value="0">Latest</asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:RadioButtonList>--%>

 
        		

        <nav class="nav-tabs" data-toggle="tabs" data-height="equal">
    <ul>
        <li><a href="#tab1" class="active">categories</a></li>
        <li><a href="#tab2">latest</a></li>
        <li><a href="#tab3" >public random</a></li>
         </ul>
</nav>
<div id="tab1">
    <asp:Repeater ID="rptCategories"   runat="server"  >
            <HeaderTemplate>    
            </HeaderTemplate>
            <ItemTemplate>
 <hgroup> 
  <h3><a href="t.aspx?c=<%# Eval("idCategThing") %>"  class="cteLnk"  style="text-decoration:none;">    <%# Eval("CategThing")%>  <span class="label label-red"><%# Eval("_cnter")%></span> </a>  </h3>
      	<h4 class="subheader"> <asp:Label ID="Label3" runat="server"  Text='<%# Eval("CategThingDesc") %>'></asp:Label>       </h4>
 </hgroup> 
            </ItemTemplate>
            <FooterTemplate>
            </FooterTemplate>
        </asp:Repeater>
</div>
<div id="tab2">
         <asp:Repeater ID="rLtestHomeTsks"   runat="server"  >
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
    <asp:Label ID="Label1" runat="server" ForeColor="#222222" CssClass="cteLnk"   Font-Size="90%"
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
</div>
<div id="tab3">
     <asp:Repeater ID="rptRandom"   runat="server"  >
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
    <asp:Label ID="Label1" runat="server" ForeColor="#222222" CssClass="cteLnk"  Font-Size="90%"
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
</div>


    </div>
    


</div>


  


