Imports Microsoft.VisualBasic
Imports System

Public Class clsManageWeekDays

    Dim _MngWeekDayID, _WeekDays, _FromHour, _FromMinute, _FromMeridiem, _ToHour, _ToMinute, _ToMeridiem, _EntryBy As String

    Public Property MngWeekDayID() As String
        Get
            Return _MngWeekDayID
        End Get
        Set(ByVal value As String)
            _MngWeekDayID = value
        End Set
    End Property

    Public Property WeekDays() As String
        Get
            Return _WeekDays
        End Get
        Set(ByVal value As String)
            _WeekDays = value
        End Set
    End Property

    Public Property FromHour() As String
        Get
            Return _FromHour
        End Get
        Set(ByVal value As String)
            _FromHour = value
        End Set
    End Property

    Public Property FromMinute() As String
        Get
            Return _FromMinute
        End Get
        Set(ByVal value As String)
            _FromMinute = value
        End Set
    End Property

    Public Property FromMeridiem() As String
        Get
            Return _FromMeridiem
        End Get
        Set(ByVal value As String)
            _FromMeridiem = value
        End Set
    End Property

    Public Property ToHour() As String
        Get
            Return _ToHour
        End Get
        Set(ByVal value As String)
            _ToHour = value
        End Set
    End Property

    Public Property ToMinute() As String
        Get
            Return _ToMinute
        End Get
        Set(ByVal value As String)
            _ToMinute = value
        End Set
    End Property

    Public Property ToMeridiem() As String
        Get
            Return _ToMeridiem
        End Get
        Set(ByVal value As String)
            _ToMeridiem = value
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
