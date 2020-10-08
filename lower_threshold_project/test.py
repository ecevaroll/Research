import pandas as pd

df = pd.read_csv(str("10000_1.txt"), sep=" ", header=None, names=["Heritability", "Genetic Variance", "Prevalance", "Risk", "Mean Liability"])
print(df['Mean Liability'].mean())