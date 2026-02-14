-- Example analytical queries (MySQL 8.x)
-- Notes:
-- - Q1 intentionally combines Tasks 1–3 (list classes, list axioms, count axioms).
-- - Uses GROUP_CONCAT with numeric ordering by the suffix of id_axiom (e.g., a1, a2, ...).

/* Q1: List algebraic classes (no id), include defining axioms (names) and how many define the class.
      Order by the number of defining axioms (descending). */
SELECT
  ac.algclass_name,
  GROUP_CONCAT(
    ax.axiom_name
    ORDER BY CAST(SUBSTRING(ax.id_axiom, 2) AS UNSIGNED)
    SEPARATOR ', '
  ) AS axioms,
  COUNT(ax.id_axiom) AS axiom_count
FROM algclasses AS ac
LEFT JOIN algclass_axiom AS aca
  ON ac.id_algclass = aca.id_algclass
LEFT JOIN axioms AS ax
  ON ax.id_axiom = aca.id_axiom
GROUP BY ac.algclass_name
ORDER BY axiom_count DESC;

/* Q2: Which algebraic class(es) have the most defining axioms? (ties allowed) */
WITH counts AS (
  SELECT
    ac.id_algclass,
    ac.algclass_name,
    COUNT(ax.id_axiom) AS axiom_count
  FROM algclasses AS ac
  LEFT JOIN algclass_axiom AS aca
    ON ac.id_algclass = aca.id_algclass
  LEFT JOIN axioms AS ax
    ON ax.id_axiom = aca.id_axiom
  GROUP BY ac.id_algclass, ac.algclass_name
)
SELECT
  algclass_name,
  axiom_count
FROM counts
WHERE axiom_count = (SELECT MAX(axiom_count) FROM counts);

/* Q3: List algebraic classes with id, and count how many superclasses and subclasses each has. */
SELECT
  ac.id_algclass,
  ac.algclass_name,
  COUNT(DISTINCT sub.id_subclass)   AS subclasses,
  COUNT(DISTINCT sup.id_superclass) AS superclasses
FROM algclasses AS ac
LEFT JOIN subclasses AS sup
  ON ac.id_algclass = sup.id_subclass
LEFT JOIN subclasses AS sub
  ON ac.id_algclass = sub.id_superclass
GROUP BY ac.id_algclass, ac.algclass_name
ORDER BY ac.id_algclass;
