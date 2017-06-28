Imports Microsoft.VisualBasic

Public Class ProcessInfo

    Private privateProcessName As String

    Public Property ProcessName() As String
        Get
            Return privateProcessName
        End Get
        Set(ByVal value As String)
            privateProcessName = value
        End Set
    End Property

    Private privateMainWindowTitle As String

    Public Property MainWindowTitle() As String
        Get
            Return privateMainWindowTitle
        End Get
        Set(ByVal value As String)
            privateMainWindowTitle = value
        End Set
    End Property

    Private privatePagedMemorySize64 As Long

    Public Property PagedMemorySize64() As Long
        Get
            Return privatePagedMemorySize64
        End Get
        Set(ByVal value As Long)
            privatePagedMemorySize64 = value
        End Set
    End Property

End Class
