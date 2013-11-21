<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="_addNewTask.ascx.vb" Inherits="Taskker._addNewTask" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/__login.ascx" TagPrefix="uc1" TagName="__login" %>


 

<asp:UpdatePanel ID="UpdatePanel2" runat="server"><ContentTemplate>
    <div ID='imic' style="margin-bottom:-10px;margin-top:-10px">
        <img src="img/main.jpg" />

    </div>
<asp:Panel ID='PnlAddTaskker' runat=server  CssClass="message"  >
<script type="text/javascript"> 
    oned = 0;
    $(document).ready(function () {
        $('#_mainPage__addNewTask_txtSubject').click(function () {
            if (oned == 0) {
                $('#tblMore').slideToggle('fast');
                $('#imic').slideToggle('fast');
                $('#counter').html();
            }
            oned = 1;
            return false;
        });
        $('.close').click(function () {
            $('#tblMore').slideToggle('fast');
            $('#imic').slideToggle('fast');
            oned = 0;
            return false;
        });

        if (oned == 1) {
            $('#tblMore').show();
            $('#imic').hide();
        }
        else {
            $('#tblMore').hide();
            $('#imic').show();

        }

        $('#_mainPage__addNewTask_txtSubject').keyup(function () {
            var len = this.value.length;
            if (len >= 250) { this.value = this.value.substring(0, 250); return false; }
            $('#counter').html(250 - len + ' left in subject');
        });

        $('#_mainPage__addNewTask_txtBody').keyup(function () {
            var len = this.value.length;
            if (len >= 1000) { this.value = this.value.substring(0, 1000); return false; }
            $('#counter').html(1000 - len + ' left in task details');
        });


    });


    function cmdShowLogin() {
        $(document).ready(function () {
            $('#_header___login_pnlSignIn').slideToggle('fast');
            $('#_header___login_txtUserName').focus();
            $('#divlogin').hide();
        });
    }


    function cmdShowTaskker() {
        $(document).ready(function () {
            $('#tblMore').show();
            $('#imic').show();
            $('#counter').html();
        });
    }


</script>  

<h2>What do you have to do?</h2> 
        <span class="close"></span>
  <asp:TextBox ID="txtSubject" runat="server" AutoCompleteType="Notes"  CssClass="width-100"   TextMode="MultiLine"    ></asp:TextBox>
    <asp:RequiredFieldValidator ID="SubjectRequired" runat="server"  Visible=false
                                     ControlToValidate="txtSubject" ErrorMessage="Subject is required." 
                                     ToolTip="Add some subject." CssClass="error" >*</asp:RequiredFieldValidator>  <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server"  
                TargetControlID="txtSubject" WatermarkText="Write here your task title"></asp:TextBoxWatermarkExtender></td>
          <asp:AutoCompleteExtender runat="server" ID="autoComplete1" TargetControlID="txtSubject" 
            ServiceMethod="GetProducts" ServicePath="AutoComplete.asmx" MinimumPrefixLength="3"
            CompletionSetCount="5">
        </asp:AutoCompleteExtender>   
    <div id="counter"></div>
    <div   id="tblMore" style="display:none; margin-bottom:-80px" >
       <br />
<asp:TextBox ID="txtBody" CssClass="width-100" runat="server"  AutoCompleteType="Notes"  Height="90px" TextMode="MultiLine" 
       ></asp:TextBox>
              <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Visible=false
                                     ControlToValidate="txtBody" ErrorMessage="Add more details." 
                                     ToolTip="Task details" CssClass="error" >*</asp:RequiredFieldValidator>--%>
        <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" 
            TargetControlID="txtBody" WatermarkText="In more details..."></asp:TextBoxWatermarkExtender>
             <br /> 
        <%-- <asp:DropDownList ID="ddlSCateg"  CssClass=forma Visible=false runat="server" 
            Width="133px">
          </asp:DropDownList>--%> 
  <table><tr>
           <td>   Category: <br /><asp:DropDownList ID="ddlCateg"  ToolTip="Category" CssClass=width-100  runat="server" Font-Size="Large">
          </asp:DropDownList></td>
           <td>  Status:  <br /><asp:DropDownList ID="ddlTaskStatus"  ToolTip="Status" Font-Size="Large"
        runat="server"   CssClass=width-100    >
    </asp:DropDownList></td> </tr>

           <tr> <td> Task Value: <br /><asp:TextBox ID="txtPrice" runat="server" CssClass="width-50"   Font-Size="Large"
                 ToolTip="Value of your task" ></asp:TextBox><asp:DropDownList ID="ddlCoin" runat="server"  CssClass="width-40" Font-Size="Large">
                 <asp:ListItem>USD</asp:ListItem>
                 <asp:ListItem Selected="True">EUR</asp:ListItem>
             </asp:DropDownList> 
             <asp:RangeValidator ID="RangeValidator1" runat="server" 
                 ControlToValidate="txtPrice" ErrorMessage="Range Validator" MaximumValue="1500" 
                 MinimumValue="0" Type="Double" CssClass="error">*</asp:RangeValidator>
             <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender6" runat="server" 
                 TargetControlID="txtPrice" WatermarkText="Amount">
             </asp:TextBoxWatermarkExtender>
              <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ControlToValidate="txtPrice" Display="Dynamic" 
            ErrorMessage="How much you're willing to pay for solving this task?" CssClass="error"></asp:RequiredFieldValidator>--%>
                   <br /></td> <td>  Hours: <br />  <asp:TextBox ID="txtHours" runat="server" CssClass="width-50"  Font-Size="Large"
                 ToolTip="Total time for your task in hours" ></asp:TextBox>
             <asp:RangeValidator ID="RangeValidator2" runat="server" 
                 ControlToValidate="txtHours" ErrorMessage="Range Validator" MaximumValue="500" 
                 MinimumValue="0" Type="Double" Visible="false" CssClass="error">*</asp:RangeValidator>
             <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender7" runat="server" 
                 TargetControlID="txtHours" WatermarkText="Total h">
             </asp:TextBoxWatermarkExtender> <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
            ControlToValidate="txtHours" Display="Dynamic" 
            ErrorMessage="How many hours assigned for this task?" Visible="false" CssClass="error"></asp:RequiredFieldValidator>
                    <br /> </td> </tr>

             <tr> <td>
Start Date: <br />  <asp:TextBox ID="txtStart" ReadOnly="true" ToolTip='Start' runat="server" Font-Size="Medium"  CssClass="width-80"  ></asp:TextBox> 
           <asp:TextBoxWatermarkExtender TargetControlID="txtStart" WatermarkText="Start datetime"
        ID="TextBoxWatermarkExtender4" runat="server"></asp:TextBoxWatermarkExtender>
    <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtStart"></asp:CalendarExtender>
  
                </td>
                  <td>
                      End Date: <br /> 
   <asp:TextBox ID="txtDue"  ReadOnly="true" runat="server" ToolTip='Due ' Font-Size="Medium" CssClass="width-80"  ></asp:TextBox> 
        <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender5" runat="server"   TargetControlID="txtDue" WatermarkText="Due to"></asp:TextBoxWatermarkExtender> 
         <asp:CalendarExtender ID="CalendarExtender2" runat="server"    TargetControlID="txtDue"></asp:CalendarExtender>             
      
                  </td>
             </tr>

       </td> </tr>

             <tr> <td>
 Who is Involved:  <br /><asp:RadioButtonList ID="rblAddPrivacy" ToolTip='Privacy' ForeColor="Black" 
            runat="server"  Font-Size="Small" RepeatColumns="5" RepeatDirection="Horizontal" BorderWidth="0px"> 
      <asp:ListItem Value=1 Selected=True>Everyone</asp:ListItem>
       <asp:ListItem Value=0>Me</asp:ListItem>
      </asp:RadioButtonList> 
                     </td>
                 <td>
Location: <br />  
  <asp:TextBox ID="txtLocation" runat="server" ToolTip="Location" CssClass="width-80" Font-Size="Large"></asp:TextBox>
                    <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender3" runat="server" 
                        TargetControlID="txtLocation" WatermarkText="Where?"></asp:TextBoxWatermarkExtender>   
                     </td>
             </tr>
       </table>

     </div>
     
    <div style="margin-top:4px;margin-right:4px; text-align:right" />
             <asp:Button cssclass="btn btn-orange width-50" ID="btnAddTask" runat="server" Text="Add Your Task"   Font-Size="Medium" />
     </div>
</asp:Panel>
 
  

      

 <%-- <td> With:</td><td>   <asp:TextBox ID="txtAsignTaskEmail" runat="server"  CssClass="forma"  Visible=false ></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvAsignTask" runat="server" Visible=false
                                     ControlToValidate="txtAsignTaskEmail" ErrorMessage="" 
                                      Display="Dynamic" >*</asp:RequiredFieldValidator>

       <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender8" runat="server" 
                        TargetControlID="txtAsignTaskEmail" WatermarkText="User email"></asp:TextBoxWatermarkExtender>
                   <asp:TextBox ID="txtEmail" runat="server"  Visible=false></asp:TextBox>
                 </td> </tr><tr>--%>
    <%--       <asp:Panel ID="pnlConditions" runat="server" Visible=false  >
    <div style=' z-index:500;position:absolute; right:25px; top:45px; border:1px solid silver;background:#f4f4f4; padding-left:20px;width:475px;height:180px;overflow-y:scroll;overflow:-moz-scrollbars-vertical'>
 <br /> <br /><b>READ THIS AND AGREE WITH THIS TERMS AND CONDITIONS BEFORE YOU PUBLISH ANY TASK!</b> 

   <asp:Label runat=server ID='lblTerms'></asp:Label>
   <br /><br />
        <asp:Button ID="LinkButton2" runat="server" Text="Close this"></asp:Button>
        <br /><br /><br />
</div>  
    </asp:Panel>--%> 
   
<div style="padding:4px; padding-top:2px;
     padding-bottom:2px; z-index:1400; position:absolute; right:50px; bottom:80px; font-size:13px">
      <asp:Label ID="lblTaskk"  BackColor=Red ForeColor=White  runat="server" Text=""  ></asp:Label>
    </div>



 </ContentTemplate></asp:UpdatePanel>


   