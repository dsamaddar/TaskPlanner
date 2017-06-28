Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System
Imports System.Configuration

Public Class clsCategory

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _CategoryID, _CategoryName, _Details, _EntryBy As String

    Public Property CategoryID() As String
        Get
            Return _CategoryID
        End Get
        Set(ByVal value As String)
            _CategoryID = value
        End Set
    End Property

    Public Property CategoryName() As String
        Get
            Return _CategoryName
        End Get
        Set(ByVal value As String)
            _CategoryName = value
        End Set
    End Property

    Public Property Details() As String
        Get
            Return _Details
        End Get
        Set(ByVal value As String)
            _Details = value
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

    Dim _IsActive, _IsODNotification As Boolean

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
        End Set
    End Property

    Public Property IsODNotification() As Boolean
        Get
            Return _IsODNotification
        End Get
        Set(ByVal value As Boolean)
            _IsODNotification = value
        End Set
    End Property

    Dim _EntryDate As DateTime

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

    Public Function fnInsertCategory(ByVal Cat As clsCategory) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertCategory", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@CategoryName", Cat.CategoryName)
            cmd.Parameters.AddWithValue("@Details", Cat.Details)
            cmd.Parameters.AddWithValue("@IsActive", Cat.IsActive)
            cmd.Parameters.AddWithValue("@IsODNotification", Cat.IsODNotification)
            cmd.Parameters.AddWithValue("@EntryBy", Cat.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Category : Inserted Successfully."
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

    Public Function fnUpdateCategory(ByVal Cat As clsCategory) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateCategory", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@CategoryID", Cat.CategoryID)
            cmd.Parameters.AddWithValue("@CategoryName", Cat.CategoryName)
            cmd.Parameters.AddWithValue("@Details", Cat.Details)
            cmd.Parameters.AddWithValue("@IsActive", Cat.IsActive)
            cmd.Parameters.AddWithValue("@IsODNotification", Cat.IsODNotification)
            cmd.Parameters.AddWithValue("@EntryBy", Cat.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Category : Updated Successfully."
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

    Public Function fnGetDetailsCategoryInfo() As DataSet

        Dim sp As String = "spGetDetailsCategoryInfo"
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

    Public Function fnGetActiveCategoryList() As DataSet

        Dim sp As String = "spGetActiveCategoryList"
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
