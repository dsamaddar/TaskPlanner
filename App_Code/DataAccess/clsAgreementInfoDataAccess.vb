Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Imports System

Public Class clsAgreementInfoDataAccess

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function fnGetExecutivesByFacilityType(ByVal FacilityTypeID As String) As DataSet

        Dim sp As String = "spGetExecutivesByFacilityType"
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

    Public Function fnGetClientListByFacSM(ByVal AgrInfo As clsAgreementInfo) As DataSet

        Dim sp As String = "spGetClientListByFacSM"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@FacilityTypeID", AgrInfo.FacilityTypeID)
                cmd.Parameters.AddWithValue("@ServiceManager", AgrInfo.ServiceManager)
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

    Public Function fnGetAgrListByFac_SM_Client(ByVal AgrInfo As clsAgreementInfo) As DataSet

        Dim sp As String = "spGetAgrListByFac_SM_Client"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@FacilityTypeID", AgrInfo.FacilityTypeID)
                cmd.Parameters.AddWithValue("@ServiceManager", AgrInfo.ServiceManager)
                cmd.Parameters.AddWithValue("@ClientID", AgrInfo.ClientID)
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
