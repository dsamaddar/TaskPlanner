Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.Net.Mail
Imports System.Web.Mail
Imports System.Configuration

Public Class clsNetApPasswordGetDataAccess
    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CASConnString").ConnectionString)

    Public Function GetPassword(ByVal UserID As String) As String

        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim Password As String
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            cmd.Connection = con

            cmd.CommandText = "exec GetPassword '" & UserID & "'"
            rd = cmd.ExecuteReader()

            Password = ""
            While (rd.Read())
                Password = rd.GetValue(0)
            End While
            con.Close()
            Return Password
        Catch ex As SqlException
            con.Close()
            Return 0
        End Try
    End Function

End Class
