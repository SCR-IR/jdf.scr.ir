' In The Name Of Allah
'  Please Download Last Version From:
'   http://jdf.scr.ir/jdf/
'    http://jdf.scr.ir/download/





Attribute VB_Name = "Module1"

' Gregorian & Jalali ( Hijri_Shamsi , Solar ) Date Converter Functions
' Author: JDF.SCR.IR =>> Download Full Version : http://jdf.scr.ir/jdf
' License: GNU/LGPL _ Open Source & Free _ Version: 2.72 : [2017=1396]
' --------------------------------------------------------------------
' 1461 = 365*4 + 4/4   &  146097 = 365*400 + 400/4 - 400/100 + 400/400
' 12053 = 365*33 + 32/4      &       36524 = 365*100 + 100/4 - 100/100


Function gregorian_to_jalali(ByVal gy As Long, ByVal gm As Long, ByVal gd As Long)
 
 Dim g_d_m(11), out(2), jy, jm, jd, days, gy2 As Long
 
 g_d_m(0) = 0
 g_d_m(1) = 31
 g_d_m(2) = 59
 g_d_m(3) = 90
 g_d_m(4) = 120
 g_d_m(5) = 151
 g_d_m(6) = 181
 g_d_m(7) = 212
 g_d_m(8) = 243
 g_d_m(9) = 273
 g_d_m(10) = 304
 g_d_m(11) = 334
 
 If (gy > 1600) Then
    jy = 979
    gy = gy - 1600
 Else
    jy = 0
    gy = gy - 621
 End If
 
 If gm > 2 Then
    gy2 = (gy + 1)
 Else
    gy2 = gy
 End If
 
 days = (365 * gy) + ((gy2 + 3) \ 4) - ((gy2 + 99) \ 100) + ((gy2 + 399) \ 400) - 80 + gd + g_d_m(gm - 1)
 jy = jy + 33 * (days \ 12053)
 days = days Mod 12053
 jy = jy + 4 * (days \ 1461)
 days = days Mod 1461
 If days > 365 Then
  jy = jy + ((days - 1) \ 365)
  days = (days - 1) Mod 365
 End If
 
 If days < 186 Then
  jm = 1 + (days \ 31)
  jd = 1 + (days Mod 31)
 Else
  jm = 7 + ((days - 186) \ 30)
  jd = 1 + ((days - 186) Mod 30)
 End If
 
 out(0) = jy
 out(1) = jm
 out(2) = jd
 
 gregorian_to_jalali = out
 
End Function


Function jalali_to_gregorian(ByVal jy As Long, ByVal jm As Long, ByVal jd As Long)
 
 Dim sal_a(12), out(2), gy, gm, gd, days, jm2, gm2, i As Long
 
 If jy > 979 Then
  gy = 1600
  jy = jy - 979
 Else
  gy = 621
 End If
 
 jm2 = IIf(jm < 7, (jm - 1) * 31, ((jm - 7) * 30) + 186)
 days = (365 * jy) + ((jy \ 33) * 8) + (((jy Mod 33) + 3) \ 4) + 78 + jd + jm2
 gy = gy + (400 * (days \ 146097))
 days = days Mod 146097
 If days > 36524 Then
  days = days - 1
  gy = gy + (100 * (days \ 36524))
  days = days Mod 36524
  If days >= 365 Then
   days = days + 1
  End If
 End If
 gy = gy + (4 * (days \ 1461))
 days = days Mod 1461
 If days > 365 Then
   gy = gy + ((days - 1) \ 365)
   days = (days - 1) Mod 365
 End If
 
 gd = days + 1
 gm = 0
 gm2 = IIf(((gy Mod 4) = 0 And (gy Mod 100) <> 0) Or ((gy Mod 400) = 0), 29, 28)
 
 sal_a(0) = 0
 sal_a(1) = 31
 sal_a(2) = gm2
 sal_a(3) = 31
 sal_a(4) = 30
 sal_a(5) = 31
 sal_a(6) = 30
 sal_a(7) = 31
 sal_a(8) = 31
 sal_a(9) = 30
 sal_a(10) = 31
 sal_a(11) = 30
 sal_a(12) = 31
 
 For i = 0 To 12
    If gd <= sal_a(i) Then Exit For
    gm = gm + 1
    gd = gd - sal_a(i)
 Next
 
 out(0) = gy
 out(1) = gm
 out(2) = gd
 
 jalali_to_gregorian = out
 
End Function