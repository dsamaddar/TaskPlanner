Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsMasterReportDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertMasterReport(ByVal MasterReport As clsMasterReport) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertMasterReport", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", MasterReport.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@ReportName", MasterReport.ReportName)
            cmd.Parameters.AddWithValue("@IsActive", MasterReport.IsActive)
            cmd.Parameters.AddWithValue("@ControlListIDLst", MasterReport.ControlListIDLst)
            cmd.Parameters.AddWithValue("@EntryBy", MasterReport.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Master Report : Inserted Successfully."
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

    Public Function fnUpdateMasterReport(ByVal MasterReport As clsMasterReport) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateMasterReport", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@MasterReportID", MasterReport.MasterReportID)
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", MasterReport.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@ReportName", MasterReport.ReportName)
            cmd.Parameters.AddWithValue("@IsActive", MasterReport.IsActive)
            cmd.Parameters.AddWithValue("@ControlListIDLst", MasterReport.ControlListIDLst)
            cmd.Parameters.AddWithValue("@EntryBy", MasterReport.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Master Report : Updated Successfully."
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

    Public Function fnGetMasterRportLstDetails() As DataSet

        Dim sp As String = "spGetMasterRportLstDetails"
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

    Public Function fnGetReportHeaderByMasterID(ByVal MasterReportID As String) As DataSet

        Dim sp As String = "spGetReportHeaderByMasterID"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@MasterReportID", MasterReportID)
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

    Public Function fnGetActiveMasterRptList() As DataSet

        Dim sp As String = "spGetActiveMasterRptList"
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
