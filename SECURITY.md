# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability within poly-db-lsp, please send an email to jonathan.jewell@open.ac.uk. All security vulnerabilities will be promptly addressed.

Please include:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

## Security Considerations

### Database Credentials

- Never commit database credentials to version control
- Use environment variables or secure credential stores
- The LSP server does not store credentials persistently

### CLI Tool Execution

- All database CLI tools are executed with user-provided credentials
- Command injection prevention is implemented via parameterized execution
- Output is sanitized before display

### Network Security

- Connection information is only stored in memory during active sessions
- SSL/TLS should be used for database connections when available
- No credentials are logged

### VSCode Extension

- Extension follows VSCode security best practices
- No telemetry or data collection
- Runs with minimal required permissions

## Best Practices

1. Always use encrypted connections (SSL/TLS) for database access
2. Use least-privilege database accounts
3. Keep database CLI tools updated
4. Review connection configurations regularly
5. Use read-only accounts when possible
