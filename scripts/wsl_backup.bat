@echo off
:: 1. Cau hinh thong tin (Thay doi thong tin tai day)
set DISTRO_NAME=Debian
set BACKUP_DIR=D:\WSL_Backups
set MAX_BACKUPS=3

:: Tao thu muc luu tru neu chua co
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: 2. Lay thoi gian hien tai de dat ten file (Format: YYYY-MM-DD_HHMM)
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set BACKUP_NAME=%DISTRO_NAME%_backup_%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,4%.tar

:: 3. Tat WSL de dam bao toan ven du lieu
echo Dang tat WSL...
wsl --shutdown

:: 4. Thuc hien xuat file sao luu
echo Dang sao luu %DISTRO_NAME% vao %BACKUP_DIR%\%BACKUP_NAME%...
wsl --export %DISTRO_NAME% "%BACKUP_DIR%\%BACKUP_NAME%"

:: 5. Tu dong xoa cac ban sao luu cu (Chi giu lai so luong %MAX_BACKUPS%)
echo Dang kiem tra va xoa cac ban sao luu cu...
for /f "skip=%MAX_BACKUPS% delims=" %%F in ('dir "%BACKUP_DIR%\%DISTRO_NAME%_backup_*.tar" /b /o-d') do (
    del "%BACKUP_DIR%\%%F"
    echo Da xoa ban sao luu cu: %%F
)

echo Hoan thanh!
pause
