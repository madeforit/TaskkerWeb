<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="__login.ascx.vb" Inherits="Taskker.__login" %>
<%-- <script>
     $(window).scroll(function () {
         $("#theFixed").css("top", Math.max(0, 240 - $(this).scrollTop()));
         $("#theFixedPanels").css("top", Math.max(0, 240 - $(this).scrollTop()));
         //    $("#theFixed").css("background", "#ffffff"); id="theFixed" style="position:fixed;top:240px;left:38%;width:490px;padding:30px;padding-top:5px; "
     });
 </script> --%>
<style>
    .theFixedPanels {    margin-bottom: -380px;  z-index:999999;  }
</style>
<asp:Label ID="lblTopMessage" runat="server" Text=""></asp:Label>
       
<asp:Panel ID="pnlLogin" runat="server"  CssClass="theFixed">    
<asp:Panel ID="pnlHomePage" runat="server"> 

<asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
<asp:Label ID="lblHomeForm" runat="server" Visible="false" Text=""></asp:Label>
<%-- <div class="message message-info">
    <span class="close"></span>
    Yhaam, this is info!
</div>--%>
     
 <asp:Panel ID="pnlSignIn" runat="server"    CssClass="theFixedPanels message message-success"  > 
 
       <asp:Label ID="lblDetailsReg" runat="server" Text="" Font-Size="X-Small"></asp:Label>   
  <h2 class="lead">Sign In</h2>  
     <div class="units-row" style="text-align:left">
          <label class="unit-100">
			Email/ Username <asp:TextBox ID="txtUserName" runat="server" AutoCompleteType="Email" ToolTip="Email/ Username" Font-Size="X-Large"  placeholder=""  TabIndex="1" Cssclass="width-100"  ></asp:TextBox> 
         </label>
		<label class="unit-100">
            Password
		  <asp:TextBox ID="txtPin" runat="server"    placeholder=""  Font-Size="X-Large"  TabIndex="2" Cssclass="width-100" TextMode="Password" ></asp:TextBox>
		 
		</label>
        
	 	<label class="unit-100">  
			  <asp:Button ID="btnCheckPin" runat="server"  BorderWidth="1"   Text="Submit" TabIndex="3"  CssClass='btn btn-green'   /> 
<%--  <asp:Button ID="btnCancel"  runat="server"  Width="150" Text="Cancel"  TabIndex="4" 
      CssClass='btn btn-white' Font-Size="Medium" OnClientClick="document.location='.';" />--%>
         <%--     <input class="btn btn-white" ID="btnCancel" type="button" value="Cancel" />--%> 
               <input class="btn btn-white" ID="btnCancel" style="padding-left:10px;" type="button" value="Cancel" /> 

              <a href="#" id="lnkPassw" style="padding-left:20px;">Send password</a> 
             <br /><%--OnClientClick="this.disabled=true;this.value='Wait 
                please...'"--%>     <asp:Label ID="lblInfo" runat="server" Text=""></asp:Label>  
	 	</label> 
	</div>
 

   </asp:Panel> 

<asp:Panel ID="pnlRegistration" runat="server"     CssClass="theFixedPanels message message-info" >
    
 
   <h2 class="lead"  >Registration / Send Password</h2>  
       <div class="units-row" style="text-align:left">


        <div style="display:none"> 
 <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="Phone Number" Font-Size="Large" Cssclass="phone input width-100"  TabIndex="0"  
   ></asp:TextBox> 
    <asp:Button ID="BtnRegisterPhone" runat="server"  ForeColor="White" CssClass='btn btn-blue' Font-Size="Medium"  Text="Send" TabIndex="3"   /> 
    <asp:Button ID="btnCancelRegistrationPhone" Text="Cancel" runat="server" TabIndex="4"   CssClass='btn btn-whsite' Font-Size="Medium" OnClientClick="document.location='.';"  /><br /> <br />
 

        </div>                                                           
         <%-- <tr><td>  <hr size="1"/></td><td> OR  </td></tr> --%>
        <label class="unit-100" style="text-align:left">
           Your email address <asp:TextBox ID="txtEmail"  runat="server" type="email" ToolTip="Email" AutoCompleteType="Email" Cssclass="width-100 email input"   Font-Size="X-Large" 
               placeholder=""  BorderWidth="1"  TabIndex="0"  ></asp:TextBox>   <br />
   
            </label>
         <label class="unit-100"> <asp:Button ID="BtnRegisterEmail" runat="server"   ForeColor="White"  CssClass='btn btn-blue' 
                Text="Register"   ToolTip="Submit Password" TabIndex="3" /> 
 <%--   <asp:Button ID="btnCancelRegistrationEmail"  CssClass='btn btn-white' Font-Size="Medium" Text="Cancel"  runat="server"   OnClientClick="document.location='.';"  TabIndex="4"    /><br /> 
 --%>           <input class="btn btn-white" ID="btnCancelR" type="button" style="padding-left:10px;" value="Cancel" />            
             </label>
 
   </asp:Panel>  



<%--  <asp:Button ID="btnSignIn"   runat="server" ForeColor="White" CssClass='btn btn-green'   Font-Size="X-Large"  Text="Sign In" />   &nbsp;  
 <asp:Button ID="btnRegistration"   runat="server" ForeColor="White"  CssClass='btn btn-blue'  Font-Size="X-Large"  Text="FREE Registration" />  --%>

  

 </ContentTemplate></asp:UpdatePanel>  
</asp:Panel> 
 </asp:Panel>

 
           <%--  <asp:Button cssclass="btn btn-green width-40" ID="btnSign" runat="server" Text="Sign In"   Font-Size="Medium" />
      --%>      
   <%--   <asp:Button cssclass="btn btn-blue width-40" ID="btnReg" runat="server" Text="Register"   Font-Size="Medium" />
  --%>  
       <div ID='divlogin' style="margin-bottom:-10px">
      <input class="btn btn-green" ID="btnSign" type="button" value="Sign In" />
      <input class="btn btn-blue" ID="btnReg" type="button" value="Register" /> 
 </div>

<script type="text/javascript">
    $(document).ready(function () {
        $('#btnSign').click(function () {
            $('#_header___login_pnlSignIn').slideToggle('fast');
            $('#_header___login_txtUserName').focus();
            $('#divlogin').hide();
            return false;
        });
        $('#btnCancel').click(function () {
            $('#_header___login_pnlSignIn').hide();
            $('#divlogin').show();
            return false;
        });
        $('#btnReg').click(function () {
            $('#_header___login_pnlRegistration').slideToggle('fast');
            $('#_header___login_txtEmail').focus();
            $('#divlogin').hide();
            return false;
        });

        $('#lnkPassw').click(function () {
            $('#_header___login_pnlRegistration').slideToggle('fast');
            $('#_header___login_pnlSignIn').hide();
            $('#_header___login_txtEmail').focus();
            $('#divlogin').hide();
            return false;
        }); 

        $('#btnCancelR').click(function () {
            $('#_header___login_pnlRegistration').hide();
            $('#divlogin').show();
         return false;
        });

        $('#close').click(function () { 
            $('#topMsg').hide();
            return false;
        });
    });
</script>  
 

<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
    <div  style="position:absolute;left:10px;top:10px; z-index:200; "  class="secondary alert icon-tape">
        loading...
    </div>
</ProgressTemplate>
</asp:UpdateProgress>   