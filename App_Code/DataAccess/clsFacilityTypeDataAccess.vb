Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsFacilityTypeDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertFacilityType(ByVal FacilityType As clsFacilityType) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertFacilityType", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@FacilityType", FacilityType.FacilityType)
            cmd.Parameters.AddWithValue("@IsActive", FacilityType.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", FacilityType.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Facility Type : Inserted Successfully."
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

    Public Function fnUpdateFacilityType(ByVal FacilityType As clsFacilityType) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateFacilityType", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@FacilityTypeID", FacilityType.FacilityTypeID)
            cmd.Parameters.AddWithValue("@FacilityType", FacilityType.FacilityType)
            cmd.Parameters.AddWithValue("@IsActive", FacilityType.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", FacilityType.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Facility Type : Updated Successfully."
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

    Public Function fnGetFacilityType() As DataSet

        Dim sp As String = "spGetFacilityType"
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

    Public Function fnGetActiveFacilityTypeList() As DataSet

        Dim sp As String = "spGetActiveFacilityTypeList"
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
