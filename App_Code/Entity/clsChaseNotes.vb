Imports Microsoft.VisualBasic
Imports System

Public Class clsChaseNotes

    Dim _ChaseNoteID, _GeneratedChaseID, _MasterChaseID, _Notes, _Attachments, _EntryBy As String

    Public Property ChaseNoteID() As String
        Get
            Return _ChaseNoteID
        End Get
        Set(ByVal value As String)
            _ChaseNoteID = value
        End Set
    End Property

    Public Property GeneratedChaseID() As String
        Get
            Return _GeneratedChaseID
        End Get
        Set(ByVal value As String)
            _GeneratedChaseID = value
        End Set
    End Property

    Public Property MasterChaseID() As String
        Get
            Return _MasterChaseID
        End Get
        Set(ByVal value As String)
            _MasterChaseID = value
        End Set
    End Property

    Public Property Notes() As String
        Get
            Return _Notes
        End Get
        Set(ByVal value As String)
            _Notes = value
        End Set
    End Property

    Public Property Attachments() As String
        Get
            Return _Attachments
        End Get
        Set(ByVal value As String)
            _Attachments = value
        End Set
    End Property

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
        End Set
    End Property

    Dim _EntryDate As DateTime

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

End Class
