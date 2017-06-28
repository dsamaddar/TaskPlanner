Imports Microsoft.VisualBasic
Imports System

Public Class clsControlList

    Dim _ChaseDefinitionID, _ControlListID, _ControlID, _ControlLabelInfo, _ControlValue, _ControlType, _DataType, _DataSource, _GroupControlLabelInfo, _GroupControlID, _EntryBy, _IsGroupControlText, _
    _ReportingHead, _ValueSelectionType As String

    Public Property ChaseDefinitionID() As String
        Get
            Return _ChaseDefinitionID
        End Get
        Set(ByVal value As String)
            _ChaseDefinitionID = value
        End Set
    End Property

    Public Property ControlListID() As String
        Get
            Return _ControlListID
        End Get
        Set(ByVal value As String)
            _ControlListID = value
        End Set
    End Property

    Public Property ControlID() As String
        Get
            Return _ControlID
        End Get
        Set(ByVal value As String)
            _ControlID = value
        End Set
    End Property

    Public Property ControlLabelInfo() As String
        Get
            Return _ControlLabelInfo
        End Get
        Set(ByVal value As String)
            _ControlLabelInfo = value
        End Set
    End Property

    Public Property ControlValue() As String
        Get
            Return _ControlValue
        End Get
        Set(ByVal value As String)
            _ControlValue = value
        End Set
    End Property

    Public Property ControlType() As String
        Get
            Return _ControlType
        End Get
        Set(ByVal value As String)
            _ControlType = value
        End Set
    End Property

    Public Property DataType() As String
        Get
            Return _DataType
        End Get
        Set(ByVal value As String)
            _DataType = value
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

    Public Property GroupControlLabelInfo() As String
        Get
            Return _GroupControlLabelInfo
        End Get
        Set(ByVal value As String)
            _GroupControlLabelInfo = value
        End Set
    End Property

    Public Property GroupControlID() As String
        Get
            Return _GroupControlID
        End Get
        Set(ByVal value As String)
            _GroupControlID = value
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

    Public Property IsGroupControlText() As String
        Get
            Return _IsGroupControlText
        End Get
        Set(ByVal value As String)
            _IsGroupControlText = value
        End Set
    End Property

    Public Property ReportingHead() As String
        Get
            Return _ReportingHead
        End Get
        Set(ByVal value As String)
            _ReportingHead = value
        End Set
    End Property

    Public Property ValueSelectionType() As String
        Get
            Return _ValueSelectionType
        End Get
        Set(ByVal value As String)
            _ValueSelectionType = value
        End Set
    End Property

    Dim _ControlIndex, _ControlIDCount, _GroupControlIDCount, _DataPresentationForm, _ViewOrder As Integer

    Public Property ControlIndex() As Integer
        Get
            Return _ControlIndex
        End Get
        Set(ByVal value As Integer)
            _ControlIndex = value
        End Set
    End Property

    Public Property ControlIDCount() As Integer
        Get
            Return _ControlIDCount
        End Get
        Set(ByVal value As Integer)
            _ControlIDCount = value
        End Set
    End Property

    Public Property GroupControlIDCount() As Integer
        Get
            Return _GroupControlIDCount
        End Get
        Set(ByVal value As Integer)
            _GroupControlIDCount = value
        End Set
    End Property

    Public Property DataPresentationForm() As Integer
        Get
            Return _DataPresentationForm
        End Get
        Set(ByVal value As Integer)
            _DataPresentationForm = value
        End Set
    End Property

    Public Property ViewOrder() As Integer
        Get
            Return _ViewOrder
        End Get
        Set(ByVal value As Integer)
            _ViewOrder = value
        End Set
    End Property

    Dim _IsGroupControl, _IsActive As Boolean

    Public Property IsGroupControl() As Boolean
        Get
            Return _IsGroupControl
        End Get
        Set(ByVal value As Boolean)
            _IsGroupControl = value
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
