Imports Microsoft.VisualBasic
Imports System

Public Class clsChaseGroupCtrls

    Dim _ChaseGroupCtrlID, _ChaseDefinitionID, _CtrlType, _GroupName, _GroupCode, _EntryBy As String

    Public Property ChaseGroupCtrlID() As String
        Get
            Return _ChaseGroupCtrlID
        End Get
        Set(ByVal value As String)
            _ChaseGroupCtrlID = value
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

    Public Property CtrlType() As String
        Get
            Return _CtrlType
        End Get
        Set(ByVal value As String)
            _CtrlType = value
        End Set
    End Property

    Public Property GroupName() As String
        Get
            Return _GroupName
        End Get
        Set(ByVal value As String)
            _GroupName = value
        End Set
    End Property

    Public Property GroupCode() As String
        Get
            Return _GroupCode
        End Get
        Set(ByVal value As String)
            _GroupCode = value
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
