Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsChaseInputValuesDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertChaseInputValues(ByVal ChaseInputValue As clsChaseInputValues) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertChaseInputValues", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@GeneratedChaseID", ChaseInputValue.GeneratedChaseID)
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseInputValue.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@ControlType", ChaseInputValue.ControlType)
            cmd.Parameters.AddWithValue("@ControlID", ChaseInputValue.ControlID)
            cmd.Parameters.AddWithValue("@Value", ChaseInputValue.Value)
            cmd.Parameters.AddWithValue("@AdditionalValue", ChaseInputValue.AdditionalValue)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Chase Value : Inserted Successfully."
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


    Public Function fnUpdateChaseInputValues(ByVal ChaseInputValue As clsChaseInputValues) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateChaseInputValues", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@GeneratedChaseID", ChaseInputValue.GeneratedChaseID)
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseInputValue.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@ControlType", ChaseInputValue.ControlType)
            cmd.Parameters.AddWithValue("@ControlID", ChaseInputValue.ControlID)
            cmd.Parameters.AddWithValue("@Value", ChaseInputValue.Value)
            cmd.Parameters.AddWithValue("@AdditionalValue", ChaseInputValue.AdditionalValue)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Chase Value : Update Successfully."
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

    Public Function fnGetChaseInputvalues(ByVal GeneratedChaseID As String) As DataSet

        Dim sp As String = "spGetChaseInputvalues"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@GeneratedChaseID", GeneratedChaseID)
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

    Public Function fnGetInputValuesByGenChase(ByVal GeneratedChaseID As String) As DataSet

        Dim sp As String = "spGetInputValuesByGenChase"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@GeneratedChaseID", GeneratedChaseID)
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
