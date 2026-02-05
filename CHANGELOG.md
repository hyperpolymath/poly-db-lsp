# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project structure
- Adapter behaviour definition with callbacks: detect, query, schema, migrate, backup, version, metadata
- PostgreSQL adapter with psql integration
- MongoDB adapter with mongosh integration
- Redis adapter with redis-cli integration
- Neo4j adapter with cypher-shell integration
- MySQL adapter with mysql CLI integration
- SQLite adapter with sqlite3 integration
- VSCode extension scaffold
- Checkpoint files (STATE.scm, META.scm, ECOSYSTEM.scm)
- README.adoc with project documentation
- Basic test structure

### Planned
- LSP server implementation using GenLSP
- Remaining 15 database adapters (Elasticsearch, Cassandra, InfluxDB, etc.)
- Query auto-completion
- Schema introspection UI
- Connection management
- Query diagnostics
- VSCode extension implementation
- Comprehensive test suite

## [0.1.0] - 2026-02-05

### Added
- Initial release
