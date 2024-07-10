@echo off
setlocal
echo Script de Teste de email.
echo.
REM Configurações de email
set SMTP_SERVER=smtp.gmail.com
set SMTP_PORT=587
set /p SMTP_USER=Escreva a conta de email:
EditV64 -p "Inforem a senha do email:" -m SMTP_PASS
set /p EMAIL_FROM=Escreva email remetente:
set /p EMAIL_TO=Para:
curl "https://www.random.org/strings/?num=1&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new"
set /P CODIGO=Escreva o CAPTCHA:
REM Assunto e corpo do email
set EMAIL_SUBJECT="Teste de Envio de Email"
set EMAIL_BODY="Este e um e-mail de teste enviado por um script em lote usando curl. Por favor, responda a este e-mail com o codigo informado para confirmar o envio e recebimento. Codigo: %CODIGO% Obrigado!"

REM Criar arquivo de email temporário
set TEMP_EMAIL_FILE=temp_email.txt
(
    echo From: %EMAIL_FROM%
    echo To: %EMAIL_TO%
    echo Subject: %EMAIL_SUBJECT%
    echo.
    echo %EMAIL_BODY%
) > %TEMP_EMAIL_FILE%

REM Enviar email usando curl
curl --url "smtp://%SMTP_SERVER%:%SMTP_PORT%" --ssl-reqd ^
  --mail-from "%EMAIL_FROM%" --mail-rcpt "%EMAIL_TO%" ^
  --upload-file %TEMP_EMAIL_FILE% ^
  --user "%SMTP_USER%:%SMTP_PASS%"

REM Remover arquivo de email temporário
del %TEMP_EMAIL_FILE%

endlocal
pause
