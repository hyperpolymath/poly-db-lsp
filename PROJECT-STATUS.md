# poly-db-lsp Project Status

**Created:** 2026-02-05
**Status:** Initialization Complete (Ready for Development)

## Overview

poly-db-lsp is a Language Server Protocol implementation for 21 database systems, providing IDE integration for database management across relational, document, key-value, graph, wide-column, time-series, and search databases.

## Completed Items

### 1. Project Structure
- [x] Created directory structure following poly-ssg-lsp template
- [x] Initialized git repository (local only, no remote yet)
- [x] Copied configuration files (.gitignore, justfile, LICENSE, .formatter.exs)

### 2. Core Implementation
- [x] Created `mix.exs` with proper dependencies and metadata
- [x] Defined `PolyDB.Adapters.Behaviour` with 7 callbacks:
  - `detect/1` - Detect database configuration
  - `query/2` - Execute queries
  - `schema/1` - Schema introspection
  - `migrate/2` - Run migrations
  - `backup/2` - Create backups
  - `version/0` - Get database version
  - `metadata/0` - Get adapter metadata

### 3. Database Adapters (6 of 21 implemented)
- [x] **PostgreSQL** - Uses `psql` CLI (port 5432)
- [x] **MongoDB** - Uses `mongosh` CLI (port 27017)
- [x] **Redis** - Uses `redis-cli` CLI (port 6379)
- [x] **Neo4j** - Uses `cypher-shell` CLI (port 7687)
- [x] **MySQL** - Uses `mysql` CLI (port 3306)
- [x] **SQLite** - Uses `sqlite3` CLI (file-based)

### 4. Application Setup
- [x] Created `PolyDB.LSP.Application` with supervision tree
- [x] Created `PolyDB.LSP` module with `detect_databases/1` and `list_adapters/0`
- [x] All adapters run as isolated GenServers

### 5. VSCode Extension Scaffold
- [x] Created `vscode-extension/` directory
- [x] Created `package.json` with extension metadata
- [x] Created `tsconfig.json` for TypeScript compilation
- [x] Created `src/extension.ts` with LSP client integration
- [x] Registered commands:
  - `polydb.executeQuery`
  - `polydb.showSchema`
  - `polydb.createBackup`
  - `polydb.connectDatabase`

### 6. Checkpoint Files
- [x] **STATE.scm** - Current project state (20% completion)
- [x] **META.scm** - Architecture decisions and development practices
- [x] **ECOSYSTEM.scm** - Project ecosystem position and relationships

### 7. Documentation
- [x] **README.adoc** - Comprehensive project documentation
- [x] **CHANGELOG.md** - Version history and planned features
- [x] **CONTRIBUTING.md** - Contribution guidelines
- [x] **SECURITY.md** - Security policy and best practices

### 8. Testing
- [x] Created test structure with `test_helper.exs`
- [x] Created initial test file `poly_db_lsp_test.exs`

### 9. Build Tools
- [x] Updated `justfile` with database-specific recipes:
  - `just detect <path>` - Test database detection
  - `just list-adapters` - List all adapters

## Remaining Work (Prioritized)

### Phase 1: Core LSP Implementation (Next)
- [ ] Add GenLSP dependency to mix.exs
- [ ] Create `PolyDB.LSP.Server` module
- [ ] Implement LSP handlers:
  - [ ] Initialize/shutdown
  - [ ] Text synchronization
  - [ ] Execute command
  - [ ] Completion
  - [ ] Diagnostics
  - [ ] Hover

### Phase 2: Additional Adapters (15 remaining)
**High Priority (5):**
- [ ] Elasticsearch - Search engine (port 9200)
- [ ] Apache Cassandra - Wide-column store (port 9042)
- [ ] InfluxDB - Time series (port 8086)
- [ ] Microsoft SQL Server - Enterprise RDBMS (port 1433)
- [ ] CouchDB - Document store (port 5984)

**Medium Priority (5):**
- [ ] ScyllaDB - Cassandra alternative (port 9042)
- [ ] ArangoDB - Multi-model (port 8529)
- [ ] TimescaleDB - PostgreSQL extension
- [ ] RavenDB - Document store (port 8080)
- [ ] OrientDB - Graph database (port 2424)

**Lower Priority (5):**
- [ ] Oracle Database - Enterprise RDBMS (port 1521)
- [ ] IBM Db2 - Enterprise RDBMS (port 50000)
- [ ] HBase - Hadoop database (port 9090)
- [ ] Memcached - Cache (port 11211)
- [ ] etcd - Key-value store (port 2379)

### Phase 3: IDE Features
- [ ] Query auto-completion engine
- [ ] Schema object completion
- [ ] Query syntax validation
- [ ] Performance diagnostics
- [ ] Go-to-definition for schema objects
- [ ] Connection management UI

### Phase 4: VSCode Extension
- [ ] Compile TypeScript extension
- [ ] Implement LSP client fully
- [ ] Add connection management panel
- [ ] Add query editor with syntax highlighting
- [ ] Add result viewer
- [ ] Add schema explorer tree view
- [ ] Package extension for VSCode marketplace

### Phase 5: Testing & Quality
- [ ] Unit tests for all adapters
- [ ] Integration tests with real databases
- [ ] Mock CLI tools for CI/CD
- [ ] Performance benchmarks
- [ ] Documentation improvements

## Architecture Decisions

### ADR-001: Elixir + BEAM VM
**Rationale:** Process isolation, fault tolerance, concurrent query execution

### ADR-002: CLI Tool Integration
**Rationale:** Avoid maintaining native drivers, leverage battle-tested tools

### ADR-003: Behaviour-Based Contract
**Rationale:** Consistent interface across 21 database types

### ADR-004: Support 21 Databases
**Rationale:** Comprehensive coverage of database ecosystem categories

## Technology Stack

- **Runtime:** Elixir 1.17+ on BEAM VM
- **LSP Framework:** GenLSP ~> 0.10
- **JSON:** Jason ~> 1.4
- **Testing:** ExUnit, Credo, Dialyxir
- **IDE:** VSCode extension (TypeScript)
- **CLI Tools:** psql, mongosh, redis-cli, cypher-shell, mysql, sqlite3, and 15 more

## File Structure

```
poly-db-lsp/
├── lib/
│   ├── adapters/
│   │   ├── behaviour.ex          # Adapter behaviour definition
│   │   ├── postgresql.ex         # PostgreSQL adapter
│   │   ├── mongodb.ex            # MongoDB adapter
│   │   ├── redis.ex              # Redis adapter
│   │   ├── neo4j.ex              # Neo4j adapter
│   │   ├── mysql.ex              # MySQL adapter
│   │   └── sqlite.ex             # SQLite adapter
│   ├── poly_db_lsp/
│   │   └── application.ex        # OTP application
│   └── poly_db_lsp.ex            # Main module
├── test/
│   ├── test_helper.exs
│   └── poly_db_lsp_test.exs
├── vscode-extension/
│   ├── src/
│   │   └── extension.ts          # VSCode extension
│   ├── package.json
│   └── tsconfig.json
├── STATE.scm                      # Project state
├── META.scm                       # Architecture decisions
├── ECOSYSTEM.scm                  # Ecosystem position
├── README.adoc                    # Main documentation
├── CHANGELOG.md                   # Version history
├── CONTRIBUTING.md                # Contribution guide
├── SECURITY.md                    # Security policy
├── LICENSE                        # PMPL-1.0-or-later
├── mix.exs                        # Project definition
├── justfile                       # Build recipes
└── .gitignore                     # Git ignore rules
```

## Next Steps

1. **Install dependencies:** `just deps`
2. **Test basic compilation:** `just build`
3. **Add GenLSP dependency** to mix.exs
4. **Implement LSP server core** in `lib/lsp/server.ex`
5. **Test adapter detection:** `just detect /path/to/project`
6. **Add remaining 15 adapters** one by one
7. **Implement VSCode extension** functionality
8. **Write comprehensive tests**

## Related Projects

- **poly-ssg-lsp** - Template for this project
- **poly-ssg-mcp** - Sibling project for SSG tooling
- **DBeaver, DataGrip** - Similar tools (competitors)
- **pgcli, mycli** - CLI tools with auto-completion (inspiration)

## License

PMPL-1.0-or-later

Copyright (c) 2025 Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>
