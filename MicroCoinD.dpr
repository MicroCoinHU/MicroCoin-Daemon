{==============================================================================|
| MicroCoin                                                                    |
| Copyright (c) 2017-2018 MicroCoin Developers                                 |
|==============================================================================|
| Permission is hereby granted, free of charge, to any person obtaining a copy |
| of this software and associated documentation files (the "Software"), to     |
| deal in the Software without restriction, including without limitation the   |
| rights to use, copy, modify, merge, publish, distribute, sublicense, and/or  |
| sell opies of the Software, and to permit persons to whom the Software is    |
| furnished to do so, subject to the following conditions:                     |
|                                                                              |
| The above copyright notice and this permission notice shall be included in   |
| all copies or substantial portions of the Software.                          |
|------------------------------------------------------------------------------|
| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR   |
| IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,     |
| FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  |
| AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER       |
| LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING      |
| FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER          |
| DEALINGS IN THE SOFTWARE.                                                    |
|==============================================================================|
| File:       MicroCoin.pas                                                    |
| Created at: 2018-09-17                                                       |
| Purpose:    MicroCoin Command line client                                    |
|==============================================================================}
program MicroCoinD;
{$IFDEF MSWINDOWS}
{$APPTYPE CONSOLE}
{$ENDIF}

{$ifdef fpc}
 {$mode delphi}
{$else}
 {$WEAKLINKRTTI ON}
{$endif}

{$R *.res}

uses
  {$IFDEF LINUX}
  cthreads,
  {$ENDIF }
  {$IFDEF DEBUG}
  FastMM4,
  {$ENDIF }
  {$IFDEF MSWINDOWS}
  windows,
  Messages,
    {$IFNDEF FPC}
    System.Console,
    {$ENDIF}
  {$ENDIF}
  Classes,
  sysutils,
  MicroCoin.Account.AccountKey in 'src\MicroCoin\Account\MicroCoin.Account.AccountKey.pas',
  MicroCoin.Account.Data in 'src\MicroCoin\Account\MicroCoin.Account.Data.pas',
  MicroCoin.Account.RPC in 'src\MicroCoin\Account\MicroCoin.Account.RPC.pas',
  MicroCoin.Account.Storage in 'src\MicroCoin\Account\MicroCoin.Account.Storage.pas',
  MicroCoin.Account.Transaction in 'src\MicroCoin\Account\MicroCoin.Account.Transaction.pas',
  MicroCoin.Application.Settings in 'src\MicroCoin\Application\MicroCoin.Application.Settings.pas',
  MicroCoin.BlockChain.Base in 'src\MicroCoin\BlockChain\MicroCoin.BlockChain.Base.pas',
  MicroCoin.BlockChain.Block in 'src\MicroCoin\BlockChain\MicroCoin.BlockChain.Block.pas',
  MicroCoin.BlockChain.BlockHeader in 'src\MicroCoin\BlockChain\MicroCoin.BlockChain.BlockHeader.pas',
  MicroCoin.BlockChain.BlockManager in 'src\MicroCoin\BlockChain\MicroCoin.BlockChain.BlockManager.pas',
  MicroCoin.BlockChain.Events in 'src\MicroCoin\BlockChain\MicroCoin.BlockChain.Events.pas',
  MicroCoin.BlockChain.FileStorage in 'src\MicroCoin\BlockChain\MicroCoin.BlockChain.FileStorage.pas',
  MicroCoin.BlockChain.Protocol in 'src\MicroCoin\BlockChain\MicroCoin.BlockChain.Protocol.pas',
  MicroCoin.BlockChain.Storage in 'src\MicroCoin\BlockChain\MicroCoin.BlockChain.Storage.pas',
  MicroCoin.Common.AppSettings in 'src\MicroCoin\Common\MicroCoin.Common.AppSettings.pas',
  MicroCoin.Common.IniFileSettings in 'src\MicroCoin\Common\MicroCoin.Common.IniFileSettings.pas',
  MicroCoin.Common.Lists in 'src\MicroCoin\Common\MicroCoin.Common.Lists.pas',
  MicroCoin.Common in 'src\MicroCoin\Common\MicroCoin.Common.pas',
  UAES in 'src\MicroCoin\Deprecated\UAES.pas',
  UBaseTypes in 'src\MicroCoin\Deprecated\UBaseTypes.pas',
  UChunk in 'src\MicroCoin\Deprecated\UChunk.pas',
  UCrypto in 'src\MicroCoin\Deprecated\UCrypto.pas',
  UECIES in 'src\MicroCoin\Deprecated\UECIES.pas',
  UJSONFunctions in 'src\MicroCoin\Deprecated\UJSONFunctions.pas',
  ULog in 'src\MicroCoin\Deprecated\ULog.pas',
  UTCPIP in 'src\MicroCoin\Deprecated\UTCPIP.pas',
  UThread in 'src\MicroCoin\Deprecated\UThread.pas',
  UTime in 'src\MicroCoin\Deprecated\UTime.pas',
  UWalletKeys in 'src\MicroCoin\Deprecated\UWalletKeys.pas',
  MicroCoin.Keys.KeyManager in 'src\MicroCoin\Keys\MicroCoin.Keys.KeyManager.pas',
  MicroCoin.Mining.Common in 'src\MicroCoin\Mining\MicroCoin.Mining.Common.pas',
  MicroCoin.Mining.Server in 'src\MicroCoin\Mining\MicroCoin.Mining.Server.pas',
  MicroCoin.Net.Client in 'src\MicroCoin\Net\MicroCoin.Net.Client.pas',
  MicroCoin.Net.Connection in 'src\MicroCoin\Net\MicroCoin.Net.Connection.pas',
  MicroCoin.Net.ConnectionBase in 'src\MicroCoin\Net\MicroCoin.Net.ConnectionBase.pas',
  MicroCoin.Net.ConnectionManager in 'src\MicroCoin\Net\MicroCoin.Net.ConnectionManager.pas',
  MicroCoin.Net.Discovery in 'src\MicroCoin\Net\MicroCoin.Net.Discovery.pas',
  MicroCoin.Net.Events in 'src\MicroCoin\Net\MicroCoin.Net.Events.pas',
  MicroCoin.Net.INetNotificationSource in 'src\MicroCoin\Net\MicroCoin.Net.INetNotificationSource.pas',
  MicroCoin.Net.NodeServer in 'src\MicroCoin\Net\MicroCoin.Net.NodeServer.pas',
  MicroCoin.Net.Protocol in 'src\MicroCoin\Net\MicroCoin.Net.Protocol.pas',
  MicroCoin.Net.Server in 'src\MicroCoin\Net\MicroCoin.Net.Server.pas',
  MicroCoin.Net.Statistics in 'src\MicroCoin\Net\MicroCoin.Net.Statistics.pas',
  MicroCoin.Net.Time in 'src\MicroCoin\Net\MicroCoin.Net.Time.pas',
  MicroCoin.Net.Utils in 'src\MicroCoin\Net\MicroCoin.Net.Utils.pas',
  MicroCoin.Node.Events in 'src\MicroCoin\Node\MicroCoin.Node.Events.pas',
  MicroCoin.Node.Node in 'src\MicroCoin\Node\MicroCoin.Node.Node.pas',
  MicroCoin.RPC.Client in 'src\MicroCoin\RPC\MicroCoin.RPC.Client.pas',
  MicroCoin.RPC.Handler in 'src\MicroCoin\RPC\MicroCoin.RPC.Handler.pas',
  MicroCoin.RPC.MethodHandler in 'src\MicroCoin\RPC\MicroCoin.RPC.MethodHandler.pas',
  MicroCoin.RPC.Plugin in 'src\MicroCoin\RPC\MicroCoin.RPC.Plugin.pas',
  MicroCoin.RPC.PluginManager in 'src\MicroCoin\RPC\MicroCoin.RPC.PluginManager.pas',
  MicroCoin.RPC.Result in 'src\MicroCoin\RPC\MicroCoin.RPC.Result.pas',
  MicroCoin.RPC.Server in 'src\MicroCoin\RPC\MicroCoin.RPC.Server.pas',
  MicroCoin.Transaction.Base in 'src\MicroCoin\Transaction\MicroCoin.Transaction.Base.pas',
  MicroCoin.Transaction.Events in 'src\MicroCoin\Transaction\MicroCoin.Transaction.Events.pas',
  MicroCoin.Transaction.HashTree in 'src\MicroCoin\Transaction\MicroCoin.Transaction.HashTree.pas',
  MicroCoin.Transaction.ITransaction in 'src\MicroCoin\Transaction\MicroCoin.Transaction.ITransaction.pas',
  MicroCoin.Transaction.Manager in 'src\MicroCoin\Transaction\MicroCoin.Transaction.Manager.pas',
  MicroCoin.Transaction.Transaction in 'src\MicroCoin\Transaction\MicroCoin.Transaction.Transaction.pas',
  MicroCoin.Transaction.TransactionList in 'src\MicroCoin\Transaction\Lists\MicroCoin.Transaction.TransactionList.pas',
  MicroCoin.Transaction.ChangeAccountInfo in 'src\MicroCoin\Transaction\Plugins\MicroCoin.Transaction.ChangeAccountInfo.pas',
  MicroCoin.Transaction.ChangeKey in 'src\MicroCoin\Transaction\Plugins\MicroCoin.Transaction.ChangeKey.pas',
  MicroCoin.Transaction.CreateSubAccount in 'src\MicroCoin\Transaction\Plugins\MicroCoin.Transaction.CreateSubAccount.pas',
  MicroCoin.Transaction.ListAccount in 'src\MicroCoin\Transaction\Plugins\MicroCoin.Transaction.ListAccount.pas',
  MicroCoin.Transaction.RecoverFounds in 'src\MicroCoin\Transaction\Plugins\MicroCoin.Transaction.RecoverFounds.pas',
  MicroCoin.Transaction.TransferMoney in 'src\MicroCoin\Transaction\Plugins\MicroCoin.Transaction.TransferMoney.pas',
  MicroCoin.Console.Application in 'src\MicroCoin\Application\MicroCoin.Console.Application.pas',
  MicroCoin.Net.CommandHandler in 'src\MicroCoin\Net\MicroCoin.Net.CommandHandler.pas',
  MicroCoin.Net.Handlers.AccountStorage in 'src\MicroCoin\Net\Handlers\MicroCoin.Net.Handlers.AccountStorage.pas',
  MicroCoin.Net.Handlers.GetBlocks in 'src\MicroCoin\Net\Handlers\MicroCoin.Net.Handlers.GetBlocks.pas',
  MicroCoin.Net.Handlers.GetOpBlocks in 'src\MicroCoin\Net\Handlers\MicroCoin.Net.Handlers.GetOpBlocks.pas',
  MicroCoin.Net.Handlers.Hello in 'src\MicroCoin\Net\Handlers\MicroCoin.Net.Handlers.Hello.pas',
  MicroCoin.Net.Handlers.Message in 'src\MicroCoin\Net\Handlers\MicroCoin.Net.Handlers.Message.pas',
  MicroCoin.Net.Handlers.NewBlock in 'src\MicroCoin\Net\Handlers\MicroCoin.Net.Handlers.NewBlock.pas',
  MicroCoin.Net.Handlers.NewTransaction in 'src\MicroCoin\Net\Handlers\MicroCoin.Net.Handlers.NewTransaction.pas',
  MicroCoin.Crypto.BigNum in 'src\MicroCoin\Crypto\MicroCoin.Crypto.BigNum.pas',
  MicroCoin.Crypto.Errors in 'src\MicroCoin\Crypto\MicroCoin.Crypto.Errors.pas',
  MicroCoin.Crypto.Keys in 'src\MicroCoin\Crypto\MicroCoin.Crypto.Keys.pas';

var quit : boolean;

  type
    ConsoleThread  = class(TThread)
      procedure Execute; override;
    end;

{ ConsoleThread }

procedure ConsoleThread.execute;
var
  c:Char;
begin
  c := 'a';
  {$IFNDEF FPC}
  repeat
    if Console.KeyAvailable
    then c := Console.ReadKey.KeyChar;
    Sleep(1000);
    TLog.NewLog(ltdebug, '', '');
  until c='q';
  quit := true;
  {$ENDIF}
end;

begin
  quit := false;
  with TMicroCoinApplication.Create do begin
    ConsoleThread.Create(false);
    {$IFDEF MSWINDOWS}
    SetConsoleTitle('MicroCoin');
    {$ENDIF}
    while not quit do begin
      CheckSynchronize(1);
    end;
    Terminate;
  end;
  try
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
