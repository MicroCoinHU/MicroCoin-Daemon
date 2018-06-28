program microcoind;

{$mode objfpc}{$H+}
{$define usecthreads}
{$apptype console}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  sysutils,
  Classes, daemonapp,
  UCrypto, upcdaemon, UAccounts;

var
c : AnsiString;
i : integer;
begin
  Application.Title:='MicroCoin Daemon application';
  RegisterDaemonClass(TPCDaemon);
  RegisterDaemonMapper(TPCDaemonMapper);
  TCrypto.InitCrypto;
  Application.Run;
end.

