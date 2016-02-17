@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"C:\Ruby21\bin\ruby.exe" "C:/Users/Daniel/Documents/GitHub/cs3283/guildmasters/.bundle/ruby/2.1.0/bin/sass-convert" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"C:\Ruby21\bin\ruby.exe" "%~dpn0" %*
