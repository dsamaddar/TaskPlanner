Imports System
Imports Microsoft.VisualBasic

Partial Class WordTagRemoval
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim i As Integer = 0
        Label1.Text = TextBox1.Text.Length
        Dim Arr As String() = Split(TextBox1.Text, "<!--")
        For i = 0 To Arr.Length - 1

            Dim endIndex As Integer = Arr(i).IndexOf("-->")
            If endIndex > 0 Then
                Arr(i) = Arr(i).Remove(0, endIndex + 3)
                TextBox2.Text += ClearUnwantedTag(Arr(i))
            End If

        Next

        If TextBox2.Text = "" Then
            TextBox2.Text = ClearUnwantedTag(TextBox1.Text)
        End If

        Label2.Text = TextBox2.Text.Length

    End Sub

    Protected Function ClearUnwantedTag(ByVal html As String) As String

        html = html.Replace("&" & "nbsp;", " ").Trim()

        '' start by completely removing all unwanted tags 
        html = Regex.Replace(html, "<[/]?(font|span|xml|del|ins|[ovwxp]:\w+)[^>]*?>", "", RegexOptions.IgnoreCase)

        '' then run another pass over the html (twice), removing unwanted attributes 
        html = Regex.Replace(html, "<([^>]*)(?:class|lang|style|size|face|[ovwxp]:\w+)=(?:'[^']*'|""[^""]*""|[^\s>]+)([^>]*)>", "<$1$2>", RegexOptions.IgnoreCase)
        html = Regex.Replace(html, "<([^>]*)(?:class|lang|style|size|face|[ovwxp]:\w+)=(?:'[^']*'|""[^""]*""|[^\s>]+)([^>]*)>", "<$1$2>", RegexOptions.IgnoreCase)
        Return html
    End Function
    

End Class
