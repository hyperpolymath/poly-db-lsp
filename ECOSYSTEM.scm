;; SPDX-License-Identifier: PMPL-1.0-or-later
;; ECOSYSTEM.scm - Project ecosystem position

(ecosystem
  (version "1.0")
  (name "poly-db-lsp")
  (type "language-server")
  (purpose "IDE integration for 21 database systems")

  (position-in-ecosystem
    (category "developer-tools")
    (subcategory "language-servers")
    (role "Database IDE integration and tooling")
    (target-users
      "Backend developers"
      "Database administrators"
      "DevOps engineers"
      "Data engineers"))

  (related-projects
    ((name "poly-ssg-lsp")
     (url "https://github.com/hyperpolymath/poly-ssg-lsp")
     (relationship "sibling-project")
     (description "LSP for 60+ static site generators")
     (shared-patterns
       "Elixir + GenLSP architecture"
       "Adapter-based design"
       "CLI tool integration"
       "VSCode extension structure"))

    ((name "poly-ssg-mcp")
     (url "https://github.com/hyperpolymath/poly-ssg-mcp")
     (relationship "sibling-project")
     (description "MCP server for SSGs")
     (shared-patterns
       "Polyglot tool support"
       "Process isolation"))

    ((name "pgcli")
     (url "https://www.pgcli.com/")
     (relationship "inspiration")
     (description "PostgreSQL CLI with auto-completion")
     (inspiration
       "Enhanced CLI experience"
       "Smart completions"))

    ((name "mycli")
     (url "https://www.mycli.net/")
     (relationship "inspiration")
     (description "MySQL CLI with auto-completion")
     (inspiration
       "Database-specific completion"
       "Syntax highlighting"))

    ((name "DBeaver")
     (url "https://dbeaver.io/")
     (relationship "inspiration")
     (description "Universal database tool")
     (inspiration
       "Multi-database support"
       "Connection management"))

    ((name "DataGrip")
     (url "https://www.jetbrains.com/datagrip/")
     (relationship "competitor")
     (description "JetBrains database IDE")
     (differentiation
       "Open-source vs proprietary"
       "LSP-based vs custom IDE"
       "Lightweight vs heavyweight"))

    ((name "sqltools-vscode")
     (url "https://github.com/mtxr/vscode-sqltools")
     (relationship "competitor")
     (description "VSCode SQL database tools")
     (differentiation
       "21 databases vs ~10"
       "NoSQL support"
       "Elixir-based fault tolerance")))

  (technology-stack
    (runtime "Elixir + BEAM VM")
    (framework "GenLSP")
    (cli-tools
      "psql" "mysql" "sqlite3"
      "mongosh" "redis-cli"
      "cypher-shell"
      "elasticsearch-cli"
      "cqlsh" "influx"
      "and 12 more...")
    (ide-integration "VSCode extension")
    (protocols "LSP" "JSON-RPC"))

  (integration-points
    (ide-support
      "VSCode"
      "Neovim (via nvim-lspconfig)"
      "Emacs (via lsp-mode)"
      "Sublime Text"
      "Other LSP-compatible editors")

    (database-systems
      "PostgreSQL" "MySQL" "SQLite"
      "MongoDB" "Redis" "Neo4j"
      "Elasticsearch" "Cassandra"
      "InfluxDB" "and 12 more...")

    (future-integrations
      "Database migration tools (Flyway, Liquibase)"
      "ORM frameworks (Ecto, Sequelize)"
      "Query builders"
      "Performance monitoring tools")))
