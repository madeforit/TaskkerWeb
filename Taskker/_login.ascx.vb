Imports System.Data

Public Class _login
    Inherits System.Web.UI.UserControl
    Public dbSrv As New _db
    Public _rootDom As String = dbSrv._adminURL

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '""   config
        Try
            If Server.HtmlEncode(Request.QueryString("c")) <> "" Then
                btnSignIn.Visible = False
                pnlSignIn.Visible = True
                btnRegistration.Visible = False

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
                    ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "message", "alert('The user is not registred or password not right!');", True)
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
            ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "message", "alert('" & Server.HtmlEncode(txtUserName.Text) & " is not registred or password not right!');", True)
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

    Protected Sub btnSignIn_Click(sender As Object, e As EventArgs) Handles btnSignIn.Click
        btnSignIn.Visible = False
        pnlSignIn.Visible = True
        '     pnlLeadHome.Visible = False
        btnRegistration.Visible = False
        txtUserName.Focus()
    End Sub

    'Private Sub lnkACS_Click(sender As Object, e As EventArgs) Handles lnkACS.Click

    '    Response.Redirect("https://i4msco.accesscontrol.windows.net:443/v2/wsfederation?wa=wsignin1.0&wtrealm=http%3a%2f%2fi4.ms%2f")

    'End Sub

    'Private Sub lnkLocalHost_Click(sender As Object, e As EventArgs) Handles lnkLocalHost.Click
    '    '   Response.Redirect("https://i4msco.accesscontrol.windows.net:443/v2/wsfederation?wa=wsignin1.0&wtrealm=http%3a%2f%2flocalhost%3a15235%2f")
    '    Response.Redirect("SignIn.html")
    'End Sub

    Private Sub btnRegistration_Click(sender As Object, e As EventArgs) Handles btnRegistration.Click
        pnlLogin.Visible = True
        pnlSignIn.Visible = False
        '    pnlLeadHome.Visible = False
        '   pnlAdmin.Visible = False
        pnlRegistration.Visible = True
        txtPhoneNumber.Focus()
        txtEmail.Focus()
        btnRegistration.Visible = False
        btnSignIn.Visible = False
    End Sub

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
                dbSrv.SendMailNotification("User account Intelligent Forms (i4.ms) ", "<p> <strong><h3>Intelligent Forms (i4.ms)</h3></strong></p> <p>  User details:" & _User & " Password:" & _Pass & "</p>  <p> <a href='http://www.youtube.com/watch?v=1FFOwEUslXI'> Startup Guide</a></p>  <p>      </p>  http://i4.ms " & vbNewLine, dbSrv._adminMail)

                lblDetailsReg.Text = "A message was sent to your phone number!');"
            Catch ex As Exception
                ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "message", "alert('Some issues has occured!');", True)
                '    Exit Sub
            End Try
            '  Exit Sub
            '   pnlLeadHome.Visible = False
            pnlLogin.Visible = True
            pnlRegistration.Visible = False
            '   pnlAdmin.Visible = False
            pnlSignIn.Visible = True
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
                dbSrv.SendMailNotification("User account i4.ms ", "user:" & _User & " pass:" & _Pass & "<br>   Learn more at <a href='http://i4.ms'>http://i4.ms</a> <br>  <a href='http://i4.ms/privacy.aspx'>Privacy</a> " & vbNewLine & dbSrv._poweredBy, txtEmail.Text)
                dbSrv.SendMailNotification("New User account i4.ms ", txtEmail.Text & vbNewLine & "user:" & _User & " pass:" & _Pass & "  http://i4.ms " & vbNewLine, dbSrv._adminMail)
                '    lblDetailsReg.Text = "Please check your email for a message in short time and login!');"
                ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "message", "alert('We will send your login details soon! Note that currently we accept only corporate email domains... ');", True)

            Catch ex As Exception
                ScriptManager.RegisterClientScriptBlock(Me.Page, GetType(String), "message", "alert('Some issues has occured!');", True)
                Exit Sub
            End Try

            '    Exit Sub
            '   Response.Redirect("default.aspx")
            pnlLogin.Visible = True
            '   pnlLeadHome.Visible = False
            pnlRegistration.Visible = False
            ' pnlAdmin.Visible = False
            pnlSignIn.Visible = True
            txtUserName.Focus()
        Else
            txtEmail.Attributes.Add("class", "input-error")
            txtEmail.Focus()

        End If
    End Sub


    Private Sub btnCancelRegistrationPhone_Click(sender As Object, e As EventArgs) Handles btnCancelRegistrationPhone.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub



    Protected Sub btnCancelRegistrationEmail_Click1(sender As Object, e As EventArgs) Handles btnCancelRegistrationEmail.Click
        Response.Redirect("default.aspx")
    End Sub
End Class