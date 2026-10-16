# Logical & Deductive Reasoning — Deep Reference

## Syllogisms (categorical logic)
Map statements to set relationships; a quick Venn/Euler sketch beats intuition.

- **All A are B**: A sits entirely inside B. (Does NOT mean all B are A.)
- **No A are B**: A and B are disjoint. Symmetric — also "No B are A".
- **Some A are B**: the A and B circles overlap in at least one member. Symmetric.
- **Some A are not B**: at least one A lies outside B.

### Valid-inference rules
- "All A are B" + "All B are C" → **All A are C** (chaining).
- "All A are B" + "No B are C" → **No A are C**.
- "Some A are B" + "All B are C" → **Some A are C**.
- From two "some" statements you can conclude **nothing** general.
- Never upgrade "some" to "all" or flip "all A are B" into "all B are A".

## Constraint / data-grid puzzles (seating, scheduling, matching)
1. List entities on one axis, attributes/positions on the other → a grid.
2. Translate each clue into grid marks: ✓ (must), ✗ (cannot).
3. Start from the **most restrictive clue** (fewest possibilities).
4. Propagate forced consequences after every placement.
5. When stuck, pick an open cell, assume a value, and test for contradiction
   (hypothetical reasoning).

## Conditional logic
- "If P then Q" (P → Q). Valid: **modus ponens** (P, therefore Q) and **modus
  tollens** (not-Q, therefore not-P).
- Invalid traps: affirming the consequent (Q, therefore P) and denying the
  antecedent (not-P, therefore not-Q).
- Contrapositive of P → Q is ¬Q → ¬P (always equivalent).

## Traps
- Smuggling real-world assumptions into a formal premise.
- Treating "some" as "most" or "all".
- Confusing necessary vs sufficient conditions.
- Order-of-clue overload — not starting from the tightest constraint.

## Verification
- Re-test the chosen conclusion against **every** premise.
- For grids, confirm no clue is violated by the final arrangement.
