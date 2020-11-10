import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("summary.csv", sep=",", header=0, index_col = 0)
groups = df.sort_values(by=['Number Sites'], ascending=False).groupby("Threshold")
markers = ["o", "v", "*", "p"]
colors = ["red", "blue", "orange", "yellow", "green"]

j = 0
for name, group in groups:
    plt.scatter(group["Number Sites"], group["Prevalance"], marker="o", label=name, color=colors[j])
    j += 1
plt.legend(title="Threshold Value")
plt.savefig('plot_main.png')

fig, ax = plt.subplots()
j = 0
for name, group in groups:
	print(group)
	for i in markers:
		#assign different value to every Number of Site and a color for every threshold value 
		scatter = ax.scatter(group["Risk"], group["Prevalance"], marker=i, label=name, color=colors[j])
	j += 1

#legend_elements = [plt.lines([0], [0], color='b', lw=4, label='Threshold 1'),
#                   Line2D([0], [0], marker='o', color='w', label='Scatter',
#                          markerfacecolor='g', markersize=15),
#                   Patch(facecolor='orange', edgecolor='r',
#                         label='Color Patch')]
legend1= ax.legend(["T", "T2", "T3", "T4","T5"], title ="Threshold", loc="center right")
legend2 = ax.legend(["31622", "10000", "3162", "1000"], title ="Number of Sites", loc="lower right")
ax.add_artist(legend1)
ax.add_artist(legend2)
plt.savefig('plot_risk_prev.png')