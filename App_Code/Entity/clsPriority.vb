Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsPriority

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _PriorityID, _PriorityText, _EntryBy As String

    Public Property PriorityID() As String
        Get
            Return _PriorityID
        End Get
        Set(ByVal value As String)
            _PriorityID = value
        End Set
    End Property

    Public Property PriorityText() As String
        Get
            Return _PriorityText
        End Get
        Set(ByVal value As String)
            _PriorityText = value
        End Set
    End Property

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
        End Set
    End Property

    Dim _Timing As Integer

    Public Property Timing() As Integer
        Get
            Return _Timing
        End Get
        Set(ByVal value As Integer)
            _Timing = value
        End Set
    End Property

    Dim _IsActive As Boolean

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
        End Set
    End Property

    Dim _EntryDate As DateTime

    Public Property EntryDate() As String
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As String)
            _EntryDate = value
        End Set
    End Property

    Public Function fnInsertPriority(ByVal Priority As clsPriority) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertPriority", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@PriorityText", Priority.PriorityText)
            cmd.Parameters.AddWithValue("@Timing", Priority.Timing)
            cmd.Parameters.AddWithValue("@IsActive", Priority.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Priority.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Priority : Inserted Successfully."
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

    Public Function fnUpdatePriority(ByVal Priority As clsPriority) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdatePriority", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@PriorityID", Priority.PriorityID)
            cmd.Parameters.AddWithValue("@PriorityText", Priority.PriorityText)
            cmd.Parameters.AddWithValue("@Timing", Priority.Timing)
            cmd.Parameters.AddWithValue("@IsActive", Priority.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Priority.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Priority : Updated Successfully."
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

    Public Function fnGetPriorityDetails() As DataSet

        Dim sp As String = "spGetPriorityDetails"
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

    Public Function fnGetActivePriorityList() As DataSet

        Dim sp As String = "spGetActivePriorityList"
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
