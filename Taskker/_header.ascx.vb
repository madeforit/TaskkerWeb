Public Class _header
    Inherits System.Web.UI.UserControl
    Dim _myDb As New _db
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("userLogin") <> "" Then
            __login.Visible = False
            _logOut.Visible = True
        End If
    End Sub

    Private Sub _logOut_Click1(sender As Object, e As EventArgs) Handles _logOut.Click
        Try
            Dim dbSrv As New _db
            dbSrv.exeDB("prcLogOut", "UserName", CStr(Session("userLogin")))
        Catch ex As Exception
        End Try
        Session.Abandon()
        Response.Redirect("default.aspx")
    End Sub
End Class