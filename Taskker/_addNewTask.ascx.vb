Public Class _addNewTask
    Inherits System.Web.UI.UserControl
    Dim _myTaskker As New _db
    Public _taskShell As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                ddlCateg.DataSource = _myTaskker.getDB("getAllMainCategories", "top", "100")
                ddlCateg.DataTextField = "CategThing"
                ddlCateg.DataValueField = "idCategThing"
                ddlCateg.SelectedValue = 30
                ddlCateg.DataBind()

                ddlTaskStatus.DataSource = _myTaskker.getDB("getStatuses", "Top", "8")
                ddlTaskStatus.DataTextField = "TaskkerStatus"
                ddlTaskStatus.DataValueField = "TaskkerStatusCode"
                ddlTaskStatus.SelectedValue = 1
                ddlTaskStatus.DataBind()

                txtStart.Text = Date.Today.Date
                txtDue.Text = Date.Today.AddDays(8).Date


                Try
                    If Session("taskShell") <> "" Then
                        Dim _tskTempShell() As String = Session("taskShell").ToString.Split("|")
                        txtSubject.Text = _tskTempShell(6)
                        txtBody.Text = _tskTempShell(7)
                        txtStart.Text = _tskTempShell(9)
                        txtDue.Text = _tskTempShell(10)
                        txtLocation.Text = _tskTempShell(11)
                        txtPrice.Text = _tskTempShell(12)
                        ddlCoin.SelectedValue = _tskTempShell(13)
                        txtHours.Text = _tskTempShell(14)
                        ddlCateg.SelectedValue = _tskTempShell(2)
                        ddlTaskStatus.SelectedValue = _tskTempShell(16)
                        rblAddPrivacy.SelectedValue = _tskTempShell(17)
                        ScriptManager.RegisterClientScriptBlock(Me.UpdatePanel2, GetType(String), "task", "cmdShowTaskker();", True)
                    End If
                Catch ex As Exception
                End Try
            End If

        Catch ex As Exception
        End Try
    End Sub

  

    Protected Sub btnAddTask_Click(sender As Object, e As EventArgs) Handles btnAddTask.Click
        Try
            lblTaskk.Text = ""
            cmdGetTaskDetails()

            If txtSubject.Text <> "" Then
                If Session("userLogin") <> "" Then
                    lblTaskk.Text = txtSubject.Text

                    Dim _tskArgm As String = "idUser|idStatus|idCateg|TaskkerUniq|TaskkerUserName|TaskkerEmail|TaskkerSubject|TaskkerBody|TaskkerHomePage|TaskkerStart|TaskkerDue|TaskkerLocation|TaskkerPrice|TaskkerCoin|TaskkerHours|TaskkerStatus|TaskkerPrivacy|TaskkerAssignmentEmail|TaskkerAttachment|TaskkerIP"
                    'ADD NEW TASK

                    '  ScriptManager.RegisterClientScriptBlock(Me.UpdatePanel2, GetType(String), "login", "cmdShowLogin();", True)
                    '   lblTaskk.Text = _taskShell
                    _myTaskker.exeDB("addNewTaskker", _tskArgm, _taskShell)
                    Session("taskShell") = ""
                    _tskArgm = ""
                Else
                    ' lblTaskk.Text = "You must login first"

                    ScriptManager.RegisterClientScriptBlock(Me.UpdatePanel2, GetType(String), "login", "cmdShowLogin();", True)


                End If
            Else
                lblTaskk.Text = "Subject cannot be empty"
                txtSubject.Focus()
            End If


        Catch ex As Exception

        End Try
    End Sub

    Public Sub cmdGetTaskDetails()
        Dim idUser As String = Session("userID")
        Dim UserEmail As String = Session("userEmail")
        Dim UserName As String = Session("userLogin")

        Dim MyGuid As Guid = Guid.NewGuid()
        Dim myGuidShort() As String = MyGuid.ToString.Split("-")
        Dim _tskUniq As String = myGuidShort(0).Substring(0, 5)
        Dim _tskUserName As String = Session("userLogin")
        Dim _tskUserEmail As String = Session("userEmail")
        Dim _tskSubject As String = txtSubject.Text
        Dim _tskBody As String = txtBody.Text
        Dim _tskHome As String = 1
        Dim _tskStart As String = txtStart.Text
        Dim _tskDue As String = txtDue.Text
        Dim _tskLoc As String = txtLocation.Text
        Dim _tskPrice As String = txtPrice.Text
        Dim _tskCoin As String = ddlCoin.SelectedValue
        Dim _tskHours As String = txtHours.Text
        Dim _tskCateg As String = ddlCateg.SelectedValue
        Dim _tskStatus As String = ddlTaskStatus.SelectedValue
        Dim _tskPrivacy As String = rblAddPrivacy.SelectedValue
        Dim _tskEmailAssign As String = "x"
        Dim _tskAttach As String = "x"
        Dim _tskIP As String = System.Web.HttpContext.Current.Request.ServerVariables("REMOTE_ADDR").ToString

        '"idUser|idStatus|idCateg|TaskkerUniq|TaskkerUserName|TaskkerEmail|TaskkerSubject|TaskkerBody|TaskkerHomePage|
        'TaskkerStart|TaskkerDue|TaskkerLocation|TaskkerPrice|TaskkerCoin|TaskkerHours|TaskkerStatus|TaskkerPrivacy|TaskkerAssignmentEmail|TaskkerAttachment|TaskkerIP "

        _taskShell = idUser & "|" & _tskStatus & "|" & _tskCateg & "|" & _tskUniq & "|" & _tskUserName & "|" & _tskUserEmail & "|" & _tskSubject & "|" & _tskBody & "|" & _tskHome _
            & "|" & _tskStart & "|" & _tskDue & "|" & _tskLoc & "|" & _tskPrice & "|" & _tskCoin & "|" & _tskHours & "|" & _tskStatus & "|" & _tskPrivacy & "|" & _tskEmailAssign & "|" & _tskAttach & "|" & _tskIP

        Session("taskShell") = _taskShell

    End Sub
End Class