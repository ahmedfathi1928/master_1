@echo off
REM Change into the smoke_test folder where Age_Verification.robot exists
cd /d "%~dp0robot_package\apps\Imperial_Brands\Native_android\tests\smoke_test"

REM Run the test with the tag filter
robot --include IT-TC-813 Age_Verification.robot

pause
