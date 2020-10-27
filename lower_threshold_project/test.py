import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("summary.csv", sep=",", header=0, index_col = 0)
groups = df.groupby("Threshold")
for name, group in groups:
    plt.scatter(group["Number Sites"], group["Prevalance"], marker="o", label=name)
plt.legend(title="Threshold Value")
plt.show()