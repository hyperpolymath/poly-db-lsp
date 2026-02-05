// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>

import * as vscode from 'vscode';
import {
  LanguageClient,
  LanguageClientOptions,
  ServerOptions,
  TransportKind
} from 'vscode-languageclient/node';

let client: LanguageClient;

export function activate(context: vscode.ExtensionContext) {
  console.log('PolyDB LSP extension activated');

  // Get configuration
  const config = vscode.workspace.getConfiguration('polydb');
  const lspPath = config.get<string>('lsp.path', '');

  if (!lspPath) {
    vscode.window.showWarningMessage(
      'PolyDB LSP path not configured. Please set polydb.lsp.path in settings.'
    );
    return;
  }

  // Server options - command to start the LSP server
  const serverOptions: ServerOptions = {
    command: lspPath,
    args: ['--stdio'],
    transport: TransportKind.stdio
  };

  // Client options
  const clientOptions: LanguageClientOptions = {
    documentSelector: [
      { scheme: 'file', language: 'sql' },
      { scheme: 'file', language: 'cypher' },
      { scheme: 'file', language: 'mongodb' }
    ],
    synchronize: {
      fileEvents: vscode.workspace.createFileSystemWatcher('**/*.{sql,cypher,js}')
    }
  };

  // Create and start the language client
  client = new LanguageClient(
    'polydb-lsp',
    'PolyDB LSP',
    serverOptions,
    clientOptions
  );

  client.start();

  // Register commands
  context.subscriptions.push(
    vscode.commands.registerCommand('polydb.executeQuery', executeQuery),
    vscode.commands.registerCommand('polydb.showSchema', showSchema),
    vscode.commands.registerCommand('polydb.createBackup', createBackup),
    vscode.commands.registerCommand('polydb.connectDatabase', connectDatabase)
  );
}

export function deactivate(): Thenable<void> | undefined {
  if (!client) {
    return undefined;
  }
  return client.stop();
}

async function executeQuery() {
  const editor = vscode.window.activeTextEditor;
  if (!editor) {
    return;
  }

  const query = editor.document.getText(editor.selection);
  if (!query) {
    vscode.window.showErrorMessage('No query selected');
    return;
  }

  // Send query to LSP server
  try {
    const result = await client.sendRequest('polydb/executeQuery', { query });
    vscode.window.showInformationMessage(`Query executed: ${JSON.stringify(result)}`);
  } catch (error) {
    vscode.window.showErrorMessage(`Query failed: ${error}`);
  }
}

async function showSchema() {
  try {
    const result = await client.sendRequest('polydb/getSchema', {});
    vscode.window.showInformationMessage(`Schema: ${JSON.stringify(result)}`);
  } catch (error) {
    vscode.window.showErrorMessage(`Failed to retrieve schema: ${error}`);
  }
}

async function createBackup() {
  const outputPath = await vscode.window.showInputBox({
    prompt: 'Enter backup file path',
    value: 'backup.sql'
  });

  if (!outputPath) {
    return;
  }

  try {
    const result = await client.sendRequest('polydb/createBackup', { outputPath });
    vscode.window.showInformationMessage(`Backup created: ${result}`);
  } catch (error) {
    vscode.window.showErrorMessage(`Backup failed: ${error}`);
  }
}

async function connectDatabase() {
  const host = await vscode.window.showInputBox({
    prompt: 'Database host',
    value: 'localhost'
  });

  if (!host) return;

  const port = await vscode.window.showInputBox({
    prompt: 'Database port',
    value: '5432'
  });

  if (!port) return;

  const database = await vscode.window.showInputBox({
    prompt: 'Database name'
  });

  if (!database) return;

  const user = await vscode.window.showInputBox({
    prompt: 'Username'
  });

  if (!user) return;

  try {
    await client.sendRequest('polydb/connect', {
      host,
      port: parseInt(port),
      database,
      user
    });
    vscode.window.showInformationMessage('Connected to database');
  } catch (error) {
    vscode.window.showErrorMessage(`Connection failed: ${error}`);
  }
}
