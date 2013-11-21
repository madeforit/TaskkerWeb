<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="Taskker._default" %>
<%@ Register Src="~/_header.ascx" TagPrefix="uc1" TagName="_header" %>
<%@ Register Src="~/_footer.ascx" TagPrefix="uc1" TagName="_footer" %>
<%@ Register Src="~/_mainPage.ascx" TagPrefix="uc1" TagName="_mainPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <%--FRAMEWORK CSS--%>
    <link rel="stylesheet" type="text/css" href="css/kube.min.css" />
	<link rel="stylesheet" type="text/css" href="css/master.css" />
    <link rel="stylesheet" href="css/colorbox.css" />
 
    <script type="text/javascript" src="js/jquery-1.10.1.min.js"></script>    
    <script type="text/javascript" src="js/kube.buttons.js"></script>
    <script type="text/javascript" src="js/kube.tabs.js"></script>
    <script type="text/javascript" src="js/jquery.flip.min.js"></script>
    <script type="text/javascript" src="js/jquery.colorbox.js"></script>
    <script type="text/javascript" src="js/unslider.min.js"></script>
    <script type="text/javascript" src="js/jquery.event.swipe.js"></script> 
     <%--FRAMEWORK END--%>
    <meta name="description" content="Taskker " />
    <meta name="keywords" content="" />
    <meta name="author" content="Madeforit.com" />
    <link rel="shortcut icon" href="favicon.png" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
</head>
<body>
    <form id="form1" runat="server" class="forms forms-inline">
    <div class="units-container">

<%--HEADER    START--%>   <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <uc1:_header runat="server" ID="_header" />
<%--HEADER    END--%>
<%-- MAIN PAGE  START--%>
<div class="units-row" >  
   <div class="unit-centered unit-80" > 
       <uc1:_mainPage runat="server" ID="_mainPage" /> 
     </div>
 </div> 
<%-- MAIN PAGE  END--%>     

<%--PAGE TEXT START--%> 
  <div class="units-row" > 
	<div class="unit-centered unit-70 teaser" >  
     <div class="units-row" >
    <div class="unit-100">
		
       <asp:Label ID="lblSitePage" runat="server" Text=""></asp:Label> 

      <%-- <img src="img/main.jpg" />--%>
    <%--   <uc1:_Analyses runat="server" id="_Analyses1" visible="false"/>
       <uc1:_MainPage runat="server" id="_MainPage1" />--%>
          <h1 style='font-size:20px;text-align:center'> <a href="?u=taskker" style='color:Orange; border-bottom:1px solid #222222'>Taskker </a><i style='font-size:28px;'>(tɑsːkr)</i> is a collaborational  platform that will help you on your tasks and be more productive </h1>
 
        </div>
    </div>


<%--        <hr />

        <div class="units-row" >
        <div class="unit-40" style="background:#808080">
		<h6></h6>
		 <p>TEXT </p> 
        </div>
    
        <div class="unit-20"> 
	 	<h6>Header 6</h6>
		 <p>TEXT </p>
       </div>	 
        <div class="unit-20"> 
	 	<h6>Header 6</h6>
		 <p>TEXT </p>
       </div>	 
        <div class="unit-20"> 
	 	<h6>Header 6</h6>
		 <p>TEXT </p>
       </div>	 
 </div>--%>
        

	</div>
</div>
<%--PAGE TEXT END --%> 
        <uc1:_footer runat="server" ID="_footer" />  
<%--END PAGE--%>
</div>


    </form>
</body>
</html>

