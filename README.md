# Algebraic Logic SQL Schema

## Overview
This project contains a relational database schema (MySQL) for storing and querying relationships between logical systems, algebraic classes, axioms, and their properties.  
The schema is designed to support structured exploration of algebraic logic classifications and their interconnections.

The project focuses on:
- logical systems
- algebraic classes
- axioms and axiom systems
- logical and algebraic properties
- subclass relations between algebraic structures

---

## Tech Stack
- **DBMS:** MySQL (tested on MySQL 8.x)
- **Language:** SQL (DDL + DML + analytical queries)

---

## Database Structure (Conceptual)
Main entity groups:

- **Logics** – logical systems
- **Algclasses** – algebraic structures corresponding to logics
- **Axioms** – named axioms with formal formulas
- **Logic Properties** – properties of logical systems
- **Algebraic Properties** – properties of algebraic classes
- **Subclass Relations** – hierarchy between algebraic classes order by variety inclusion

bridge and blok_pigozzi are separate tables because these links are expected to become first-class entities later (e.g., adding theorem/correspondence name, references, notes). The current data is 1–1, but the schema keeps room for relationship attributes without redesign.

---

## Repository Structure

```text

.
├── README.md
├── LICENSE
├── DATA                        # xlsx tables with project data
├── sql/
│   ├── 01_schema.sql           # Database schema (DDL)
│   ├── 02_seed.sql             # Initial dataset (DML)
│   └── 03_queries.sql          # Example analytical queries
└── docs/
    ├── ER_diagram.png          # Full entity-relationship diagram
    ├── simplified_diagram.png  # simplified version of diagram
    └── subclasses_diagram      # special diagram for subclasses table
