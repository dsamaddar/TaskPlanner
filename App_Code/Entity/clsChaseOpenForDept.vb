Imports Microsoft.VisualBasic
Imports System

Public Class clsChaseOpenForDept

    Dim _ChaseOpenForDeptID, _ChaseDefinitionID, _DepartmentID, _EntryBy As String

    Public Property ChaseOpenForDeptID() As String
        Get
            Return _ChaseOpenForDeptID
        End Get
        Set(ByVal value As String)
            _ChaseOpenForDeptID = value
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

    Public Property DepartmentID() As String
        Get
            Return _DepartmentID
        End Get
        Set(ByVal value As String)
            _DepartmentID = value
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
