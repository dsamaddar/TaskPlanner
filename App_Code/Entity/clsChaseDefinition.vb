Imports Microsoft.VisualBasic
Imports System

Public Class clsChaseDefinition

    Dim _ChaseDefinitionID, _FacilityTypeID, _ChaseName, _ChaseShortCode, _CategoryID, _SubCategoryID, _ItemID, _PriorityID, _EmployeeList, _
    _InformedParties, _EntryBy, _DepartmentIDList, _PrimarySupportRep, _ChaseInstruction, _EmployeeName As String

    Public Property ChaseDefinitionID() As String
        Get
            Return _ChaseDefinitionID
        End Get
        Set(ByVal value As String)
            _ChaseDefinitionID = value
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

    Public Property ChaseName() As String
        Get
            Return _ChaseName
        End Get
        Set(ByVal value As String)
            _ChaseName = value
        End Set
    End Property

    Public Property ChaseShortCode() As String
        Get
            Return _ChaseShortCode
        End Get
        Set(ByVal value As String)
            _ChaseShortCode = value
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

    Public Property PriorityID() As String
        Get
            Return _PriorityID
        End Get
        Set(ByVal value As String)
            _PriorityID = value
        End Set
    End Property

    Public Property EmployeeList() As String
        Get
            Return _EmployeeList
        End Get
        Set(ByVal value As String)
            _EmployeeList = value
        End Set
    End Property

    Public Property InformedParties() As String
        Get
            Return _InformedParties
        End Get
        Set(ByVal value As String)
            _InformedParties = value
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

    Public Property DepartmentIDList() As String
        Get
            Return _DepartmentIDList
        End Get
        Set(ByVal value As String)
            _DepartmentIDList = value
        End Set
    End Property

    Public Property PrimarySupportRep() As String
        Get
            Return _PrimarySupportRep
        End Get
        Set(ByVal value As String)
            _PrimarySupportRep = value
        End Set
    End Property

    Public Property ChaseInstruction() As String
        Get
            Return _ChaseInstruction
        End Get
        Set(ByVal value As String)
            _ChaseInstruction = value
        End Set
    End Property

    Public Property EmployeeName() As String
        Get
            Return _EmployeeName
        End Get
        Set(ByVal value As String)
            _EmployeeName = value
        End Set
    End Property

    Dim _IsActive, _IsOpenChase, _UserCanChange As Boolean

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
        End Set
    End Property

    Public Property IsOpenChase() As Boolean
        Get
            Return _IsOpenChase
        End Get
        Set(ByVal value As Boolean)
            _IsOpenChase = value
        End Set
    End Property

    Public Property UserCanChange() As Boolean
        Get
            Return _UserCanChange
        End Get
        Set(ByVal value As Boolean)
            _UserCanChange = value
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
