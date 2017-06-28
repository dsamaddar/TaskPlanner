Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsMarketInfoDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnGetAllPrimaryRep() As DataSet

        Dim sp As String = "spGetPendingMktInfoPrimaryRating"
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

    Public Function fnMktInfoFilterReport(ByVal MktInfo As clsMarketInfo) As DataSet

        Dim sp As String = "spMktInfoFilterReport"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DateFrom", MktInfo.DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", MktInfo.DateTo)
                cmd.Parameters.AddWithValue("@DataStatus", MktInfo.DataStatus)
                cmd.Parameters.AddWithValue("@CPDesignation", MktInfo.CPDesignation)
                cmd.Parameters.AddWithValue("@Status", MktInfo.Status)
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

    Public Function fnPrimaryRatingMktInfo(ByVal MktInfo As clsMarketInfo) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spPrimaryRatingMktInfo", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@MarketInfoID", MktInfo.MarketInfoID)
            cmd.Parameters.AddWithValue("@PrimaryRating", MktInfo.PrimaryRating)
            cmd.Parameters.AddWithValue("@PrimaryRemarks", MktInfo.PrimaryRemarks)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Market Info : Rating Successful."
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

End Class
