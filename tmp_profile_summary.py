import pandas as pd
from pathlib import Path
path = Path('docs/source_profile/source_profile_summary.csv')
df = pd.read_csv(path)
priority = ['patients.csv','encounters.csv','conditions.csv','procedures.csv','claims.csv','claims_transactions.csv','providers.csv','payers.csv']
print('Rows by priority file:')
print(df[df.filename.isin(priority)].groupby('filename').first()[['row_count','column_count','duplicate_rows','candidate_primary_keys']])
print('\nCost-related columns by file:')
cost_mask = df.column_name.str.contains('cost|amount|paid|charge|revenue|allowed|allowed_amt|total|price', case=False, regex=True)
for fn, group in df[cost_mask].groupby('filename'):
    names = sorted(set(group.column_name.tolist()))
    print(f'{fn}: {names}')
print('\nLikely patient join columns:')
pat_cols = df[df.column_name.str.contains('patient', case=False, regex=True)].groupby('filename').column_name.unique()
print(pat_cols.to_string())
print('\nLikely encounter join columns:')
enc_cols = df[df.column_name.str.contains('encounter', case=False, regex=True)].groupby('filename').column_name.unique()
print(enc_cols.to_string())
print('\nClaim identifier candidates:')
claim_ids = df[(df.filename.isin(['claims.csv','claims_transactions.csv'])) & df.column_name.str.contains('claim|transaction|id', case=False, regex=True)]
print(claim_ids[['filename','column_name','inferred_type','unique_pct']].drop_duplicates().to_string(index=False))
print('\nPatient-level dataset candidate tables:')
for fn in ['patients.csv','encounters.csv','conditions.csv','procedures.csv','claims.csv','claims_transactions.csv']:
    cols = sorted(df[df.filename==fn].column_name.tolist())
    print(f'{fn}: {len(cols)} columns')
