Imports System.Data.SqlClient
Imports System.Data
Imports System
Imports System.Configuration

Public Class clsGeneratedChaseDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnUpdateChaseStatus(ByVal GenChase As clsGeneratedChase) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateChaseStatus", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@MasterChaseID", GenChase.MasterChaseID)
            cmd.Parameters.AddWithValue("@ParentChaseID", GenChase.ParentChaseID)
            cmd.Parameters.AddWithValue("@InitiatorID", GenChase.InitiatorID)
            cmd.Parameters.AddWithValue("@UploadedFile", GenChase.UploadedFile)
            cmd.Parameters.AddWithValue("@AssignedToID", GenChase.AssignedToID)
            cmd.Parameters.AddWithValue("@Remarks", GenChase.Remarks)
            cmd.Parameters.AddWithValue("@ChaseProgress", GenChase.ChaseProgress)
            cmd.Parameters.AddWithValue("@IsTerminated", GenChase.IsTerminated)
            cmd.Parameters.AddWithValue("@EntryBy", GenChase.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Chase " + GenChase.ChaseStatus + " : Successfully."
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

    Public Function fnUpdatePriorityInfo(ByVal GeneratedChaseID As String, ByVal PriorityID As String) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdatePriorityInfo", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@GeneratedChaseID", GeneratedChaseID)
            cmd.Parameters.AddWithValue("@PriorityID", PriorityID)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Chase Priority Updated : Successfully."
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

    Public Function fnChangeSupportPerson(ByVal GenChase As clsGeneratedChase) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spChangeSupportPerson", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ChaseIDList", GenChase.ChaseIDList)
            cmd.Parameters.AddWithValue("@AssignedToID", GenChase.AssignedToID)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Changed Successfully."
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

    Public Function fnUpdateContactInfoByMasterID(ByVal GenChase As clsGeneratedChase) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateContactInfoByMasterID", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@MasterChaseID", GenChase.MasterChaseID)
            cmd.Parameters.AddWithValue("@ULCBranchID", GenChase.ULCBranchID)
            cmd.Parameters.AddWithValue("@ContactPersonID", GenChase.ContactPersonID)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Contact Info Updated Successfully."
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

    Public Function fnInsertGeneratedChase(ByVal GenChase As clsGeneratedChase) As String
        Dim dr As SqlDataReader
        Dim GeneratedChaseID As String = ""
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertGeneratedChase", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", GenChase.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@VoiceDataCollectionID", GenChase.VoiceDataCollectionID)
            cmd.Parameters.AddWithValue("@ParentChaseID", GenChase.ParentChaseID)
            cmd.Parameters.AddWithValue("@InitiatorID", GenChase.InitiatorID)
            cmd.Parameters.AddWithValue("@InitiatorRemarks", GenChase.InitiatorRemarks)
            cmd.Parameters.AddWithValue("@AssignedToID", GenChase.AssignedToID)
            cmd.Parameters.AddWithValue("@ULCBranchID", GenChase.ULCBranchID)
            cmd.Parameters.AddWithValue("@ContactPersonID", GenChase.ContactPersonID)
            cmd.Parameters.AddWithValue("@ModeOfCommunication", GenChase.ModeOfCommunication)
            cmd.Parameters.AddWithValue("@PriorityID", GenChase.PriorityID)
            cmd.Parameters.AddWithValue("@EntryBy", GenChase.EntryBy)
            dr = cmd.ExecuteReader()
            While dr.Read()
                GeneratedChaseID = dr.Item("GeneratedChaseID")
            End While
            con.Close()
            Return GeneratedChaseID
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If

            Return ""
        End Try
    End Function

    Public Function fnInsertGenGeneratedChase(ByVal GenChase As clsGeneratedChase) As String
        Dim dr As SqlDataReader
        Dim GeneratedChaseID As String = ""
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertGenGeneratedChase", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ChaseDefinitionID", GenChase.ChaseDefinitionID)
            cmd.Parameters.AddWithValue("@ParentChaseID", GenChase.ParentChaseID)
            cmd.Parameters.AddWithValue("@InitiatorID", GenChase.InitiatorID)
            cmd.Parameters.AddWithValue("@InitiatorRemarks", GenChase.InitiatorRemarks)
            cmd.Parameters.AddWithValue("@AssignedToID", GenChase.AssignedToID)
            cmd.Parameters.AddWithValue("@ULCBranchID", GenChase.ULCBranchID)
            cmd.Parameters.AddWithValue("@ContactPersonID", GenChase.ContactPersonID)
            cmd.Parameters.AddWithValue("@ModeOfCommunication", GenChase.ModeOfCommunication)
            cmd.Parameters.AddWithValue("@PriorityID", GenChase.PriorityID)
            cmd.Parameters.AddWithValue("@EntryBy", GenChase.EntryBy)
            cmd.Parameters.AddWithValue("@ActivationTime", GenChase.ActivationTime)
            dr = cmd.ExecuteReader()
            While dr.Read()
                GeneratedChaseID = dr.Item("GeneratedChaseID")
            End While
            con.Close()
            Return GeneratedChaseID
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If

            Return ""
        End Try
    End Function

    Public Function fnGetGenChaseInfoByID(ByVal MasterChaseID As String) As String
        Dim dr As SqlDataReader
        Dim ChaseDefinitionID As String = ""
        Try
            Dim cmd As SqlCommand = New SqlCommand("spGetGenChaseInfoByID", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@MasterChaseID", MasterChaseID)
            dr = cmd.ExecuteReader()
            While dr.Read()
                ChaseDefinitionID = dr.Item("ChaseDefinitionID")
            End While
            con.Close()
            Return ChaseDefinitionID
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If

            Return ""
        End Try
    End Function

    Public Function fnGetAssignedChaseByUser(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetAssignedChaseByUser"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
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

    Public Function fnGetChasePendingAtUser(ByVal AssignedToID As String) As DataSet

        Dim sp As String = "spGetChasePendingAtUser"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@AssignedToID", AssignedToID)
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

    Public Function fnGetAssignmentPendingUsr() As DataSet

        Dim sp As String = "spGetAssignmentPendingUsr"
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

    Public Function fnGetAssignedChase(ByVal GenChase As clsGeneratedChase) As DataSet

        Dim sp As String = "spGetAssignedChase"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CategoryID", GenChase.CategoryID)
                cmd.Parameters.AddWithValue("@SubCategoryID", GenChase.SubCategoryID)
                cmd.Parameters.AddWithValue("@ItemID", GenChase.ItemID)
                cmd.Parameters.AddWithValue("@ChaseStatus", GenChase.ChaseStatus)
                cmd.Parameters.AddWithValue("@PriorityID", GenChase.PriorityID)
                cmd.Parameters.AddWithValue("@ULCBranchID", GenChase.ULCBranchID)
                cmd.Parameters.AddWithValue("@FinalStatus", GenChase.FinalStatus)
                cmd.Parameters.AddWithValue("@InitiatorID", GenChase.InitiatorID)
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

    Public Function fnGetAssignedChaseByUserAndSts(ByVal EmployeeID As String, ByVal ChaseStatus As String) As DataSet

        Dim sp As String = "spGetAssignedChaseByUserAndSts"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                cmd.Parameters.AddWithValue("@ChaseStatus", ChaseStatus)
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

    Public Function fnGetChaseHistoryByGenChaseID(ByVal GeneratedChaseID As String) As DataSet

        Dim sp As String = "spGetChaseHistoryByGenChaseID"
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

    Public Shared Sub fnGetChaseInitiatorByGenChaseID(ByVal GeneratedChaseID As String, ByRef InitiatorID As String, ByRef InitiatorName As String)
        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)

        Dim sp As String = "spGetChaseInitiatorByGenChaseID"
        Dim dr As SqlDataReader
        Dim Priority As New clsPriority()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@GeneratedChaseID", GeneratedChaseID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    InitiatorID = dr.Item("InitiatorID")
                    InitiatorName = dr.Item("InitiatorName")
                End While
                con.Close()
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
        End Try
    End Sub

    Public Function fnGetGlobalChaseView() As DataSet

        Dim sp As String = "spGetGlobalChaseView"
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

    Public Function fnGetGlobalChaseViewByDept(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetGlobalChaseViewByDept"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
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

    Public Function fnGetCategoryWiseGlobalView() As DataSet

        Dim sp As String = "spGetCategoryWiseGlobalView"
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

    Public Function fnGetChaseDefWiseGraphicalData(ByVal CategoryID As String) As DataSet

        Dim sp As String = "spGetChaseDefWiseGraphicalData"
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

    Public Function fnGenFormattedReport(ByVal MasterReportID As String, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataSet

        Dim sp As String = "spGenFormattedReport"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@MasterReportID", MasterReportID)
                cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", DateTo)
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

    Public Function fnGetDataForGraphicalView(ByVal GeneratedChaseID As String) As DataSet

        Dim sp As String = "spGetDataForGraphicalView"
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

    Public Function fnGetChaseViewGraphByUser(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetChaseViewGraphByUser"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
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

    Public Function fnGetTotalChaseForAssessment(ByVal Year As Integer) As DataSet

        Dim sp As String = "spGetTotalChaseForAssessment"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Year", Year)
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

    Public Function fnRptGeneratedChase(ByVal GenChase As clsGeneratedChase) As DataSet

        Dim sp As String = "spRptGeneratedChase"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.CommandTimeout = 3000
                cmd.Parameters.AddWithValue("@CategoryID", GenChase.CategoryID)
                cmd.Parameters.AddWithValue("@SubCategoryID", GenChase.SubCategoryID)
                cmd.Parameters.AddWithValue("@ItemID", GenChase.ItemID)
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", GenChase.ChaseDefinitionID)
                cmd.Parameters.AddWithValue("@ChaseStatus", GenChase.ChaseStatus)
                cmd.Parameters.AddWithValue("@PriorityID", GenChase.PriorityID)
                cmd.Parameters.AddWithValue("@ULCBranchID", GenChase.ULCBranchID)
                cmd.Parameters.AddWithValue("@AssignedToID", GenChase.AssignedToID)
                cmd.Parameters.AddWithValue("@FinalStatus", GenChase.FinalStatus)
                cmd.Parameters.AddWithValue("@DateFrom ", GenChase.InitiationDateFrom)
                cmd.Parameters.AddWithValue("@DateTo", GenChase.InitiationDateTo)
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

    Public Function fnGetTaskInitiatorList() As DataSet

        Dim sp As String = "spGetTaskInitiatorList"
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


    Public Function fnGetTaskAssignedToList() As DataSet

        Dim sp As String = "spGetTaskAssignedToList"
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

    Public Function fnGetAssignedChaseByInitiator(ByVal InitiatorID As String, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataSet

        Dim sp As String = "spGetAssignedChaseByInitiator"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@InitiatorID", InitiatorID)
                cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", DateTo)
                cmd.CommandTimeout = 999999
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

    Public Function fnGetChaseContactDetails(ByVal GeneratedChaseID As String) As String
        Dim sp As String = "spGetChaseContactDetails"
        Dim dr As SqlDataReader
        Dim ContactStr As String = ""
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@GeneratedChaseID", GeneratedChaseID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ContactStr = dr.Item("ContactStr")
                End While
                con.Close()

                Return ContactStr
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return ""
        End Try
    End Function

    Public Function fnGetPriorityInfo(ByVal GeneratedChaseID As String) As clsPriority
        Dim sp As String = "spGetPriorityInfo"
        Dim dr As SqlDataReader
        Dim Priority As New clsPriority()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@GeneratedChaseID", GeneratedChaseID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    Priority.PriorityID = dr.Item("PriorityID")
                    Priority.PriorityText = dr.Item("PriorityText")
                End While
                con.Close()
                Return Priority
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#Region " Mail For Chase Generation "

    Public Function fnChaseGenearationMail(ByVal GeneratedChaseID As String) As clsMailProperty
        Dim sp As String = "spChaseGenearationMail"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@GeneratedChaseID", GeneratedChaseID)
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

    Public Function fnChaseUpdateMail(ByVal GeneratedChaseID As String) As clsMailProperty
        Dim sp As String = "spChaseUpdateMail"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@GeneratedChaseID", GeneratedChaseID)
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

    Public Function fnChaseForwardMail(ByVal GenChase As clsGeneratedChase) As clsMailProperty
        Dim sp As String = "spChaseForwardMail"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@MasterChaseID", GenChase.MasterChaseID)
                cmd.Parameters.AddWithValue("@InitiatorID", GenChase.InitiatorID)
                cmd.Parameters.AddWithValue("@AssignedToID", GenChase.AssignedToID)
                cmd.Parameters.AddWithValue("@Remarks", GenChase.Remarks)
                cmd.Parameters.AddWithValue("@ChaseProgress", GenChase.ChaseProgress)
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

    Public Function fnChaseTerminateMail(ByVal GenChase As clsGeneratedChase) As clsMailProperty
        Dim sp As String = "spChaseTerminateMail"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@GeneratedChaseID", GenChase.ParentChaseID)
                cmd.Parameters.AddWithValue("@MasterChaseID", GenChase.MasterChaseID)
                cmd.Parameters.AddWithValue("@InitiatorID", GenChase.InitiatorID)
                cmd.Parameters.AddWithValue("@Remarks", GenChase.Remarks)
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
                    ' MailProp.Attachment = dr.Item("Attachment")
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

    Public Function fnGetSupervisorChaseView(ByVal CurrentSupervisor As String, ByVal ChaseDefinitionID As String, ByVal EmployeeID As String, ByVal ChaseStatus As String) As DataSet

        Dim sp As String = "spGetSupervisorChaseView"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CurrentSupervisor", CurrentSupervisor)
                cmd.Parameters.AddWithValue("@ChaseDefinitionID", ChaseDefinitionID)
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                cmd.Parameters.AddWithValue("@ChaseStatus", ChaseStatus)
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

    Public Function fnSearchChaseByIDorName(ByVal ChaseNameOrID As String) As DataSet

        Dim sp As String = "spSearchChaseByIDorName"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.CommandTimeout = 3000
                cmd.Parameters.AddWithValue("@ChaseNameOrID", ChaseNameOrID)
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

    Public Function fnGetPerformedChase(ByVal AssignedToID As String, ByVal DateFrom As datetime, ByVal DateTo As datetime) As DataSet

        Dim sp As String = "spGetPerformedChase"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@AssignedToID", AssignedToID)
                cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", DateTo)
                cmd.CommandTimeout = 999999
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

    Public Function fnRptReqLogCount(ByVal QueryType As String) As DataSet

        Dim sp As String = "spRptReqLogCount"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@QueryType", QueryType)
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

    Public Function fnGetContactInfoByMasterID(ByVal MasterChaseID As String) As clsGeneratedChase
        Dim sp As String = "spGetContactInfoByMasterID"
        Dim dr As SqlDataReader
        Dim GenChase As New clsGeneratedChase()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@MasterChaseID", MasterChaseID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    GenChase.ULCBranchID = dr.Item("ULCBranchID")
                    GenChase.ContactPersonID = dr.Item("ContactPersonID")

                End While
                con.Close()

                Return GenChase
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

End Class
