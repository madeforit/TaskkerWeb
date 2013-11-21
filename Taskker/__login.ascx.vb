Imports System.Data
Public Class __login
    Inherits System.Web.UI.UserControl
    Public dbSrv As New _db
    Public _rootDom As String = dbSrv._adminURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '""   config
        Try
            If Server.HtmlEncode(Request.QueryString("c")) <> "" Then
             
                Dim myRemoteUser As String = Server.HtmlEncode(Request.QueryString("c"))
                If myRemoteUser.Contains("@") Then
                    txtUserName.Text = myRemoteUser
                Else
                    txtUserName.Text = dbSrv.Decrypt(myRemoteUser, "i4msOffice")
                End If
                '    txtUserName.Text = .Replace("office", "")
                txtPin.Focus()

                If txtUserName.Text = "" Then
                    txtUserName.Focus()
                End If

            End If
            'Button1.Attributes.Add("onclick", "alert('hello, world')")
            'Button1.Style.Add("background-color", "red")

            '' Example 3
            'body.Attributes("bgcolor") = "lightblue"

            pnlSignIn.Style.Add("display", "none")
            pnlRegistration.Style.Add("display", "none")
        Catch ex As Exception

        End Try

    End Sub


    Protected Sub btnCheckPin_Click(sender As Object, e As EventArgs) Handles btnCheckPin.Click
        Try
            lblInfo.Text = "Wait pls..."
            cmdLogin()
        Catch ex As Exception

        End Try

    End Sub

    Function cmdLogin()
        Try
            If txtUserName.Text.Length > 0 And txtUserName.Text.Length < 50 And txtPin.Text.Length > 0 And txtPin.Text.Length < 20 Then
                lblInfo.Text = ""
                Dim dsLoggIn As New DataSet
                Dim strUser, strPass As String
                strUser = Server.HtmlEncode(txtUserName.Text)
                strPass = Server.HtmlEncode(txtPin.Text)
                Dim _prmValues As String = strUser & "|" & strPass
                dsLoggIn = dbSrv.getDB("prcLoginv", "UserName|UPassword", _prmValues)
                Dim _LoginRes As Integer = CInt(dsLoggIn.Tables(0).Rows(0).Item("OutRes").ToString())
                If _LoginRes = 1 Then
                    Session("userLogin") = dsLoggIn.Tables(0).Rows(0).Item("UserName").ToString()
                    Session("userID") = dsLoggIn.Tables(0).Rows(0).Item("UserID").ToString()
                    Session("userEmail") = dsLoggIn.Tables(0).Rows(0).Item("UserEmail").ToString()
                    Session("userPhone") = dsLoggIn.Tables(0).Rows(0).Item("UserEmail").ToString()
                    Session.Timeout = 30

                    'Dim loginId As Integer = MySession.Current.LoginId
                    'Dim property1 As String = MySession.Current.Property1
                    'MySession.Current.Property1 = 1

                    'Dim myDate As DateTime = MySession.Current.MyDate
                    'MySession.Current.MyDate = DateTime.Now

                    Response.Redirect(Server.HtmlEncode(Request.RawUrl))

                Else
                    Session("userLogin") = ""
                    ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "task", "cmdShowLogin();alert('The user is not registred or password not right!')", True)
                    '    lblTopMessage.Text = "<div class='message message-info'><span class='close'></span>The user is not registred or password not right!!</div>"

                    Session.Abandon()
                End If
            Else
                txtUserName.Attributes.Add("class", "input-error")
                txtPin.Attributes.Add("class", "input-error")
                Session.Abandon()
                txtUserName.Focus()
            End If
            lblInfo.Text = ""
        Catch ex As Exception
            txtUserName.Attributes.Add("class", "input-error")
            ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "task", "cmdShowLogin();alert('" & Server.HtmlEncode(txtUserName.Text) & " is not registred or password not right!')", True)
            '     lblTopMessage.Text = "<div class='message message-info' id='topMsg'><span class='close' id='close' ></span>" & Server.HtmlEncode(txtUserName.Text) & " is not registred or password not right!'</div>"
            txtUserName.Focus()
        End Try
        Return True
    End Function

    Function cmdCheckPin()

        Try
            btnCheckPin.Enabled = False
            Dim token As Integer = CInt(Date.Now.Year)
            Dim myCode As String = CInt(Date.Now.Hour) + CInt(Date.Now.Minute) + token
            Dim myResult As Boolean

        Catch ex As Exception
            lblInfo.Text = ""
            'lblInfo.Text = "Not good! Try again or call your administrator"
            'Threading.Thread.Sleep(1000)
            '  btnCheckPin.Enabled = True
        End Try
    End Function

   

    Private Sub BtnRegisterPhone_Click(sender As Object, e As EventArgs) Handles BtnRegisterPhone.Click
        If txtPhoneNumber.Text <> "" Then
            Try
                Dim dsUserReg As DataSet
                dsUserReg = dbSrv.getDB("prcUserNewRegistration", "Phone", txtPhoneNumber.Text)
                Dim _User As String = dsUserReg.Tables(0).Rows(0).Item("User").ToString
                Dim _Pass As String = dsUserReg.Tables(0).Rows(0).Item("UPass").ToString
                Dim _Phone As String = dsUserReg.Tables(0).Rows(0).Item("Phone").ToString
                '  dbSrv.exeDB("prcUserNewRegistration", "Phone", txtPhoneNumber.Text)
                '     dbSrv.SendSmsNotification(_Phone, "user:" & _User & " pass:" & _Pass & "   http://i4.ms")
                dbSrv.SendMailNotification("User account Intelligent Forms (i4.ms) ", "<p> <strong><h3>Intelligent Forms (i4.ms)</h3></strong></p> <p>  User details:" & _User & " Password:" & _Pass & "</p>  <p>  Startup Guide</a></p>  " & vbNewLine, dbSrv._adminMail)

                lblDetailsReg.Text = "A message was sent to your phone number!');"
            Catch ex As Exception
                ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "message", "alert('Some issues has occured!');", True)
                '    Exit Sub
            End Try
            '  Exit Sub
       
            txtUserName.Focus()
        End If


    End Sub

    Private Sub BtnRegisterEmail_Click(sender As Object, e As EventArgs) Handles BtnRegisterEmail.Click
        If txtEmail.Text <> "" Then
            Try
                Dim dsUserReg As DataSet
                dsUserReg = dbSrv.getDB("prcUserNewRegistrationEmail", "Email", txtEmail.Text.Replace(" ", "").ToLower)
                Dim _User As String = dsUserReg.Tables(0).Rows(0).Item("User").ToString
                Dim _Pass As String = dsUserReg.Tables(0).Rows(0).Item("UPass").ToString
                Dim _Phone As String = dsUserReg.Tables(0).Rows(0).Item("Email").ToString
                '  dbSrv.exeDB("prcUserNewRegistration", "Phone", txtPhoneNumber.Text)
                dbSrv.SendMailNotification("User account tser ", "user:" & _User & " pass:" & _Pass & "<br>    " & vbNewLine & dbSrv._poweredBy, txtEmail.Text)

                ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "message", "alert('We will send your login details soon! Note that currently we accept only corporate email domains... ');", True)
                ' Response.Redirect(".")
            Catch ex As Exception
                ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "message", "alert('Some issues has occured!:" & ex.Message & "');", True)
                Exit Sub
            End Try

            '    Exit Sub
            '   Response.Redirect("default.aspx")
            'pnlLogin.Visible = True
            ''   pnlLeadHome.Visible = False
            'pnlRegistration.Visible = False
            '' pnlAdmin.Visible = False
            'pnlSignIn.Visible = True
            txtUserName.Focus()
        Else
            txtEmail.Attributes.Add("class", "input-error")
            txtEmail.Focus()

        End If
    End Sub


    Private Sub btnCancelRegistrationPhone_Click(sender As Object, e As EventArgs) Handles btnCancelRegistrationPhone.Click
        '  Response.Redirect("default.aspx")
        pnlLogin.Visible = True
        pnlRegistration.Visible = False
        pnlSignIn.Visible = False
    End Sub



End Class