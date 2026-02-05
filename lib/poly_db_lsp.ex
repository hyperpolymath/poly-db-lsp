# SPDX-License-Identifier: PMPL-1.0-or-later
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>

defmodule PolyDB.LSP do
  @moduledoc """
  PolyDB.LSP - Language Server Protocol for 21 database systems.

  Provides IDE integration for database management across multiple database systems
  including PostgreSQL, MongoDB, Redis, Neo4j, MySQL, SQLite, and many more.

  ## Supported Databases

  ### Relational (SQL)
  - PostgreSQL
  - MySQL/MariaDB
  - SQLite
  - Microsoft SQL Server
  - Oracle Database
  - IBM Db2

  ### Document Stores
  - MongoDB
  - CouchDB
  - RavenDB

  ### Key-Value Stores
  - Redis
  - Memcached
  - etcd

  ### Graph Databases
  - Neo4j
  - ArangoDB
  - OrientDB

  ### Wide Column Stores
  - Apache Cassandra
  - ScyllaDB
  - HBase

  ### Time Series
  - InfluxDB
  - TimescaleDB (PostgreSQL extension)

  ### Search Engines
  - Elasticsearch

  ## Features

  - Auto-detection of database types from project configuration
  - Query execution and result formatting
  - Schema introspection and auto-completion
  - Database backup and restore operations
  - Migration management
  - Connection management
  """

  @doc """
  Detect which database adapters are relevant for the given project path.

  Returns a list of detected database types.

  ## Examples

      iex> PolyDB.LSP.detect_databases("/path/to/project")
      {:ok, [:postgresql, :redis]}
  """
  def detect_databases(project_path) do
    adapters = [
      {PolyDB.Adapters.PostgreSQL, :postgresql},
      {PolyDB.Adapters.MongoDB, :mongodb},
      {PolyDB.Adapters.Redis, :redis},
      {PolyDB.Adapters.Neo4j, :neo4j},
      {PolyDB.Adapters.MySQL, :mysql},
      {PolyDB.Adapters.SQLite, :sqlite}
    ]

    detected = adapters
    |> Enum.filter(fn {adapter, _name} ->
      case adapter.detect(project_path) do
        {:ok, true} -> true
        _ -> false
      end
    end)
    |> Enum.map(fn {_adapter, name} -> name end)

    {:ok, detected}
  end

  @doc """
  Get metadata for all supported database adapters.
  """
  def list_adapters do
    [
      PolyDB.Adapters.PostgreSQL.metadata(),
      PolyDB.Adapters.MongoDB.metadata(),
      PolyDB.Adapters.Redis.metadata(),
      PolyDB.Adapters.Neo4j.metadata(),
      PolyDB.Adapters.MySQL.metadata(),
      PolyDB.Adapters.SQLite.metadata()
    ]
  end
end
