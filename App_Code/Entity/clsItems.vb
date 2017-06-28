Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System

Public Class clsItems : Inherits clsSubCategory

    Dim _ItemID, _ItemName As String

    Public Property ItemID() As String
        Get
            Return _ItemID
        End Get
        Set(ByVal value As String)
            _ItemID = value
        End Set
    End Property

    Public Property ItemName() As String
        Get
            Return _ItemName
        End Get
        Set(ByVal value As String)
            _ItemName = value
        End Set
    End Property

    Public Function fnInsertItems(ByVal Items As clsItems) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertItems", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@CategoryID", Items.CategoryID)
            cmd.Parameters.AddWithValue("@SubCategoryID", Items.SubCategoryID)
            cmd.Parameters.AddWithValue("@ItemName", Items.ItemName)
            cmd.Parameters.AddWithValue("@Details", Items.Details)
            cmd.Parameters.AddWithValue("@IsActive", Items.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Items.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Item : Inserted Successfully."
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

    Public Function fnUpdateItems(ByVal Items As clsItems) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateItems", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ItemID", Items.ItemID)
            cmd.Parameters.AddWithValue("@CategoryID", Items.CategoryID)
            cmd.Parameters.AddWithValue("@SubCategoryID", Items.SubCategoryID)
            cmd.Parameters.AddWithValue("@ItemName", Items.ItemName)
            cmd.Parameters.AddWithValue("@Details", Items.Details)
            cmd.Parameters.AddWithValue("@IsActive", Items.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Items.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Item : Updated Successfully."
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

    Public Function fnGetDetailsItems() As DataSet

        Dim sp As String = "spGetDetailsItems"
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

    Public Function fnGetItemsBySubCategory(ByVal SubCategoryID As String) As DataSet

        Dim sp As String = "spGetItemsBySubCategory"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@SubCategoryID", SubCategoryID)
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
