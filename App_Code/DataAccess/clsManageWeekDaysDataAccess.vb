Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsManageWeekDaysDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertManageWeekdays(ByVal MngWeekDays As clsManageWeekDays) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertManageWeekdays", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@WeekDays", MngWeekDays.WeekDays)
            cmd.Parameters.AddWithValue("@FromHour", MngWeekDays.FromHour)
            cmd.Parameters.AddWithValue("@FromMinute", MngWeekDays.FromMinute)
            cmd.Parameters.AddWithValue("@FromMeridiem", MngWeekDays.FromMeridiem)
            cmd.Parameters.AddWithValue("@ToHour", MngWeekDays.ToHour)
            cmd.Parameters.AddWithValue("@ToMinute", MngWeekDays.ToMinute)
            cmd.Parameters.AddWithValue("@ToMeridiem", MngWeekDays.ToMeridiem)
            cmd.Parameters.AddWithValue("@EntryBy", MngWeekDays.EntryBy)

            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "WeekDay : Inserted Successfully."
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

    Public Function fnUpdateManageWeekDays(ByVal MngWeekDays As clsManageWeekDays) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateManageWeekDays", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@MngWeekDayID", MngWeekDays.MngWeekDayID)
            cmd.Parameters.AddWithValue("@WeekDays", MngWeekDays.WeekDays)
            cmd.Parameters.AddWithValue("@FromHour", MngWeekDays.FromHour)
            cmd.Parameters.AddWithValue("@FromMinute", MngWeekDays.FromMinute)
            cmd.Parameters.AddWithValue("@FromMeridiem", MngWeekDays.FromMeridiem)
            cmd.Parameters.AddWithValue("@ToHour", MngWeekDays.ToHour)
            cmd.Parameters.AddWithValue("@ToMinute", MngWeekDays.ToMinute)
            cmd.Parameters.AddWithValue("@ToMeridiem", MngWeekDays.ToMeridiem)
            cmd.Parameters.AddWithValue("@EntryBy", MngWeekDays.EntryBy)

            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "WeekDay : Updated Successfully."
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

    Public Function fnGetWeekDaysDetails() As DataSet
        Dim sp As String = "spGetWeekDaysDetails"
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
