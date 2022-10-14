# Stress test for lake

This repo "accurately" simulates the contents of mathlib
to help with performance optimizations in Lake.

```bash
lake build
time lake print-paths Inundation
```

## Variations

The contents of this repository are automatically generated.
You can also try different parameters:

```bash
lean --run mk.lean 40 40
```

These are the default values.
The first number is the maximum dependency depth,
the second number is the number of dependencies for each file.
