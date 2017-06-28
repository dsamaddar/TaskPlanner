Imports Microsoft.VisualBasic
Imports System

Public Class clsVoiceDataColl

    Dim _VoiceDataCollectionID, _FacilityTypeID, _ServiceManager, _ClientID, _AgreementInfoID, _DataFrequency, _DataSource, _EntryBy As String

    Public Property VoiceDataCollectionID() As String
        Get
            Return _VoiceDataCollectionID
        End Get
        Set(ByVal value As String)
            _VoiceDataCollectionID = value
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

    Public Property ClientID() As String
        Get
            Return _ClientID
        End Get
        Set(ByVal value As String)
            _ClientID = value
        End Set
    End Property

    Public Property AgreementInfoID() As String
        Get
            Return _AgreementInfoID
        End Get
        Set(ByVal value As String)
            _AgreementInfoID = value
        End Set
    End Property

    Public Property DataFrequency() As String
        Get
            Return _DataFrequency
        End Get
        Set(ByVal value As String)
            _DataFrequency = value
        End Set
    End Property

    Public Property DataSource() As String
        Get
            Return _DataSource
        End Get
        Set(ByVal value As String)
            _DataSource = value
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

    Dim _CollectionDate, _EntryDate As DateTime

    Public Property CollectionDate() As DateTime
        Get
            Return _CollectionDate
        End Get
        Set(ByVal value As DateTime)
            _CollectionDate = value
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
