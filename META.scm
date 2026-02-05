;; SPDX-License-Identifier: PMPL-1.0-or-later
;; META.scm - Meta-level information

(define meta
  '((metadata
     (version "1.0")
     (created "2026-02-05")
     (updated "2026-02-05"))

    (philosophy
     (principles
      ("Polyglot database support")
      ("Process isolation for fault tolerance")
      ("Adapter-based architecture")
      ("CLI tool integration")
      ("No vendor lock-in")))

    (architecture-decisions
     ((id "ADR-001")
      (title "Use Elixir and BEAM VM")
      (status "accepted")
      (date "2026-02-05")
      (context "Need concurrent, fault-tolerant language for managing multiple database adapters")
      (decision "Use Elixir with BEAM VM for process isolation and supervision")
      (consequences
       ("Each adapter runs as isolated GenServer")
       ("Automatic fault recovery via supervision trees")
       ("Concurrent query execution")
       ("Hot code swapping capability")))

     ((id "ADR-002")
      (title "CLI tool integration over native drivers")
      (status "accepted")
      (date "2026-02-05")
      (context "Need to support 21+ databases without maintaining native Elixir drivers")
      (decision "Integrate with existing CLI tools (psql, mongosh, redis-cli, etc.)")
      (consequences
       ("Simpler adapter implementation")
       ("Leverage battle-tested CLI tools")
       ("Easier to add new database support")
       ("Performance overhead from CLI invocation")
       ("Dependency on external tools being installed")))

     ((id "ADR-003")
      (title "Behaviour-based adapter contract")
      (status "accepted")
      (date "2026-02-05")
      (context "Need consistent interface across different database types")
      (decision "Define PolyDB.Adapters.Behaviour with callbacks: detect, query, schema, migrate, backup, version, metadata")
      (consequences
       ("All adapters implement same contract")
       ("Easy to add new adapters")
       ("Consistent API for IDE integration")
       ("Some callbacks may not apply to all database types")))

     ((id "ADR-004")
      (title "Support 21 database systems initially")
      (status "accepted")
      (date "2026-02-05")
      (context "Need to cover major database categories")
      (decision "Support relational (6), document (3), key-value (3), graph (3), wide-column (3), time-series (2), search (1)")
      (consequences
       ("Comprehensive database ecosystem coverage")
       ("Significant implementation work")
       ("More maintenance burden")
       ("Better market positioning"))))

    (development-practices
     (code-quality
      ("Use Credo for style checking")
      ("Use Dialyzer for type checking")
      ("Maintain test coverage above 80%")
      ("Document all public APIs"))
     (testing
      ("Unit tests for each adapter")
      ("Integration tests with real databases")
      ("Mock CLI tools for CI/CD"))
     (documentation
      ("AsciiDoc for README")
      ("ExDoc for API documentation")
      ("Example code in docstrings")))

    (design-rationale
     (adapter-isolation
      "Each adapter runs as GenServer for fault isolation. If PostgreSQL adapter crashes, MongoDB adapter continues working.")
     (cli-integration
      "Using CLI tools (psql, mongosh) instead of native drivers reduces complexity and leverages existing battle-tested tools.")
     (behaviour-contract
      "Behaviour defines: detect (find DB config), query (execute queries), schema (introspection), migrate (schema changes), backup (data export), version (tool version), metadata (adapter info).")
     (lsp-integration
      "GenLSP provides LSP server framework. Adapters provide database-specific functionality."))))
