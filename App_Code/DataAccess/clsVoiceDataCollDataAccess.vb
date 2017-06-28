Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsVoiceDataCollDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertVoiceDataCollection(ByVal VoiceColl As clsVoiceDataColl) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertVoiceDataCollection", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@FacilityTypeID", VoiceColl.FacilityTypeID)
            cmd.Parameters.AddWithValue("@ServiceManager", VoiceColl.ServiceManager)
            cmd.Parameters.AddWithValue("@ClientID", VoiceColl.ClientID)
            cmd.Parameters.AddWithValue("@AgreementInfoID", VoiceColl.AgreementInfoID)
            cmd.Parameters.AddWithValue("@DataFrequency", VoiceColl.DataFrequency)
            cmd.Parameters.AddWithValue("@CollectionDate", VoiceColl.CollectionDate)
            cmd.Parameters.AddWithValue("@DataSource", VoiceColl.DataSource)
            cmd.Parameters.AddWithValue("@EntryBy", VoiceColl.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Voice Data : Inserted Successfully."
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

    Public Function fnGetVoiceDataColl() As DataSet

        Dim sp As String = "spGetVoiceDataColl"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
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

End Class
