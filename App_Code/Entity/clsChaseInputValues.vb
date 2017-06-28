Imports Microsoft.VisualBasic

Public Class clsChaseInputValues

    Dim _ChaseDefinitionID, _ControlType, _ControlID, _ChaseInputValueID, _GeneratedChaseID, _ReportingHead, _Value, _AdditionalValue As String

    Public Property ChaseDefinitionID() As String
        Get
            Return _ChaseDefinitionID
        End Get
        Set(ByVal value As String)
            _ChaseDefinitionID = value
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

    Public Property ControlID() As String
        Get
            Return _ControlID
        End Get
        Set(ByVal value As String)
            _ControlID = value
        End Set
    End Property

    Public Property ChaseInputValueID() As String
        Get
            Return _ChaseInputValueID
        End Get
        Set(ByVal value As String)
            _ChaseInputValueID = value
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

    Public Property ReportingHead() As String
        Get
            Return _ReportingHead
        End Get
        Set(ByVal value As String)
            _ReportingHead = value
        End Set
    End Property

    Public Property Value() As String
        Get
            Return _Value
        End Get
        Set(ByVal value As String)
            _Value = value
        End Set
    End Property

    Public Property AdditionalValue() As String
        Get
            Return _AdditionalValue
        End Get
        Set(ByVal value As String)
            _AdditionalValue = value
        End Set
    End Property

End Class
