# Usage Guide

> Comprehensive guide for using poly-db-lsp across VSCode, Neovim, and Emacs

## Table of Contents

- [VSCode Setup](#vscode-setup)
- [Neovim Setup](#neovim-setup)
- [Emacs Setup](#emacs-setup)
- [Configuration](#configuration)
- [Commands](#commands)
- [Troubleshooting](#troubleshooting)
- [Adapter-Specific Notes](#adapter-specific-notes)

## VSCode Setup

### Installation

1. **Install the LSP Server:**
   ```bash
   git clone https://github.com/hyperpolymath/poly-db-lsp.git
   cd poly-db-lsp
   ./install.sh
   ```

2. **Install VSCode Extension:**
   ```bash
   cd vscode-extension
   npm install
   npm run compile
   code --install-extension *.vsix
   ```

### Features

The VSCode extension provides:

- **Multi-Database Support**: PostgreSQL, MongoDB, Redis, Neo4j, MySQL, SQLite
- **SQL/Query Completion**: Table names, columns, functions
- **Schema Validation**: Foreign keys, constraints, indexes
- **Diagnostics**: Query errors, performance warnings, security issues
- **Hover Documentation**: Table/column info, function signatures
- **Commands**: Execute queries, explain plans, manage connections

### Available Commands

Access via Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`):

- **DB: Connect** - Connect to database
- **DB: Disconnect** - Close database connection
- **DB: Execute Query** - Run SQL/query
- **DB: Explain Plan** - Show query execution plan
- **DB: List Tables** - Show all tables/collections
- **DB: Describe Table** - Show table schema
- **DB: Export Schema** - Export database schema
- **DB: Switch Database** - Change active database

### Settings

Add to your workspace or user `settings.json`:

```json
{
  "lsp.serverPath": "/path/to/poly-db-lsp",
  "lsp.trace.server": "verbose",
  "lsp.db.type": "auto",
  "lsp.db.validateOnSave": true,
  "lsp.db.enableQueryExecution": true
}
```

## Neovim Setup

### Using nvim-lspconfig

Add to your Neovim configuration:

```lua
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

-- Register poly-db-lsp if not already defined
if not configs.poly_db_lsp then
  configs.poly_db_lsp = {
    default_config = {
      cmd = {'/path/to/poly-db-lsp/_build/prod/rel/poly_db_lsp/bin/poly_db_lsp'},
      filetypes = {'sql', 'plsql', 'mysql', 'pgsql', 'mongodb', 'cypher'},
      root_dir = lspconfig.util.root_pattern(
        '.pgpass',
        'my.cnf',
        '.mongorc.js',
        'neo4j.conf',
        'redis.conf',
        'database.yml'
      ),
      settings = {
        db = {
          type = 'auto',
          validateOnSave = true,
          enableQueryExecution = true
        }
      }
    }
  }
end

-- Setup the LSP
lspconfig.poly_db_lsp.setup({
  on_attach = function(client, bufnr)
    -- Enable completion
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Key mappings
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Custom commands
    vim.api.nvim_buf_create_user_command(bufnr, 'DBExecute', function()
      vim.lsp.buf.execute_command({command = 'db.execute'})
    end, {})

    vim.api.nvim_buf_create_user_command(bufnr, 'DBExplain', function()
      vim.lsp.buf.execute_command({command = 'db.explain'})
    end, {})

    vim.api.nvim_buf_create_user_command(bufnr, 'DBTables', function()
      vim.lsp.buf.execute_command({command = 'db.tables'})
    end, {})
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})
```

## Emacs Setup

### Using lsp-mode

Add to your Emacs configuration:

```elisp
(use-package lsp-mode
  :hook ((sql-mode . lsp))
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     '("/path/to/poly-db-lsp/_build/prod/rel/poly_db_lsp/bin/poly_db_lsp"))
    :major-modes '(sql-mode)
    :server-id 'poly-db-lsp
    :priority 1
    :initialization-options (lambda ()
                             '(:type "auto"
                               :validateOnSave t)))))

;; Custom commands
(defun db-execute ()
  "Execute SQL query."
  (interactive)
  (lsp-execute-command "db.execute"))

(defun db-explain ()
  "Show query execution plan."
  (interactive)
  (lsp-execute-command "db.explain"))

(define-key lsp-mode-map (kbd "C-c q e") 'db-execute)
(define-key lsp-mode-map (kbd "C-c q x") 'db-explain)
```

## Configuration

### Server Configuration

Create `.poly-db-lsp.json` in your project root:

```json
{
  "db": {
    "type": "postgresql",
    "host": "localhost",
    "port": 5432,
    "database": "mydb",
    "username": "user",
    "password": "",
    "ssl": false
  },
  "postgresql": {
    "schema": "public",
    "enableExtensions": true
  },
  "mongodb": {
    "authSource": "admin",
    "replicaSet": ""
  },
  "redis": {
    "db": 0,
    "cluster": false
  },
  "neo4j": {
    "enableBolt": true
  },
  "mysql": {
    "charset": "utf8mb4"
  },
  "sqlite": {
    "file": "./dev.db"
  }
}
```

### Environment Variables

```bash
# PostgreSQL
export PGHOST=localhost
export PGPORT=5432
export PGDATABASE=mydb
export PGUSER=user
export PGPASSWORD=password

# MongoDB
export MONGO_URL=mongodb://localhost:27017/mydb
export MONGO_AUTH_SOURCE=admin

# Redis
export REDIS_URL=redis://localhost:6379/0
export REDIS_PASSWORD=

# Neo4j
export NEO4J_URI=bolt://localhost:7687
export NEO4J_USER=neo4j
export NEO4J_PASSWORD=password

# MySQL
export MYSQL_HOST=localhost
export MYSQL_PORT=3306
export MYSQL_DATABASE=mydb
export MYSQL_USER=root
export MYSQL_PASSWORD=password

# SQLite
export SQLITE_DATABASE=./dev.db
```

## Commands

### LSP Commands

#### db.connect
Connect to database.

**Parameters:**
- `type`: Database type
- `connectionString`: Connection string

**Returns:** Connection status

#### db.execute
Execute SQL query or command.

**Parameters:**
- `query`: SQL/query string

**Returns:** Result set or execution status

**Example (Neovim):**
```lua
vim.lsp.buf.execute_command({
  command = 'db.execute',
  arguments = {{query = 'SELECT * FROM users LIMIT 10'}}
})
```

#### db.explain
Show query execution plan.

**Parameters:**
- `query`: SQL query

**Returns:** Execution plan

#### db.tables
List all tables or collections.

**Parameters:** None

**Returns:** Table/collection list

#### db.describe
Describe table schema.

**Parameters:**
- `table`: Table name

**Returns:** Column definitions, indexes, constraints

## Troubleshooting

### Connection Errors

**Symptoms:** "Unable to connect to database" error.

**Solutions:**

1. **Verify database is running:**
   ```bash
   # PostgreSQL
   pg_isready

   # MongoDB
   mongosh --eval "db.runCommand({ ping: 1 })"

   # Redis
   redis-cli ping

   # Neo4j
   curl http://localhost:7474

   # MySQL
   mysqladmin ping

   # SQLite
   sqlite3 dev.db ".databases"
   ```

2. **Check credentials:**
   ```bash
   # Test connection manually
   psql -U user -d mydb
   mongosh mongodb://localhost:27017/mydb
   redis-cli -a password
   cypher-shell -u neo4j -p password
   mysql -u root -p mydb
   ```

### Query Execution Errors

**Symptoms:** Query fails with syntax or permission error.

**Solutions:**

1. **Validate SQL syntax:**
   ```bash
   # Use database client to test
   psql -U user -d mydb -c "SELECT * FROM users"
   ```

2. **Check permissions:**
   ```sql
   -- PostgreSQL
   SELECT * FROM information_schema.role_table_grants WHERE grantee = 'user';

   -- MySQL
   SHOW GRANTS FOR 'user'@'localhost';
   ```

## Adapter-Specific Notes

### PostgreSQL

**Detection:** `.pgpass`, `postgresql.conf`, or connection to PostgreSQL server

**Features:**
- Full SQL standard support
- Schema-aware completion
- Extension support (PostGIS, pg_trgm, etc.)
- Explain plan visualization
- Foreign key validation

**Configuration:**
```json
{
  "adapters": {
    "postgresql": {
      "host": "localhost",
      "port": 5432,
      "schema": "public",
      "enableExtensions": true,
      "sslMode": "prefer"
    }
  }
}
```

### MongoDB

**Detection:** `.mongorc.js`, `mongodb.conf`, or connection to MongoDB server

**Features:**
- MongoDB query language completion
- Collection schema inference
- Aggregation pipeline support
- Index recommendations

**Configuration:**
```json
{
  "adapters": {
    "mongodb": {
      "uri": "mongodb://localhost:27017",
      "database": "mydb",
      "authSource": "admin"
    }
  }
}
```

### Redis

**Detection:** `redis.conf` or connection to Redis server

**Features:**
- Redis command completion
- Key pattern suggestions
- Data type validation
- Pipeline support

**Configuration:**
```json
{
  "adapters": {
    "redis": {
      "host": "localhost",
      "port": 6379,
      "db": 0,
      "password": ""
    }
  }
}
```

### Neo4j

**Detection:** `neo4j.conf` or connection to Neo4j server

**Features:**
- Cypher query completion
- Graph pattern matching
- Node/relationship suggestions
- Explain plan support

**Configuration:**
```json
{
  "adapters": {
    "neo4j": {
      "uri": "bolt://localhost:7687",
      "username": "neo4j",
      "password": "password"
    }
  }
}
```

### MySQL

**Detection:** `my.cnf`, `.my.cnf`, or connection to MySQL server

**Features:**
- MySQL SQL dialect support
- Stored procedure completion
- Trigger validation
- Performance schema queries

**Configuration:**
```json
{
  "adapters": {
    "mysql": {
      "host": "localhost",
      "port": 3306,
      "database": "mydb",
      "charset": "utf8mb4"
    }
  }
}
```

### SQLite

**Detection:** `.db`, `.sqlite`, `.sqlite3` files

**Features:**
- SQLite SQL dialect
- Local file management
- Pragma completion
- Lightweight queries

**Configuration:**
```json
{
  "adapters": {
    "sqlite": {
      "file": "./dev.db",
      "readOnly": false
    }
  }
}
```

## Additional Resources

- **GitHub Repository:** https://github.com/hyperpolymath/poly-db-lsp
- **Issue Tracker:** https://github.com/hyperpolymath/poly-db-lsp/issues
- **Examples:** See `examples/` directory for sample configurations

## License

PMPL-1.0-or-later
