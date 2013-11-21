Public Class _tskList
    Inherits System.Web.UI.UserControl
    Dim _myTaskker As New _db
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim _tskCtg As String = Server.HtmlEncode(Request.QueryString("c"))
            Dim _tskUser As String = Server.HtmlEncode(Request.QueryString("u"))
            Dim _tskTsk As String = Server.HtmlEncode(Request.QueryString("t"))

            Dim _dsTasks As New DataSet
            'TASK CATEGORIES
            If _tskCtg <> "" Then
                _dsTasks = _myTaskker.getDB("spTaskkerOnCategory", "C", _tskCtg)
                lblTitle.Text = _dsTasks.Tables(0).Rows(0).Item("CategThing").ToString
            End If
            'USER'S TASKS
            If _tskUser <> "" Then
                _dsTasks = _myTaskker.getDB("spTaskkerOnUser", "U", _tskUser)
                lblTitle.Text = _dsTasks.Tables(0).Rows(0).Item("TaskkerUserRealName").ToString
            End If
            'ONE TASKS
            If _tskTsk <> "" Then
                _dsTasks = _myTaskker.getDB("spTaskkerOnTask", "T", _tskTsk)
                lblTitle.Text = _dsTasks.Tables(0).Rows(0).Item("TaskkerUserRealName").ToString
            End If

            rptTaskList.DataSource = _dsTasks
            rptTaskList.DataBind()

        Catch ex As Exception
            lblTitle.Text = ex.Message.ToString
        End Try




    End Sub


    Public Function cmdUserAvatar(ByVal usr As String)
        Return _myTaskker.getUserAvatar(usr)
    End Function

    Public Function SrcLinks(ByVal myBody As Object)
        Dim regex As String = "((www\.|(http|https|ftp|news|file)+\:\/\/)[&#95;.a-z0-9-]+\.[a-z0-9\/&#95;:@=.+?,##%&~-]*[^.|\'|\# |!|\(|?|,| |>|<|;|\)])"
        Dim r As New Regex(regex, RegexOptions.IgnoreCase)
        Return r.Replace(myBody, "<a href=""$1"" title=""Click to open in a new window or tab"" target=""&#95;blank"">$1</a>").Replace("href=""www", "href=""http://www")
    End Function


End Class