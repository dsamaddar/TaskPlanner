Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Web.UI.WebControls

Public Class clsControlListDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertControlList(ByVal ControlList As clsControlList) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertControlList", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", ControlList.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@ControlIndex", ControlList.ControlIndex)
            cmd.Parameters.AddWithValue("@ControlID", ControlList.ControlID)
            cmd.Parameters.AddWithValue("@ControlLabelInfo", ControlList.ControlLabelInfo)
            cmd.Parameters.AddWithValue("@ControlValue", ControlList.ControlValue)
            cmd.Parameters.AddWithValue("@ControlType", ControlList.ControlType)
            cmd.Parameters.AddWithValue("@IsGroupControl", ControlList.IsGroupControl)
            cmd.Parameters.AddWithValue("@GroupControlLabelInfo", ControlList.GroupControlLabelInfo)
            cmd.Parameters.AddWithValue("@GroupControlID", ControlList.GroupControlID)
            cmd.Parameters.AddWithValue("@DataType", ControlList.DataType)
            cmd.Parameters.AddWithValue("@DataSource", ControlList.DataSource)
            cmd.Parameters.AddWithValue("@DataPresentationForm", ControlList.DataPresentationForm)
            cmd.Parameters.AddWithValue("@ViewOrder", ControlList.ViewOrder)
            cmd.Parameters.AddWithValue("@ReportingHead", ControlList.ReportingHead)
            cmd.Parameters.AddWithValue("@ValueSelectionType", ControlList.ValueSelectionType)
            cmd.Parameters.AddWithValue("@IsActive", ControlList.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", ControlList.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Control Structure : Inserted Successfully."
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

    Public Function fnUpdateControlList(ByVal ControlList As clsControlList) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateControlList", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ControlListID", ControlList.ControlListID)
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", ControlList.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@ControlIndex", ControlList.ControlIndex)
            cmd.Parameters.AddWithValue("@ControlID", ControlList.ControlID)
            cmd.Parameters.AddWithValue("@ControlLabelInfo", ControlList.ControlLabelInfo)
            cmd.Parameters.AddWithValue("@ControlValue", ControlList.ControlValue)
            cmd.Parameters.AddWithValue("@ControlType", ControlList.ControlType)
            cmd.Parameters.AddWithValue("@IsGroupControl", ControlList.IsGroupControl)
            cmd.Parameters.AddWithValue("@GroupControlLabelInfo", ControlList.GroupControlLabelInfo)
            cmd.Parameters.AddWithValue("@GroupControlID", ControlList.GroupControlID)
            cmd.Parameters.AddWithValue("@DataType", ControlList.DataType)
            cmd.Parameters.AddWithValue("@DataSource", ControlList.DataSource)
            cmd.Parameters.AddWithValue("@DataPresentationForm", ControlList.DataPresentationForm)
            cmd.Parameters.AddWithValue("@ViewOrder", ControlList.ViewOrder)
            cmd.Parameters.AddWithValue("@ReportingHead", ControlList.ReportingHead)
            cmd.Parameters.AddWithValue("@ValueSelectionType", ControlList.ValueSelectionType)
            cmd.Parameters.AddWithValue("@IsActive", ControlList.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", ControlList.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Control Structure : Updated Successfully."
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

    Public Function fnGetAllControlListByChase(ByVal ChaseDefinitionID As String) As DataSet

        Dim sp As String = "spGetAllControlListByChase"
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

    Public Function fnGetControlInfoByIDAndType(ByVal CtrlList As clsControlList) As List(Of clsControlList)
        Dim sp As String = "spGetControlInfoByIDAndType"
        Dim list As List(Of clsControlList) = New List(Of clsControlList)
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", CtrlList.ChaseDefinitionID)
                cmd.Parameters.AddWithValue("@ControlType", CtrlList.ControlType)
                Dim dr As SqlDataReader = cmd.ExecuteReader()
                Dim i As Integer = 0
                While dr.Read()
                    Dim ctllst As New clsControlList()
                    ctllst.ControlType = dr.Item("ControlType")
                    ctllst.ControlIndex = dr.Item("ControlIndex")
                    ctllst.ControlID = dr.Item("ControlID")
                    ctllst.ControlLabelInfo = dr.Item("ControlLabelInfo")
                    ctllst.ControlValue = dr.Item("ControlValue")
                    ctllst.IsGroupControlText = dr.Item("IsGroupControl")
                    ctllst.GroupControlLabelInfo = dr.Item("GroupControlLabelInfo")
                    ctllst.GroupControlID = dr.Item("GroupControlID")
                    ctllst.DataPresentationForm = dr.Item("DataPresentationForm")
                    ctllst.ControlIDCount = dr.Item("ControlIDCount")
                    ctllst.GroupControlIDCount = dr.Item("GroupControlIDCount")
                    list.Add(ctllst)
                End While
                con.Close()

                Return list
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetCtrlDetailsByChaseDefIDAndCtrlID(ByVal CtrlList As clsControlList) As List(Of clsControlList)
        Dim sp As String = "spGetCtrlDetailsByChaseDefIDAndCtrlID"
        Dim list As List(Of clsControlList) = New List(Of clsControlList)
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", CtrlList.ChaseDefinitionID)
                cmd.Parameters.AddWithValue("@ControlID", CtrlList.ControlID)
                Dim dr As SqlDataReader = cmd.ExecuteReader()
                Dim i As Integer = 0
                While dr.Read()
                    Dim ctllst As New clsControlList()
                    ctllst.ControlType = dr.Item("ControlType")
                    ctllst.ControlIndex = dr.Item("ControlIndex")
                    ctllst.ControlID = dr.Item("ControlID")
                    ctllst.ControlLabelInfo = dr.Item("ControlLabelInfo")
                    ctllst.ControlValue = dr.Item("ControlValue")
                    ctllst.IsGroupControlText = dr.Item("IsGroupControl")
                    ctllst.GroupControlLabelInfo = dr.Item("GroupControlLabelInfo")
                    ctllst.GroupControlID = dr.Item("GroupControlID")
                    ctllst.DataPresentationForm = dr.Item("DataPresentationForm")
                    ctllst.DataType = dr.Item("DataType")
                    ctllst.ValueSelectionType = dr.Item("ValueSelectionType")
                    list.Add(ctllst)
                End While
                con.Close()

                Return list
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetAllCtrlIDByChaseDefID(ByVal ChaseDefinitionID As String) As ArrayList

        Dim sp As String = "spGetAllCtrlIDByChaseDefID"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim list As ArrayList = New ArrayList
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
                Dim dr As SqlDataReader = cmd.ExecuteReader()
                While dr.Read()
                    list.Add(New ListItem(dr("ControlID").ToString, dr("ControlType").ToString))
                End While
                con.Close()

                Return list
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetRptHeaderByChaseDefID(ByVal ChaseDefinitionID As String) As DataSet

        Dim sp As String = "spGetRptHeaderByChaseDefID"
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


    Public Function fnGetControlCounter(ByVal ChaseDefinitionID As String, ByVal ControlID As String, ByVal IsGroupControl As Boolean) As String
        Dim sp As String = "spGetControlCounter"
        Dim Suffix As String = ""
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
                cmd.Parameters.AddWithValue("@ControlID", ControlID)
                cmd.Parameters.AddWithValue("@IsGroupControl", IsGroupControl)
                Dim dr As SqlDataReader = cmd.ExecuteReader()
                While dr.Read()
                    Suffix = dr.Item("Suffix")
                End While
                con.Close()

                Return Suffix
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return ""
        End Try
    End Function

End Class
