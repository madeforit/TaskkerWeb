Imports System.Data.SqlClient
Imports System.IO
Imports System.IO.Compression
Imports System.Net.Mail
Imports System.Net
Imports System.Security.Cryptography

Public Class _db
    Public _adminURL As String = "http://taskker.com"
    Public _poweredBy As String = ""
    Public _adminMail As String = "admin@taskker.com"

    Dim connectionString As String = "Data Source=(local);Initial Catalog=Taskker;User=DB_TASKKER;Password=PASSWORD_TSK"
    

    'database access and return of the dataset with the specified procedure 
    Public Function getDB(ByVal sp As String, ByVal spp As String, ByVal sppv As String) As DataSet

        Dim dataSet As New DataSet()
        Using conn As New SqlConnection(connectionString) 'System.Configuration.ConfigurationManager.ConnectionStrings(connectionString).ConnectionString)
            Try
                Dim adapter As New SqlDataAdapter()
                Using cmd As New SqlCommand(sp)
                    cmd.CommandType = CommandType.StoredProcedure
                    'check parameter
                    Dim prmVal() As String = sppv.Split("|")
                    Dim i As Integer = 0
                    For Each prmItem As String In spp.Split("|")
                        If prmVal(i) <> "" Then
                            cmd.Parameters.Add(New SqlParameter("@" & prmItem, prmVal(i)))
                            i += 1
                        End If
                    Next

                    conn.Open()
                    cmd.Connection = conn
                    adapter.SelectCommand = cmd
                    adapter.InsertCommand = cmd
                    adapter.Fill(dataSet)
                    conn.Close()

                End Using

            Catch ex As Exception

            End Try
        End Using
        Return dataSet
        Try

        Catch ex As Exception
            '   SaveTextToFile(ex.Message, "Test.txt", "")
        End Try
    End Function



    'database access and add item 
    Public Function exeDB(ByVal sp As String, ByVal spp As String, ByVal sppv As String) As String
        '   Return sp & " " & spp & " " & sppv
        Dim myElems As String = ""

        Using conn As New SqlConnection(connectionString)
            Try
                Dim adapter As New SqlDataAdapter()
                Using cmd As New SqlCommand(sp)
                    cmd.CommandType = CommandType.StoredProcedure
                    'check parameter
                    Dim prmVal() As String = sppv.Split("|")
                    Dim i As Integer = 0
                    For Each prmItem As String In spp.Split("|")
                        If prmVal(i) <> "" Then
                            myElems &= " '" & prmItem & " " & prmVal(i) & "'"
                            cmd.Parameters.Add(New SqlParameter("@" & prmItem, prmVal(i)))
                            i += 1
                        End If
                    Next

                    conn.Open()
                    cmd.Connection = conn
                    cmd.ExecuteNonQuery()
                    conn.Close()

                End Using

            Catch ex As Exception
                Return ex.Message.ToString
                Exit Function
            End Try
        End Using

        Return True

    End Function


    Function cmdGetParametersFromSP(ByVal _SP As String) As String
        Try

            Dim myParams As String = ""

            Dim cmd As New SqlCommand()
            Dim conn As New SqlConnection(connectionString)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandText = _SP
            cmd.Connection = conn

            conn.Open()
            SqlCommandBuilder.DeriveParameters(cmd)
            conn.Close()
            Dim collection As SqlParameterCollection = cmd.Parameters

            ' Populate the Input Parameters With Values Provided        
            For Each parameter As SqlParameter In collection
                If parameter.Direction = ParameterDirection.Input Then ' Or parameter.Direction = ParameterDirection.InputOutput Then '
                    myParams &= parameter.ParameterName.ToString.Replace("@", "") & "|"

                End If
            Next

            Return myParams

        Catch ex As Exception
            Return ex.Message.ToString
        End Try

    End Function

    Public Sub SendMailNotification(subject As String, body As String, [to] As String)
        Try
            Dim message As New MailMessage()
            message.From = New MailAddress("no_reply@taskker.com", "Taskker")
            message.[To].Add([to])
            message.Subject = subject
            message.Body = body
            message.BodyEncoding = System.Text.Encoding.ASCII
            message.IsBodyHtml = True
            message.Priority = MailPriority.Normal
            Dim smtp As New SmtpClient("localhost")

            smtp.Send(message)
        Catch ex As Exception
            '    Response.Write(ex.Message.ToString)
        End Try
    End Sub


    
 
    Public Function getMetaData(ByVal spName As String) As String()
        Dim sqlCon As New SqlConnection(connectionString)
        sqlCon.Open()

        Dim sqlCmd As New SqlCommand("sp_helptext " + spName, sqlCon)
        Dim sqlDataAdapter As New SqlDataAdapter(sqlCmd)
        Dim dt As New DataTable
        Dim strTempQuery As String = String.Empty
        Dim strColumns As String()
        Dim strCol As String = String.Empty

        sqlDataAdapter.Fill(dt)
        If dt.Rows.Count > 0 Then
            For Each dr As DataRow In dt.Rows
                strTempQuery += dr.Item(0)
            Next
        End If

        If Not strTempQuery = "" Then

            'Dim objRegex As New Regex("select([^<]*)from")

            Dim objMatches As MatchCollection = Regex.Matches(strTempQuery, "select([^<]*)from", RegexOptions.IgnoreCase)
            For Each mymatch As System.Text.RegularExpressions.Match In objMatches
                strCol += mymatch.Groups(1).Value
            Next

            If Not strCol = "" Then
                strColumns = strCol.Split(",")
                For a As Integer = 0 To strColumns.Length - 1
                    strColumns(a) = strColumns(a).Trim()
                Next
            End If
        End If
        Return strColumns
    End Function

    'get reference to 0
    Public Function get0(ByVal _elmVal As Decimal, ByVal _elmLimit As Decimal) As Integer
        Try
            Dim myCntTo0 As Integer = CInt(100 - (_elmVal / _elmLimit * 100))

            If myCntTo0 > 0 Then
                Return 0
            Else
                Return 1
            End If

        Catch ex As Exception
            Return 0
        End Try
    End Function


    

    Public Function DecompressString(ByVal compressedText As String) As String
        Dim gZipBuffer As Byte() = Convert.FromBase64String(compressedText)
        Using memoryStream = New MemoryStream()
            Dim dataLength As Integer = BitConverter.ToInt32(gZipBuffer, 0)
            memoryStream.Write(gZipBuffer, 4, gZipBuffer.Length - 4)

            Dim buffer = New Byte(dataLength - 1) {}

            memoryStream.Position = 0
            Using gZipStream = New GZipStream(memoryStream, CompressionMode.Decompress)
                gZipStream.Read(buffer, 0, buffer.Length)
            End Using

            Return Encoding.UTF8.GetString(buffer)
        End Using
    End Function


    Public Function strip(ByVal des As String)
        Dim strorigFileName As String
        Dim intCounter As Integer
        Dim arrSpecialChar() As String = {"<", ">", "?", """", "{", "[", "}", "]", "`", "~", "!", "%", "^", "(", ")", "`", " ", "=", "  ", "\"}
        strorigFileName = des
        intCounter = 0
        Dim i As Integer
        For i = 0 To arrSpecialChar.Length - 1

            Do Until intCounter = 22
                des = Replace(strorigFileName, arrSpecialChar(i), "")
                intCounter = intCounter + 1
                strorigFileName = des
            Loop
            intCounter = 0
        Next
        Return strorigFileName

    End Function

    Public Function cmdFormatHours(ByVal myTimeHour As Object)
        'show panel if belongs to the user
        Dim StrResultTime As String
        Try
            Dim decTimeHour As Decimal
            decTimeHour = CDbl(String.Format("{0:n}", myTimeHour))
            If decTimeHour = 0 Then
                StrResultTime = ""
            ElseIf decTimeHour < 2 Then
                StrResultTime = "/" & myTimeHour & " hour"
            Else
                StrResultTime = "/" & myTimeHour & " hours"
            End If
            '    String.Format("{0:n}", cmdFormatHours(Eval("TaskkerHours")))
            Return StrResultTime
        Catch ex As Exception

        End Try
    End Function

    Public Function cmdFormatPrice(ByVal myAmount As Object, ByVal myCoin As Object, ByVal myTimeHour As Object)
        Dim strAmount, strCoin, strResult As String
        Try
            If CInt(myAmount) > 0 Then
                strResult = " " & CInt(myAmount.ToString) & " " & myCoin.ToString
                Dim decTimeHour As Integer
                decTimeHour = CInt(myTimeHour)
                If decTimeHour = 0 Then
                    strResult += ""
                ElseIf decTimeHour < 2 Then
                    strResult += "/" & myTimeHour & " hour"
                Else
                    strResult += "/" & myTimeHour & " hours"
                End If
                '  strResult = " </div> "
            Else
                strResult = ""
            End If
            Return strResult
        Catch ex As Exception

        End Try
    End Function

    Public Function SrcLinks(ByVal myBody As Object)
        Dim regex As String = "((www\.|(http|https|ftp|news|file)+\:\/\/)[&#95;.a-z0-9-]+\.[a-z0-9\/&#95;:@=.+?,##%&~-]*[^.|\'|\# |!|\(|?|,| |>|<|;|\)])"
        Dim r As New Regex(regex, RegexOptions.IgnoreCase)
        Return r.Replace(myBody, "<a href=""$1"" title=""Click to open in a new window or tab"" target=""&#95;blank"">$1</a>").Replace("href=""www", "href=""http://www")
    End Function


    'SHOW AVATAR OF THE USERS
    Public Function getUserAvatar(ByVal myUserTaskker As String) As String
        Dim myUserAvatar As String
        Dim myImageUser As String = strip(myUserTaskker)
        If myImageUser <> "" Then
            myUserAvatar = "img/taskker_avatar/" & myImageUser & "?width=50&height=50&crop=(2,2,-2,-2)&paddingColor=white&paddingwidth=0&borderWidth=0&borderColor=808080"
        Else
            myUserAvatar = "img/a.png"
        End If
        Return myUserAvatar
    End Function

    'Function getFileInfo(ByVal file As String)
    '    Try

    '        Dim objFileInfo As New FileInfo(Server.MapPath(file))
    '        Dim myFileInfos As String
    '        'To get the creation, lastaccess, lastwrite time of this file

    '        Dim dtCreationDate As DateTime = objFileInfo.CreationTime
    '        Dim dtFileExt As String = objFileInfo.Extension
    '        Dim dtFileSize As String = Math.Round(objFileInfo.Length / 1024, 2)
    '        Dim dtFileName As String = objFileInfo.Name

    '        myFileInfos = "<a href='../" & file & "' target='_blank' title='Right click -> Save as Target: " & dtFileName & "'> <b style='font-size:14px;'>" & dtFileName & "</b></a><br><span style='font-size:10px;color:silver'>" & dtFileExt & " " & dtFileSize & " kb " & dtCreationDate & "</span>"
    '        Return myFileInfos

    '        'To encrypt and decrypt the file

    '        '    objFileInfo.Encrypt()

    '        '   objFileInfo.Decrypt()

    '        'Now to move the file from one place to another

    '        '     objFileInfo.MoveTo("C:\64.jpg")
    '    Catch ex As Exception
    '        Return "<br>Under development<br><br>"
    '    End Try
    'End Function
    Private key() As Byte = {}
    Private IV() As Byte = {&H12, &H34, &H56, &H78, &H90, &HAB, &HCD, &HEF}

    Public Function Decrypt(ByVal stringToDecrypt As String, _
        ByVal sEncryptionKey As String) As String
        Dim inputByteArray(stringToDecrypt.Length) As Byte
        Try
            key = System.Text.Encoding.UTF8.GetBytes(Left(sEncryptionKey, 8))
            Dim des As New DESCryptoServiceProvider()
            inputByteArray = Convert.FromBase64String(stringToDecrypt)
            Dim ms As New MemoryStream()
            Dim cs As New CryptoStream(ms, des.CreateDecryptor(key, IV), _
                CryptoStreamMode.Write)
            cs.Write(inputByteArray, 0, inputByteArray.Length)
            cs.FlushFinalBlock()
            Dim encoding As System.Text.Encoding = System.Text.Encoding.UTF8
            Return encoding.GetString(ms.ToArray())
        Catch e As Exception
            Return e.Message
        End Try
    End Function

    Public Function Encrypt(ByVal stringToEncrypt As String, _
        ByVal SEncryptionKey As String) As String
        Try
            key = System.Text.Encoding.UTF8.GetBytes(Left(SEncryptionKey, 8))
            Dim des As New DESCryptoServiceProvider()
            Dim inputByteArray() As Byte = Encoding.UTF8.GetBytes( _
                stringToEncrypt)
            Dim ms As New MemoryStream()
            Dim cs As New CryptoStream(ms, des.CreateEncryptor(key, IV), _
                CryptoStreamMode.Write)
            cs.Write(inputByteArray, 0, inputByteArray.Length)
            cs.FlushFinalBlock()
            Return Convert.ToBase64String(ms.ToArray())
        Catch e As Exception
            Return e.Message
        End Try
    End Function
End Class
