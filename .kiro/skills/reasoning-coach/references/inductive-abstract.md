# Inductive & Abstract / Diagrammatic Reasoning — Deep Reference

## The per-frame checklist (run in this order)
1. **Quantity** — count shapes, lines, dots, sides, shaded regions. Look for +1/−1,
   doubling, odd/even alternation, prime or Fibonacci progressions.
2. **Rotation** — is an element turning 45/90/180°? Clockwise vs anti-clockwise?
   Track one identifiable element across frames.
3. **Shading / colour toggles** — alternating fill; or a **logic gate** between two
   layers: XOR (shaded only where exactly one layer is shaded), AND (both), OR
   (either).
4. **Symmetry & reflection** — mirror across a vertical/horizontal/diagonal axis.
5. **Position shift / translation** — an element moving a fixed step each frame,
   possibly wrapping around.
6. **Switch / mutation rules** — position swaps, size inversion (big↔small),
   shape substitution.

## Sequences (numbers & letters)
- Differences: constant (arithmetic), ratio (geometric), differences-of-differences
  (quadratic).
- Letters: convert to positions (A=1…Z=26); look for +constant or alternating steps;
  mind wrap-around past Z.
- Interleaved sequences: odd and even positions may follow separate rules.

## Matrices (3×3 "find the missing cell")
- Read **across rows** AND **down columns**; the rule often holds in both directions.
- Common matrix rules: element added/removed per step; rotation per step; one cell =
  the XOR/AND/OR of the other two in its row.
- The third cell is frequently the *combination* of the first two (overlay, or
  cancel-common-elements).

## Rule discipline (avoid overfitting)
- Form a candidate rule, then **test it against every row/column/term** before
  trusting it.
- Prefer the **simplest** rule that fits all data. If two rules both fit, pick the
  one needing fewer exceptions.
- Among the answer options, eliminate any that break a confirmed sub-rule (e.g.
  wrong shape count), narrowing before you finalise.

## Traps
- A salient but irrelevant feature (colour) distracting from the real rule (count).
- Rotation that looks like reflection (check a non-symmetric element to tell them
  apart).
- Two rules running at once (e.g. rotate AND add a dot).

## Verification
- Apply the rule forward from the first frame to regenerate the known frames.
- Confirm the chosen option matches on **all** tracked dimensions, not just one.
