Imports Microsoft.VisualBasic
Imports System

Public Class clsAgreementInfo

    Dim _AgreementInfoID, _AgreementNo, _ClientID, _FacilityTypeID, _ServiceManager, _ULCBranchID, _EntryBy As String

    Public Property AgreementInfoID() As String
        Get
            Return _AgreementInfoID
        End Get
        Set(ByVal value As String)
            _AgreementInfoID = value
        End Set
    End Property

    Public Property AgreementNo() As String
        Get
            Return _AgreementNo
        End Get
        Set(ByVal value As String)
            _AgreementNo = value
        End Set
    End Property

    Public Property ClientID() As String
        Get
            Return _ClientID
        End Get
        Set(ByVal value As String)
            _ClientID = value
        End Set
    End Property

    Public Property FacilityTypeID() As String
        Get
            Return _FacilityTypeID
        End Get
        Set(ByVal value As String)
            _FacilityTypeID = value
        End Set
    End Property

    Public Property ServiceManager() As String
        Get
            Return _ServiceManager
        End Get
        Set(ByVal value As String)
            _ServiceManager = value
        End Set
    End Property

    Public Property ULCBranchID() As String
        Get
            Return _ULCBranchID
        End Get
        Set(ByVal value As String)
            _ULCBranchID = value
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

    Dim _EnryDate As DateTime

    Public Property EnryDate() As DateTime
        Get
            Return _EnryDate
        End Get
        Set(ByVal value As DateTime)
            _EnryDate = value
        End Set
    End Property

End Class
