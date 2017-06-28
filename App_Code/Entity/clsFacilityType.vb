Imports Microsoft.VisualBasic
Imports System

Public Class clsFacilityType

    Dim _FacilityTypeID, _FacilityType, _EntryBy As String

    Public Property FacilityTypeID() As String
        Get
            Return _FacilityTypeID
        End Get
        Set(ByVal value As String)
            _FacilityTypeID = value
        End Set
    End Property

    Public Property FacilityType() As String
        Get
            Return _FacilityType
        End Get
        Set(ByVal value As String)
            _FacilityType = value
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
