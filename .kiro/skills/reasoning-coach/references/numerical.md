# Numerical Reasoning — Deep Reference

## Core formulas
- **Percentage change**: (New − Old) / Old × 100. Keep the sign (negative = decrease).
- **Percentage of a total**: part / whole × 100.
- **Reverse percentage** (find original before an x% rise): Original = Final / (1 + x/100).
  Before an x% fall: Original = Final / (1 − x/100).
- **Ratio sharing**: for ratio a:b:c of total T, each part = T × (its share / sum of shares).
- **Weighted average**: Σ(value × weight) / Σ(weight). Never average the averages
  unless the group sizes are equal.
- **Compound growth**: A = P(1 + r)^t. For n periods per year: A = P(1 + r/n)^(nt).
- **Index numbers**: value relative to a base = 100. A reading of 112 = 12% above base.
- **Exchange / conversion**: multiply or divide carefully; sanity-check direction
  (does the answer get bigger or smaller?).

## Multi-table / multi-source parsing
1. Identify the **join key** linking tables (year, region, product, unit).
2. Note the **units of each table separately** — one may be £m, the other £'000.
3. Pull the exact cells you need *before* calculating; write them down.
4. Only combine figures that share the same unit and time period.

## Fast shortcuts
- Estimate the magnitude first (round to 1 sig fig) to catch unit errors.
- 10% is a divide-by-10 anchor; build other percentages from it (5% = half of 10%,
  15% = 10% + 5%, 1% = 10%/10).
- To compare two fractions fast, cross-multiply rather than converting to decimals.
- "Which grew fastest?" → compare *ratios* (New/Old), not absolute differences.

## Classic traps
- **Percentage points vs percent**: a move 20%→25% is +5 points but +25% relative.
- **Wrong base**: "% of total revenue" vs "% of that region's revenue".
- **Unit switch mid-question**: hours→years, £→€, thousands→millions.
- **"Excluding" / "except"**: subtract the named item before totalling.
- **Distractor options** engineered from the common wrong base or a missed unit.

## Verification method (use a DIFFERENT method than you solved with)
- Back-substitute the answer into the original relationship.
- Reverse the arithmetic (check a × b with the result ÷ b).
- Re-estimate magnitude and confirm the answer is among the options.
