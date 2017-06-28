Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsChaseGroupCtrlsDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertChaseGroupCtrls(ByVal ChaseGrpCtrl As clsChaseGroupCtrls) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertChaseGroupCtrls", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseGrpCtrl.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@CtrlType", ChaseGrpCtrl.CtrlType)
            cmd.Parameters.AddWithValue("@GroupName", ChaseGrpCtrl.GroupName)
            cmd.Parameters.AddWithValue("@GroupCode", ChaseGrpCtrl.GroupCode)
            cmd.Parameters.AddWithValue("@IsActive", ChaseGrpCtrl.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", ChaseGrpCtrl.EntryBy)

            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Chase Group Ctrl : Inserted Successfully."
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

    Public Function fnUpdateChaseGroupCtrls(ByVal ChaseGrpCtrl As clsChaseGroupCtrls) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateChaseGroupCtrls", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ChaseGroupCtrlID", ChaseGrpCtrl.ChaseGroupCtrlID)
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseGrpCtrl.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@CtrlType", ChaseGrpCtrl.CtrlType)
            cmd.Parameters.AddWithValue("@GroupName", ChaseGrpCtrl.GroupName)
            cmd.Parameters.AddWithValue("@GroupCode", ChaseGrpCtrl.GroupCode)
            cmd.Parameters.AddWithValue("@IsActive", ChaseGrpCtrl.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", ChaseGrpCtrl.EntryBy)

            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Chase Group Ctrl : Updated Successfully."
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

    Public Function fnGetActiveChaseGroupCtrls(ByVal ChaseDefinitionID As String) As DataSet

        Dim sp As String = "spGetActiveChaseGroupCtrls"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
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

    Public Function fnGetActiveChaseGroupCtrlsByType(ByVal ChaseDefinitionID As String, ByVal CtrlType As String) As DataSet

        Dim sp As String = "spGetActiveChaseGroupCtrlsByType"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
                cmd.Parameters.AddWithValue("@CtrlType", CtrlType)
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

    Public Function fnGetChaseGroupCtrlsByCDID(ByVal ChaseDefinitionID As String) As DataSet

        Dim sp As String = "spGetChaseGroupCtrlsByCDID"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
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
