#!/usr/bin/env python3

import pandas as pd

df = pd.read_csv("input.tsv", sep="\\t", index_col=0)
print(df)

# Make sure that there is more than one column and row
assert df.shape[0] > 1, "Input must have more than one row"
assert df.shape[1] >= 1, "Input must have more than one column"

# Remove any column (after the index) which isn't all numeric
cols_to_remove = [
    cname
    for cname, cvals in df.items()
    if not cvals.apply(
        lambda v: pd.to_numeric(v, errors="coerce")
    ).dropna().shape[0] == cvals.shape[0]
]

if len(cols_to_remove) > 0:
    print("Removing columns:")
    for cname in cols_to_remove:
        print("    " + cname)

    df = df.drop(columns=cols_to_remove)
else:
    print("Did not find any columns to remove")

print(df)

# Write out the file as TSV
df.to_csv("parsed.tsv", sep="\\t")
