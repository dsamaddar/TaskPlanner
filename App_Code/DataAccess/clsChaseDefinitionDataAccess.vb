Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsChaseDefinitionDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnInsertChaseDefinition(ByVal ChaseDef As clsChaseDefinition) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertChaseDefinition", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@FacilityTypeID", ChaseDef.FacilityTypeID)
            cmd.Parameters.AddWithValue("@ChaseName", ChaseDef.ChaseName)
            cmd.Parameters.AddWithValue("@ChaseShortCode", ChaseDef.ChaseShortCode)
            cmd.Parameters.AddWithValue("@CategoryID", ChaseDef.CategoryID)
            cmd.Parameters.AddWithValue("@SubCategoryID", ChaseDef.SubCategoryID)
            cmd.Parameters.AddWithValue("@ItemID", ChaseDef.ItemID)
            cmd.Parameters.AddWithValue("@PriorityID", ChaseDef.PriorityID)
            cmd.Parameters.AddWithValue("@EmployeeList", ChaseDef.EmployeeList)
            cmd.Parameters.AddWithValue("@InformedParties", ChaseDef.InformedParties)
            cmd.Parameters.AddWithValue("@DepartmentIDList", ChaseDef.DepartmentIDList)
            cmd.Parameters.AddWithValue("@IsOpenChase", ChaseDef.IsOpenChase)
            cmd.Parameters.AddWithValue("@IsActive", ChaseDef.IsActive)
            cmd.Parameters.AddWithValue("@PrimarySupportRep", ChaseDef.PrimarySupportRep)
            cmd.Parameters.AddWithValue("@ChaseInstruction", ChaseDef.ChaseInstruction)
            cmd.Parameters.AddWithValue("@EntryBy", ChaseDef.EntryBy)
            cmd.Parameters.AddWithValue("@UserCanChange", ChaseDef.UserCanChange)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Chase Definition : Inserted Successfully."
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

    Public Function fnUpdateChaseDefinition(ByVal ChaseDef As clsChaseDefinition) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateChaseDefinition", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDef.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@FacilityTypeID", ChaseDef.FacilityTypeID)
            cmd.Parameters.AddWithValue("@ChaseName", ChaseDef.ChaseName)
            cmd.Parameters.AddWithValue("@ChaseShortCode", ChaseDef.ChaseShortCode)
            cmd.Parameters.AddWithValue("@CategoryID", ChaseDef.CategoryID)
            cmd.Parameters.AddWithValue("@SubCategoryID", ChaseDef.SubCategoryID)
            cmd.Parameters.AddWithValue("@ItemID", ChaseDef.ItemID)
            cmd.Parameters.AddWithValue("@PriorityID", ChaseDef.PriorityID)
            cmd.Parameters.AddWithValue("@EmployeeList", ChaseDef.EmployeeList)
            cmd.Parameters.AddWithValue("@InformedParties", ChaseDef.InformedParties)
            cmd.Parameters.AddWithValue("@DepartmentIDList", ChaseDef.DepartmentIDList)
            cmd.Parameters.AddWithValue("@IsOpenChase", ChaseDef.IsOpenChase)
            cmd.Parameters.AddWithValue("@IsActive", ChaseDef.IsActive)
            cmd.Parameters.AddWithValue("@PrimarySupportRep", ChaseDef.PrimarySupportRep)
            cmd.Parameters.AddWithValue("@ChaseInstruction", ChaseDef.ChaseInstruction)
            cmd.Parameters.AddWithValue("@EntryBy", ChaseDef.EntryBy)
            cmd.Parameters.AddWithValue("@UserCanChange", ChaseDef.UserCanChange)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Chase Definition : Updated Successfully."
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

    Public Function fnGetChaseDefListAll() As DataSet

        Dim sp As String = "spGetChaseDefListAll"
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

    Public Function fnGetChaseDefListActive() As DataSet

        Dim sp As String = "spGetChaseDefListActive"
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

    Public Function fnGetChaseDefListActiveByCat(ByVal CategoryID As String, ByVal SubCategoryID As String) As DataSet

        Dim sp As String = "spGetChaseDefListActiveByCat"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CategoryID", CategoryID)
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

    Public Function fnGetChaseDefListActiveByCatByUsr(ByVal CategoryID As String, ByVal SubCategoryID As String, ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetChaseDefListActiveByCatByUsr"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CategoryID", CategoryID)
                cmd.Parameters.AddWithValue("@SubCategoryID", SubCategoryID)
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
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

    Public Function fnGetChaseDefListByFacilityType(ByVal FacilityTypeID As String) As DataSet

        Dim sp As String = "spGetChaseDefListByFacilityType"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@FacilityTypeID", FacilityTypeID)
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

    Public Function fnGetChaseShortCode(ByVal ChaseDefinitionID As String) As String

        Dim sp As String = "spGetChaseShortCode"
        Dim dr As SqlDataReader
        Dim ChaseShortCode As String = ""
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ChaseShortCode = dr.Item("ChaseShortCode")
                End While
                con.Close()
                Return ChaseShortCode
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetPriorityByChaseDef(ByVal ChaseDefinitionID As String) As String

        Dim sp As String = "spGetPriorityByChaseDef"
        Dim dr As SqlDataReader
        Dim PriorityID As String = ""
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    PriorityID = dr.Item("PriorityID")
                End While
                con.Close()
                Return PriorityID
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try

    End Function

    Public Function fnChngSupRep(ByVal ChaseDef As clsChaseDefinition) As clsResult
        Dim Result As New clsResult()
        Dim sp As String = "spChngSupRep"
        Dim dr As SqlDataReader
        Dim PriorityID As String = ""
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDef.ChaseDefinitionID)
                cmd.Parameters.AddWithValue("@PrimarySupportRep", ChaseDef.PrimarySupportRep)
                cmd.Parameters.AddWithValue("@ChaseInstruction", ChaseDef.ChaseInstruction)
                cmd.ExecuteNonQuery()
                con.Close()
                Result.Success = True
                Result.Message = "Primary Support Rep.: Updated Successfully."
                Return Result
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Result.Success = False
            Result.Message = "Error Found: " & ex.Message
            Return Result
        End Try

    End Function

    Public Function fnGetAllPrimaryRep() As DataSet

        Dim sp As String = "spGetAllPrimaryRep"
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

    Public Function fnGetAllChasesByPrimaryRep(ByVal PrimarySupportRep As String) As DataSet

        Dim sp As String = "spGetAllChasesByPrimaryRep"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PrimarySupportRep", PrimarySupportRep)
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

    Public Function fnGetChaseInstruction(ByVal ChaseDefinitionID As String) As clsChaseDefinition
        Dim ChaseDef As New clsChaseDefinition()
        Dim sp As String = "spGetChaseInstruction"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ChaseDef.PrimarySupportRep = dr.Item("PrimarySupportRep")
                    ChaseDef.EmployeeName = dr.Item("EmployeeName")
                    ChaseDef.ChaseInstruction = dr.Item("ChaseInstruction")
                    ChaseDef.UserCanChange = dr.Item("UsrChngPrimarySupportRep")
                End While
                con.Close()
                Return ChaseDef
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#Region " Mail For Resp Chng "

    Public Function fnRespChngMail(ByVal ChaseDefinitionID As String, ByVal InitiatorID As String, ByVal AssignedToID As String) As clsMailProperty
        Dim sp As String = "spRespChngMail"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
                cmd.Parameters.AddWithValue("@InitiatorID", InitiatorID)
                cmd.Parameters.AddWithValue("@AssignedToID", AssignedToID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    MailProp.MailSubject = dr.Item("MailSubject")
                    MailProp.MailBody = dr.Item("MailBody")
                    MailProp.MailFrom = dr.Item("MailFrom")
                    MailProp.MailTo = dr.Item("MailTo")
                    MailProp.MailCC = dr.Item("MailCC")
                    MailProp.MailBCC = dr.Item("MailBCC")
                    MailProp.SMTPServer = dr.Item("SMTPServer")
                    MailProp.SMTPPort = dr.Item("SMTPPort")
                End While
                con.Close()

                Return MailProp
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

End Class
