Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsChaseNotesDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertChaseNotes(ByVal ChaseNotes As clsChaseNotes) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertChaseNotes", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@GeneratedChaseID", ChaseNotes.GeneratedChaseID)
            cmd.Parameters.AddWithValue("@MasterChaseID", ChaseNotes.MasterChaseID)
            cmd.Parameters.AddWithValue("@Notes", ChaseNotes.Notes)
            cmd.Parameters.AddWithValue("@Attachments", ChaseNotes.Attachments)
            cmd.Parameters.AddWithValue("@EntryBy", ChaseNotes.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Notes : Inserted Successfully."
            Return Result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Result.Success = False
            Result.Message = "Error Found: " & ex.Message
            Return Result
        End Try
    End Function


    Public Function fnGetMasterChaseWiseNotes(ByVal MasterChaseID As String) As DataSet

        Dim sp As String = "spGetMasterChaseWiseNotes"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@MasterChaseID", MasterChaseID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnChaseAddNotesMail(ByVal Notes As clsChaseNotes) As clsMailProperty
        Dim sp As String = "spChaseAddNotesMail"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@MasterChaseID", Notes.MasterChaseID)
                cmd.Parameters.AddWithValue("@GeneratedChaseID", Notes.GeneratedChaseID)
                cmd.Parameters.AddWithValue("@Notes", Notes.Notes)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    MailProp.MailSubject = dr.Item("MailSubject")
                    MailProp.MailBody = dr.Item("MailBody")
                    MailProp.MailFrom = dr.Item("MailFrom")
                    MailProp.MailTo = dr.Item("MailTo")
                    MailProp.MailCC = dr.Item("MailCC")
                    MailProp.MailBCC = dr.Item("MailBCC")
                    MailProp.SMTPServer = dr.Item("SMTPServer")
                    MailProp.SMTPPort = dr.Item("SMTPPort")
                End While
                con.Close()

                Return MailProp
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function


End Class
