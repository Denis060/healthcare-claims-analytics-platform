import pandas as pd
from pathlib import Path
files = ['patients.csv','encounters.csv','conditions.csv','procedures.csv','claims.csv','claims_transactions.csv','providers.csv','payers.csv']
for fn in files:
    path = Path('data/raw') / fn
    df = pd.read_csv(path, nrows=0)
    print(f'FILE:{fn}')
    print(','.join(df.columns.tolist()))
    print('---')
