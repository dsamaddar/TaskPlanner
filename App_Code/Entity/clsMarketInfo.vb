Imports Microsoft.VisualBasic
Imports System

Public Class clsMarketInfo

    Dim _MarketInfoID, _EmployeeID, _Client, _PrimaryRating, _PrimaryRemarks, _DataStatus, _CPDesignation, _Remarks, _Attachment, _Status, _EntryBy As String

    Public Property MarketInfoID() As String
        Get
            Return _MarketInfoID
        End Get
        Set(ByVal value As String)
            _MarketInfoID = value
        End Set
    End Property

    Public Property EmployeeID() As String
        Get
            Return _EmployeeID
        End Get
        Set(ByVal value As String)
            _EmployeeID = value
        End Set
    End Property

    Public Property Client() As String
        Get
            Return _Client
        End Get
        Set(ByVal value As String)
            _Client = value
        End Set
    End Property

    Public Property PrimaryRating() As String
        Get
            Return _PrimaryRating
        End Get
        Set(ByVal value As String)
            _PrimaryRating = value
        End Set
    End Property

    Public Property PrimaryRemarks() As String
        Get
            Return _PrimaryRemarks
        End Get
        Set(ByVal value As String)
            _PrimaryRemarks = value
        End Set
    End Property

    Public Property DataStatus() As String
        Get
            Return _DataStatus
        End Get
        Set(ByVal value As String)
            _DataStatus = value
        End Set
    End Property

    Public Property CPDesignation() As String
        Get
            Return _CPDesignation
        End Get
        Set(ByVal value As String)
            _CPDesignation = value
        End Set
    End Property

    Public Property Remarks() As String
        Get
            Return _Remarks
        End Get
        Set(ByVal value As String)
            _Remarks = value
        End Set
    End Property

    Public Property Attachment() As String
        Get
            Return _Attachment
        End Get
        Set(ByVal value As String)
            _Attachment = value
        End Set
    End Property

    Public Property Status() As String
        Get
            Return _Status
        End Get
        Set(ByVal value As String)
            _Status = value
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

    Dim _EntryDate, _DateFrom, _DateTo As DateTime

    Public Property DateFrom() As DateTime
        Get
            Return _DateFrom
        End Get
        Set(ByVal value As DateTime)
            _DateFrom = value
        End Set
    End Property

    Public Property DateTo() As DateTime
        Get
            Return _DateTo
        End Get
        Set(ByVal value As DateTime)
            _DateTo = value
        End Set
    End Property

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

End Class
