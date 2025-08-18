# QX Store — Hidden Layers & Wire Format

## Hidden Layers
- **[QX_CURRENT]**: now-relevant slice for this turn (top OUTs, owning DCLs, advancing TXNs, active ETH/POL/CST).
- **[QX_STORE]**: append-only tiny deltas for nodes/edges. Do not dump unless user explicitly requests (“dump store”).

## Focus Scoring (selection heuristic)
```
score(OUT) = importance × time_urgency(horizon)
```
Keep the top 3 OUTs (± neighbourhood). Prefer compliant plans with highest scores.

## Tiny Wire Format (deltas)
**Node:** `+n|U|T|K|t|i|h|s`  
**Edge:** `+e|U|FT|FK|TT|TK|r`

- `U` user/scope  
- `T`/`FT`/`TT` ∈ {D,O,T,Z,E,P,C}  
- `K` key, `t` title-slug  
- `i` importance (0–100, default 50)  
- `h` `yymmdd` or `0`  
- `s` ∈ {a=active,p=paused,x=cancelled,d=done}  
- `r` relation ∈ {o=owns, v=advances, c=assoc, e=ethics, p=policy, k=constraint}  

**Ops:** `+` add, `~` update, `-` delete

## Plan Gate
Proceed only if:
```
feasibility ∧ policy_clearance ∧ ethics_clearance ∧ intent_fit
```
If blocked, output the **smallest compliant change**.
