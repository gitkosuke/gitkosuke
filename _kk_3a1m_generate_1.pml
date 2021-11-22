# 2021-02-03 Kosuke Kikuchi created
# 2021-11-22 Kosuke Kikuchi edited


# PN with foldon at both ends
fetch 3a1m, async=0
hide everything
show cartoon

# Create then align
create strand1, (chain A and 3a1m)
create strand2, (chain B and 3a1m)
create strand3, (chain C and 3a1m)
create strand4, (chain A and 3a1m)
create strand5, (chain B and 3a1m)
create strand6, (chain C and 3a1m)
align strand4, (chain D and 3a1m)
align strand5, (chain E and 3a1m)
align strand6, (chain F and 3a1m)
delete 3a1m

# Change attributes
alter strand4, chain='D'
alter strand5, chain='E'
alter strand6, chain='F'

# Now you can see PN with foldon at both ends

# Example of PN preferences
# Set domain names
sel PN_1-139, strand*
sel body, resi 1:101
sel foldon_102-133, resi 102:133
sel None

# Color
color cyan, body and (strand1 or strand4)
color palecyan, body and (strand2 or strand5)
color aquamarine, body and (strand3 or strand6)
color red, foldon_102-133

# View options
set_view (\
     0.430619508,   -0.023105418,   -0.902235806,\
     0.902441740,    0.025012983,    0.430078298,\
     0.012631192,   -0.999419153,    0.031622481,\
     0.000000000,    0.000000000, -502.962799072,\
    16.496383667,    0.071107864,   31.408912659,\
   404.709045410,  601.216552734,  -20.000000000 )
bg_color white
