# -*- coding: utf-8 -*-
# Major Update: 2019/12/12, Kosuke Kikuchi
# 191212; Written base on ESI_fig_overlay.py
#         - difference: data loading step 

import sys, os, numpy as np, matplotlib.pyplot as plt
from time import localtime, strftime

"""
Parameters ### Default
"""
# linewidth --- Line width of plots ### 0.5
# legend --- True: show legend, False: DONT shoe legend ### True
# xlim --- X range in plots ### [1000,10000]
# save --- True: Save directly, False: DONT save but show ### True
# dpi --- Image resolution ### 1000
xlim = [5000,200000]
linewidth = 0.5
legend = True
save = True
dpi = 1000

"""
Set Line Color
"""
# Comment off: Palette 1, else: Palette 2
""" <--- Here to comment off
color_list = ['black'] # Palette 1
"""
color_list = ['red', 'blue', 'purple', 'black'] # Palette 2
"""#"""

"""
Main
"""
def main():
    """
    Load path
    """
    # Generate empty list for path names
    path_list = []
    base_name_list = []
    # Set plotmode --- 1: Raw, 2: Normalized, 3: Normalized & Stack (default)
    plot_type = ['_', 'Raw', 'Norm', 'NormStack']
    # Check the last argv and set plot_mode
    if len(sys.argv[-1]) <= 1:
        plot_mode = int(sys.argv[-1])
        num = len(sys.argv) -1
    else:
        plot_mode = 3
        num = len(sys.argv)
    # Load all path names
    for n in range(1,num):
        path = sys.argv[n]
        extension = os.path.splitext(path)[1]
        try:
            if extension != '.txt':
                raise IOError
        except IOError:
            print('File Type Error')
            print('%s is not a TXT file. Please select a TXT file.' % path)
            exit(-1)
        path_list.append(path)
        base_name = os.path.basename(path)[:-4]
        base_name_list.append(base_name)


    """
    Load and calculate data
    """
    data = []
    j = 1
    for i in path_list:
        with open(i, 'r') as file:
            raw = np.array([l.split(' ') for l in file], dtype = 'float') ### Different from ESI_fig_overlay !!!
        raw_x = raw[:,0]
        raw_y = raw[:,1]
        # Normalize
        per_y = raw_y / np.max(raw_y) * 100
        # Stack normalized data
        perstack_y = per_y + (num - j - 1) * 100
        data.append([raw_x, raw_y, per_y, perstack_y])
        j += 1

    """
    Plot Figure
    """
    # Initialize figure
    fig, ax = plt.subplots()
    def plot(x,y,num):
        # Set Labels
        ax.set_title('MALDI-TOFMS Overlay')
        ax.set_xlabel('m/z')
        ax.set_ylabel('[%]')

        # Hide the right and top spines
        ax.spines['right'].set_visible(False)
        ax.spines['top'].set_visible(False)
        # Only show ticks on the left and bottom spines
        ax.yaxis.set_ticks_position('left')
        ax.xaxis.set_ticks_position('bottom')

        # Set the X range
        ax.set_xlim(xlim)

        # Select the colors and Plot
        col_n = color_list[num%len(color_list)]
        ax.plot(x, y, markersize=0, markeredgewidth=0, linewidth=linewidth, color=col_n, label=base_name_list[num])

        # Show legend if necessary
        if legend == True:
            ax.legend(loc='upper right', fontsize = 5, framealpha = 0)
        else:
            pass

        return fig

    # Overlay plots
    for i in range(len(data)):
        plot(data[i][0], data[i][plot_mode], i)

    """
    Save or Show Figure
    """
    if save == True:
        # Set file name
        save_fig_name = str(strftime("%y%m%d_%H%M%S", localtime())) + '_MALDI_overlay.png'
        # Save figure
        fig.savefig(save_fig_name, dpi = dpi)
        print('### Saved as "%s" ###' % save_fig_name)
    else:
        plt.show()

if __name__ == '__main__':
    main()
