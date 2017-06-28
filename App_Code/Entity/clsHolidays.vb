Imports Microsoft.VisualBasic
Imports System

Public Class clsHolidays

    Dim _HolidayID, _Purpose, _EntryBy As String

    Public Property HolidayID() As String
        Get
            Return _HolidayID
        End Get
        Set(ByVal value As String)
            _HolidayID = value
        End Set
    End Property

    Public Property Purpose() As String
        Get
            Return _Purpose
        End Get
        Set(ByVal value As String)
            _Purpose = value
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

    Dim _HolidayDate, _DateTo As DateTime

    Public Property HolidayDate() As DateTime
        Get
            Return _HolidayDate
        End Get
        Set(ByVal value As DateTime)
            _HolidayDate = value
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


End Class
