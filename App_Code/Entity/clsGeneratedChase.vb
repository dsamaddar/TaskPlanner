Imports Microsoft.VisualBasic
Imports System

Public Class clsGeneratedChase

    Dim _GeneratedChaseID, _ChaseIDList, _ChaseDefinitionID, _VoiceDataCollectionID, _MasterChaseID, _ParentChaseID, _InitiatorID, _InitiatorRemarks, _UploadedFile, _AssignedToID, _Remarks, _TerminatorID, _ChaseProgress, _ChaseStatus, _
    _EntryBy, _CategoryID, _SubCategoryID, _ItemID, _FinalStatus As String

    Public Property GeneratedChaseID() As String
        Get
            Return _GeneratedChaseID
        End Get
        Set(ByVal value As String)
            _GeneratedChaseID = value
        End Set
    End Property

    Public Property ChaseIDList() As String
        Get
            Return _ChaseIDList
        End Get
        Set(ByVal value As String)
            _ChaseIDList = value
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

    Public Property VoiceDataCollectionID() As String
        Get
            Return _VoiceDataCollectionID
        End Get
        Set(ByVal value As String)
            _VoiceDataCollectionID = value
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

    Public Property ParentChaseID() As String
        Get
            Return _ParentChaseID
        End Get
        Set(ByVal value As String)
            _ParentChaseID = value
        End Set
    End Property

    Public Property InitiatorID() As String
        Get
            Return _InitiatorID
        End Get
        Set(ByVal value As String)
            _InitiatorID = value
        End Set
    End Property

    Public Property InitiatorRemarks() As String
        Get
            Return _InitiatorRemarks
        End Get
        Set(ByVal value As String)
            _InitiatorRemarks = value
        End Set
    End Property

    Public Property UploadedFile() As String
        Get
            Return _UploadedFile
        End Get
        Set(ByVal value As String)
            _UploadedFile = value
        End Set
    End Property

    Public Property AssignedToID() As String
        Get
            Return _AssignedToID
        End Get
        Set(ByVal value As String)
            _AssignedToID = value
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

    Public Property TerminatorID() As String
        Get
            Return _TerminatorID
        End Get
        Set(ByVal value As String)
            _TerminatorID = value
        End Set
    End Property

    Public Property ChaseProgress() As String
        Get
            Return _ChaseProgress
        End Get
        Set(ByVal value As String)
            _ChaseProgress = value
        End Set
    End Property

    Public Property ChaseStatus() As String
        Get
            Return _ChaseStatus
        End Get
        Set(ByVal value As String)
            _ChaseStatus = value
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

    Public Property CategoryID() As String
        Get
            Return _CategoryID
        End Get
        Set(ByVal value As String)
            _CategoryID = value
        End Set
    End Property

    Public Property SubCategoryID() As String
        Get
            Return _SubCategoryID
        End Get
        Set(ByVal value As String)
            _SubCategoryID = value
        End Set
    End Property

    Public Property ItemID() As String
        Get
            Return _ItemID
        End Get
        Set(ByVal value As String)
            _ItemID = value
        End Set
    End Property

    Public Property FinalStatus() As String
        Get
            Return _FinalStatus
        End Get
        Set(ByVal value As String)
            _FinalStatus = value
        End Set
    End Property

    Dim _ULCBranchID, _ContactPersonID, _ModeOfCommunication, _PriorityID As String

    Public Property ULCBranchID() As String
        Get
            Return _ULCBranchID
        End Get
        Set(ByVal value As String)
            _ULCBranchID = value
        End Set
    End Property

    Public Property ContactPersonID() As String
        Get
            Return _ContactPersonID
        End Get
        Set(ByVal value As String)
            _ContactPersonID = value
        End Set
    End Property

    Public Property ModeOfCommunication() As String
        Get
            Return _ModeOfCommunication
        End Get
        Set(ByVal value As String)
            _ModeOfCommunication = value
        End Set
    End Property

    Public Property PriorityID() As String
        Get
            Return _PriorityID
        End Get
        Set(ByVal value As String)
            _PriorityID = value
        End Set
    End Property

    Dim _InitiationDate, _TerminationDate, _EntryDate, _InitiationDateFrom, _InitiationDateTo, _ActivationTime As DateTime

    Public Property InitiationDate() As DateTime
        Get
            Return _InitiationDate
        End Get
        Set(ByVal value As DateTime)
            _InitiationDate = value
        End Set
    End Property
    Public Property InitiationDateFrom() As DateTime
        Get
            Return _InitiationDateFrom
        End Get
        Set(ByVal value As DateTime)
            _InitiationDateFrom = value
        End Set
    End Property
    Public Property InitiationDateTo() As DateTime
        Get
            Return _InitiationDateTo
        End Get
        Set(ByVal value As DateTime)
            _InitiationDateTo = value
        End Set
    End Property

    Public Property TerminationDate() As DateTime
        Get
            Return _TerminationDate
        End Get
        Set(ByVal value As DateTime)
            _TerminationDate = value
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

    Public Property ActivationTime() As DateTime
        Get
            Return _ActivationTime
        End Get
        Set(ByVal value As DateTime)
            _ActivationTime = value
        End Set
    End Property

    Dim _IsTerminated, _IsActive As Boolean

    Public Property IsTerminated() As Boolean
        Get
            Return _IsTerminated
        End Get
        Set(ByVal value As Boolean)
            _IsTerminated = value
        End Set
    End Property

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
        End Set
    End Property

End Class
