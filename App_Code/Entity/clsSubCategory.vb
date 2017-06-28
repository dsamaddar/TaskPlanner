Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System

Public Class clsSubCategory : Inherits clsCategory

    Dim _SubCategoryID, _SubCategory As String

    Public Property SubCategoryID() As String
        Get
            Return _SubCategoryID
        End Get
        Set(ByVal value As String)
            _SubCategoryID = value
        End Set
    End Property

    Public Property SubCategory() As String
        Get
            Return _SubCategory
        End Get
        Set(ByVal value As String)
            _SubCategory = value
        End Set
    End Property

    Public Sub New()

    End Sub

    Public Function fnInsertSubCategory(ByVal SubCat As clsSubCategory) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertSubCategory", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@CategoryID", SubCat.CategoryID)
            cmd.Parameters.AddWithValue("@SubCategory", SubCat.SubCategory)
            cmd.Parameters.AddWithValue("@Details", SubCat.Details)
            cmd.Parameters.AddWithValue("@IsActive", SubCat.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", SubCat.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Sub Category : Inserted Successfully."
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

    Public Function fnUpdateSubCategory(ByVal SubCat As clsSubCategory) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateSubCategory", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@SubCategoryID", SubCat.SubCategoryID)
            cmd.Parameters.AddWithValue("@CategoryID", SubCat.CategoryID)
            cmd.Parameters.AddWithValue("@SubCategory", SubCat.SubCategory)
            cmd.Parameters.AddWithValue("@Details", SubCat.Details)
            cmd.Parameters.AddWithValue("@IsActive", SubCat.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", SubCat.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Sub Category : Updated Successfully."
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

    Public Function fnGetSubCategoryDetailsInfo() As DataSet

        Dim sp As String = "spGetSubCategoryDetailsInfo"
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

    Public Function fnGetActiveSubCatListByCategory(ByVal CategoryID As String) As DataSet

        Dim sp As String = "spGetSubCategoryListByCategory"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CategoryID", CategoryID)
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
