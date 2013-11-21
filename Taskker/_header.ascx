<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="_header.ascx.vb" Inherits="Taskker._header" %>
<%@ Register Src="~/__login.ascx" TagPrefix="uc1" TagName="__login" %>

<div class="units-row units-split" style="background:#f4f4f4;  border-bottom:#ffd800 solid 3px"> 
	<div class="unit-centered unit-70" style="padding-top:20px;padding-left:5px;padding-right:5px; "> 
    <div class="unit-30" > 
        <asp:HyperLink ID="homeLnk" runat="server" NavigateUrl="../">  <div id="logo"></div></asp:HyperLink> 
    </div>
    <div class="unit-70"> 
    <nav class="nav-g" id="nav">     
             <asp:Label ID="lblUserDetails" runat="server"   ForeColor="Silver" Text=""></asp:Label> 
          <asp:Button ID="_logOut"     Visible="false"  UseSubmitBehavior="false" 
                runat="server" CssClass="btn btn-white"  Text="LogOff"  ></asp:Button> 
        <asp:UpdatePanel ID="UpdateLoginPanel1" runat="server"><ContentTemplate> 
        <uc1:__login runat="server" ID="__login" />
       
              </ContentTemplate></asp:UpdatePanel>


         <asp:Label ID="lblMainMenu" runat="server" Font-Size="Large" Text=""></asp:Label> 
          <asp:Panel ID="pnlUserAccount" runat="server" Visible="false"> 
             <ul>  <li>
                     <a href="a.aspx"  class="user" style="margin-left:10px;margin-right:10px;color:white;float:right" >Account Details</a> 
                      </li>
                   <li>
                     <a href="pages/features.html"  class="preview" style="margin-left:10px;margin-right:10px;color:white;float:right" >Get Help</a> 
                      </li>
                   <li>
                     <a href="http://i4.ms/f.aspx?i=9e1263d3-ad01-48b8-8562-adb9e66e1853&type=classic"  class="formpreview" style="margin-left:10px;margin-right:10px;color:white;float:right" >Support</a> 
                      </li>
                       <li>
                     <a href="http://i4.ms/f.aspx?i=4b150cdf-89b6-40bb-9a21-2cc10b11f5a0&type=classic"  class="user" style="margin-left:10px;margin-right:10px;color:white;float:right" >Contact</a> 
                      </li>
                      <%-- <li>
                          <a style='color:#00482e' href='?aspx=' >Forms</a>
                      </li>--%>
                  </ul>
          
          </asp:Panel>
    </nav>     
              <asp:Label ID="lblTest" runat="server" Text=""></asp:Label>
    </div> 
</div>  
</div>
        