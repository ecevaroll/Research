import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
NUM_SITES = {10000}
THRES = {5}


df = pd.read_csv("summary.csv", sep=",", header=0, index_col = 0)
groups = df.sort_values(by=['Number Sites'], ascending=False).groupby("Threshold")
markers = ["o", "v", "*", "p"]
colors = ["red", "blue", "orange", "yellow", "green"]

j = 0
for name, group in groups:
    plt.scatter(group["Number Sites"], group["Prevalance"], marker="o", label=name, color=colors[j])
    j += 1
plt.legend(title="Threshold Value")
plt.savefig('prev_plot.png')

fig, ax = plt.subplots()
j = 0
for name, group in groups:
	for i in markers:
		#assign different value to every Number of Site and a color for every threshold value 
		scatter = ax.scatter(group["Risk"], group["Prevalance"], marker=i, label=name, color=colors[j])
	j += 1

handles1 = [plt.scatter([0], [0], marker="o", color = c) for c in colors]
handles2 = [plt.scatter([0], [0], marker=c, color ="black") for c in markers]

legend1= ax.legend(handles1,["T", "T2", "T3", "T4","T5"], title ="Threshold", loc="center right")
legend2 = ax.legend(handles2,["31622", "10000", "3162", "1000"], title ="Number of Sites", loc="lower right")
ax.add_artist(legend1)
ax.add_artist(legend2)
plt.savefig('Risk_plot.png')


for i in NUM_SITES:
	for t in THRES:
		hist = pd.read_csv((str(i) +"_" + str(t) + "histogram.txt"), sep=",", header=None)
		hist.columns = ["generation", "liability"]
		series = pd.Series(hist["liability"].replace(" ",","))
		x = series[1].split()
		x = pd.to_numeric(x)
		print(np.var(x))
		plt.hist(x, bins=100, rwidth=0.5)
		plt.ylabel("Frequency")
		plt.xlabel("Liability")
		plt.axvline(x = t, color="red")
		plt.title("Genetic Liability Distribution of Individuals at Generation " + str(15000) + " T=" + str(t) + " Num Sites= " + str(i))
