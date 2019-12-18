# 使い方： csvファイルへのpath 大まかな添加時間の範囲

import sys, csv, numpy as np
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt

def smoothing(data, num=100):
    b = np.ones(num)/num # numは移動平均の個数
    smoothed = np.convolve(data, b, mode='same') # 移動平均
    return smoothed

path = sys.argv[1]
with open(path, 'r', encoding='shift_jis') as f:
    raw_data = list(csv.reader(f))[28:]

time = np.array([float(l[0]) for l in raw_data])
CH = [np.array([float(l[i]) for l in raw_data]) for i in range(1, 5)]

# 添加時間の自動検出
# スムージングし2次微分
CH_smooth = [smoothing(d) for d in CH] # 移動平均
grad_CH = [np.gradient(d) for d in CH_smooth]
grad_CH_smooth = [smoothing(d) for d in grad_CH] # 移動平均
grad2_CH = [np.gradient(d) for d in grad_CH_smooth]
# おおまかな添加時間を指定する
if len(sys.argv) >= 3:
    idx_start = int(sys.argv[2])
    if len(sys.argv) >= 4:
        idx_stop = int(sys.argv[3])
    else:
        idx_stop = idx_start + 1800
else:
    idx_start = 600
    idx_stop = 600

# 添加直後からの差分を取る
start_time = [np.argmin(d[idx_start:-idx_stop]) + idx_start for d in grad2_CH]
CH_mod = [d[s:]-d[s] for (d, s) in zip(CH, start_time)]
m = np.min([len(d) for d in CH_mod])
CH_mod = [d[:m] for d in CH_mod]
time = time[:len(CH_mod[0])]-1

# 補正
# '''
def correction(time, data):
    for i in range(1000, len(time), 1000):
        r = np.corrcoef(time[-i:], data[-i:])[0][1]
        a, b = np.polyfit(time[-i:], data[-i:], 1)
        if r > -0.95:
            break
    data_mod = [y-a*x for x, y in zip(time, data)]
    return data_mod, [a, b, r, i]

CH_mod = [correction(time, d)[0] for d in CH_mod]
'''
# '''

# カーブフィット
F_max = [np.min(d) for d in CH_mod]
tau = [curve_fit(lambda t, tau: dF_max*(1-np.exp(-t/tau)), time, d)[0][0] for (d, dF_max) in zip(CH_mod, F_max)]
print(tau)

# CSV書き出し
out = [['', 'CH1', 'CH2', 'CH3', 'CH4']]
out.append(['tau'] + tau)
out.append(['', '', '', '', ''])


# CH_graph = [d[s-100:]-d[s] for (d, s) in zip(CH, start_time)]
# time_graph = np.array([t for t in range(-100, 0, 1)] + list(time))

out.extend([[t, ch1, ch2, ch3, ch4] for (t, ch1, ch2, ch3, ch4) in zip(time, *CH_mod)])
# out.extend([[t, ch1, ch2, ch3, ch4] for (t, ch1, ch2, ch3, ch4) in zip(time_graph, *CH_graph)])
path_out = path.replace('.csv', '')+'_analized.csv'
print(path_out)
with open(path_out, 'w', newline='') as f:
    csv.writer(f).writerows(out)

for ch in CH_mod:
# for ch in CH_graph:
    plt.plot(time, ch)
    # plt.plot(time_graph, ch[:len(time_graph)])
plt.show()
