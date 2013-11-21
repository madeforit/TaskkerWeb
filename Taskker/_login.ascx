<%@ Control Language="VB" AutoEventWireup="false" CodeFile="_login.ascx.vb" Inherits="Taskker._login" %>
 <script>
     $(window).scroll(function () {
         $("#theFixed").css("top", Math.max(0, 240 - $(this).scrollTop()));
         $("#theFixedPanels").css("top", Math.max(0, 240 - $(this).scrollTop()));
         //    $("#theFixed").css("background", "#ffffff"); id="theFixed" style="position:fixed;top:240px;left:38%;width:490px;padding:30px;padding-top:5px; "
     });
 </script> 
<style>
   .theFixed {
  position:fixed;top:240px;left:38%;width:490px;padding:30px;padding-top:5px;
    }
   .theFixedPanels {
  position:fixed;top:240px;left:38%;width:490px;padding:30px;padding-top:15px; background:#ebebeb; filter:alpha(opacity=95); /* IE */
    -moz-opacity:0.95; /* Mozilla */
    opacity: 0.95; /* CSS3 */ 
    }
 
</style>
<center>
 <div  >

<asp:Panel ID="pnlLogin" runat="server"  CssClass="theFixed">    
<asp:Panel ID="pnlHomePage" runat="server"> 

<asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
<asp:Label ID="lblHomeForm" runat="server" Visible="false" Text=""></asp:Label>
 
     
 <asp:Panel ID="pnlSignIn" runat="server" Visible="false"    CssClass="theFixedPanels"  > 
 
       <asp:Label ID="lblDetailsReg" runat="server" Text="" Font-Size="X-Small"></asp:Label>   
  <h2 class="lead">Sign In</h2>  
     <div class="units-row" style="text-align:left">
          <label class="unit-100">
			Email/ Username <asp:TextBox ID="txtUserName" runat="server" ToolTip="Email/ Username" Font-Size="X-Large"  placeholder=""  TabIndex="1" Cssclass="width-100"  ></asp:TextBox> 
         </label>
		<label class="unit-100">
            Password
		  <asp:TextBox ID="txtPin" runat="server"    placeholder=""  Font-Size="X-Large"  TabIndex="2" Cssclass="width-100" TextMode="Password" ></asp:TextBox>
		 
		</label>
        
	 	<label class="unit-100">  
			  <asp:Button ID="btnCheckPin" runat="server"  BorderWidth="1"   Text="Submit" TabIndex="3"  CssClass='btn btn-green' Font-Size="Medium"  /> 
  <asp:Button ID="btnCancel"  runat="server"  Width="150" Text="Cancel"  TabIndex="4" CssClass='btn btn-white' Font-Size="Medium" OnClientClick="document.location='.';" /><br /><%--OnClientClick="this.disabled=true;this.value='Wait 
                please...'"--%>     <asp:Label ID="lblInfo" runat="server" Text=""></asp:Label>  
	 	</label> 
	</div>
 

   </asp:Panel> 

<asp:Panel ID="pnlRegistration" runat="server" Visible="false"   CssClass="theFixedPanels" >
    
 
   <h2 class="lead"  >Registration / Send Password</h2> 
         <div style="font-size:12px;line-height:normal;">
    Enter your email address and click register. By default you'll get a free 'Contact form' that you can embed or test and for now you may configure as
              many forms as you wish. If you need a more complex application or need help, please <a href="?aspx=contact">contact us</a></div>  <br /> 


       <div class="units-row" style="text-align:left">


        <div style="display:none"> 
          <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="Phone Number" Font-Size="Large" Cssclass="phone input width-100"  TabIndex="0"  
   ></asp:TextBox> 
    <asp:Button ID="BtnRegisterPhone" runat="server"  ForeColor="White" CssClass='btn btn-blue' Font-Size="Medium"  Text="Send" TabIndex="3"   /> 
    <asp:Button ID="btnCancelRegistrationPhone" Text="Cancel" runat="server" TabIndex="4"   CssClass='btn btn-whsite' Font-Size="Medium" OnClientClick="document.location='.';"  /><br /> <br />
 

        </div>                                                           
         <%-- <tr><td>  <hr size="1"/></td><td> OR  </td></tr> --%>
        <label class="unit-100" style="text-align:left">
           Your email address <asp:TextBox ID="txtEmail"  runat="server" type="email" ToolTip="Email" Cssclass="width-100 email input"   Font-Size="X-Large" 
               placeholder=""  BorderWidth="1"  TabIndex="0"  ></asp:TextBox>   <br />
   
            </label>
         <label class="unit-100"> <asp:Button ID="BtnRegisterEmail" runat="server"    BorderWidth="1" ForeColor="White"  CssClass='btn btn-blue' Font-Size="Medium"
                Text="Register"   ToolTip="Submit Password" TabIndex="3" /> 
    <asp:Button ID="btnCancelRegistrationEmail"  CssClass='btn btn-white' Font-Size="Medium" Text="Cancel"  runat="server"   OnClientClick="document.location='.';"  TabIndex="4"    /><br /> 
                  
             </label>
  </div>
   </asp:Panel>  



  <asp:Button ID="btnSignIn"   runat="server" ForeColor="White" CssClass='btn btn-green'   Font-Size="X-Large"  Text="Sign In" />   &nbsp;  
 <asp:Button ID="btnRegistration"   runat="server" ForeColor="White"  CssClass='btn btn-blue'  Font-Size="X-Large"  Text="FREE Registration" />  

 
        
 </ContentTemplate></asp:UpdatePanel>  
</asp:Panel> 
 </asp:Panel>

  
 </div></center>

<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
    <div  style="position:absolute;left:10px;top:10px; z-index:200; "  class="secondary alert icon-tape">
        loading...
    </div>
</ProgressTemplate>
</asp:UpdateProgress>   