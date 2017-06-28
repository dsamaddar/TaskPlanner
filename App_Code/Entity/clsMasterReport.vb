Imports Microsoft.VisualBasic
Imports System

Public Class clsMasterReport

    Dim _MasterReportID, _ChaseDefinitionID, _ReportName, _EntryBy, _ControlListIDLst As String

    Public Property MasterReportID() As String
        Get
            Return _MasterReportID
        End Get
        Set(ByVal value As String)
            _MasterReportID = value
        End Set
    End Property

    Public Property ChaseDefinitionID() As String
        Get
            Return _ChaseDefinitionID
        End Get
        Set(ByVal value As String)
            _ChaseDefinitionID = value
        End Set
    End Property

    Public Property ReportName() As String
        Get
            Return _ReportName
        End Get
        Set(ByVal value As String)
            _ReportName = value
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

    Public Property ControlListIDLst() As String
        Get
            Return _ControlListIDLst
        End Get
        Set(ByVal value As String)
            _ControlListIDLst = value
        End Set
    End Property

    Dim _IsActive As Boolean

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
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
