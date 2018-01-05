Dim screenName
On Error Resume Next
screenName = " "
CurrentTime = "_Test_Case" & "_" & Day(now) & "_" & Month(now) & "_" & Day(now) & "_" & Year(now) & "_" & Hour(now) & "_" & Mintute(now) & "_" & Second(now)
ScreenShotName = "Name_Of_the_Screen_" & CurrentTime & ".png"
screenName = "Path where the screenshot needs to be stored: " & "\" & ScreenShotName

Desktop.CaptureBitmap "C:\UFT Test\" & screenName,True
Reporter.ReportEvent micDone, "Image", "Image", "C:\UFT Test\" & screenName
