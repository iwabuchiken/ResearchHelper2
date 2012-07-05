start %SystemRoot%\system32\cmd.exe
start %SystemRoot%\system32\cmd.exe

start C:\WORKS\PROGRAMS\FreeMind\Freemind.exe C:\WORKS\WORKSPACES_APTANA\FM_APTANA\ResearchHelper2.mm
REM call :rails

goto end

:rails
cd C:\WORKS\WORKSPACES_APTANA\ResearchHelper2
rails s --port 3000

:end