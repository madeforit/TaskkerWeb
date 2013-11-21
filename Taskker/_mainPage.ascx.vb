Public Class _mainPage
    Inherits System.Web.UI.UserControl
    Dim _myTaskker As New _db
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '  _myTaskker.SendMailNotification("muie steaua", "test", "mariusdima@msn.com")
        Try
            Dim dsUserStats As New DataSet
            Dim _dsLatestTasks As New DataSet
            Dim _dsLtestHomeTsks As New DataSet
            Dim _dsRandomHomeTsks As New DataSet
            '  spTaskkerOnHomePageLatestPublicProgress

            If Session("userLogin") <> "" Then
                Dim duser As String = "8d302f72e54a9c4a773c99971d3d1fd5"
                dsUserStats = _myTaskker.getDB("getTaskkerStatsOnUser", "idUser", duser)
                _dsLtestHomeTsks = _myTaskker.getDB("spTaskkerOnLatestUserProgress", "idUser", duser)
                _dsRandomHomeTsks = _myTaskker.getDB("spTaskkerOnRandomPublicProgress", "", "")
                _dsLatestTasks = _myTaskker.getDB("getAllCategoriesUser", "Top|idUser", "7|" & duser)
            Else
                dsUserStats = _myTaskker.getDB("getTaskkerStats", "", "")
                _dsLtestHomeTsks = _myTaskker.getDB("spTaskkerOnLatestPublicProgress", "", "")
                _dsRandomHomeTsks = _myTaskker.getDB("spTaskkerOnRandomPublicProgress", "", "")
                _dsLatestTasks = _myTaskker.getDB("getAllCategories", "Top", "7")
            End If


            Dim _allTasks = dsUserStats.Tables(0).Rows(0).Item("PublishedTasks").ToString
            '      Dim _allUsers = dsUserStats.Tables(0).Rows(0).Item("Users").ToString
            '  Dim _allComments = dsUserStats.Tables(0).Rows(0).Item("Comments").ToString
            Dim _allUnsolved = dsUserStats.Tables(0).Rows(0).Item("UNSolvedTasks").ToString
            lblHome.Text = "<h2>  <a href='?s=unsolved' class='cteLnk'>" & _allUnsolved & " unsolved</a> tasks from " & _allTasks & " published so far </h2>"
     

            rptCategories.DataSource = _dsLatestTasks
            rptCategories.DataBind()

            rLtestHomeTsks.DataSource = _dsLtestHomeTsks
            rLtestHomeTsks.DataBind()

            rptRandom.DataSource = _dsRandomHomeTsks
            rptRandom.DataBind()
            'lblInfo.Text = "ok"
        Catch ex As Exception
            lblInfo.Text = ex.Message.ToString
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