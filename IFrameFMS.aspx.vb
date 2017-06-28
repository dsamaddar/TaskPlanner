Imports System.Security.Cryptography
Partial Class IFrameFMS
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim md5 As System.Security.Cryptography.MD5 = New MD5CryptoServiceProvider()
        Dim originalBytes As Byte() = ASCIIEncoding.[Default].GetBytes(Session("Password"))
        Dim encodedBytes As Byte() = md5.ComputeHash(originalBytes)


        Session("EncodedPassword") = Convert.ToBase64String(encodedBytes)

        frame1.Attributes.Add("src", "http://192.168.1.232/Feedback/Login.aspx?UserID=" + Session("LoginUserID") + "&Password=" + Convert.ToBase64String(encodedBytes))
    End Sub
End Class
